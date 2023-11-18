AddCSLuaFile()

ENT.Base = "base_nextbot"
ENT.PrintName = "Common Infected"
ENT.Author = "Pyri"
ENT.IsCommonInfected = false
ENT.IsUnCommonInfected = false
ENT.IsWalking = false
ENT.IsRunning = false
ENT.IsLyingOrSitting = false
ENT.IsClimbing = false

--- Include files based on sv_ sh_ or cl_
local ENT_CommonFiles = file.Find( "left4dead/z_common/*", "LUA", "nameasc" )

for k, luafile in ipairs( ENT_CommonFiles ) do
    if string.StartWith( luafile, "sv_" ) then -- Server Side Files
        include( "left4dead/z_common/" .. luafile )
        print( "Left 4 Dead ENT TABLE: Included Server Side ENT Lua File [" .. luafile .. "]" )
    elseif string.StartWith( luafile, "sh_" ) then -- Shared Files
        if SERVER then
            AddCSLuaFile( "left4dead/z_common/" .. luafile )
        end
        include( "left4dead/z_common/" .. luafile )
        print( "Left 4 Dead ENT TABLE: Included Shared ENT Lua File [" .. luafile .. "]" )
    elseif string.StartWith( luafile, "cl_" ) then -- Client Side Files
        if SERVER then
            AddCSLuaFile( "left4dead/z_common/" .. luafile )
        else
            include( "left4dead/z_common/" .. luafile )
            print( "Left 4 Dead ENT TABLE: Included Client Side ENT Lua File [" .. luafile .. "]" )
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
local table_insert = table.insert
local Clamp = math.Clamp
local coroutine_wait = coroutine.wait

local AddGestureSequence = AddGestureSequence
local LookupSequence = LookupSequence
local SequenceDuration = SequenceDuration
local IsValid = IsValid
local Vector = Vector

local collisionmins = Vector( -16, -16, 0 )
local collisionmaxs = Vector( 16, 16, 72 )
local crouchingcollisionmaxs = Vector( 16, 16, 36 )

-- Convars
local ignorePlys = GetConVar( "ai_ignoreplayers" )
local sv_gravity = GetConVar( "sv_gravity" )
local droppableProps = GetConVar( "l4d_nb_sv_createitems" )

if CLIENT then language.Add( "nb_common_infected", ENT.PrintName ) end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetUpZombie()
	-- When it comes down to models, we make all of the models available for the player/admins to customize.
	-- Sorta similar to how the population is handled in L4D2.
	-- Should the player only want Military, Police, Rural, Common, Hospital, or all of above? ect ect.
    local mdls = {}
    for k, v in pairs(Z_MaleModels ) do table_insert( mdls, v ) end
    for k, v in pairs(Z_FemaleModels ) do table_insert( mdls, v ) end

    -- Now select a random model from the combined table
    local spawnMdl = mdls[ random( #mdls ) ]
    self:SetModel( spawnMdl )

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
		local mdl = self:GetModel()

		self.ci_BehaviorState = "Idle" -- The state for our behavior thread is currently running

		self:SetHealth( 50 )
		self:SetShouldServerRagdoll( true )

		if droppableProps:GetBool() then
			if mdl == "models/infected/c_inf_nextbot/common_police_male01.mdl" && random( 100 ) <= 15 then
				self:CreateItem( "nightstick",  true, "baton" )
			end
		end

		--self.loco:SetAcceleration( random( 250, 600 ) )
		self.loco:SetDeceleration( 200 )
		self.loco:SetStepHeight( 30 )
		self.loco:SetGravity( sv_gravity:GetFloat() )

		self:SetCollisionBounds( collisionmins, collisionmaxs )
		self:PhysicsInitShadow()
		self:SetSolid(SOLID_BBOX)

		self:SetCollisionGroup( COLLISION_GROUP_PLAYER )

		self:SetLagCompensated( true )
		self:AddFlags( FL_OBJECT + FL_NPC )
		self:SetSolidMask( MASK_PLAYERSOLID )

		-- from Lambdaplayers
		for _, v in ipairs( self:GetBodyGroups() ) do
			local subMdls = #v.submodels
			if subMdls == 0 then continue end
			self:SetBodygroup( v.id, random( 0, subMdls ) )
		end

		local skinCount = self:SkinCount()
		if skinCount > 0 then self:SetSkin( random( 0, skinCount - 1 ) ) end

		-- Idle Facial Anims
		ZombieExpression( self, "idle" )

		-- Breathing Anims
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
	local model = itemModels[ itemName ]
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
	item:SetSolid( SOLID_VPHYSICS )

	self.item = item
	self.canparent = canparent
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnKilled( dmginfo )
	hook_Run( "OnNPCKilled", self, dmginfo:GetAttacker(), dmginfo:GetInflictor() )

	local ragdoll = self:BecomeRagdoll( dmginfo )
	ragdoll:SetCollisionGroup( COLLISION_GROUP_DEBRIS )

	self:SetDeathExpression( ragdoll )

	-- Move this into it's own function "ENT:CreateItemOnDeath"
	if IsValid( self.item ) then
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
				local force = Vector( random( -1000, 1000 ), random( -1000, 1000 ), random( 450, 1000 ) )
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
function ENT:HandleStuck()

--[[ 	local dmginfo = DamageInfo()
	dmginfo:SetAttacker( self )
	dmginfo:SetInflictor( self )
	dmginfo:SetDamageType( DMG_CRUSH )
	dmginfo:SetDamage( self:Health() )
	self:OnKilled( dmginfo )
	self.loco:ClearStuck()

	--self:EmitSound( "npc/infected/gore/bullets/bullet_impact_05.wav", 65 ) ]]

	self:Remove()
	print( "Infected was removed due to getting stuck" )
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RunBehaviour()
	while ( true ) do
		-- Basic movement for now
		if ( self:IsOnGround() ) then
			if ( random( 20 ) == 1 ) then
				self:StartWalkAction()
			else
				self:StartIdleAction()
			end
		end

		coroutine_wait( 0.1 )
	end
end

---------------------------------------------------------------------------------------------------------------------------------------------
--
	-- 3 function below used for testing and animations
	-- We will create an expansive function for Actions
	function ENT:StartWalkAction()
		self.loco:SetAcceleration( random( 160, 280 ) )
		local anim = _Z_WalkAnims[ random( #_Z_WalkAnims ) ]
		self:ResetSequence( self:LookupSequence( anim ) )

		self.loco:SetDesiredSpeed( random( 15, 17 ) )
		self:MoveToPos( self:GetPos() + VectorRand() * random( 250, 500 ) )

		self.IsWalking = true
	end
	---------------------------------------------------------------------------------------------------------------------------------------------
	function ENT:StartIdleAction()
		local idleAnim = _Z_IdleAnims[ random( #_Z_IdleAnims ) ]
		self:SetSequence( self:LookupSequence( idleAnim ) )
		
		self.IsWalking = false
		self.IsRunning = false
	end
	---------------------------------------------------------------------------------------------------------------------------------------------
	function ENT:StartRunAction()
		self.loco:SetAcceleration( random( 250, 600 ) )
		local anim = _Z_RunAnims[ random( #_Z_RunAnims ) ]
		self:ResetSequence( self:LookupSequence( anim ) )

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
---------------------------------------------------------------------------------------------------------------------------------------------