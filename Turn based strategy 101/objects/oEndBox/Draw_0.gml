/// @description Insert description here
// You can write your code in this editor
draw_set_color(c_black);

draw_rectangle(x - 256, y-64, x + 256, y, false);

draw_set_color(c_white);

draw_set_font(fCrit);

draw_set_halign(fa_center);

draw_text(x, y - 64, endText);

draw_set_halign(fa_left);

draw_self();