//argument 0 - node id to colour
//argument 1 - selected actors move statistic
//argument 2 - selected actors actions

var node, move, actions;

node = argument0;
move = argument1;
actions = argument2;

if (actions > 1)
{
	if(node.G > move)
	{
		node.colour = c_yellow;	
	}
	else
	{
		node.colour = c_aqua;	
	}
}
else
{
	node.colour = c_yellow;	
}