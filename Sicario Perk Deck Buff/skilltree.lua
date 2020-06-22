Hooks:PostHook(SkillTreeTweakData, "init", "F_"..Idstring("PostHook:SkillTreeTweakData:init:Perk Deck Buff"):key(), function(self)
	if self.specializations then
		table.insert(self.specializations[18][5].upgrades, "player_passive_dodge_chance_3")
	end
end)