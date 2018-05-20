/// @description Insert description here
// You can write your code in this editor
state = "idle";

army = BLUE_ARMY;

gridX = 0;
gridY= 0;

name = "error";

class = "Peasant";

race = "Human";

//character statistics
level =1;

//base stats
profMod = 2 + floor(level/5);

strMod =0;
dexMod =0;
conMod =0;
intMod =0;
wisMod =0;

//health variables
maxHitPoints= 4+conMod + ((level - 1) * (3 + conMod));

hitPoints = maxHitPoints;

//attack variables
hitBonus = profMod + strMod;
attackType = "melee";
attackTarget = noone;

actionTimer =0;

//damage variables
damageDice =4;
damageBonus = strMod
damageType = "piercing"

//defense variables
armourClass =10 + dexMod;

//move and action variables
move = 6;
actions = 2;
canAct = false;

//special action variables
charge = false;
sneakAttack = false;

//spell and action variables
spellHitBonus =0;
spellSaveDC = 0;

firstLevelSlotMax =0;
firstLevelSlot=0;


readiedAction = "error";
targetingType = "error";
actionRange=0;

initiative = dexMod;
initRoll = 0;

//variables related to buttons
defaultActions = ds_list_create();

ds_list_add(defaultActions, "end turn");

//variables related to pathing
movementPath = path_add();
path_set_kind(movementPath, 2);
path_set_closed(movementPath, false);

endPath = "idle";

moveSpeed = 8;


//variables related to buffs/debuffs

//buffs
blessed =0;

//debuffs
acidBurn =0;
guidingBolt =false;

//variables related to FX
shake = 0;
shakeMag =0;























