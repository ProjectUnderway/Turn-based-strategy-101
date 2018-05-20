/// @description Insert description here
// You can write your code in this editor
draw_self();

draw_set_font(fHotKey);

draw_set_color(c_black);

draw_text(x + 22, y - 32, string(hotKey));

if(spell)
{
	draw_text(x + 12, y + 18, "(" + string(spellSlot) + ")");
	
}

draw_set_color(c_white);

draw_set_font(fDefault);