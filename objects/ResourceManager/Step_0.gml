if (gamepad_button_check_pressed (0,gp_start) || gamepad_button_check_pressed (1,gp_start)) {
	paused = !paused;
	if (paused) {
		if (!sprite_exists (screenShot))
			if (instance_number (Camera) == 1)  {
				screenShot = sprite_create_from_surface (application_surface, 0, 0, global.width, global.height, 0, 0, Camera.x - global.width / 2, Camera.y - global.height / 2);    
			} else {
				screenShot = sprite_create_from_surface (application_surface, 0, 0, global.width, global.height, 0, 0, 0, 0);    
			}
			sprite_set_offset (screenShot, 0, 0);
		instance_deactivate_all (1);
		instance_activate_object (Camera);
	} else {
		if(sprite_exists (screenShot))
			sprite_delete (screenShot);
		
		instance_activate_all ();
	}
}

if (keyboard_check_pressed (vk_enter)) 
	window_set_fullscreen (!window_get_fullscreen ());
