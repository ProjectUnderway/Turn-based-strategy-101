/// @description Insert description here
// You can write your code in this editor
draw_set_colour(c_black);

draw_rectangle(x-256, y-128, x+256, y, false);

draw_set_color(c_white);

draw_set_font(fCrit);

draw_set_halign(fa_center);

draw_text(x, y-128, title);

tempOffset = string_height(title);

draw_set_font(fDefault);

draw_text(x, y-126 + tempOffset, text);

draw_set_halign(fa_left);

draw_self();
