Hooks:PostHook(UpgradesTweakData, "init", "hustler_upgrades_init", function(self, tweak_data)
-------------------------------------------------- init values --------------------------------------------------	

	--1
	local v1 = table.maxn(self.values.player.passive_dodge_chance) + 1
	self.values.player.hustler_health = { 229/230 } --<-- multiplier reducing healh as displayed in menu screen
	self.values.player.hustler_health_visual = { 0.001 } --<-- caps max health at 0.1% for full berserker effect
	self.values.player.passive_dodge_chance[v1] = 0.35 --<-- bonus dodge chance

	--3
	local v2 = table.maxn(self.values.player.armor_regen_timer_multiplier_passive) + 1
	local v3 = table.maxn(self.values.player.damage_to_armor) + 1
	self.values.player.armor_regen_timer_multiplier_passive[v2] = 1000000 --<-- multiplier to practically disable armor regeneration
	self.values.player.damage_to_armor[v3] = { --<-- armor gained per damage dealt in format { <armor>, <cooldown> } where value <armor> will give 10x its value 
													-- e.g. { 1, 0.1 } = 10 armor per damage dealt 0.1 seconds cooldown
													-- armor gain can be different per armor type
		-- Suit/LBV/BV/HBV/Flak Jacket/CTV/ICTV
		{ 1, 0.1 }, --<-- Suit
		{ 1, 0.1 },
		{ 1, 0.1 },
		{ 1, 0.1 },
		{ 1, 0.1 },
		{ 1, 0.1 },
		{ 1, 0.1 }
	}

	--5
	self.values.player.hustler_kill_armor = { --<-- multiplier for armor gained on kill; armor gained per kill is last damage taken (calculated in player.lua file)
													-- percentage armor gain of last damage taken can be different per difficulty
		-- easy(?)/Normal/Hard/Very Hard/Overkill/Mayhem/Deathwish/Death Sentence
		{ 
			0.42,
			0.42,
			0.42,
			0.42,
			0.42, --<-- Overkill
			0.42,
			0.42,
			0.42
		} 
	}

	--7
	local v4 = table.maxn(self.values.player.tier_armor_multiplier) + 1
	self.values.player.hustler_armor_raw = { 8 } --<-- raw armor bonus added before armor multipliers; e.g. 8 is 80 armor
	self.values.player.tier_armor_multiplier[v4] = 2.5 --<-- armor multiplier; e.g. armor * 2.5 = armor + 150% * armor

	--9
	self.values.player.hustler_kill_armor_close = { --<-- multiplier for armor gained on kill withn 18m (?); armor gained per kill is last damage taken (calculated in player.lua file)
														-- percentage armor gain of last damage taken can be different per difficulty
		-- easy(?)/Normal/Hard/Very Hard/Overkill/Mayhem/Deathwish/Death Sentence
		{ 
			0.69,
			0.69,
			0.69,
			0.69,
			0.69, --<-- Overkill
			0.69,
			0.69,
			0.69
		} 
	}

-------------------------------------------------- definitions --------------------------------------------------

	--1
	self.definitions.hustlerHealth = {
		name_id = "menu_player_hustler_health",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "hustler_health",
			category = "player"
		}
	}
	self.definitions.hustlerHealthVisual = {
		name_id = "menu_player_hustler_health_visual",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "hustler_health_visual",
			category = "player"
		}
	}
	
	self.definitions.hustlerDodge = {
		name_id = "menu_player_run_dodge_chance",
		category = "feature",
		upgrade = {
			value = v1,
			upgrade = "passive_dodge_chance",
			category = "player"
		}
	}

	--3
	self.definitions.hustlerNoArmor = {
		name_id = "menu_player_armor_regen_timer_multiplier_passive",
		category = "feature",
		upgrade = {
			value = v2,
			upgrade = "armor_regen_timer_multiplier_passive",
			category = "player"
		}
	}
	self.definitions.hustlerDamageArmor = {
		name_id = "menu_player_damage_to_armor",
		category = "feature",
		upgrade = {
			value = v3,
			upgrade = "damage_to_armor",
			category = "player"
		}
	}

	--5
	self.definitions.hustlerKillArmor = {
		name_id = "menu_player_hustler_kill_armor",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "hustler_kill_armor",
			category = "player"
		}
	}

	--7
	self.definitions.hustlerArmorRaw = {
		category = "feature",
		name_id = "menu_player_hustler_armor_raw",
		upgrade = {
			category = "player",
			upgrade = "hustler_armor_raw",
			value = 1
		}
	}
	self.definitions.hustlerArmor = {
		category = "feature",
		name_id = "menu_player_tier_armor_multiplier",
		upgrade = {
			category = "player",
			upgrade = "tier_armor_multiplier",
			value = v4
		}
	}

	--9
	self.definitions.hustlerKillArmorClose = {
		name_id = "menu_player_hustler_kill_armor_close",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "hustler_kill_armor_close",
			category = "player"
		}
	}

end)