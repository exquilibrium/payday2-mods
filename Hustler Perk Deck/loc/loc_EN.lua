local s = "22"

local text_original = LocalizationManager.text
function LocalizationManager:text(string_id, ...)
return string_id == "menu_st_spec_" .. s and "Hustler"
or string_id == "menu_st_spec_" .. s .. "_desc" and "I'm gonna be a hustler, you better ask somebody!"
or string_id == "menu_deck_" .. s .. "_1" and "The First Hustle"
or string_id == "menu_deck_" .. s .. "_1_desc" and "Your health is reduced to ##1##.\n\nYou only get ##0.1%## of your maximum health and can not heal above it.\n\nYou gain ##35%## dodge."
or string_id == "menu_deck_" .. s .. "_2" and "Helmet Popping"
or string_id == "menu_deck_" .. s .. "_2_desc" and "Increases your headshot damage by ##25%##."
or string_id == "menu_deck_" .. s .. "_3" and "Ignorance of the Hustler!"
or string_id == "menu_deck_" .. s .. "_3_desc" and "Your will no longer automatically regenerate armor.\n\nDealing damage replenishes ##10## armor.\n##0.1## seconds cooldown"
or string_id == "menu_deck_" .. s .. "_4" and "Blending In"
or string_id == "menu_deck_" .. s .. "_4_desc" and "You gain ##+1## increased concealment.\n\nWhen wearing armor, your movement speed is ##15%## less affected.\n\nYou gain ##45%## more experience when you complete days and jobs."
or string_id == "menu_deck_" .. s .. "_5" and "Restless"
or string_id == "menu_deck_" .. s .. "_5_desc" and "Killing enemies replenishes ##42%## of the last damage taken as armor.\n##1## second cooldown"
or string_id == "menu_deck_" .. s .. "_6" and "Walk-in Closet"
or string_id == "menu_deck_" .. s .. "_6_desc" and "Unlocks an armor bag equipment for you to use. The armor bag can be used to change your armor during a heist.\n\nIncreases your ammo pickup to ##135%## of the normal rate."
or string_id == "menu_deck_" .. s .. "_7" and "Unending Hustler"
or string_id == "menu_deck_" .. s .. "_7_desc" and "Your armor is increased by ##80##.\n\nYou gain ##150%## more armor."
or string_id == "menu_deck_" .. s .. "_8" and "Fast and Furious"
or string_id == "menu_deck_" .. s .. "_8_desc" and  "You do ##5%## more damage. Does not apply to melee damage, throwables, grenade launchers or rocket launchers.\n\nIncreases your doctor bag interaction speed by ##20%##."
or string_id == "menu_deck_" .. s .. "_9" and "Final Hustle"
or string_id == "menu_deck_" .. s .. "_9_desc" and "Killing enemies in medium range replenishes ##69%## of the last damage taken as armor.\n##1## second cooldown\n\nDeck Completion Bonus: Your chance of getting a higher quality item during a PAYDAY is increased by ##10%##."
or text_original(self, string_id, ...)
end