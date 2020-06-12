Hooks:PostHook(SkillTreeTweakData, "init", "hustler_skilltree_init", function(self, tweak_data)
	local s = tostring(table.maxn(self.specializations) + 1)

	table.insert(self.specializations, {
		name_id = "menu_st_spec_" .. s,
		desc_id = "menu_st_spec_" .. s .. "_desc",
		{
			upgrades = {		--1
								--low hp, high dodge
				"hustlerHealth",
				"hustlerHealthVisual",
				"hustlerDodge"
			},
			cost = 0,
			icon_xy = {7, 6},
			name_id = "menu_deck" .. s .. "_1",
			desc_id = "menu_deck" .. s .. "_1_desc"
		},	
			
		{
			upgrades = {		--2
				"weapon_passive_headshot_damage_multiplier"
			},
			cost = 0,
			icon_xy = {1, 0},
			name_id = "menu_deck" .. s .. "_2",
			desc_id = "menu_deck" .. s .. "_2_desc"
		},
			
		{
			upgrades = {		--3
								--no armor recovery, damage to armor
				"hustlerNoArmor",
				"hustlerDamageArmor"
			},
			cost = 0,
			icon_xy = {7, 7},
			name_id = "menu_deck" .. s .. "_3",
			desc_id = "menu_deck" .. s .. "_3_desc"
		},
			
		{
			upgrades = {		--4
				"passive_player_xp_multiplier",
				"player_passive_suspicion_bonus",
				"player_passive_armor_movement_penalty_multiplier"
			},
			cost = 0,
			icon_xy = {3, 0},
			name_id = "menu_deck" .. s .. "_4",
			desc_id = "menu_deck" .. s .. "_4_desc"
		},
			
		{
			upgrades = {		--5
								--kills to armor
				"hustlerKillArmor"
			},
			cost = 0,
			icon_xy = {2, 0},
			name_id = "menu_deck" .. s .. "_5",
			desc_id = "menu_deck" .. s .. "_5_desc"
		},
			
		{
			upgrades = {		--6
				"armor_kit",
				"player_pick_up_ammo_multiplier"
			},
			cost = 0,
			icon_xy = {5, 0},
			name_id = "menu_deck" .. s .. "_6",
			desc_id = "menu_deck" .. s .. "_6_desc"
		},
			
		{
			upgrades = {		--7
								--extra armorS
				"hustlerArmorRaw",
				"hustlerArmor"
			},
			cost = 0,
			icon_xy = {2, 7},
			name_id = "menu_deck" .. s .. "_7",
			desc_id = "menu_deck" .. s .. "_7_desc"
		},
			
		{
			upgrades = {		--8
				"weapon_passive_damage_multiplier",
				"passive_doctor_bag_interaction_speed_multiplier"
			},
			cost = 0,
			icon_xy = {7, 0},
			name_id = "menu_deck" .. s .. "_8",
			desc_id = "menu_deck" .. s .. "_8_desc"
		},
			
		{
			upgrades = {		--9
								--close kills to armor
								
				"hustlerKillArmorClose",
				"player_passive_loot_drop_multiplier"	
			},
			cost = 0,
			icon_xy = {3, 1},
			name_id = "menu_deck" .. s .. "_9",
			desc_id = "menu_deck" .. s .. "_9_desc"
		}
	})
end)
