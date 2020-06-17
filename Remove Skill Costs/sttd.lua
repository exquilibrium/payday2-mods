local old_init = SkillTreeTweakData.init
function SkillTreeTweakData:init(tweak_data)
	old_init(self, tweak_data)
	self.tier_cost = {
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		}
	}
end