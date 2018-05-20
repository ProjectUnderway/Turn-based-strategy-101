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

		
		state = "find target";
	break
	
	case "find target":
		attackTarget = noone;
		
		node = map[gridX, gridY];
		
		targetList = ds_list_create();
		
		for(ii =0; ii < ds_list_size(node.neighbours); ii+=1)
		{
			neighbour = ds_list_find_value(node.neighbours, ii);
			
			if(neighbour.occupant != noone)
			{
				if(neighbour.occupant.army == BLUE_ARMY)
				{
					ds_list_add(targetList, neighbour.occupant);
				}
			}
		}
		
		if(ds_list_size(targetList) > 0)
		{
			roll = irandom_range(1,20);
			
			
			if(roll + intMod > 10)
			{
				healthRatio =1;
				
				for(ii =0; ii < ds_list_size(targetList); ii+=1)
				{
					tempTarget = ds_list_find_value(targetList, ii);
					
					if(tempTarget.hitPoints/tempTarget.maxHitPoints < healthRatio)
					{
						attackTarget = tempTarget;
						healthRatio = tempTarget.hitPoints/tempTarget.maxHitPoints;
					}
				}
			}
			
			if(attackTarget == noone)
			{
				attackTarget = ds_list_find_value(targetList, irandom_range(0, ds_list_size(targetList) -1));
			}
		}
		
		ds_list_destroy(targetList);
		
		if(attackTarget != noone)
		{
			state = "begin attack";
			actionTimer =10;
		}
		else
		{
			state = "find move node";
		}
	break;
	
	case "find move node":
		heroList = ds_priority_create();
		
		with(oActor)
		{
			if(army == BLUE_ARMY)
			{
				ds_priority_add(other.heroList, id, point_distance(x,y,other.x,other.y));
			}
		}
		
		
		closestNode = noone;
		
		while(closestNode = noone)
		{
			targetHero = ds_priority_delete_min(heroList);
			
			targetNode = map[targetHero.gridX, targetHero.gridY]
			
			for(ii =0; ii < ds_list_size(targetNode.neighbours); ii+=1)
			{
				currentNode = ds_list_find_value(targetNode.neighbours, ii);
				
				if(currentNode.occupant == noone && currentNode.passable)
				{
					closestNode = currentNode;
				}
			}
			
			if(ds_priority_size(heroList) <=0)
			{
				targetHero = noone;
				flash = true;
				alarm[0] = 30
				state = "idle";
				break;
			}
		}
		
		ds_priority_destroy(heroList);
		
		if(targetHero != noone)
		{
			targetNode = closestNode;	
			
			ai_movement(map[gridX, gridY], closestNode);
			
			while(closestNode.G > move * actions)
			{
				closestNode = closestNode.parent;	
			}
			
			create_path(id, closestNode);
			
			map[gridX, gridY].occupant = noone;
			
			gridX = closestNode.gridX;
			gridY = closestNode.gridY;
			
			closestNode.occupant = id;
			
			state = "begin path";
			
			if(closestNode.G > move)
			{
				actions -= 2;
			}
			else
			{
				actions -=1;	
			}
		}
		
		wipe_nodes();
		
		
	break;
	
	case "begin path":
		path_start(movementPath, moveSpeed, 0, true);
		
		state = "moving";
	break
	
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
			oGames.currentActor = noone;
			state = "idle"
		}
	break;
	
}
























