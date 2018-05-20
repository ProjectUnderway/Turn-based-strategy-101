/// @description Insert description here
// You can write your code in this editor
if(finalize)
{
	if(alpha <= 1)
	{
		alpha += 0.05;	
	}
	else
	{
		room_restart();	
	}
}
else
{

	if(alpha <= 0.8)
	{
		alpha += 0.5;
	}
	else
	{
		if(!instance_exists(oEndBox))
		{
			instance_create_depth(room_width/2, room_height/2, -1, oEndBox);
		}
	}
}