last_dmg = 0
old_armor = 70

if RequiredScript == "lib/units/beings/player/playerdamage" then
	-- Fix ingame berserker health
	Hooks:PostHook(PlayerDamage, "init", "hustler_player_init", function(self, unit)
		if managers.player:has_category_upgrade("player", "hustler_health_visual") then
			self._max_health_reduction = managers.player:upgrade_value("player", "hustler_health_visual", 1)
			self:replenish()
		end
	end)

	-- Damage based armor gain
	Hooks:PreHook(PlayerDamage, "set_armor", "hustler_armor_gain", function(self, armor)
			if armor < old_armor then
				last_dmg = old_armor - armor
				old_armor = armor
			else
				old_armor = armor
			end
	end)
end

if RequiredScript == "lib/managers/playermanager" then
	-- Fixes display of armor in menu
	local old_armor_func = PlayerManager.body_armor_skill_addend
	function PlayerManager:body_armor_skill_addend(override_armor)
		local addend = old_armor_func(self, override_armor)
		
		if self:has_category_upgrade("player", "hustler_armor_raw") then
			addend = addend + self:upgrade_value("player", "hustler_armor_raw", 1)
		end

		return addend
	end

	-- Fixes display of health in menu
	local old_health_func = PlayerManager.health_skill_multiplier
	function PlayerManager:health_skill_multiplier()
		local multiplier = old_health_func(self)

		if self:has_category_upgrade("player", "hustler_health") then
			multiplier = multiplier - self:upgrade_value("player", "hustler_health", 0)
		end

		return multiplier
	end

	Hooks:PreHook(PlayerManager, "on_killshot", "hustler_on_killshot", function(self, killed_unit, variant, headshot, weapon_id)
		if self:has_category_upgrade("player", "hustler_kill_armor") then
			--------------------------------------------- Local variables for difficulty scaling 
			local difficulty = Global.game_settings and Global.game_settings.difficulty or "normal"
			local difficulty_index = tweak_data:difficulty_to_index(difficulty)
			---------------------------------------------

			local player_unit = self:player_unit()

			if not player_unit then
				return
			end

			--------------------------------------------- Hustler armor regen
			local damage_ext = player_unit:character_damage()
				regen_armor_bonus = last_dmg * self:upgrade_value("player", "hustler_kill_armor", 0)[difficulty_index]
			---------------------------------------------

			local dist_sq = mvector3.distance_sq(player_unit:movement():m_pos(), killed_unit:movement():m_pos())
			local close_combat_sq = tweak_data.upgrades.close_combat_distance * tweak_data.upgrades.close_combat_distance

			if dist_sq <= close_combat_sq then
				--------------------------------------------- Hustler armor regen close
				if self:has_category_upgrade("player", "hustler_kill_armor_close") then
					regen_armor_bonus = regen_armor_bonus + last_dmg * self:upgrade_value("player", "hustler_kill_armor_close", 0)[difficulty_index]
				end
				---------------------------------------------
			end

			if damage_ext and regen_armor_bonus > 0 then
				damage_ext:restore_armor(regen_armor_bonus)
			end
		end
	end)
end