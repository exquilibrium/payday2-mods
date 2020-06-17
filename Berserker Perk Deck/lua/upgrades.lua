Hooks:PostHook(UpgradesTweakData, "init", "berserker_upgrades_init", function(self, tweak_data)
-------------------------------------------------- init values --------------------------------------------------	

	--0
	self.values.temporary.swan_song_basic = { 1 }
	self.values.temporary.swan_song_aced = { 1 }

	--1
	local swan_song_t = 6
	local v1 = table.maxn(self.values.temporary.berserker_damage_multiplier) + 1
	self.values.temporary.berserker_damage_multiplier[v1] = { 1, swan_song_t }
	self.values.temporary.berserker_time_increase = { swan_song_t }
	self.values.temporary.berserker_movement = { 1 }

	--3
	self.values.player.berserker_time_on_damage = {
		{
			{ 1.0, 0.5 }, --<-- Suit
			{ 1.0, 0.5 },
			{ 1.0, 0.5 },
			{ 1.0, 0.5 },
			{ 1.0, 0.5 },
			{ 1.0, 0.5 },
			{ 1.0, 0.5 } --<-- ICTV
		}
	}

	--5
	self.values.player.berserker_cheat_death_chance = { 0.45 }

	--7
	self.values.player.berserker_time_on_killshot = { 3 }

	--9
	self.values.player.berserker_lives = { 4 }

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