/// @description Insert description here
// You can write your code in this editor

shake -=1;

if(hitPoints <=0)
{
	map[gridX, gridY].occupant = noone;
	
	if(oGames.currentActor = id)
	{
		oCursor.selectedActor = noone;
		oGames.currentActor = noone;
	}
	
	with(instance_create_depth(x, y, -1, oDying))
	{
		sprite_index = other.sprite_index;
	}
	
	instance_destroy();
}

switch(state)
{
	case "initialize turn":
		if(blessed > oGames.roundCounter)
		{
			with(instance_create_depth(x, y, -1, oBless))
			{
				target = other;
			}
		}
		else
		{
			blessed =0;	
		}
		
		if(acidBurn > 0)
		{
			damage = irandom_range(1,4);
			
			with(instance_create_depth(x + 28, y + 2, -1, oDamageText))
			{
				text = "";
				ground = y;
			}
			
			hitPoints -= damage;
			
			acidBurn -=1;
		}
		
		if(army == BLUE_ARMY)
		{
			movement_range(map[gridX, gridY], move, actions);

			switch(attackType)
			{
				case "melee":
					melee_attack_range(id);
				break;
				case "ranged":
					ranged_attack_range(id);
				break;
			}
			
			oCursor.selectedActor = id;
		}
		else
		{
			flash = true;
			alarm[0] = 30;
		}
		
		state = "ready";
	break
	
	
	case "begin path":
		//being moving along path
		if(path_get_number(movementPath) == 1)
		{
			
		}
		else
		{
			path_start(movementPath, moveSpeed, 0, true);
		}
		state="moving";
	break;
	
	case "moving":
		
	break;
	
	
	case "begin attack":
		actionTimer -= 1;
		if(actionTimer <= 0)
		{
			state = "attack"	
		}
	break;
	
	case "attack":
			//make attack roll
			attackRoll = irandom_range(1,20);
			
			applySneakAttack= false;
			
			if(sneakAttack)
			{
				tempNode = map[attackTarget.gridX, attackTarget.gridY];
				
				for(ii =0; ii < ds_list_size(tempNode.neighbours); ii+=1)
				{
					current = ds_list_find_value(tempNode.neighbours, ii);
					
					if(current.occupant != noone)
					{
						if(current.occupant.army != attackTarget.army)
						{
							applySneakAttack = true;
						}
					}
				}
			}
			
			attackStatus = attack_roll(id, attackTarget);
			tempDamage = 0;
				
			//make damage roll
			if(attackStatus != "miss")
			{
				tempDamage = irandom_range(1, damageDice) + damageBonus;
					
				if(applySneakAttack)
				{
					tempDamage += irandom_range(1, sneakAttackDamage);
				}
					
				if(attackStatus == "crit")
				{
					tempDamage += irandom_range(1, damageDice)
						
					if(applySneakAttack)
					{
						tempDamage += irandom_range(1, sneakAttackDamage);
					}
				}
			}
				
				
		switch(attackType)
		{

			case "ranged":
			
				
				attackDir = point_direction(x+16, y+16, attackTarget.x+16, attackTarget.y+16);
				
				beginX = x + 16 + lengthdir_x(30, attackDir);
				beginY = y + 16 + lengthdir_y(30, attackDir);
				
				with(instance_create_depth(beginX, beginY, -1, oArrow))
				{
					target = other.attackTarget;
					status = other.attackStatus;
					damage = other.tempDamage;
					damageType = other.damageType;
					
					path_add_point(movementPath, other.beginX, other.beginY, 100);
					
					if(status != "miss")
					{
						path_add_point(movementPath, target.x + 16, target.y + 16, 100);
					}
					else
					{
						path_add_point(movementPath, target.x + (irandom_range(30,50) * choose(-1,1)), target.y + (irandom_range(30,50) * choose(-1,1)), 100);
					}
					
					path_start(movementPath, speed, true, true);
				}
			
			state = "end attack";
			
			actionTimer = 30;
			
			break;
			
			case "melee":
				if(attackStatus!= "miss")
		{
			for(ii =0; ii< 6; ii +=1)	
			{
				with(instance_create_depth(attackTarget.x +16 , attackTarget.y +16, -1, oBiff))
				{
					direction = irandom(360);
					speed = choose(2,4);
					scale = choose(2,3);
					
					image_speed = 0.5;
					
					if(other.attackStatus == "crit")
					{
						colour = c_yellow;
						
					}
				}
			}
			if(attackStatus == "crit")
			{
				attackTarget.shake = 8;
				attackTarget.shakeMag = 8;
			}
			else
			{
				attackTarget.shake = 4;
				attackTarget.shakeMag = 4;	
			}
			
			attackTarget.hitPoints -= tempDamage;
			
			with(instance_create_depth(attackTarget.x +28 , attackTarget.y +2, -1, oDamageText))
				{
					text = "-" +  string(other.tempDamage);
					
					ground = y;
					
					if(other.attackStatus == "crit")
					{
						font = fCrit;
					}
						
				}
		}
			else
			{
				with(instance_create_depth(attackTarget.x +28 , attackTarget.y +2, -1, oDamageText))
				{
					text = "miss";
					
					ground = y;
						
				}
			}
					
			state = "end attack";
			actionTimer = 10;
					
					
			break;
		}
	break;
	
	case "end attack":
		actionTimer -=1;
		
		if(actionTimer <= 0)
		{
			if(actions > 0)
			{
				oCursor.selectedActor = id;
				movement_range(map[gridX, gridY], move, actions);
			}
			else
			{
				oGames.currentActor = noone;	
			}
			state = "idle";
		}
	break;
	
	case "begin action":
		wipe_nodes();
		action_targeting(id, targetingType, actionRange);
	break;
	
	case "perform action":
		perform_action(id, readiedAction);
		wipe_nodes();
	break;
	
	case "end action":
		actionTimer-=1;
		if(actionTimer <=0)
		{
			state = "idle";	
			if(actions > 0)
			{
				movement_range(map[gridX, gridY], move, actions);
			}
			else
			{
				state = "idle";
				oCursor.selectedActor = noone;
				oGames.currentActor = noone;
			}
		}
	break;
	
	case "end turn":
		actionTimer -= 1;
		if(actionTimer <=0)
		{
			oCursor.selectedActor = noone;
			oGames.currentActor = noone;
			state = "idle";	
		}
		
	break;
}










