function ENT:InitSounds()
	Zombie_BulletImpact = {
		"left4dead/vocals/infected/sfx/gore/bullet_impact_01.mp3",
		"left4dead/vocals/infected/sfx/gore/bullet_impact_02.mp3",
		"left4dead/vocals/infected/sfx/gore/bullet_impact_03.mp3",
		"left4dead/vocals/infected/sfx/gore/bullet_impact_04.mp3",
		"left4dead/vocals/infected/sfx/gore/bullet_impact_05.mp3",
		"left4dead/vocals/infected/sfx/gore/bullet_impact_06.mp3",
		"left4dead/vocals/infected/sfx/gore/bullet_impact_07.mp3",
		"left4dead/vocals/infected/sfx/gore/bullet_impact_08.mp3",
	}

	-- Get sounds later!
	Zombie_BulletImpact_Riot = {
		"physics/metal/metal_solid_impact_bullet1.wav",
		"physics/metal/metal_solid_impact_bullet2.wav",
		"physics/metal/metal_solid_impact_bullet3.wav",
		"physics/metal/metal_solid_impact_bullet4.wav",
		"physics/metal/metal_box_impact_bullet1.wav",
		"physics/metal/metal_box_impact_bullet2.wav",
		"physics/metal/metal_box_impact_bullet3.wav",
		"physics/metal/golfclub_impact1.wav",
		"physics/metal/golfclub_impact2.wav",
		"physics/metal/golfclub_impact3.wav",
		"physics/metal/golfclub_impact4.wav",
		"physics/metal/blade_impact_soft1.wav",
		"physics/metal/blade_impact_soft2.wav",
		"physics/metal/blade_impact_soft3.wav",
		"physics/metal/blade_impact_soft4.wav",
	}
	---------------------------------------------------------------------------------------------------------------------------------------------
	-- Shared Sounds - COMMON INFECTED
	---------------------------------------------------------------------------------------------------------------------------------------------
	-- I'm lying down, I should breathe
	ZCommon_Idle_LyingDown = {
		"left4dead/vocals/infected/idle/breathing/breathing01.wav",
		"left4dead/vocals/infected/idle/breathing/breathing08.wav",
		"left4dead/vocals/infected/idle/breathing/breathing09.wav",
		"left4dead/vocals/infected/idle/breathing/breathing10.wav",
		"left4dead/vocals/infected/idle/breathing/breathing13.wav",
		"left4dead/vocals/infected/idle/breathing/breathing16.wav",
		"left4dead/vocals/infected/idle/breathing/breathing18.wav",
		"left4dead/vocals/infected/idle/breathing/breathing25.wav",
		"left4dead/vocals/infected/idle/breathing/breathing26.wav"
	}
	
	-- Im wandering around, i make noise
	ZCommon_Idle_Wander = {
		"left4dead/vocals/infected/idle/breathing/idle_breath_01.wav",
		"left4dead/vocals/infected/idle/breathing/idle_breath_02.wav",
		"left4dead/vocals/infected/idle/breathing/idle_breath_03.wav",
		"left4dead/vocals/infected/idle/breathing/idle_breath_04.wav",
		"left4dead/vocals/infected/idle/breathing/idle_breath_06.wav",
		"left4dead/vocals/infected/idle/moaning/moan01.wav",
		"left4dead/vocals/infected/idle/moaning/moan02.wav",
		"left4dead/vocals/infected/idle/moaning/moan03.wav",
		"left4dead/vocals/infected/idle/moaning/moan04.wav",
		"left4dead/vocals/infected/idle/moaning/moan05.wav",
		"left4dead/vocals/infected/idle/moaning/moan06.wav",
		"left4dead/vocals/infected/idle/moaning/moan07.wav",
		"left4dead/vocals/infected/idle/moaning/moan08.wav",
		"left4dead/vocals/infected/idle/moaning/moan09.wav",
		"left4dead/vocals/infected/idle/mumbling/mumbling01.wav",
		"left4dead/vocals/infected/idle/mumbling/mumbling02.wav",
		"left4dead/vocals/infected/idle/mumbling/mumbling03.wav",
		"left4dead/vocals/infected/idle/mumbling/mumbling04.wav",
		"left4dead/vocals/infected/idle/mumbling/mumbling05.wav",
		"left4dead/vocals/infected/idle/mumbling/mumbling06.wav",
		"left4dead/vocals/infected/idle/mumbling/mumbling07.wav",
		"left4dead/vocals/infected/idle/mumbling/mumbling08.wav",
		"left4dead/vocals/infected/idle/mumbling/mumbling09.wav",
		"left4dead/vocals/infected/idle/breathing/breathing01.wav",
		"left4dead/vocals/infected/idle/breathing/breathing08.wav",
		"left4dead/vocals/infected/idle/breathing/breathing09.wav",
		"left4dead/vocals/infected/idle/breathing/breathing10.wav",
		"left4dead/vocals/infected/idle/breathing/breathing13.wav",
		"left4dead/vocals/infected/idle/breathing/breathing16.wav",
		"left4dead/vocals/infected/idle/breathing/breathing18.wav",
		"left4dead/vocals/infected/idle/breathing/breathing25.wav",
		"left4dead/vocals/infected/idle/breathing/breathing26.wav"
	}
	
	-- OWWW! Pain!
	ZCommon_Pain = {
		"left4dead/vocals/infected/pain/been_shot_01.wav",
		"left4dead/vocals/infected/pain/been_shot_02.wav",
		"left4dead/vocals/infected/pain/been_shot_04.wav",
		"left4dead/vocals/infected/pain/been_shot_05.wav",
		"left4dead/vocals/infected/pain/been_shot_06.wav",
		"left4dead/vocals/infected/pain/been_shot_08.wav",
		"left4dead/vocals/infected/pain/been_shot_09.wav",
		"left4dead/vocals/infected/pain/been_shot_12.wav",
		"left4dead/vocals/infected/pain/been_shot_13.wav",
		"left4dead/vocals/infected/pain/been_shot_14.wav",
		"left4dead/vocals/infected/pain/been_shot_18.wav",
		"left4dead/vocals/infected/pain/been_shot_19.wav",
		"left4dead/vocals/infected/pain/been_shot_20.wav",
		"left4dead/vocals/infected/pain/been_shot_21.wav",
		"left4dead/vocals/infected/pain/been_shot_22.wav",
		"left4dead/vocals/infected/pain/been_shot_24.wav",
		"left4dead/vocals/infected/pain/"..self.Gender.."/been_shot_30.wav",
		"left4dead/vocals/infected/pain/"..self.Gender.."/been_shot_31.wav",
		"left4dead/vocals/infected/pain/"..self.Gender.."/been_shot_32.wav",
		"left4dead/vocals/infected/pain/"..self.Gender.."/been_shot_33.wav",
		"left4dead/vocals/infected/pain/"..self.Gender.."/been_shot_34.wav",
		"left4dead/vocals/infected/pain/"..self.Gender.."/been_shot_35.wav",
		"left4dead/vocals/infected/pain/"..self.Gender.."/been_shot_36.wav",
		"left4dead/vocals/infected/pain/"..self.Gender.."/been_shot_37.wav"
	}
	
	-- Screaming, on fire!
	ZCommon_Ignited = {
		"left4dead/vocals/infected/ignite/ignite01.wav",
		"left4dead/vocals/infected/ignite/ignite07.wav",
		"left4dead/vocals/infected/ignite/ignite08.wav",
		"left4dead/vocals/infected/ignite/ignite09.wav",
		"left4dead/vocals/infected/ignite/"..self.Gender.."/ignite10.wav",
		"left4dead/vocals/infected/ignite/"..self.Gender.."/ignite11.wav",
		"left4dead/vocals/infected/ignite/"..self.Gender.."/ignite12.wav",
		"left4dead/vocals/infected/ignite/"..self.Gender.."/ignite13.wav",
		"left4dead/vocals/infected/ignite/"..self.Gender.."/ignite14.wav",
	}
	
	ZCommon_AttackSmack = {
		"left4dead/vocals/infected/sfx/hit/hit_body_01.mp3",
		"left4dead/vocals/infected/sfx/hit/hit_body_02.mp3",
		"left4dead/vocals/infected/sfx/hit/hit_body_03.mp3",
		"left4dead/vocals/infected/sfx/hit/hit_body_04.mp3",
		"left4dead/vocals/infected/sfx/hit/hit_face_01.mp3",
		"left4dead/vocals/infected/sfx/hit/hit_face_02.mp3",
		"left4dead/vocals/infected/sfx/hit/hit_face_03.mp3",
		"left4dead/vocals/infected/sfx/hit/hit_face_04.mp3",
		"left4dead/vocals/infected/sfx/hit/hit_punch_01.mp3",
		"left4dead/vocals/infected/sfx/hit/hit_punch_02.mp3",
		"left4dead/vocals/infected/sfx/hit/hit_punch_03.mp3",
		"left4dead/vocals/infected/sfx/hit/hit_punch_04.mp3",
		"left4dead/vocals/infected/sfx/hit/hit_punch_05.mp3",
		"left4dead/vocals/infected/sfx/hit/hit_punch_06.mp3",
		"left4dead/vocals/infected/sfx/hit/hit_punch_07.mp3",
		"left4dead/vocals/infected/sfx/hit/hit_punch_08.mp3",
	}
	---------------------------------------------------------------------------------------------------------------------------------------------
	-- Left 4 Dead 1 Sounds
	---------------------------------------------------------------------------------------------------------------------------------------------
	
	-- Play these when wandering / idling when they spot their prey
	ZCommon_L4D1_BecomeAlert = {
		"left4dead/vocals/infected/l4d1/alert/becomealert/become_alert01.wav",
		"left4dead/vocals/infected/l4d1/alert/becomealert/become_alert04.wav",
		"left4dead/vocals/infected/l4d1/alert/becomealert/become_alert09.wav",
		"left4dead/vocals/infected/l4d1/alert/becomealert/become_alert11.wav",
		"left4dead/vocals/infected/l4d1/alert/becomealert/become_alert12.wav",
		"left4dead/vocals/infected/l4d1/alert/becomealert/become_alert14.wav",
		"left4dead/vocals/infected/l4d1/alert/becomealert/become_alert17.wav",
		"left4dead/vocals/infected/l4d1/alert/becomealert/become_alert18.wav",
		"left4dead/vocals/infected/l4d1/alert/becomealert/become_alert21.wav",
		"left4dead/vocals/infected/l4d1/alert/becomealert/become_alert23.wav",
		"left4dead/vocals/infected/l4d1/alert/becomealert/become_alert25.wav",
		"left4dead/vocals/infected/l4d1/alert/becomealert/become_alert26.wav",
		"left4dead/vocals/infected/l4d1/alert/becomealert/become_alert29.wav",
		"left4dead/vocals/infected/l4d1/alert/becomealert/become_alert38.wav",
		"left4dead/vocals/infected/l4d1/alert/becomealert/become_alert41.wav",
		"left4dead/vocals/infected/l4d1/alert/becomealert/become_alert54.wav",
		"left4dead/vocals/infected/l4d1/alert/becomealert/become_alert55.wav",
		"left4dead/vocals/infected/l4d1/alert/becomealert/become_alert56.wav",
		"left4dead/vocals/infected/l4d1/alert/becomealert/become_alert57.wav",
		"left4dead/vocals/infected/l4d1/alert/becomealert/become_alert58.wav",
		"left4dead/vocals/infected/l4d1/alert/becomealert/become_alert59.wav",
		"left4dead/vocals/infected/l4d1/alert/becomealert/become_alert59.wav",
		"left4dead/vocals/infected/l4d1/alert/becomealert/hiss01.wav",
		"left4dead/vocals/infected/l4d1/alert/becomealert/howl01.wav",
		"left4dead/vocals/infected/l4d1/alert/becomealert/recognize01.wav",
		"left4dead/vocals/infected/l4d1/alert/becomealert/recognize02.wav",
		"left4dead/vocals/infected/l4d1/alert/becomealert/recognize03.wav",
		"left4dead/vocals/infected/l4d1/alert/becomealert/recognize04.wav",
		"left4dead/vocals/infected/l4d1/alert/becomealert/recognize05.wav",
		"left4dead/vocals/infected/l4d1/alert/becomealert/recognize06.wav",
		"left4dead/vocals/infected/l4d1/alert/becomealert/recognize07.wav",
		"left4dead/vocals/infected/l4d1/alert/becomealert/recognize08.wav",
		"left4dead/vocals/infected/l4d1/alert/becomealert/shout01.wav",
		"left4dead/vocals/infected/l4d1/alert/becomealert/shout02.wav",
		"left4dead/vocals/infected/l4d1/alert/becomealert/shout03.wav",
		"left4dead/vocals/infected/l4d1/alert/becomealert/shout04.wav",
		"left4dead/vocals/infected/l4d1/alert/becomealert/shout05.wav",
		"left4dead/vocals/infected/l4d1/alert/becomealert/shout06.wav",
		"left4dead/vocals/infected/l4d1/alert/becomealert/shout07.wav",
		"left4dead/vocals/infected/l4d1/alert/becomealert/shout08.wav",
		"left4dead/vocals/infected/l4d1/alert/becomealert/shout09.wav",
		"left4dead/vocals/infected/l4d1/alert/becomealert/"..self.Gender.."/become_alert60.wav",
		"left4dead/vocals/infected/l4d1/alert/becomealert/"..self.Gender.."/become_alert61.wav",
		"left4dead/vocals/infected/l4d1/alert/becomealert/"..self.Gender.."/become_alert62.wav",
		"left4dead/vocals/infected/l4d1/alert/becomealert/"..self.Gender.."/become_alert63.wav"
	}
	
	-- While lying, sitting or leaning, play these when they spot their prey
	ZCommon_L4D1_Alert = {
		"left4dead/vocals/infected/l4d1/alert/alert/alert13.wav",
		"left4dead/vocals/infected/l4d1/alert/alert/alert16.wav",
		"left4dead/vocals/infected/l4d1/alert/alert/alert22.wav",
		"left4dead/vocals/infected/l4d1/alert/alert/alert23.wav",
		"left4dead/vocals/infected/l4d1/alert/alert/alert25.wav",
		"left4dead/vocals/infected/l4d1/alert/alert/alert26.wav",
		"left4dead/vocals/infected/l4d1/alert/alert/alert27.wav",
		"left4dead/vocals/infected/l4d1/alert/alert/alert36.wav",
		"left4dead/vocals/infected/l4d1/alert/alert/alert37.wav",
		"left4dead/vocals/infected/l4d1/alert/alert/alert38.wav",
		"left4dead/vocals/infected/l4d1/alert/alert/alert39.wav",
		"left4dead/vocals/infected/l4d1/alert/alert/alert40.wav",
		"left4dead/vocals/infected/l4d1/alert/alert/alert41.wav",
		"left4dead/vocals/infected/l4d1/alert/alert/alert42.wav",
		"left4dead/vocals/infected/l4d1/alert/alert/alert43.wav",
		"left4dead/vocals/infected/l4d1/alert/alert/alert44.wav",
		"left4dead/vocals/infected/l4d1/alert/alert/"..self.Gender.."/alert50.wav",
		"left4dead/vocals/infected/l4d1/alert/alert/"..self.Gender.."/alert51.wav",
		"left4dead/vocals/infected/l4d1/alert/alert/"..self.Gender.."/alert52.wav",
		"left4dead/vocals/infected/l4d1/alert/alert/"..self.Gender.."/alert53.wav",
		"left4dead/vocals/infected/l4d1/alert/alert/"..self.Gender.."/alert54.wav",
		"left4dead/vocals/infected/l4d1/alert/alert/"..self.Gender.."/alert55.wav"
	}
	
	-- We luanched our melee attack
	ZCommon_L4D1_BecomeEnraged = {
		"left4dead/vocals/infected/l4d1/alert/becomeenraged/alert24.wav",
		"left4dead/vocals/infected/l4d1/alert/becomeenraged/become_enraged01.wav",
		"left4dead/vocals/infected/l4d1/alert/becomeenraged/become_enraged02.wav",
		"left4dead/vocals/infected/l4d1/alert/becomeenraged/become_enraged03.wav",
		"left4dead/vocals/infected/l4d1/alert/becomeenraged/become_enraged06.wav",
		"left4dead/vocals/infected/l4d1/alert/becomeenraged/become_enraged07.wav",
		"left4dead/vocals/infected/l4d1/alert/becomeenraged/become_enraged09.wav",
		"left4dead/vocals/infected/l4d1/alert/becomeenraged/become_enraged10.wav",
		"left4dead/vocals/infected/l4d1/alert/becomeenraged/become_enraged11.wav",
		"left4dead/vocals/infected/l4d1/alert/becomeenraged/become_enraged30.wav",
		"left4dead/vocals/infected/l4d1/alert/becomeenraged/"..self.Gender.."/become_enraged40.wav",
		"left4dead/vocals/infected/l4d1/alert/becomeenraged/"..self.Gender.."/become_enraged41.wav",
		"left4dead/vocals/infected/l4d1/alert/becomeenraged/"..self.Gender.."/become_enraged42.wav",
		"left4dead/vocals/infected/l4d1/alert/becomeenraged/"..self.Gender.."/become_enraged43.wav"
	}
	-- raging mad, running through the streets, NO SPECIFIC VICTIM
	ZCommon_L4D1_Rage = {
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_50.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_51.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_52.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_53.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_54.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_55.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_56.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_57.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_58.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_59.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_60.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_61.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_62.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_64.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_65.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_66.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_67.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_68.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_69.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_70.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_71.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_72.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_73.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_74.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_75.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_76.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_77.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_78.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_79.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_80.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_81.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_82.wav",
	}
	
	-- chasing, raging mad, at a target we can see, VICTIM HAS BEEN DETERMINED AND IS BEING YELLED AT 
	ZCommon_L4D1_RageAtVictim = {
		"left4dead/vocals/infected/l4d1/action/rageat/rage_at_victim01.wav",
		"left4dead/vocals/infected/l4d1/action/rageat/rage_at_victim02.wav",
		"left4dead/vocals/infected/l4d1/action/rageat/rage_at_victim21.wav",
		"left4dead/vocals/infected/l4d1/action/rageat/rage_at_victim22.wav",
		"left4dead/vocals/infected/l4d1/action/rageat/rage_at_victim25.wav",
		"left4dead/vocals/infected/l4d1/action/rageat/rage_at_victim26.wav",
		"left4dead/vocals/infected/l4d1/action/rageat/rage_at_victim34.wav",
		"left4dead/vocals/infected/l4d1/action/rageat/rage_at_victim35.wav",
		"left4dead/vocals/infected/l4d1/action/rageat/snarl_4.wav",
		"left4dead/vocals/infected/l4d1/action/rageat/"..self.Gender.."/rage_at_victim20.wav",
		"left4dead/vocals/infected/l4d1/action/rageat/"..self.Gender.."/rage_at_victim21.wav",
		"left4dead/vocals/infected/l4d1/action/rageat/"..self.Gender.."/rage_at_victim22.wav",
		"left4dead/vocals/infected/l4d1/action/rageat/"..self.Gender.."/rage_at_victim23.wav",
		"left4dead/vocals/infected/l4d1/action/rageat/"..self.Gender.."/rage_at_victim24.wav",
		"left4dead/vocals/infected/l4d1/action/rageat/"..self.Gender.."/rage_at_victim25.wav",
		"left4dead/vocals/infected/l4d1/action/rageat/"..self.Gender.."/rage_at_victim26.wav",
		"left4dead/vocals/infected/l4d1/action/rageat/"..self.Gender.."/rage_at_victim27.wav",
		"left4dead/vocals/infected/l4d1/action/rageat/"..self.Gender.."/rage_at_victim28.wav",
		"left4dead/vocals/infected/l4d1/action/rageat/"..self.Gender.."/rage_at_victim29.wav",
		"left4dead/vocals/infected/l4d1/action/rageat/"..self.Gender.."/rage_at_victim30.wav",
		"left4dead/vocals/infected/l4d1/action/rageat/"..self.Gender.."/rage_at_victim31.wav",
		"left4dead/vocals/infected/l4d1/action/rageat/"..self.Gender.."/rage_at_victim32.wav",
		"left4dead/vocals/infected/l4d1/action/rageat/"..self.Gender.."/rage_at_victim33.wav",
		"left4dead/vocals/infected/l4d1/action/rageat/"..self.Gender.."/rage_at_victim34.wav",
		"left4dead/vocals/infected/l4d1/action/rageat/"..self.Gender.."/rage_at_victim35.wav",
		"left4dead/vocals/infected/l4d1/action/rageat/"..self.Gender.."/rage_at_victim36.wav",
		"left4dead/vocals/infected/l4d1/action/rageat/"..self.Gender.."/rage_at_victim37.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_50.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_51.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_52.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_53.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_54.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_55.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_56.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_57.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_58.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_59.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_60.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_61.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_62.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_64.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_65.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_66.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_67.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_68.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_69.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_70.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_71.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_72.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_73.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_74.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_75.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_76.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_77.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_78.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_79.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_80.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_81.wav",
		"left4dead/vocals/infected/l4d1/action/rage/"..self.Gender.."/rage_82.wav",
	}
	
	-- Got shoved / stumbled from something or someone
	ZCommon_L4D1_Shoved = {
		"left4dead/vocals/infected/l4d1/action/rage/shoved_1.wav",
		"left4dead/vocals/infected/l4d1/action/rage/shoved_2.wav",
		"left4dead/vocals/infected/l4d1/action/rage/shoved_3.wav",
		"left4dead/vocals/infected/l4d1/action/rage/shoved_4.wav",
		"left4dead/vocals/infected/l4d1/action/shoved/mp/shoved_01.wav",
		"left4dead/vocals/infected/l4d1/action/shoved/mp/shoved_02.wav",
		"left4dead/vocals/infected/l4d1/action/shoved/mp/shoved_03.wav",
		"left4dead/vocals/infected/l4d1/action/shoved/mp/shoved_04.wav",
		"left4dead/vocals/infected/l4d1/action/shoved/mp/shoved_05.wav",
		"left4dead/vocals/infected/l4d1/action/shoved/mp/shoved_06.wav",
		"left4dead/vocals/infected/l4d1/action/shoved/mp/shoved_07.wav",
		"left4dead/vocals/infected/l4d1/action/shoved/mp/shoved_08.wav",
		"left4dead/vocals/infected/l4d1/action/shoved/mp/shoved_09.wav",
		"left4dead/vocals/infected/l4d1/action/shoved/mp/shoved_10.wav",
		"left4dead/vocals/infected/l4d1/action/shoved/mp/shoved_11.wav",
		"left4dead/vocals/infected/l4d1/action/shoved/mp/shoved_12.wav",
		"left4dead/vocals/infected/l4d1/action/shoved/mp/shoved_13.wav",
		"left4dead/vocals/infected/l4d1/action/shoved/mp/shoved_14.wav",
		"left4dead/vocals/infected/l4d1/action/shoved/mp/shoved_15.wav",
		"left4dead/vocals/infected/l4d1/action/shoved/mp/shoved_16.wav",
		"left4dead/vocals/infected/l4d1/action/shoved/mp/shoved_17.wav",
		"left4dead/vocals/infected/l4d1/action/shoved/mp/shoved_long_1.wav",
		"left4dead/vocals/infected/l4d1/action/shoved/mp/shoved_long_2.wav",
		"left4dead/vocals/infected/l4d1/action/shoved/mp/shoved_long_3.wav"
	}
	
	ZCommon_L4D1_Death = {
		"left4dead/vocals/infected/death/mp/odd_2.wav",
		"left4dead/vocals/infected/death/mp/odd_3.wav",
		"left4dead/vocals/infected/death/mp/odd_4.wav",
		"left4dead/vocals/infected/death/mp/odd_5.wav",
		"left4dead/vocals/infected/death/mp/squeal_1.wav",
		"left4dead/vocals/infected/death/mp/squeal_2.wav",
		"left4dead/vocals/infected/death/mp/squeal_3.wav",
		"left4dead/vocals/infected/death/mp/squeal_4.wav",
		"left4dead/vocals/infected/l4d1/action/die/death_14.wav",
		"left4dead/vocals/infected/l4d1/action/die/death_17.wav",
		"left4dead/vocals/infected/l4d1/action/die/death_18.wav",
		"left4dead/vocals/infected/l4d1/action/die/death_19.wav",
		"left4dead/vocals/infected/l4d1/action/die/death_22.wav",
		"left4dead/vocals/infected/l4d1/action/die/death_23.wav",
		"left4dead/vocals/infected/l4d1/action/die/death_24.wav",
		"left4dead/vocals/infected/l4d1/action/die/death_25.wav",
		"left4dead/vocals/infected/l4d1/action/die/death_26.wav",
		"left4dead/vocals/infected/l4d1/action/die/death_27.wav",
		"left4dead/vocals/infected/l4d1/action/die/death_28.wav",
		"left4dead/vocals/infected/l4d1/action/die/death_29.wav",
		"left4dead/vocals/infected/l4d1/action/die/death_30.wav",
		"left4dead/vocals/infected/l4d1/action/die/death_32.wav",
		"left4dead/vocals/infected/l4d1/action/die/death_33.wav",
		"left4dead/vocals/infected/l4d1/action/die/death_34.wav",
		"left4dead/vocals/infected/l4d1/action/die/death_35.wav",
		"left4dead/vocals/infected/l4d1/action/die/death_36.wav",
		"left4dead/vocals/infected/l4d1/action/die/death_37.wav",
		"left4dead/vocals/infected/l4d1/action/die/death_38.wav",
		"left4dead/vocals/infected/death/"..self.Gender.."/death_40.wav",
		"left4dead/vocals/infected/death/"..self.Gender.."/death_41.wav",
		"left4dead/vocals/infected/death/"..self.Gender.."/death_42.wav",
		"left4dead/vocals/infected/death/"..self.Gender.."/death_43.wav",
		"left4dead/vocals/infected/death/"..self.Gender.."/death_44.wav",
		"left4dead/vocals/infected/death/"..self.Gender.."/death_45.wav",
		"left4dead/vocals/infected/death/"..self.Gender.."/death_46.wav",
		"left4dead/vocals/infected/death/"..self.Gender.."/death_47.wav",
		"left4dead/vocals/infected/death/"..self.Gender.."/death_48.wav",
		"left4dead/vocals/infected/death/"..self.Gender.."/death_49.wav",
	}
end