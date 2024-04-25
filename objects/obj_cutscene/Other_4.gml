if (cutscenes[global.story_val][room] != -1) {
    var this_sequence = cutscenes[global.story_val][room];
    
    global.current_sequence = layer_sequence_create("Cutscenes", 0, 0, this_sequence);
    
    var _seq_inst = layer_sequence_get_instance(global.current_sequence);    

    var _seq = sequence_get(this_sequence);
    sequence_objects = sequence_get_objects(_seq);

    for (var i = 0; i < array_length(sequence_objects); i++) {
        var object = sequence_objects[i];
        
        if instance_exists(object) {
            var room_obj_inst = instance_find(object, 0);
            sequence_instance_override_object(_seq_inst, object, room_obj_inst);
        }
    }
    
    layer_sequence_pause(global.current_sequence);
}
