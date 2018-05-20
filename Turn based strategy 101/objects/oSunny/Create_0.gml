/// @description Insert description here
// You can write your code in this editor

//Will do the parents create event followed by the rest of the code
event_inherited();

name = "Sunny";


class = "Wizard";

race = "Gnome";

//character statistics
level =1;

//base statistics
profMod = 2 + floor(level/5);

strMod =0;
dexMod =1;
conMod =2;
intMod =3;
wisMod =0;

//health stats
maxHitPoints= 4+conMod + ((level - 1) * (3 + conMod));
hitPoints = maxHitPoints;

//attack variables
hitBonus = profMod + intMod;
attackType = "ranged";
attackRange = 15 * grid_size;

//damage variables
damageDice = 10;
damageBonus = 0;
damageType = "fire";

//spell and action variables
spellHitBonus = profMod + intMod;
spellSaveDC = 8 + profMod + intMod;

firstLevelSlotMax =2;
firstLevelSlot = 2;

firstLevelSpellList = ds_list_create();

fill_spell_list(id, level, class);


//defence variables
armourClass = 10 + dexMod;


//movement and action variables
move = 5;
actions = 2;

//initative variables
initiative = dexMod;
initRoll = 0;