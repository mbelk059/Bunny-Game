var _interaction_radius = 35;

if (!global.dialogue_active) {
	
	right_key = keyboard_check(vk_right);
	left_key = keyboard_check(vk_left);
	up_key = keyboard_check(vk_up);
	down_key = keyboard_check(vk_down);

	xspd = (right_key - left_key) * move_spd;
	yspd = (down_key - up_key) * move_spd;
	
	// Check for interaction with obj_speakblock when space is pressed
	if (keyboard_check_pressed(vk_space)) {
		with (obj_speakblock) {
			var _dist_to_player = point_distance(x, y, obj_cute_cat.x, obj_cute_cat.y);
	        if (_dist_to_player <= _interaction_radius) {
				global.dialogue_active = true;
	            create_textbox(text_id);
			}
	    }
	} 
		
	// set sprite
	mask_index = sprite[DOWN];
	
	if yspd == 0 {
		if xspd > 0 {face = RIGHT};
		if xspd < 0 {face = LEFT};
	}

	if xspd > 0 && face == LEFT {face = RIGHT};
	if xspd < 0 && face == RIGHT {face = LEFT};

	if xspd == 0 {	
		if yspd > 0 {face = DOWN};
		if yspd < 0 {face = UP};
	}

	if yspd > 0 && face == UP {face = DOWN};
	if yspd < 0 && face == DOWN {face = UP};

} else {
	xspd = 0;
	yspd = 0;
}

if(global.main_state == e_main.ready){
	var cutscene = collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, obj_activate_cutscene, false, true);

	if (cutscene != noone && obj_cutscene.cutscenes[global.story_val][room] != -1) {
		global.main_state = e_main.cutscene;
		with obj_cutscene state = e_cutscene.init;
	}
	
	if (keyboard_check_pressed(vk_enter)) {
		if (room == rm_start3) room_goto(rm_start2);
		else room_goto(rm_start3);
	}
	
	sprite_index = sprite[face];
	
	// collisions
    if place_meeting(x + xspd, y, obj_wall) == true {
		xspd = 0;
	}
	if place_meeting(x, y + yspd, obj_wall) == true {
		yspd = 0;
	}

	x += xspd;
	y += yspd;

	// animate
	if xspd == 0 && yspd == 0 {
		image_index = 0;
	}

	// depth
	depth = -bbox_bottom;
	
}