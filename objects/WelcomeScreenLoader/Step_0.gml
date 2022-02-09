alpha = 0.5 + dsin(current_time / 5) * 0.5;


if (keyboard_check(vk_anykey) || mouse_check_button(mb_any) || gamepad_button_check(0, gp_face1)) {
	room_goto(menu);
}

