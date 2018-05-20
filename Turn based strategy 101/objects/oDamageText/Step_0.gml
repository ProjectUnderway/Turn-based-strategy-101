/// @description Insert description here
// You can write your code in this editor
y -= vspd;

vspd -= grav;

if(y >= ground)
{
	y = ground;
	grav =0;
	fade = true;
	
}

if(fade)
{
	alpha -= .1;
}

if(alpha <= 0)
{
	instance_destroy();
}
