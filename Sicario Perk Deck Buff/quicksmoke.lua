function PlayerManager:__is_smoke_screen_grenade()
	return managers.blackmarket:equipped_grenade() == "smoke_screen_grenade" and self.__smoke_screen_grenade_init and self.__is_smoke_screen_grenade_ok
end

function PlayerManager:__smoke_screen_grenade_unit_name()
	return self.__smoke_screen_grenade
end

function PlayerManager:__clbk_smoke_screen_grenade_unit_loaded()
	self.__is_smoke_screen_grenade_ok = true
	if self:__is_smoke_screen_grenade() then
		self:register_message(Message.OnEnemyKilled, "__"..Idstring("Sicario Perk Deck Buff: Speed it Up!!"):key(), function ()
			managers.player:speed_up_grenade_cooldown(6)
		end) 
	end
end

Hooks:PostHook(PlayerManager, "spawned_player", "F_"..Idstring("PostHook:PlayerManager:spawned_player:Sicario Perk Deck Buff"):key(), function(self)
	if not self.__smoke_screen_grenade_init then
		self.__smoke_screen_grenade_init = true
		self.__smoke_screen_grenade = Idstring("units/pd2_dlc_max/weapons/wpn_fps_smoke_screen_grenade/wpn_fps_smoke_screen_grenade_husk")
		if not managers.dyn_resource:is_resource_ready(Idstring("unit"), self.__smoke_screen_grenade, managers.dyn_resource.DYN_RESOURCES_PACKAGE) then
			managers.dyn_resource:load(Idstring("unit"), self.__smoke_screen_grenade, managers.dyn_resource.DYN_RESOURCES_PACKAGE, callback(self, self, "__clbk_smoke_screen_grenade_unit_loaded"))
		else
			self:__clbk_smoke_screen_grenade_unit_loaded()
		end
	end
end)

Hooks:PostHook(PlayerManager, "update", "F_"..Idstring("PostHook:PlayerManager:update:Sicario Perk Deck Buff"):key(), function(self, t, dt)
	if self.__QuickSmokeHusk and self.__QuickSmokeHusk.update then
		self.__QuickSmokeHusk:update(t, dt)
	end
end)