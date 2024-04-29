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
    
    if (yspd == 0) {
        if (xspd > 0) face = RIGHT;
        else if (xspd < 0) face = LEFT;
    }

    if (xspd == 0) {    
        if (yspd > 0) face = DOWN;
        else if (yspd < 0) face = UP;
    }
} else {
    xspd = 0;
    yspd = 0;
}

if (global.main_state == e_main.ready) {
    // Check if obj_activate_cutscene has not been triggered
    if (!global.cutscene_triggered) {
        var cutscene = collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, obj_activate_cutscene, false, true);

        if (cutscene != noone && obj_cutscene.cutscenes[global.story_val][room] != -1) {
            global.main_state = e_main.cutscene;
            with obj_cutscene state = e_cutscene.init;
            
            // Mark obj_activate_cutscene as triggered
            global.cutscene_triggered = true;
            instance_destroy(obj_activate_cutscene); // Destroy obj_activate_cutscene
        }
    }
    
    //if (keyboard_check_pressed(vk_enter)) {
    //    if (room == rm_start3) room_goto(rm_start2);
    //    else room_goto(rm_start3);
    //}
    
    // Set sprite based on direction
    sprite_index = sprite[face];
    
    // Collisions
    if (!place_meeting(x + xspd, y, obj_wall)) {
        x += xspd;
    }
    if (!place_meeting(x, y + yspd, obj_wall)) {
        y += yspd;
    }

    // Animate if not moving
    if (xspd == 0 && yspd == 0) {
        image_index = 0;
    }

    // Depth
    depth = -bbox_bottom;
}
