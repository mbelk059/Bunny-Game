accept_key = keyboard_check_pressed(vk_space);

textbox_x = camera_get_view_x( view_camera[0] );
textbox_y = camera_get_view_y( view_camera[0] ) + 144;

//setup
if setup == false {
	
	setup = true;
	draw_set_font(global.font_main);
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
	
	//loop thru the pages
	for(var p = 0; p < page_number; p++) {
		
		//find how many characters r on page and store that num in text_length array
		text_length[p] = string_length(text[p]);
		
		// get x position for textbox
			//character on left
			text_x_offset[p] = 80;
			portrait_x_offset[p] = 8;
			
			//character on right
			if speaker_side[p] == -1 {
				text_x_offset[p] = 8;
				portrait_x_offset[p] = 216;
			}
			// no character aka center the textbox in screen
			if speaker_sprite[p] == noone {
				text_x_offset[p] = (camera_get_view_width(view_camera[0]) - textbox_width) / 2;
				portrait_x_offset[p] = (camera_get_view_width(view_camera[0]) - sprite_width) / 2; // Assuming sprite_width is the width of the textbox sprite
			}
		
		//setting individ chars and finding where the lines of text should break
		for (var c = 0; c < text_length[p]; c++) {
			
			var _char_pos =  c+1;
			
			//store individ chars in char array
			char[c, p] = string_char_at(text[p], _char_pos);
			
			//get current width of line
			var _txt_up_to_char = string_copy( text[p], 1, _char_pos );
			var _current_txt_w = string_width( _txt_up_to_char ) - string_width( char[c, p] );
			
			// get last free space
			if char[c, p] == " " { last_free_space = _char_pos+1 };
			
			// get line breaks
			if _current_txt_w - line_break_offset[p] > line_width {
				line_break_pos[ line_break_num[p] , p ] = last_free_space;
				line_break_num[p]++;
				var _txt_up_to_last_space = string_copy( text[p], 1, last_free_space );
				var _last_free_space_string = string_char_at( text[p], last_free_space );
				line_break_offset[p] = string_width( _txt_up_to_last_space ) - string_width( _last_free_space_string );
			}
		}
		
	//getting each characters coordinates
	for (var c = 0; c < text_length[p]; c++) {
		
		var _char_pos = c+1;
		var _txt_x = textbox_x + text_x_offset[p] + border;
		var _txt_y = textbox_y + border;
		//get current width of line
		var _txt_up_to_char = string_copy( text[p], 1, _char_pos );
		var _current_txt_w = string_width (_txt_up_to_char ) - string_width( char[c, p] );
		var _txt_line = 0;
			
		//compensate for string breaks
		for (var lb = 0; lb < line_break_num[p]; lb++) {
			// if current looping char is after a line break
			if _char_pos >= line_break_pos[lb, p] {
				var _str_copy = string_copy( text[p], line_break_pos[lb, p], _char_pos-line_break_pos[lb, p] );
				_current_txt_w = string_width(_str_copy);
				
				//record line this char should be on
				_txt_line = lb+1;
				
				}
			}
			
		//add to x and y coordinates based on new info
		char_x[c, p] = _txt_x + _current_txt_w;
		char_y[c, p] = _txt_y + _txt_line*line_sep;
			
		}
	}
	
}
	
//typing text
if text_pause_timer <= 0 {
	if draw_char < text_length[page] {
		draw_char += text_speed;
		draw_char = clamp(draw_char, 0, text_length[page]);
		var _check_char = string_char_at(text[page], draw_char);
		if _check_char == "." || _check_char == "!" || _check_char == "?" {
			text_pause_timer = text_pause_time;
			if !audio_is_playing(snd[page]) {
				audio_play_sound(snd[page], 8, false);
			}
		} else {
			//typing sound
			if snd_count < snd_delay {
				snd_count++;
			} else {
				snd_count = 0;
				audio_play_sound(snd[page], 8, false);
			}
		}
	}
} else {
	text_pause_timer--;
}


