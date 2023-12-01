AddCSLuaFile()

ENT.Base = "base_nextbot"
ENT.PrintName = "Common Infected"
ENT.Author = "Pyri"
ENT.IsCommonInfected = true
ENT.IsUnCommonInfected = false
ENT.IsWalking = false
ENT.IsRunning = false
ENT.Gender = nil
ENT.IsLyingOrSitting = false
ENT.IsClimbing = false

--- Include files based on sv_ sh_ or cl_
local ENT_CommonFiles = file.Find( "left4dead/z_common/*", "LUA", "nameasc" )

for k, luafile in ipairs( ENT_CommonFiles ) do
    if string.StartWith( luafile, "sv_" ) then -- Server Side Files
        include( "left4dead/z_common/" .. luafile )
        print( "Left 4 Dead Common Infected ENT TABLE: Included Server Side ENT Lua File [" .. luafile .. "]" )
    elseif string.StartWith( luafile, "sh_" ) then -- Shared Files
        if SERVER then
            AddCSLuaFile( "left4dead/z_common/" .. luafile )
        end
        include( "left4dead/z_common/" .. luafile )
        print( "Left 4 Dead Common Infected ENT TABLE: Included Shared ENT Lua File [" .. luafile .. "]" )
    elseif string.StartWith( luafile, "cl_" ) then -- Client Side Files
        if SERVER then
            AddCSLuaFile( "left4dead/z_common/" .. luafile )
        else
            include( "left4dead/z_common/" .. luafile )
            print( "Left 4 Dead Common Infected ENT TABLE: Included Client Side ENT Lua File [" .. luafile .. "]" )
        end
    end
end

-- This might seem reduntant, but trust me, it's not.
-- We create locals of functions so GLua can access them faster
local hook_Run = hook.Run
local SimpleTimer = timer.Simple
local timer_Create = timer.Create
local timer_Adjust = timer.Adjust
local timer_Stop = timer.Stop
local timer_Remove = timer.Remove
local ents_Create = ents.Create
local random = math.random
local Rand = math.Rand
local MathHuge = math.huge
local table_insert = table.insert
local table_HasValue = table.HasValue
local Clamp = math.Clamp
local coroutine_wait = coroutine.wait
local ents_FindInSphere = ents.FindInSphere
local CurTime = CurTime

local AddGestureSequence = AddGestureSequence
local LookupSequence = LookupSequence
local SequenceDuration = SequenceDuration
local IsValid = IsValid
local Vector = Vector
local ents_GetAll = ents.GetAll

local collisionmins = Vector( -16, -16, 0 )
local collisionmaxs = Vector( 16, 16, 72 )
local crouchingcollisionmaxs = Vector( 16, 16, 36 )

-- Convars
local ignorePlys = GetConVar( "ai_ignoreplayers" )
local sv_gravity = GetConVar( "sv_gravity" )
local droppableProps = GetConVar( "l4d_nb_sv_createitems" )
local developer = GetConVar( "developer" )

if CLIENT then language.Add( "nb_common_infected", ENT.PrintName ) end

