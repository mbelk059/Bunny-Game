if event_data[? "event_type"] == "sequence event" {
	
	var broadcast_str = event_data[? "message"];
	show_debug_message("broadcast_str: " + broadcast_str);
	
	//what symbol is at the start
	var symbol = string_char_at(broadcast_str, 1);
	
	switch (symbol) {
		case "$":
			var index = 2;
			var char = string_char_at(broadcast_str, index);
			var actor_id = "";
			
			while string_digits(char) != "" {
				actor_id += char;
				index++;
				char = string_char_at(broadcast_str, index);
			}
			
			actor_id = real(actor_id);
			var facing = real(string_char_at(broadcast_str, index+1));
				
			actor_objects[actor_id].sprite_index = actor_objects[actor_id].sprite[facing];
			
			break;
			case "@":
				with obj_text_engine {
					total_text_to_display = string_copy(broadcast_str, 2, string_length(broadcast_str));
				}
			
				layer_sequence_pause(global.current_sequence);
				break;
	}
}