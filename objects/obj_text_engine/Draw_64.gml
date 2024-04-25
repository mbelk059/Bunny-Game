if(total_text_to_display != "") {
	
	draw_set_font(Font1);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_color(c_white);
	
	var font_size = font_get_size(Font1);
	var margin = (font_size/2);
	var box_width = display_get_gui_width();
	var box_height = ((font_size*5)*1.5);
	var box_x = display_get_gui_width() / 2;
	var box_y = display_get_gui_height();
	var xscale = box_width / sprite_get_width(spr_textbox_grey);
	var yscale = box_height / sprite_get_height(spr_textbox_grey);
	
	draw_sprite_ext(spr_textbox_grey, 0, box_x, box_y, xscale, yscale, 0, c_white, 1);
	
	draw_text_ext(margin, (box_y - box_height) + margin, total_text_to_display, (font_size*1.5), display_get_gui_width() - (margin*2));
}