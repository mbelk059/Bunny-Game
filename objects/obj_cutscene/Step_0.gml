if(state == e_cutscene.init) {
	layer_sequence_play(global.current_sequence);
	state = e_cutscene.play;
}

if state == e_cutscene.play {
	
	if(layer_sequence_is_finished(global.current_sequence)) {
		
		layer_sequence_destroy(global.current_sequence);
		global.current_sequence = -1;
		state = e_cutscene.idle;
		global.main_state = e_main.ready;
	}
}