if (image_index == 0 && (place_meeting(x,y,Player) || position_meeting(mouse_x, mouse_y, self))) {
	switch (irandom (2)) {
	    case 0:
			audio_play_sound(buttonSound1, 0, 0);
			break;
		case 1:
			audio_play_sound(buttonSound2, 0, 0);
			break;
		case 2:
			audio_play_sound(buttonSound3, 0, 0);
			break;
	}

	image_index = 1;
} else if(!place_meeting(x,y,Player) && !position_meeting(mouse_x, mouse_y, self)) {
	image_index = 0;
}


if(mouse_check_button_released(mb_left) && position_meeting(mouse_x, mouse_y, self))
	event_user(0);