Hooks:PostHook(SkillTreeTweakData, "init", "berserker_skilltree_init", function(self, tweak_data)
	local s = table.maxn(self.specializations) + 1

	-- Perk deck costs
	local pdc1 = 0
	local pdc2 = 0
	local pdc3 = 0
	local pdc4 = 0
	local pdc5 = 0
	local pdc6 = 0
	local pdc7 = 0
	local pdc8 = 0
	local pdc9 = 0

	table.insert(self.specializations, {
		name_id = "menu_st_spec_" .. s,
		desc_id = "menu_st_spec_" .. s .. "_desc",
		{
			upgrades = {		--1
								-- Health reduction, Activate Swan Song, Swan Song time, Swan Song movement bonus
				"berserker_armor",
				"berserker_health",
				"berserker_swan_song",
				"berserker_time_increase",
				"berserker_movement"
			},
			cost = pdc1,
			icon_xy = {2, 7},
			name_id = "menu_deck" .. s .. "_1",
			desc_id = "menu_deck" .. s .. "_1_desc"
		},	
			
		{
			upgrades = {		--2
				"weapon_passive_headshot_damage_multiplier"
			},
			cost = pdc2,
			icon_xy = {1, 0},
			name_id = "menu_deck" .. s .. "_2",
			desc_id = "menu_deck" .. s .. "_2_desc"
		},
			
		{
			upgrades = {		--3
								-- Swan Song duration on damage dealt
				"berserker_time_on_damage"
			},
			cost = pdc3,
			icon_xy = {2, 7},
			name_id = "menu_deck" .. s .. "_3",
			desc_id = "menu_deck" .. s .. "_3_desc"
		},
			
		{
			upgrades = {		--4
				"passive_player_xp_multiplier",
				"player_passive_suspicion_bonus",
				"player_passive_armor_movement_penalty_multiplier"
			},
			cost = pdc4,
			icon_xy = {3, 0},
			name_id = "menu_deck" .. s .. "_4",
			desc_id = "menu_deck" .. s .. "_4_desc"
		},
			
		{
			upgrades = {		--5
								-- Auto-revive
				"berserker_cheat_death_chance"
			},
			cost = pdc5,
			icon_xy = {2, 7},
			name_id = "menu_deck" .. s .. "_5",
			desc_id = "menu_deck" .. s .. "_5_desc"
		},
			
		{
			upgrades = {		--6
				"armor_kit",
				"player_pick_up_ammo_multiplier"
			},
			cost = pdc6,
			icon_xy = {5, 0},
			name_id = "menu_deck" .. s .. "_6",
			desc_id = "menu_deck" .. s .. "_6_desc"
		},
			
		{
			upgrades = {		--7
								-- Swan Song duration on kill
				"berserker_time_on_killshot"
			},
			cost = pdc7,
			icon_xy = {2, 7},
			name_id = "menu_deck" .. s .. "_7",
			desc_id = "menu_deck" .. s .. "_7_desc"
		},
			
		{
			upgrades = {		--8
				"weapon_passive_damage_multiplier",
				"passive_doctor_bag_interaction_speed_multiplier"
			},
			cost = pdc8,
			icon_xy = {7, 0},
			name_id = "menu_deck" .. s .. "_8",
			desc_id = "menu_deck" .. s .. "_8_desc"
		},
			
		{
			upgrades = {		--9
								-- Additional lives
				"berserker_lives",
				"player_passive_loot_drop_multiplier"	
			},
			cost = pdc9,
			icon_xy = {2, 7},
			name_id = "menu_deck" .. s .. "_9",
			desc_id = "menu_deck" .. s .. "_9_desc"
		}
	})
	
	local t1 = table.maxn(self.skills.perseverance[1].upgrades) + 1
	local t2 = table.maxn(self.skills.perseverance[2].upgrades) + 1
	self.skills.perseverance[1].upgrades[t1] = "swan_song_basic"
	self.skills.perseverance[2].upgrades[t2] = "swan_song_aced"

end)
