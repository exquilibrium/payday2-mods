Hooks:PostHook(UpgradesTweakData, "init", "berserker_upgrades_init", function(self, tweak_data)
-------------------------------------------------- init values --------------------------------------------------	

	--0
	self.values.temporary.swan_song_basic = { 1 } --<-- Dummy variable needed to make Swan Song skill work with perk deck
	self.values.temporary.swan_song_aced = { 1 } --<-- Dummy variable needed to make Swan Song skill work with perk deck

	--1
	self.values.player.berserker_health = { 229/230 } --<-- Multiplier for your health
	local swan_song_t = 6 --<-- Additional Swan Song duration (stacks with Swan Song skill)
	local v1 = table.maxn(self.values.temporary.berserker_damage_multiplier) + 1
	self.values.temporary.berserker_damage_multiplier[v1] = { 1, swan_song_t } --<-- Stores Swan Song duration in original Swan Song table, also need to activate Swan Song when only having perk deck equipped
	self.values.temporary.berserker_time_increase = { swan_song_t } --<-- Stores Swan Song duration, needed to calculate perk deck Swan Song stacked with Swan Song skill
	self.values.temporary.berserker_movement = { 1 } --<-- Movement bonus added during Swan Song (normal Swan Song 40% movement speed, with perk deck 100% + 40% = 140% movement speed) 

	--3
	self.values.player.berserker_time_on_damage = { --<-- Swan Song duration gained per damage dealt; format { <seconds gaind>, <cooldown in seconds> }
		{
			{ 1.0, 0.5 }, --<-- Suit
			{ 1.0, 0.5 }, --<-- LBV
			{ 1.0, 0.5 }, --<-- BV
			{ 1.0, 0.5 }, --<-- HBV
			{ 1.0, 0.5 }, --<-- Flak Jacket
			{ 1.0, 0.5 }, --<-- CTV
			{ 1.0, 0.5 } --<-- ICTV
		}
	}

	--5
	self.values.player.berserker_cheat_death_chance = { 0.45 } --<-- Additional auto-revive chance (Stacks with skill)

	--7
	self.values.player.berserker_time_on_killshot = { 1.5 } --<-- Swan Song duration gained per kill, cooldown 1s

	--9
	self.values.player.berserker_lives = { 4 } --<-- Additional lives before going into arrest

-------------------------------------------------- definitions --------------------------------------------------

	--0
	self.definitions.swan_song_basic = {
		name_id = "menu_temporary_swan_song_basic",
		category = "temporary",
		upgrade = {
			value = 1,
			upgrade = "swan_song_basic",
			category = "temporary"
		}
	}
	self.definitions.swan_song_aced = { 
		name_id = "menu_temporary_swan_song_aced",
		category = "temporary",
		upgrade = {
			value = 1,
			upgrade = "swan_song_aced",
			category = "temporary"
		}
	}

	--1
	self.definitions.berserker_health = {
		name_id = "menu_player_berserker_health",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "berserker_health",
			category = "player"
		}
	}
	self.definitions.berserker_swan_song = {
		name_id = "menu_temporary_berserker_damage_multiplier",
		category = "temporary",
		upgrade = {
			value = v1,
			upgrade = "berserker_damage_multiplier",
			category = "temporary"
		}
	}
	self.definitions.berserker_time_increase = {
		name_id = "menu_temporary_berserker_time_increase",
		category = "temporary",
		upgrade = {
			value = 1,
			upgrade = "berserker_time_increase",
			category = "temporary"
		}
	}
	self.definitions.berserker_movement = {
		name_id = "menu_temporary_berserker_movement",
		category = "temporary",
		upgrade = {
			value = 1,
			upgrade = "berserker_movement",
			category = "temporary"
		}
	}



	--3
	self.definitions.berserker_time_on_damage = {
		name_id = "menu_player_berserker_time_on_damage",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "berserker_time_on_damage",
			category = "player"
		}
	}

	--5
	self.definitions.berserker_cheat_death_chance = {
		name_id = "menu_player_berserker_cheat_death_chance",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "berserker_cheat_death_chance",
			category = "player"
		}
	}

	--7
	self.definitions.berserker_time_on_killshot = {
		name_id = "menu_player_berserker_time_on_killshot",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "berserker_time_on_killshot",
			category = "player"
		}
	}

	--9
	self.definitions.berserker_lives = {
		name_id = "menu_player_berserker_lives",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "berserker_lives",
			category = "player"
		}
	}

end)