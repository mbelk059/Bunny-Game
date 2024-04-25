	if (total_text_to_display != "") {
		//close text message
		if(keyboard_check_pressed(vk_space)) {
			layer_sequence_play(global.current_sequence);
			total_text_to_display = "";
		}
	}