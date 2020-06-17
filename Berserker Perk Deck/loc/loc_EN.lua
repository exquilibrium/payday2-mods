local s = "22"

local text_original = LocalizationManager.text
function LocalizationManager:text(string_id, ...)
return string_id == "menu_st_spec_" .. s and "Berserker"
or string_id == "menu_st_spec_" .. s .. "_desc" and "BERSERK TIME!!!"
or string_id == "menu_deck" .. s .. "_1" and "Going Berserk"
or string_id == "menu_deck" .. s .. "_1_desc" and "Upon dieing you will enter Swan Song.\nSwan Song duration increased by ##6## seconds.\n\nYour movement speed is increasd by ##40%## during Swan Song."
or string_id == "menu_deck" .. s .. "_2" and "Helmet Popping"
or string_id == "menu_deck" .. s .. "_2_desc" and "Increases your headshot damage by ##25%##."
or string_id == "menu_deck" .. s .. "_3" and "Continuous Rage"
or string_id == "menu_deck" .. s .. "_3_desc" and "Damaging enemies increases Swan Song duration by ##1## second.\n##0.5## seconds cooldown\n\n(Swan Song duration can not increase above your maximum Swan Song duration.)"
or string_id == "menu_deck" .. s .. "_4" and "Blending In"
or string_id == "menu_deck" .. s .. "_4_desc" and "You gain ##+1## increased concealment.\n\nWhen wearing armor, your movement speed is ##15%## less affected.\n\nYou gain ##45%## more experience when you complete days and jobs."
or string_id == "menu_deck" .. s .. "_5" and "Undying Berserker"
or string_id == "menu_deck" .. s .. "_5_desc" and "You gain ##45%## chance to automatically revive during bleedout."
or string_id == "menu_deck" .. s .. "_6" and "Walk-in Closet"
or string_id == "menu_deck" .. s .. "_6_desc" and "Unlocks an armor bag equipment for you to use. The armor bag can be used to change your armor during a heist.\n\nIncreases your ammo pickup to ##135%## of the normal rate."
or string_id == "menu_deck" .. s .. "_7" and "Murderspree"
or string_id == "menu_deck" .. s .. "_7_desc" and "Killing enemies increases Swan Song duration by ##2## seconds.\n##1## second cooldown\n\n(Swan Song duration can not increase above your maximum Swan Song duration.)"
or string_id == "menu_deck" .. s .. "_8" and "Fast and Furious"
or string_id == "menu_deck" .. s .. "_8_desc" and  "You do ##5%## more damage. Does not apply to melee damage, throwables, grenade launchers or rocket launchers.\n\nIncreases your doctor bag interaction speed by ##20%##."
or string_id == "menu_deck" .. s .. "_9" and "9 Lives"
or string_id == "menu_deck" .. s .. "_9_desc" and "You gain additional ##4## lives before going down.\n\nDeck Completion Bonus: Your chance of getting a higher quality item during a PAYDAY is increased by ##10%##."
or text_original(self, string_id, ...)
end