/// @description Insert description here
// You can write your code in this editor

if(alpha >= 0)
{
	alpha -= 0.05;
}
else
{
	oGames.state = "ready";
	
	instance_destroy();
}
