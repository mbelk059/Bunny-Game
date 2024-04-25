xspd = 0;
yspd = 0;

move_spd = 1.1;

sprite[RIGHT] = spr_cute_cat_right;
sprite[UP] = spr_cute_cat_up;
sprite[LEFT] = spr_cute_cat_left;
sprite[DOWN] = spr_cute_cat_down;

face = DOWN;

global.interact_speakblock = false;
global.active_textbox = noone;

current_sprite = sprite_index;

global.main_state = e_main.ready;
global.story_val = 0;