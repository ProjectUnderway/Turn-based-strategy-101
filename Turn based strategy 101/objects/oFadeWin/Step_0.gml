/// @description Insert description here
// You can write your code in this editor

if(alpha <= 1)
{
	alpha += 0.05;
}
else
{
	if(room_exists(room_next(room)))
	{
		room_goto_next();
	}
	else
	{
		room_goto(room0);	
	}
}
