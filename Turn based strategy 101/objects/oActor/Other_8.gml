/// @description Insert description here
// You can write your code in this editor

//clear path
path_clear_points(movementPath);

if(endPath == "ready")
{
	if(actions > 0)
	{
		oCursor.selectedActor = id;	
		movement_range(map[gridX, gridY], move, actions);
	
		if(canAct)
		{
			switch(attackType)
			{
				case "ranged":
					ranged_attack_range(id);
				break;
				case "melee":
					melee_attack_range(id);
				break;
			}
		}
	}
	else
	{
		oGames.currentActor = noone;	
	}
		state="idle";
}
else
{
	state = endPath;
}