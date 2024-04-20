var _interaction_radius = 35;

//are we standing on a cutscene obj
var cutscene = collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, obj_activate_cutscene, false, true);

//start cutscene if there is one
if (cutscene != noone) {
	with cutscene instance_destroy();
}

if (keyboard_check(vk_left)) x -= 1;
if (keyboard_check(vk_right)) x += 1;

#region NEXT



xspd = 0;
yspd = 0;

move_spd = 0;

sprite[RIGHT] = spr_player_right;
sprite[UP] = spr_player_up;
sprite[LEFT] = spr_player_left;
sprite[DOWN] = spr_player_down;

face = DOWN;