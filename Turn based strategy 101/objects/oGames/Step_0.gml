/// @description Insert description here
// You can write your code in this editor

if(keyboard_check_pressed(vk_delete))
{
	oCursor.selectedActor = noone;
	oGames.currentActor = noone;
	with(oActor)
	{
		if(army = BLUE_ARMY)	
		{
			instance_destroy();	
		}
	}
	wipe_nodes();
	wipe_buttons();
}

switch (state)
{
	case "initializing":
		with(oNode)
		{
			if(instance_position(x+16, y+16, oTerrain))
			{
				tempTerrain = instance_position(x+16, y+16, oTerrain)
				
				switch(tempTerrain.type)
				{
					case "wall":
						instance_change(oWall, true);
						type = "wall";
						passable = false;
						
						break;
						
					case "rubble":
					instance_change(oRubble, true);
						type = "rubble"
						cost = 2;
						
						break;
				}
				
				
				with(tempTerrain)
				{
					instance_destroy();	
				}
			}
			
			
			if(instance_position(x+16,y+16, oActor))
			{
				occupant = instance_position(x + 16, y +16, oActor);
				occupant.gridX = gridX;
				occupant.gridY = gridY;
			}
			
			
			
		}
		
		state = "roll init";
		break;
		
		case "roll init":
		tempInit = ds_priority_create();
		with(oActor)
		{
			initRoll = 	irandom_range(1,20) + initiative;
			ds_priority_add(other.tempInit, id, initRoll);
		}
		
		while(ds_priority_size(tempInit) > 0)
		{
			ds_list_add(turnOrder, ds_priority_delete_max(tempInit));	
		}
		
		turnMax = ds_list_size(turnOrder);
		
		ds_priority_destroy(tempInit);
		
		state="waiting";
		break;
		
		case "ready":
		if(currentActor == noone)
		{
			redCount =0;
			blueCount =0;
			
			with(oActor)
			{
				if(army == RED_ARMY)
				{
					other.redCount += 1;
				}
				
				if(army == BLUE_ARMY)
				{
					other.blueCount += 1;
				}
			}
			
			if(redCount > 0 && blueCount > 0)
			{
					
				turnCounter+=1;
				if(turnCounter >= turnMax)
				{
					turnCounter = 0;
					roundCounter += 1;
				}
			
				currentActor = ds_list_find_value(turnOrder, turnCounter);
			
				if(instance_exists(currentActor))
				{
					currentActor.actions =2;
					currentActor.canAct = true;
			
					currentActor.state = "initialize turn";
				}
				else
				{
					currentActor = noone;
				}
			}
			else
			{
				if(blueCount <=0)
				{
					state = "retry room"
				}
				else
				{
					state = "next room";	
				}
			}
		}
		break;
		
		case "retry room":
			instance_create_depth(0,0, 0, oFadeLose);
			state = "waiting";
		break
		
		case "next room":
			instance_create_depth(0,0, 0, oFadeWin);
			state = "waiting";
		break;
		
}


















