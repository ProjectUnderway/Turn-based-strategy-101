/// @description Insert description here
// You can write your code in this editor

if(oCursor.selectedActor == id)
{
	//if cursor is hovering over a different node than actors
	if(oCursor.hoverNode != noone)
	{
		tempNode = oCursor.hoverNode;
			
			if(tempNode.moveNode)
			{
				current = oCursor.hoverNode;
				
				//step through every node in the chain parent to parent until we reach the actors node
				while(current.parent != noone)
				{
					draw_line_width_colour(current.x+16, current.y + 16, current.parent.x + 16, current.parent.y + 16, 4, c_lime, c_lime);
					
					current = current.parent;
				}
			}
			
			if(tempNode.attackNode)
			{
				switch(attackType)
				{
					case "ranged":
						draw_line_width_color(x + 16, y + 16, tempNode.x + 16, tempNode.y + 16, 4, c_purple, c_purple);
					break;
					
					case "melee":
						tempX = abs(tempNode.gridX - gridX);
						tempY = abs(tempNode.gridY - gridY);
						
						if(tempX <= 1 && tempY <= 1)
						{
							draw_line_width_color(x + 16, y + 16, tempNode.x + 16, tempNode.y + 16, 4, c_purple, c_purple);	
						}
						else
						{
							current = noone;
							tempG = 100;
							
							for(ii =0; ii< ds_list_size(tempNode.neighbours); ii+= 1)
							{
								neighbour = ds_list_find_value(tempNode.neighbours, ii);
								
								if(neighbour.occupant == noone && neighbour.G > 0 && neighbour.G < tempG)
								{
									tempG = neighbour.G;
									current = neighbour;
								}
								
							}
							draw_line_width_color(tempNode.x + 16, tempNode.y + 16, current.x + 16, current.y + 16, 4, c_purple, c_purple);	
							
							while(current.parent != noone)
							{
								draw_line_width_color(current.x + 16, current.y + 16, current.parent.x + 16, current.parent.y + 16, 4, c_purple, c_purple);		
								current = current.parent;
							}
						}
					break;
				}
			}
	}
}

if(shake > 0)
{
	draw_sprite_ext(sprite_index, -1, x + irandom_range(-shakeMag, shakeMag), y + irandom_range(-shakeMag, shakeMag), 1,1, 0,c_white,1);
	
}
else
{
	draw_self();
}
























