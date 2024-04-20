if (!global.dialogue_active && place_meeting(x, y, obj_cute_cat) && keyboard_check_pressed(vk_space)) {
    global.dialogue_active = true;
    create_textbox(text_id);
}