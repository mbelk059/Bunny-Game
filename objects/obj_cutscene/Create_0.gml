enum e_main {ready, cutscene};
enum e_cutscene {idle, init, play};

state = e_cutscene.idle;

global.main_state = e_main.ready;
global.story_val = 0;

var max_story_points = 3;

for(var yy = 0; yy <= 2; yy ++) {
	for (var xx = 0; xx < max_story_points; xx ++) {
		cutscenes[xx][yy] = -1;
	}
}

cutscenes[0][rm_hallway] = seq_mayor_calls_about_mission;	
cutscenes[1][rm_level3] = -1;
cutscenes[2][rm_start2] = seq_test4;
cutscenes[3][rm_start2] = seq_test3;		

actor_objects[0] = obj_bunny;
actor_objects[1] = obj_cute_cat;
