/// @param text_id
function scr_game_text(_text_id){
switch(_text_id) {
		
	case "npc 1":
		scr_text("i'm the cat! ", "cat");
			scr_text_color(8, 10, c_orange, c_orange, c_orange, c_orange);
		scr_text("uhh... ok? hello cat.");
		scr_text("do u wanna play with me?", "cat");
			scr_option("sure", "npc 1 - yes");
			scr_option("no what r u...", "npc 1 - no");
		break;
		case "npc 1 - yes":
			scr_text("hehe");
			break;
		case "npc 1 - no":
			scr_text("you will regret this.", "cat annoyed");
				scr_text_shake(9, 14);
			break;
			
	case "mayor":
	    scr_text("where are my stupid bodyguards...", "mayor");
	    scr_text("lol", "mayor");
	    scr_text("this is awkward...", "mayor");
	    break;




			
	case "bed":
		scr_text("This is a bed. Do you want to take a nap?");
			scr_option("yes", "bed - yes");
			scr_option("no", "bed - no");
		break;
		case "bed - yes":
			scr_text("hehe");
			break;
		case "bed - no":
			scr_text("hehe");
			break;
		
	case "bunny":
		scr_text("Nothing to see here. Move along.");
		break;
		
	}

}