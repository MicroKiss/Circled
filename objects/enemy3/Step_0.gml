// Inherit the parent event
event_inherited ();

if (state == Enemy3states.moving) {
	if (Distance ([x,y],destination) <= moveSpeed * global.deltaTime) {
		state = Enemy3states.arrived;
		sprite_index = enemy1Sprite;
		alarm_set (0, room_speed * 2);
		bulletDir = dir;
	}
}


if (state == Enemy3states.moving) {
	x += lengthdir_x (moveSpeed, dir) * global.deltaTime;
	y += lengthdir_y (moveSpeed, dir) * global.deltaTime;
} else if (state == Enemy3states.arrived) {

}

