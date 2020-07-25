Information about this mod
-Description
-Fix Perk Deck Description
-Tweaking this mod

### Description ###
-------------------------------------------------- 1
Your health is reduced to 1.

You only get 0.1% of you maximum health and you can not heal above it.

You gain 35% dodge chance.

-------------------------------------------------- 3
You will no longer automatically regenerate armor.

Dealing damage replenishes 10 armor.
(0.1 seconds cooldown)

-------------------------------------------------- 5
Killing enemies replenishes 42% of the last damage taken as armor.
(1 second cooldown)

-------------------------------------------------- 7
Your armor is increased by 80.

You gain 150% more armor

-------------------------------------------------- 9
Killing enemies in medium range replenishes 69% of the last damage taken as armor.
(1 second cooldown)

### Fix Perk Deck Description ###
- If you have other costum perk decks, this perk deck might have the wrong description
- To fix this open loc/loc_EN.lua
- In line 1: Change the default number 22 to the position this perk deck is in game.
-- There are 21 official perk decks at current time
-- Or you can just count from the top to the position of this perk deck

### Tweaking this mod ###
Outline on the files:
- loc_EN.lua >>> localization and in game text description of perk deck
- player.lua >>> contains fixes for health and armor being displayed right; contains the calculation of armor gained on kill
- skilltree.lua >>> contains the player upgrades of each tier of the perk deck; perk deck costs editable (pdc1-pdc9)
- upgrades.lua >>> contains the numbers to tweak at; necessary documentation in the file; variables are sorted like the perk deck description at the top
