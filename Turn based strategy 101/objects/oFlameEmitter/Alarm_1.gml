/// @description Insert description here
// You can write your code in this editor
if(target != noone)
{
	roll = irandom_range(1,20);
	
	if(roll + target.dexMod > saveDC)
	{
		damage = ceil(damage/2);
	}
	
	with(instance_create_depth(x + 10, y - 12, -1, oDamageText))
	{
		ground = y;
		text = "-" + string(other.damage);
		
	}
	
	target.hitBonus -= damage;
	target.shake =4;
	target.shakeMag =4;
}

instance_destroy();