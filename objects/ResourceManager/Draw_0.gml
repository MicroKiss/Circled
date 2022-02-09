draw_set_halign(fa_center);

if(paused){
	if (instance_number (Camera) == 1)  {
	    draw_sprite(screenShot,0,Camera.x-global.width/2,Camera.y-global.height/2);
		draw_text(Camera.x,Camera.y, "Paused");

	} else {

	draw_sprite_ext(screenShot,0,0,0,1,1,0,c_white,1);
    draw_text(global.width/2, global.height/2, "Paused");
	}
}