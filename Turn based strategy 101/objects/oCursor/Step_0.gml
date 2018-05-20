/// @description Insert description here
// You can write your code in this editor


x=mouse_x;
y=mouse_y;

//floor rounds the result to a whole number
gridX = floor(x/grid_size);

gridY = floor(y/grid_size);

if(gridX < 0 || gridY < 0 || gridX >= room_width/grid_size || gridY >= room_height/grid_size)
{
	 hoverNode = noone;
}
else
{
	hoverNode = map[gridX, gridY];	
}

with(oConfirmButton)
{
	if(keyboard_check_pressed(vk_enter) ||	keyboard_check_pressed(ord(hotKey)))
	{
		other.selectedActor.state = "perform action";
		instance_destroy();
	}
}

if(instance_place(x,y, oButton))
{
	if(instance_place(x,y,oButton) == hoverButton)
	{
		buttonTimer += 1;	
	}
	else
	{
		hoverButton = noone;
		buttonTimer =0;
	}
	hoverButton = instance_place(x,y,oButton);
	hoverNode = noone;
}
else
{
	hoverButton = noone;	
}

with(oButton)
{
	if(keyboard_check_pressed(ord(hotKey)))
	{
		perform_buttons(oCursor.selectedActor, id);		
	}
}

if(keyboard_check_pressed(vk_escape) && selectedActor != noone)
{
	if(selectedActor.state == "begin action")
	{
		selectedActor.state = "idle";
		with(oConfirmButton)
		{
			instance_destroy();	
		}
		with(oConfirmBox)
		{
			instance_destroy();	
		}
	}
	wipe_buttons();
	wipe_nodes();
	movement_range(map[selectedActor.gridX, selectedActor.gridY], selectedActor.move, selectedActor.actions);
	
	if(selectedActor.canAct)
	{
		switch(selectedActor.attackType)
		{
			case "ranged":
				ranged_attack_range(selectedActor);
			break;
		
			case "melee":
				melee_attack_range(selectedActor);
			break;
		}
	}
	
}


if(mouse_check_button_pressed(mb_left))
{
	if(selectedActor != noone && hoverButton != noone)
	{
		perform_buttons(selectedActor, hoverButton);	
	}
	
	if(instance_place(x,y, oConfirmButton))
	{
		selectedActor.state = "perform action";
		with(oConfirmButton)
		{
				instance_destroy();
		}
	}
	
	if(instance_place(x,y, oEndBox))
	{
		with(oFadeLose)
		{
			finalize = true;
		}
		
		with(oEndBox)
		{
			instance_destroy();	
		}
	}
}


if(mouse_check_button_pressed(mb_right))
{
	if(selectedActor != noone && hoverNode.moveNode ) //&& hoverNode.gridX != selectedActor.gridX && hoverNode.gridY != selectedActor.gridY
	{
		current = hoverNode;
		
		create_path(selectedActor, current);
		
		//first clear the node of selectedActor
		map[selectedActor.gridX, selectedActor.gridY].occupant = noone;
		
		//update selectedActors appropriate coords
		selectedActor.gridX = gridX;
		selectedActor.gridY = gridY;
		
		//update selectedActors future node
		hoverNode.occupant = selectedActor;
		
		//send selected actor on its way
		selectedActor.state = "begin path";
		selectedActor.endPath = "ready";
		
		//reduce selected actors actions and wipe nodes;
		
		if(hoverNode.G > selectedActor.move)
		{
			selectedActor.actions -=2;	
			wipe_buttons();
			wipe_nodes();
		}
		else
		{
			selectedActor.actions -=1;	
			wipe_buttons();
			wipe_nodes();
		}
		
		selectedActor = noone;
		
	}//move node block end
	
	if(selectedActor != noone && hoverNode.attackNode)
	{
		
		switch(selectedActor.attackType)
		{
			case "ranged":
				selectedActor.canAct = false;
				selectedActor.actions -=1;
				selectedActor.attackTarget = hoverNode.occupant;
				selectedActor.state = "begin attack"
				selectedActor.actionTimer = 10;
				selectedActor = noone;
				
				wipe_buttons();
				wipe_nodes();
			break;
			
			case "melee":
				selectedActor.canAct = false;
				selectedActor.attackTarget = hoverNode.occupant;
				
				tempX = abs(hoverNode.gridX - selectedActor.gridX);
				tempY = abs(hoverNode.gridY - selectedActor.gridY);
				
				if(tempX <= 1 && tempY <= 1)
				{
					selectedActor.actions -=1 ;
					selectedActor.state = "begin attack";
					selectedActor.actionTimer = 10;
					selectedActor = noone;
					
					wipe_buttons();
					wipe_nodes();
				}
				else
				{
					tempG = 100;
					
					current = noone;
					
					for(ii =0; ii < ds_list_size(hoverNode.neighbours);ii+=1)
					{
						tempNode = ds_list_find_value(hoverNode.neighbours, ii);
						
						if(tempNode.occupant == noone && tempNode.G > 0 &&  tempNode.G < tempG)
						{
							tempG = tempNode.G;
							current = tempNode;
						}
					}
					
					targetNode = current;
					
					create_path(selectedActor, targetNode);
					
					//first clear the node of selectedActor
					map[selectedActor.gridX, selectedActor.gridY].occupant = noone;
		
					//update selectedActors appropriate coords
					selectedActor.gridX = targetNode.gridX;
					selectedActor.gridY = targetNode.gridY;
		
					//update selectedActors future node
					targetNode.occupant = selectedActor
		
					//send selected actor on its way
					selectedActor.state = "begin path";
					selectedActor.endPath = "begin attack";
					selectedActor. attackTarget = hoverNode.occupant;
					
					selectedActor.actions -=2;
					selectedActor.canAct = false;
					
					selectedActor = noone;
					
					wipe_buttons();
					wipe_nodes();
				}
			break;
		}

	}//attackNode block end
	
	if(hoverNode.actionNode)
	{
		selectedActor.state = "perform action";
		with(oConfirmButton)
		{
			instance_destroy();
		}
		with(oConfirmBox)
		{
			instance_destroy();
		}
	}
	
}












