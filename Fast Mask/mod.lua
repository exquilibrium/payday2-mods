local old_init = PlayerTweakData.init
function PlayerTweakData:init(tweak_data)
	old_init(self, tweak_data)
	self.put_on_mask_time = 0.5
end