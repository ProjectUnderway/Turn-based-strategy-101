//argument0 - origin node - the node to pathfind from
//argument1 - units movement range
//argument2 - units remaining actions

//reset all node data
wipe_nodes();

var open,closed; //data structures
var start,current,neighbour; //instance ids
var tempG, range, costMod;

//set up variables from arguments
start = argument0;
range = argument1 * argument2;

//create data structures
open = ds_priority_create();
closed = ds_list_create();

//add starting node to the open list
ds_priority_add(open, start, start.G);

//while open queue is not empty
//repeat the following until all nodes have been looked at
while(ds_priority_size(open) > 0)
{
	//remove node with the lowest G score from the open
	current = ds_priority_delete_min(open);
	
	//add that node to the closed list
	ds_list_add(closed, current);
	
	//step through all of currents neighbours
	for(ii=0; ii<ds_list_size(current.neighbours); ii+=1)
	{
		//store current neighbour in neighbour variable
		neighbour = ds_list_find_value(current.neighbours, ii);
		
		//add neighbour to current list if it qualifies
		if(ds_list_find_index(closed, neighbour) < 0 && neighbour.passable && neighbour.occupant == noone && neighbour.cost + current.G <= range )
		{
			//only calculate a new G score for neighbour if it hasn't already been calculated
			
			if(ds_priority_find_priority(open, neighbour) == 0|| ds_priority_find_priority(open, neighbour) == undefined)
			{
					costMod = 1;
					
					//give neighbour the appropriate parent
					neighbour.parent = current;
					
					//if node is diagonal create appropriate costMod
					if(neighbour.gridX != current.gridX && neighbour.gridY!= current.gridY)
					{
						costMod = 1.5;	
					}
					
					//calculate G score of neighbour with costMod in place
					neighbour.G = current.G + (neighbour.cost * costMod);
					
					//add neighbour to the open list so it can be checked out too!
					ds_priority_add(open, neighbour, neighbour.G);
			}
			//else if neighbour has already been calculated for the open list
			else
			{
				//figure out if the neighbours score would be lower if found from the current node
					costMod = 1;
					
					//if node is diagonal create appropriate costMod
					if(neighbour.gridX != current.gridX && neighbour.gridY!= current.gridY)
					{
						costMod = 1.5;	
					}
					
					tempG = current.G + (neighbour.cost * costMod)
					
					//check if G score would be lower if tempG is less than neighbour.G
					if(tempG < neighbour.G)
					{
						neighbour.parent = current;	
						neighbour.G = tempG;
						ds_priority_change_priority(open, neighbour, neighbour.G);
					}
			}
		}
	}
}

//round down all G scores for movement calculations
with(oNode)
{
	G = floor(G);	
}

ds_priority_destroy(open);

//colour move node then destroy closed list

for(ii=0; ii<ds_list_size(closed); ii+=1)
{
	current = ds_list_find_value(closed, ii);
	current.moveNode = true;
	
	colour_move_node(current, argument1, argument2);
}

start.moveNode = false;
start.colour = c_white;

ds_list_destroy(closed);

start.moveNode = false;

create_buttons(start.occupant);





















