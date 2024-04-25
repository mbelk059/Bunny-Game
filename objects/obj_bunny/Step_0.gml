if(global.main_state == e_main.ready){
	
	var cutscene = collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, obj_activate_cutscene, false, true);

	if (cutscene != noone && obj_cutscene.cutscenes[global.story_val][room] != -1) {
		global.main_state = e_main.cutscene;
		with obj_cutscene state = e_cutscene.init;
	}

	if (keyboard_check(vk_left)) x -= 1;
	if (keyboard_check(vk_right)) x += 1;
	
	if (keyboard_check_pressed(vk_enter)) {
		if (room == rm_start3) room_goto(rm_start2);
		else room_goto(rm_start3);
	}
	
}