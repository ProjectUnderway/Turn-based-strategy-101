/// @description Insert description here
// You can write your code in this editor

//Will do the parents create event followed by the rest of the code
event_inherited();

name = "Danny";

class = "Fighter";

race = "Dwarf";

//character statistics
level =1;

//base statistics
profMod = 2 + floor(level/5);

strMod =3;
dexMod =0;
conMod =2;
intMod =0;
wisMod =1;

//health stats
maxHitPoints= 10 +conMod + ((level - 1) * (6 + conMod));
hitPoints = maxHitPoints;

//attack variables
hitBonus = profMod + strMod;

//damage variables
damageDice =8;
damageBonus = strMod
damageType = "slashing"

//defense variables
armourClass =18;

//movement and action variables
move = 5;
actions = 2;

//special attack variables
charge = true;


//initative variables
initiative = dexMod;
initRoll = 0;

