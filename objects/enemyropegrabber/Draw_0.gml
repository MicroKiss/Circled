if (canGrab) {
	draw_sprite_ext (sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_red, image_alpha);
} else {
	var randomColor = make_colour_rgb (255, 255,10);
	draw_sprite_ext (sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, randomColor, image_alpha);
	var ha = draw_get_halign ();
	var va = draw_get_valign ();
	var col = draw_get_color ();
	draw_set_halign (fa_center);
	draw_set_valign (fa_middle);
	draw_set_color (c_black);
	draw_text (x,y,countDown);
	draw_set_halign (ha);
	draw_set_valign (va);
	draw_set_color (col)
}