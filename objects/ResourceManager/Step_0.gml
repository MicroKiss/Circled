/// @description Insert description here
// You can write your code in this editor


if (gamepad_button_check_pressed(0,gp_start) || gamepad_button_check_pressed(1,gp_start)) {
	paused = !paused;
	if(paused) {
		if(!sprite_exists(screenShot))
	        screenShot = sprite_create_from_surface(application_surface,0,0,width,height,0,0,0,0);    
	    
		instance_deactivate_all(1);
	} else {
		if(sprite_exists(screenShot))
			sprite_delete(screenShot);
		
		instance_activate_all();
	}
}

if (keyboard_check_pressed(vk_enter)) 
 window_set_fullscreen(!window_get_fullscreen());
