//argument0 the actor we are creating the path for
//argument1 the destination node

current=argument1;

selectedActor = argument0;

for(ii =0; ii < ds_list_size(current.neighbours); ii+=1)
{
		neighbour = ds_list_find_value(current.neighbours, ii);
		if(neighbour.occupant == selectedActor)
		{
				path_add_point(selectedActor.movementPath, neighbour.x, neighbour.y, 100);
				//path_add_point(selectedActor.movementPath, current.x, current.y, 100);
				break;
		}
}

//create priority queue
path = ds_priority_create();
	
//add current node to the queue
ds_priority_add(path, current, current.G);
	
//step through each node parent to parent
while(current.parent != noone)
{
	//add parent node to queue
	ds_priority_add(path, current, current.G);
		
	current = current.parent;
}
	
do{
	//delete lowest priority node
	current = ds_priority_delete_min(path);
		
	//add current nodes sprite coords to the selectedActors path
	path_add_point(selectedActor.movementPath, current.x, current.y, 100);
		
} until (ds_priority_empty(path)); 
	
	
ds_priority_destroy(path);