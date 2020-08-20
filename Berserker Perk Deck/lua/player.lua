berserker_t = 0 -- do NOT make local --<-- variable to store additional Swan Song duration gained from damaging/kills
time_decrease = 1.0 -- do NOT make local --<-- variable storing decrease value of Swan Song duration gained from damaging/kills
decrease_value = 0.01 -- do NOT make local --<-- variable to sets the percentual amount Swan Song duration gained from damaging/kills gets decreased
-- ^^^ Change this decrease_value to set the percentual decrease of gained Swan Song time -- example 0.01 == 1%, 0.1 == 10%, 0.05 == 5%, 0.5 == 50%

----------------------------------------------------------------------------------------------------[[ PlayerManager ]]
if RequiredScript == "lib/managers/playermanager" then
    ---------------------------------------------------------------------------------------------------- Fixes display of health in menu
	local old_health_func = PlayerManager.health_skill_multiplier
	function PlayerManager:health_skill_multiplier()
		local multiplier = old_health_func(self)

		if self:has_category_upgrade("player", "berserker_health") then
			multiplier = multiplier - self:upgrade_value("player", "berserker_health", 0)
		end

		return multiplier
	end
    ---------------------------------------------------------------------------------------------------- Berserk Time on killshot
    Hooks:PreHook(PlayerManager, "on_killshot", "beserker_on_killshot", function(self, killed_unit, variant, headshot, weapon_id)
        if self:has_category_upgrade("player", "berserker_time_on_killshot") then
            berserker_t = berserker_t + self:upgrade_value("player", "berserker_time_on_killshot") * time_decrease
        end
    end)

    ---------------------------------------------------------------------------------------------------- Swan Song Activity
    --[[
    Checks if Swan Song is still active
    ]]
    function PlayerManager:has_activate_temporary_upgrade(category, upgrade)
        local upgrade_value = self:upgrade_value(category, upgrade)
    
        if upgrade_value == 0 then
            return false
        end
    
        if not self._temporary_upgrades[category] then
            return false
        end
    
        if not self._temporary_upgrades[category][upgrade] then
            return false
        end

        -------------------------------------------------- Swan Song is active. berserker_t fills the difference + the bonus time exists in update_t
        local local_t = Application:time() --<-- Might be more efficient
        if upgrade == "berserker_damage_multiplier" and self:has_category_upgrade("temporary", "berserker_time_increase") then
            -------------------------------------------------- Add berserker_t time up to maximum swan song time
            if (self._temporary_upgrades[category][upgrade].expire_time + berserker_t) > (local_t + self:upgrade_value("temporary", "berserker_time_increase")) then
                self._temporary_upgrades[category][upgrade].expire_time = local_t + self:upgrade_value("temporary", "berserker_time_increase")
                berserker_t = 0
            else 
                self._temporary_upgrades[category][upgrade].expire_time = self._temporary_upgrades[category][upgrade].expire_time + berserker_t
                berserker_t = 0
            end
            -------------------------------------------------- Return corrected time in case you have swan song base/aced
            if self:has_category_upgrade("temporary", "swan_song_aced") then
                return local_t < (self._temporary_upgrades[category][upgrade].expire_time + self:upgrade_value_by_level("temporary", "berserker_damage_multiplier", 2)[2])
            end
            if self:has_category_upgrade("temporary", "swan_song_basic") then
                return local_t < (self._temporary_upgrades[category][upgrade].expire_time + self:upgrade_value_by_level("temporary", "berserker_damage_multiplier", 1)[2])
            end
        end

        return local_t < self._temporary_upgrades[category][upgrade].expire_time
    end
    
    ---------------------------------------------------------------------------------------------------- Berserker Movement
    local old_speed_func = PlayerManager.movement_speed_multiplier
    function PlayerManager:movement_speed_multiplier(speed_state, bonus_multiplier, upgrade_level, health_ratio)
        multiplier = old_speed_func(self, speed_state, bonus_multiplier, upgrade_level, health_ratio)
        
        if managers.player:has_activate_temporary_upgrade("temporary", "berserker_damage_multiplier") then
            return multiplier + self:upgrade_value("temporary", "berserker_movement")
        end

        return multiplier
    end
