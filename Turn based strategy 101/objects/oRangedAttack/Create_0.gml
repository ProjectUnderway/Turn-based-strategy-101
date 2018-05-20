/// @description Insert description here
// You can write your code in this editor
//status off the attack
status = "miss";

//damage and damage type
damage =0;
damageType = "piercing"

//who the attack is targeting 
target = noone;

//owner who made the attack
owner = noone;

//path information
movementPath = path_add();
path_set_closed(movementPath, false);
path_set_kind(movementPath, 0);