// flip thru pages
if accept_key {
    // if typing is done 
    if draw_char == text_length[page] {
        //next page
        if page < page_number - 1 {
            page++;
            draw_char = 0;
        } else {
            // link text for options
            if option_number > 0 {
                create_textbox(option_link_id[option_pos]);
                
                // Set dialogue_active to true when creating options
                global.dialogue_active = true;
            }
            instance_destroy();
            
            // Reset dialogue_active flag
            if (!option_number > 0) {
                global.dialogue_active = false;
            }
        }
    } else { //if not done typing
        draw_char = text_length[page];
    }
}



// draw textbox
var _txtb_x = textbox_x + text_x_offset[page];
var _txtb_y = textbox_y;
txtb_img += txtb_img_spd;
txtb_spr_w = sprite_get_width(txtb_spr[page]);
txtb_spr_h = sprite_get_height(txtb_spr[page]);
//draw the speaker
if speaker_sprite[page] != noone {
	if draw_char == text_length[page] {image_index = 0};
	sprite_index = speaker_sprite[page];
	var _speaker_x = textbox_x + portrait_x_offset[page];
	if speaker_side[page] == -1 {_speaker_x += sprite_width};
	//draw speaker
	draw_sprite_ext(txtb_spr[page], txtb_img, textbox_x + portrait_x_offset[page], textbox_y, sprite_width/txtb_spr_w, sprite_height/txtb_spr_h, 0, c_white, 1);
	draw_sprite_ext(sprite_index, image_index, _speaker_x, textbox_y, speaker_side[page], 1, 0, c_white, 1);
	
}
//back of textbox
draw_sprite_ext(txtb_spr[page], txtb_img, _txtb_x, _txtb_y, textbox_width/txtb_spr_w, textbox_height/txtb_spr_h, 0, c_white, 1);

if draw_char == text_length[page] && page == page_number - 1 {
	
	//option selection
	option_pos += keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);	
	option_pos = clamp(option_pos, 0, option_number-1);
	
	//draw options
	var _op_space = 15;
	var _op_bord = 4;
	for (var op = 0; op < option_number; op++) {
		//the option box
		var _o_w = string_width(option[op]) + _op_bord*2;
		draw_sprite_ext(txtb_spr[page], txtb_img, _txtb_x + 16, _txtb_y -_op_space*option_number + _op_space*op, _o_w/txtb_spr_w, (_op_space-1)/txtb_spr_h, 0, c_white, 1);

		//arrow
		if option_pos == op {
			draw_sprite(spr_textbox_star_arrow, 0, _txtb_x,  _txtb_y -_op_space*option_number + _op_space*op);
		}
		
		//option text
		draw_text(_txtb_x + 16 + _op_bord, _txtb_y -_op_space*option_number + _op_space*op + 2, option[op]);
	}

}

//draw text
for (var c = 0; c < draw_char; c++) {
	
	//special stuff
	// floating text
	var _float_y = 0;
	if float_text[c, page] == true {
		float_dir[c, page] -= 6;
		_float_y = dsin(float_dir[c, page])*1;
	}
	//shake text
	var _shake_x = 0;
	var _shake_y = 0;
	if shake_text[c, page] = true {
		shake_timer[c, page]--;	
		if shake_timer[c, page] <= 0 {
			shake_timer[c, page] = irandom_range(4, 8);
			shake_dir[c, page] = irandom(360);
		}
		if shake_timer[c, page] <= 2 {
			_shake_x = lengthdir_x(1, shake_dir[c, page]);
			_shake_y = lengthdir_y(1, shake_dir[c, page]);
		}
	}
	
	//the text
	draw_text_color( char_x[c, page] + _shake_x, char_y[c, page] + _float_y + _shake_y, char[c, page],  col_1[c, page], col_2[c, page], col_3[c, page], col_4[c, page], 1 );
	}