end

----------------------------------------------------------------------------------------------------[[ PlayerDamage ]]
if RequiredScript == "lib/units/beings/player/playerdamage" then
    ---------------------------------------------------------------------------------------------------- Init Berserker time on damage
    local old_init = PlayerDamage.init
    function PlayerDamage:init(unit)
        old_init(self, unit)
        if managers.player:has_category_upgrade("player", "berserker_time_on_damage") then
            local damage_to_berserker_time_data = managers.player:upgrade_value("player", "berserker_time_on_damage", nil)
            local armor_data = tweak_data.blackmarket.armors[managers.blackmarket:equipped_armor(true, true)]
    
            if damage_to_berserker_time_data and armor_data then
                local idx = armor_data.upgrade_level
                self._damage_to_armor = {
                    armor_value = damage_to_berserker_time_data[idx][1],
                    target_tick = damage_to_berserker_time_data[idx][2],
                    elapsed = 0
                }
    
                local function on_damage(damage_info)
                    local attacker_unit = damage_info and damage_info.attacker_unit
    
                    if alive(attacker_unit) and attacker_unit:base() and attacker_unit:base().thrower_unit then
                        attacker_unit = attacker_unit:base():thrower_unit()
                    end
    
                    if self._unit == attacker_unit then
                        local time = Application:time()
    
                        if self._damage_to_armor.target_tick < time - self._damage_to_armor.elapsed then
                            self._damage_to_armor.elapsed = time
    
                            berserker_t = berserker_t + self._damage_to_armor.armor_value * time_decrease
                        end
                    end
                end
    
                CopDamage.register_listener("on_damage", {
                    "on_damage"
                }, on_damage)
            end
        end
    end

    ---------------------------------------------------------------------------------------------------- Update Berserker Time
    function PlayerDamage:update(unit, t, dt)
        if _G.IS_VR and self._heartbeat_t and t < self._heartbeat_t then
            local intensity_mul = 1 - (t - self._heartbeat_start_t) / (self._heartbeat_t - self._heartbeat_start_t)
            local controller = self._unit:base():controller():get_controller("vr")
    
            for i = 0, 1 do
                local intensity = get_heartbeat_value(t)
                intensity = intensity * (1 - math.clamp(self:health_ratio() / 0.3, 0, 1))
                intensity = intensity * intensity_mul
    
                controller:trigger_haptic_pulse(i, 0, intensity * 900)
            end
        end
    
        self:_check_update_max_health()
        self:_check_update_max_armor()
        self:_update_can_take_dmg_timer(dt)
        self:_update_regen_on_the_side(dt)
    
        if not self._armor_stored_health_max_set then
            self._armor_stored_health_max_set = true
    
            self:update_armor_stored_health()
        end
    
        if managers.player:has_activate_temporary_upgrade("temporary", "chico_injector") then
            self._chico_injector_active = true
            local total_time = managers.player:upgrade_value("temporary", "chico_injector")[2]
            local current_time = managers.player:get_activate_temporary_expire_time("temporary", "chico_injector") - t
    
            managers.hud:set_player_ability_radial({
                current = current_time,
                total = total_time
            })
        elseif self._chico_injector_active then
            managers.hud:set_player_ability_radial({
                current = 0,
                total = 1
            })
    
            self._chico_injector_active = nil
        end

        -------------------------------------------------- Swan Song activated via Berserker
        local is_berserker_active = managers.player:has_activate_temporary_upgrade("temporary", "berserker_damage_multiplier")
    
        if self._check_berserker_done then
            if is_berserker_active then
                if self._unit:movement():tased() then
                    self._tased_during_berserker = true
                else
                    self._tased_during_berserker = false
                end
            end
    
            if not is_berserker_active then
                
                berserker_t = 0

                if self._unit:movement():tased() then
                    self._bleed_out_blocked_by_tased = true
                else
                    self._bleed_out_blocked_by_tased = false
                    self._check_berserker_done = nil
    
                    managers.hud:set_teammate_condition(HUDManager.PLAYER_PANEL, "mugshot_normal", "")
                    managers.hud:set_player_custom_radial({
                        current = 0,
                        total = self:_max_health(),
                        revives = Application:digest_value(self._revives, false)
                    })
                    self:force_into_bleedout()
    
                    if not self._bleed_out then
                        self._disable_next_swansong = true
                    end
                end
            else
                -------------------------------------------------- Time update for Swan Song
                local expire_time = managers.player:get_activate_temporary_expire_time("temporary", "berserker_damage_multiplier")
                local total_time = managers.player:upgrade_value("temporary", "berserker_damage_multiplier")
                total_time = total_time and total_time[2] or 0

                --
                if managers.player:has_category_upgrade("temporary", "berserker_time_increase") then
                    if managers.player:has_category_upgrade("temporary", "swan_song_aced") then
                        expire_time = expire_time + managers.player:upgrade_value_by_level("temporary", "berserker_damage_multiplier", 2)[2]
                        total_time = total_time + managers.player:upgrade_value_by_level("temporary", "berserker_damage_multiplier", 2)[2]
                    elseif  managers.player:has_category_upgrade("temporary", "swan_song_basic") then
                        expire_time = expire_time + managers.player:upgrade_value_by_level("temporary", "berserker_damage_multiplier", 1)[2]
                        total_time = total_time + managers.player:upgrade_value_by_level("temporary", "berserker_damage_multiplier", 1)[2]
                    end
                end
                --

                local delta = 0
                local max_health = self:_max_health()
    
                if total_time ~= 0 then
                    delta = math.clamp((expire_time - Application:time()) / total_time, 0, 1)
                end
    
                managers.hud:set_player_custom_radial({
                    current = delta * max_health,
                    total = max_health,
                    revives = Application:digest_value(self._revives, false)
                })
                managers.network:session():send_to_peers("sync_swansong_timer", self._unit, delta * max_health, max_health, Application:digest_value(self._revives, false), managers.network:session():local_peer():id())
            end
        end
    
        if self._bleed_out_blocked_by_zipline and not self._unit:movement():zipline_unit() then
            self:force_into_bleedout(true)
    
            self._bleed_out_blocked_by_zipline = nil
        end
    
        if self._bleed_out_blocked_by_movement_state and not self._unit:movement():current_state():bleed_out_blocked() then
            self:force_into_bleedout()
    
            self._bleed_out_blocked_by_movement_state = nil
        end
    
        if self._bleed_out_blocked_by_tased and not self._tased_during_berserker and not self._unit:movement():tased() then
            self:force_into_bleedout()
    
            self._bleed_out_blocked_by_tased = nil
        end
    
        if self._current_state then
            self:_current_state(t, dt)
        end
    
        self:_update_armor_hud(t, dt)
    
        if self._tinnitus_data then
            self._tinnitus_data.intensity = (self._tinnitus_data.end_t - t) / self._tinnitus_data.duration
    
            if self._tinnitus_data.intensity <= 0 then
                self:_stop_tinnitus()
            else
                SoundDevice:set_rtpc("downed_state_progression", math.max(self._downed_progression or 0, self._tinnitus_data.intensity * 100))
            end
        end
    
        if self._concussion_data then
            self._concussion_data.intensity = (self._concussion_data.end_t - t) / self._concussion_data.duration
    
            if self._concussion_data.intensity <= 0 then
                self:_stop_concussion()
            else
                SoundDevice:set_rtpc("concussion_effect", self._concussion_data.intensity * 100)
            end
        end
    
        if not self._downed_timer and self._downed_progression then
            self._downed_progression = math.max(0, self._downed_progression - dt * 50)
    
            if not _G.IS_VR then
                managers.environment_controller:set_downed_value(self._downed_progression)
            end
    
            SoundDevice:set_rtpc("downed_state_progression", self._downed_progression)
    
            if self._downed_progression == 0 then
                self._unit:sound():play("critical_state_heart_stop")
    
                self._downed_progression = nil
            end
        end
    
        if self._auto_revive_timer then
            if not managers.platform:presence() == "Playing" or not self._bleed_out or self._dead or self:incapacitated() or self:arrested() or self._check_berserker_done then
                self._auto_revive_timer = nil
            else
                self._auto_revive_timer = self._auto_revive_timer - dt
    
                if self._auto_revive_timer <= 0 then
                    self:revive(true)
                    self._unit:sound_source():post_event("nine_lives_skill")
    
                    self._auto_revive_timer = nil
                end
            end
        end
    
        if self._revive_miss then
            self._revive_miss = self._revive_miss - dt
    
            if self._revive_miss <= 0 then
                self._revive_miss = nil
            end
        end
    
        self:_upd_suppression(t, dt)
    
        if not self._dead and not self._bleed_out and not self._check_berserker_done then
            self:_upd_health_regen(t, dt)
        end
    
        if not self:is_downed() then
            self:_update_delayed_damage(t, dt)
        end
    end

    ---------------------------------------------------------------------------------------------------- Additional Lives Berserker
    function PlayerDamage:band_aid_health()
        if managers.platform:presence() == "Playing" and (self:arrested() or self:need_revive()) then
            return
        end
    
        self:change_health(self:_max_health() * self._healing_reduction)
    
        self._said_hurt = false
    
        if math.rand(1) < managers.player:upgrade_value("first_aid_kit", "downs_restore_chance", 0) then --<-- Unused player upgrade that makes first aid kit restore downs with 10% chance
            self._revives = Application:digest_value(math.min(self._lives_init + managers.player:upgrade_value("player", "additional_lives", 0) + managers.player:upgrade_value("player", "berserker_lives", 0), Application:digest_value(self._revives, false) + 1), true)
            self._revive_health_i = math.max(self._revive_health_i - 1, 1)
    
            managers.environment_controller:set_last_life(Application:digest_value(self._revives, false) <= 1)
        end
    end

    ---------------------------------------------------------------------------------------------------- Additional Lives Berserker
    function PlayerDamage:_regenerated(no_messiah)
        self:set_health(self:_max_health())
        self:_send_set_health()
        self:_set_health_effect()
    
        self._said_hurt = false
        self._revives = Application:digest_value(self._lives_init + managers.player:upgrade_value("player", "additional_lives", 0) + managers.player:upgrade_value("player", "berserker_lives", 0), true)
        self._revive_health_i = 1
    
        managers.environment_controller:set_last_life(false)
    
        self._down_time = tweak_data.player.damage.DOWNED_TIME
    
        if not no_messiah then
            self._messiah_charges = managers.player:upgrade_value("player", "pistol_revive_from_bleed_out", 0)
        end
    end

    ---------------------------------------------------------------------------------------------------- Cheat Death Berserker
    function PlayerDamage:_chk_cheat_death()
        if Application:digest_value(self._revives, false) > 1 and not self._check_berserker_done and (managers.player:has_category_upgrade("player", "cheat_death_chance") or managers.player:has_category_upgrade("player", "berserker_cheat_death_chance")) then
            local r = math.rand(1)
    
            if r <= (managers.player:upgrade_value("player", "cheat_death_chance", 0) + managers.player:upgrade_value("player", "berserker_cheat_death_chance", 0)) then
                time_decrease = time_decrease - decrease_value --<-- decrease the time gained from berserker damage/kills by decrease_value for each down
                self._auto_revive_timer = 1
            end
        end
    end
end