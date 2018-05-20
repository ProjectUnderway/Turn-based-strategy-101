/// @description Insert description here
// You can write your code in this editor

//Will do the parents create event followed by the rest of the code
event_inherited();

name = "Sandy";



class = "Rougue";

race = "Elf";

//character statistics
level =1;

//base statistics
profMod = 2 + floor(level/5);

strMod =0;
dexMod =3;
conMod =2;
intMod =1;
wisMod =0;

//health variables
maxHitPoints= 6+conMod + ((level - 1) * (4 + conMod));
hitPoints = maxHitPoints;

//attack variables
hitBonus = profMod + dexMod;
attackType = "ranged";
attackRange = 15 * grid_size;

//move and action variables
move = 7;
actions = 2;

//special actions
sneakAttack = true;
sneakAttackDamage =6;

//initiative variables
initiative = dexMod;
initRoll = 0;