local ci_BatonModels = 
{
    ["models/infected/c_nb/common_male_police01.mdl"] = true,
    ["models/infected/c_nb/trs_common_male_police01.mdl"] = true
}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetUpZombie()
	-- When it comes down to models, we make all of the models available for the player/admins to customize.
	-- Sorta similar to how the population is handled in L4D2.
	-- Should the player only want Military, Police, Rural, Common, Hospital, or all of above? ect ect.
    local mdls = {}
    for k, v in pairs( Z_MaleModels ) do table_insert( mdls, v ) end
    for k, v in pairs( Z_FemaleModels ) do table_insert( mdls, v ) end

    -- Now select a random model from the combined table
    local spawnMdl = mdls[ random( #mdls ) ]
    self:SetModel( spawnMdl )

    -- Set Gender based on model
    if table_HasValue( Z_MaleModels, spawnMdl ) then
        self.Gender = "Male"
    elseif table_HasValue( Z_FemaleModels, spawnMdl ) then
        self.Gender = "Female"
    end

    -- from Lambdaplayers
    for _, v in ipairs( self:GetBodyGroups() ) do
        local subMdls = #v.submodels
        if subMdls == 0 then continue end
        self:SetBodygroup( v.id, random( 0, subMdls ) )
    end

    local skinCount = self:SkinCount()
    if skinCount > 0 then self:SetSkin( random( 0, skinCount - 1 ) ) end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Initialize()
	if SERVER then

		self:SetUpZombie()
		self:InitSounds()
		local mdl = self:GetModel()

		self.ci_BehaviorState = "Idle" -- The state for our behavior thread is currently running

		self:SetHealth( 50 )
		self:SetShouldServerRagdoll( true )

		if droppableProps:GetBool() then
			local randomValue = random( 100 ) <= 15
			
			if ci_BatonModels[ mdl ] and randomValue then
				self:CreateItem( "nightstick", true, "baton" )
			elseif mdl == "models/infected/l4d2_nb/uncommon_male_ceda.mdl" and randomValue then
				self:CreateItem( "bileJar", false, "grenade" )
			end
		end

		--self.loco:SetAcceleration( random( 250, 600 ) )
		self.loco:SetDeceleration( 200 )
		self.loco:SetStepHeight( 18 )
		self.loco:SetGravity( sv_gravity:GetFloat() )

		self:SetCollisionBounds( collisionmins, collisionmaxs )
		self:PhysicsInitShadow()
		self:SetSolid(SOLID_BBOX)

		self:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)

		self:SetLagCompensated( true )
		self:AddFlags( FL_OBJECT + FL_NPC )
		self:SetSolidMask( MASK_PLAYERSOLID )

		-- Idle Facial Anims
		self:ZombieExpression( "idle" )

		-- Breathing Anims layer
		self:AddGestureSequence( self:LookupSequence( "idlenoise" ), false )

	elseif CLIENT then
		self.ci_lastdraw = 0
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
-- Certain Common/Uncommon Infected will have
-- props attached to them... Riot Cops, Cops
-- CEDA, ect. Create some props for them to carry

-- itemName = Prop name in table
-- canparent = Should it parented to the ragdoll on death?
-- id = id attachment name
function ENT:CreateItem( itemName, canparent, id )
	local model = Z_itemModels[ itemName ]
	if !model then return end

	local item = ents_Create( "prop_physics" )
	item:SetModel( model )
	item:SetLocalPos( self:GetPos() )
	item:SetLocalAngles( self:GetAngles() )
	item:SetOwner( self )
	item:SetParent( self )
	item:Fire( "SetParentAttachmentMaintainOffset", id )
	item:Fire( "SetParentAttachment", id )
	item:SetCollisionGroup( COLLISION_GROUP_IN_VEHICLE )
	item:Spawn()
	item:Activate()
	item:SetSolid( SOLID_BSP )

	self.item = item
	self.canparent = canparent
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CreateItemOnDeath( ragdoll )
	local item = self.item
	-- Make this into a convar later
	local dropChance = random( 100 ) <= 60

	if dropChance or !self.canparent then
		item:SetParent( nil )
		item:SetPos( self:GetPos() + Vector( 0, 0, 50 ) )
		item:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
		item:PhysicsInit( SOLID_VPHYSICS )

		local phys = item:GetPhysicsObject()
		if IsValid( phys ) then
			phys:EnableGravity( true )
			phys:Wake()

			-- Apply a force so they fly up or around.
			local randX = random( -1000, 1000 )
			local randY = random( -1000, 1000 )
			local randZ = random( 450, 1000 )
			local force = Vector( randX, randY, randZ )
			local position = item:WorldToLocal( item:OBBCenter() ) + Vector( Rand( 5, 10 ), Rand( 5, 10 ), Rand( -10, 60 ) )
			phys:ApplyForceOffset( force, position )
		end

		SimpleTimer( 15, function()
			if IsValid( item ) then
				item:Remove()
			end
		end)
	else
		-- Parent to the model, don't drop.
		if IsValid( ragdoll ) then
			item:SetParent( ragdoll )
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnKilled( dmginfo )
	hook_Run( "OnNPCKilled", self, dmginfo:GetAttacker(), dmginfo:GetInflictor() )

	local ragdoll = self:BecomeRagdoll( dmginfo )
	ragdoll:SetCollisionGroup( COLLISION_GROUP_DEBRIS )

	self:SetDeathExpression( ragdoll )

	if IsValid( self.item ) then
		self:CreateItemOnDeath( ragdoll )
	end

	self:Vocalize( ZCommon_L4D1_Death )

	-- Have a chance for the ragdoll to fly around a bit.
	-- Instead of faceplanting if no animations played, they could land
	-- on their back.
	if random( 10 ) == 1 then
		local phys = ragdoll:GetPhysicsObject()
		if IsValid( phys ) then
			local randX = random( -20, 30 )
			local randY = random( -20, 30 )
			local randZ = random( -30, 60 )
			local force = Vector( randX, randY, randZ )

			-- Apply the force at a random point on the ragdoll.
			local position = Vector( 0,0,0 )
			phys:ApplyForceOffset( force, position )
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Draw()
	self.ci_lastdraw = RealTime() + 0.1
	self:DrawModel()
	--Msg("Being drawn")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnRemove()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DirectPoseParametersAt(pos, pitch, yaw, center)
	local isstring = isstring
	local isentity = isentity
	local isvector = isvector
	local AngleDifference = math.AngleDifference
	local GetAngles = self.GetAngles
	local SetPoseParameter = self.SetPoseParameter
	local WorldSpaceCenter = self.WorldSpaceCenter

	if not isstring(yaw) then
		return self:DirectPoseParametersAt(pos, pitch.."_pitch", pitch.."_yaw", yaw)
	elseif isentity(pos) then 
		pos = pos:WorldSpaceCenter() 
	end

	if isvector(pos) then
		center = center or WorldSpaceCenter(self)
		local angle = (pos - center):Angle()
		SetPoseParameter(self, pitch, AngleDifference(angle.p, GetAngles(self).p))
		SetPoseParameter(self, yaw, AngleDifference(angle.y, GetAngles(self).y))
	else
		SetPoseParameter(self, pitch, 0)
		SetPoseParameter(self, yaw, 0)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:LookAtEntity( ent )
	local enemy = self:FindNearestEnemy()
	if IsValid(enemy) and enemy:GetBonePosition(1) then
		local distance = self:GetPos():Distance(enemy:GetPos())

		-- Look at out prey
		if distance < 700 then
			self:DirectPoseParametersAt(enemy:GetBonePosition(1), "body", self:EyePos())
		else -- If our prey is too far, don't look at them
			self:DirectPoseParametersAt(nil, "body_pitch", "body_yaw", 0)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:HandleStuck()
	self:Remove()
	print( "Infected was removed due to getting stuck" )
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:FindNearestEnemy()
    local enemies = ents_FindInSphere(self:GetPos(), 2500) -- Find potential targets
    local nearestEnemy = nil -- Our enemy
    local nearestDistance = MathHuge -- Limited to out range of FindInSphere, 

    for _, enemy in pairs(enemies) do

		if enemy ~= self and not enemy.IsCommonInfected and enemy:IsNPC() or enemy:IsPlayer() or !ignorePlys or enemy:IsNextBot() and not enemy.IsCommonInfected then
			local distance = self:GetPos():Distance(enemy:GetPos()) -- Calculating distance between zombie and target

			if distance < nearestDistance then
				nearestDistance = distance
				nearestEnemy = enemy
			end
		end
    end

    return nearestEnemy -- Returning target for all purposes.
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RunBehaviour()
	while ( true ) do
		local enemy = self:FindNearestEnemy()
		if not IsValid(enemy) then
			self:StartWandering()
		elseif IsValid(enemy) then
			local distance = self:GetPos():Distance(enemy:GetPos())
			if distance > 100 then
				self:ChaseTarget(enemy)
				--PrintMessage(HUD_PRINTTALK, "Chasing!")
			else
				self:Attack(enemy)
				--PrintMessage(HUD_PRINTTALK, "Attacking!")
			end
		end
		coroutine.yield()
	end
end

---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:StartWandering()
	self.loco:SetAcceleration(5000)
	self.loco:SetDeceleration(5000)

	local anim = self:GetActivity()
	
	if self.Gender == "Female" then
		anim = "ACT_RUN"
	else
		anim = "ACT_TERROR_RUN_INTENSE"
	end

	self:ResetSequence(anim)
	self.loco:SetDesiredSpeed(350)
	self:MoveToPos(self:GetPos() + VectorRand() * math.random(250, 300))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Attack(target)
	local detectedEnemy = target
	local directionToEnemy = (target:GetPos() - self:GetPos()):GetNormalized()
	local distance = self:GetPos():Distance(target:GetPos())
	local AngleToEnemy = directionToEnemy:Angle()
	AngleToEnemy.p = 0
	if distance < 100 and (not self.AttackDelay or CurTime() - self.AttackDelay > 1.2) then
		self:SetCycle(0)
		self:SetPlaybackRate(1)
		self:SetAngles(AngleToEnemy)

		if random( 2 ) == 1 then
			if !self.SpeakDelay or CurTime() - self.SpeakDelay > Rand( 0.2, 1 ) then
				self:Vocalize( ZCommon_L4D1_BecomeEnraged )
				PrintMessage( HUD_PRINTTALK, "Enraged!" )
				self.SpeakDelay = CurTime()
			end
		end

		local dmginfo = DamageInfo()
		dmginfo:SetDamage(5)
		dmginfo:SetDamageType(DMG_DIRECT)
		dmginfo:SetInflictor(self)
		dmginfo:SetAttacker(self)
		target:TakeDamageInfo(dmginfo)
		self:Vocalize( ZCommon_AttackSmack )
		self:LookAtEntity()
		self:PlayAttackAnimation()
		self.AttackDelay = CurTime()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:ChaseTarget(target)
	self.loco:SetDesiredSpeed(300)
	self.loco:SetAcceleration(5000)
	self.loco:SetDeceleration(5000)
	self.IsRunning = true

	local anim = self:GetActivity()
	
	if self.Gender == "Female" then
		anim = "ACT_RUN"
	else
		anim = "ACT_TERROR_RUN_INTENSE"
	end

	if random( 8 ) == 3 then
		if !self.SpeakDelay or CurTime() - self.SpeakDelay > Rand( 1.2, 2 ) then
			self:Vocalize( ZCommon_L4D1_RageAtVictim )
			PrintMessage( HUD_PRINTTALK, "Rage At Victim!" )
			self.SpeakDelay = CurTime()
		end
	end

	self:ResetSequence(anim)
	self.loco:SetDesiredSpeed(300)
	self:LookAtEntity()

    local TargetToChase = target
    local path = Path("Follow")
    --path:Chase(self, target)
    path:Compute(self, TargetToChase:GetPos())
    while (path:IsValid() and IsValid(TargetToChase)) do
        if path:GetAge() > 0.1 then
            path:Compute(self, TargetToChase:GetPos())
        end

		if developer:GetBool() then path:Draw() end

        path:Update(self)

		local distance = self:GetPos():Distance(TargetToChase:GetPos())
        if distance > 90 then
            break
        end

        coroutine.yield()
    end
end

function ENT:PlayAttackAnimation()
	coroutine.wait(0.4)
	self:ResetSequence("ACT_TERROR_ATTACK_CONTINUOUSLY")
end
---------------------------------------------------------------------------------------------------------------------------------------------
--
	-- 4 function below used for testing and animations
	-- We will create an expansive function for Actions
	function ENT:StartWalkAction()
		self.loco:SetAcceleration( random( 160, 280 ) )
	
		local anim = self:GetActivity()
	
		if self.Gender == "female" then
			anim = "ACT_WALK"
		elseif self.Gender == "male" then
			local maleAnims = { "ACT_TERROR_WALK_NEUTRAL", "ACT_TERROR_SHAMBLE", "ACT_TERROR_WALK_INTENSE" }
			anim = table.Random(maleAnims)
		end
	
		self:ResetSequence( anim )
	
		self.loco:SetDesiredSpeed( random( 15, 17 ) )
		self:MoveToPos( self:GetPos() + VectorRand() * random( 250, 500 ) )
	
		self.IsWalking = true
	end
	---------------------------------------------------------------------------------------------------------------------------------------------
	function ENT:StartCrouchAction()
		self.loco:SetAcceleration( random( 200, 280 ) )
	
		local anim = self:GetActivity()
		anim = "ACT_TERROR_CROUCH_RUN_INTENSE"
	
		self:ResetSequence( anim )
	
		self.loco:SetDesiredSpeed( random( 275, 325 ) )
		self:MoveToPos( self:GetPos() + VectorRand() * random( 500, 1000 ) )
	
		self.IsWalking = true
	end
	
	---------------------------------------------------------------------------------------------------------------------------------------------
	function ENT:StartIdleAction()
		local anim = self:GetActivity()
		anim = "ACT_TERROR_IDLE_NEUTRAL"

		self:ResetSequence( anim )
		
		self.IsWalking = false
		self.IsRunning = false
	end
	---------------------------------------------------------------------------------------------------------------------------------------------
	function ENT:StartRunAction()
		self.loco:SetAcceleration( random( 250, 600 ) )
		
		local anim = self:GetActivity()
		if self.Gender == "female" then
			anim = "ACT_RUN"
		else
			anim = "ACT_TERROR_RUN_INTENSE"
		end

		self:ResetSequence( anim )

		self.loco:SetDesiredSpeed( 280 )
		self:MoveToPos( self:GetPos() + VectorRand() * random( 600, 1500 ) )

		self.IsRunning = true
	end
--
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:BodyUpdate()
    local velocity = self.loco:GetVelocity()
    if !velocity:IsZero() then
        -- Apparently NEXTBOT:BodyMoveXY() really don't likes swimming animations and sets their playback rate to crazy values, causing the game to crash
        -- So instead I tried to recreate what that function does, but with clamped set playback rate
        if self:GetWaterLevel() >= 2 then
            local selfPos = self:GetPos()

            -- Setup pose parameters (model's legs movement)
            local moveDir = ( ( selfPos + velocity ) - selfPos ); moveDir.z = 0
            local moveXY = ( self:GetAngles() - moveDir:Angle() ):Forward()

            local frameTime = FrameTime()
            self:SetPoseParameter( "move_x", Lerp( 15 * frameTime, self:GetPoseParameter( "move_x" ), moveXY.x ) )
            self:SetPoseParameter( "move_y", Lerp( 15 * frameTime, self:GetPoseParameter( "move_y" ), moveXY.y ) )
			--self:InvalidateBoneCache()

            -- Setup swimming animation's clamped playback rate
            local length = velocity:Length()
            local groundSpeed = self:GetSequenceGroundSpeed( self:GetSequence() )
            self:SetPlaybackRate( Clamp( ( length > 0.2 and ( length / groundSpeed ) or 1 ), 0.5, 2 ) )
        else
            self:BodyMoveXY()
            return
        end
    end

    self:FrameAdvance()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetDeathExpression( ragdoll )

	local expressionKeys = {}
	for key in pairs( _DeathExpressions ) do
		table_insert( expressionKeys, key )
	end

	local randomExpressionKey = expressionKeys[ random( #expressionKeys ) ]
	local bonesToModify = _DeathExpressions[ randomExpressionKey ]

	Msg( "Expression picked: " .. randomExpressionKey )

	for _, boneData in pairs( bonesToModify ) do
		local boneIndex = ragdoll:LookupBone( boneData.boneName )
		if boneIndex then
			ragdoll:ManipulateBonePosition( boneIndex, boneData.positionOffset )
			ragdoll:ManipulateBoneAngles( boneIndex, boneData.angleOffset )
		end

		Msg("Bones set \n")
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
list.Set( "NPC", "z_common", {
	Name = "Common Infected",
	Class = "z_common",
	Category = "Left 4 Dead NextBots"
})

if CLIENT then
	language.Add( "z_common", "Common Infected" )
end
---------------------------------------------------------------------------------------------------------------------------------------------