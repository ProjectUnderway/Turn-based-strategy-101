/// @description Insert description here
// You can write your code in this editor

//Will do the parents create event followed by the rest of the code
event_inherited();

name = "Rizzo";


class = "Cleric";

race = "Human";

//character statistics
level =1;

//base statistics
profMod = 2 + floor(level/5);

strMod =2;
dexMod =0;
conMod =1;
intMod =0;
wisMod =3;

//health stats
maxHitPoints= 8+conMod + ((level - 1) * (5 + conMod));
hitPoints = maxHitPoints;

//attack variables
hitBonus = profMod + strMod;

//damage variables
damageDice =8;
damageBonus = strMod
damageType = "bludgeoning"

//spell and action variables
spellHitBonus = profMod + wisMod;
spellSaveDC = 8 + profMod + wisMod;

firstLevelSlotMax =2;
firstLevelSlot = 2;

firstLevelSpellList = ds_list_create();

fill_spell_list(id, level, class);

//defense variables
armourClass =16;

//movement and action variables
move = 6;
actions = 2;

//initative variables
initiative = dexMod;
initRoll = 0;