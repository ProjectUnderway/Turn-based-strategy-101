/// @description Insert description here
// You can write your code in this editor
draw_self();

draw_rectangle_color(300, 0, 350, 16, c_black, c_black, c_black, c_black, false);

buttonCount =0;

with(oButton)
{
	other.buttonCount += 1;
}

draw_text(300, 0, string(buttonCount));

if(hoverButton != noone && buttonTimer > 15)
{
	tempTitle = hoverButton.title;
	
	tempText = hoverButton.text
	
	draw_set_font(fCrit);
	
	heightY = string_height(tempTitle) + string_height(tempText);
	
	draw_set_color(c_black);
	
	draw_rectangle(x+20, y - heightY, x+20 + string_width(tempTitle), y - heightY + string_height(tempTitle), false);

	draw_set_colour(c_white);
	draw_text(x+20, y- heightY, tempTitle);
	
	draw_set_font(fDefault);
	
    draw_set_color(c_black);
	draw_rectangle(x + 20, y - string_height(tempText), x + 20 + string_width(tempText), y, false);
	
	draw_set_colour(c_white);
	draw_text(x + 20, y - string_height(tempText), tempText);
}



//Debugging
if(hoverNode != noone)
{
	tempText = string(gridX) + " / " + string(gridY) + " = ";
	
	if(hoverNode.occupant!=noone)
	{
		tempText += hoverNode.occupant.name; 
	}
	else
	{
	tempText += "noone";	
	}
	
	draw_set_color(c_black);
	draw_rectangle(0,100, string_width(tempText), 100+string_height(tempText), false); 

	draw_set_color(c_white);
	draw_text(0,100,tempText);
	
	tempText = hoverNode.type;
	
	if(hoverNode.passable)
	{
		tempText += " passable = true cost = " + string(hoverNode.cost);
	}
	
	draw_set_color(c_black);
	draw_rectangle(0, 120, string_width(tempText), 120 + string_height(tempText), false); 

	draw_set_color(c_white);
	draw_text(0, 120,tempText);
}


if(selectedActor != noone)
{
	tempText = selectedActor.name + " the " + selectedActor.race + " " + selectedActor.class;
	
	tempHitPoints = "HP " + string(selectedActor.hitPoints) + " / " + string(selectedActor.maxHitPoints);
	
	tempHitBonus = "Hit Bonus: " + string(selectedActor.hitBonus);
	
	draw_set_color(c_black);
	draw_rectangle(0, 0, string_width(tempText), string_height(tempText), false); 
	draw_rectangle(0, 16, string_width(tempHitPoints), 16 + string_height(tempHitPoints), false);
	draw_rectangle(0, 32, string_width(tempHitBonus), 32 + string_height(tempHitBonus), false);

	draw_set_color(c_white);
	draw_text(0,0,tempText);
	draw_text(0,16,tempHitPoints);
	draw_text(0,32,tempHitBonus);
}














