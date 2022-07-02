// Inherit the parent event
event_inherited ();

if (state == Enemy3states.moving) {
	if (Distance ([x,y],destination) <= moveSpeed * global.deltaTime) {
		state = Enemy3states.arrived;
		sprite_index = enemy1Sprite;
		alarm_set (0, room_speed * 2);
		bulletDir = dir;
		
		var Shoot = function() {
			var newBullet =  instance_create_depth (x, y, depth, Bullet)
			newBullet.dir = bulletDir;
			bulletDir = (bulletDir + 90) mod 360;
		}
		timer = time_source_create (time_source_game, 2, time_source_units_seconds, Shoot, [], -1)

		time_source_start (timer)
	}
}


if (state == Enemy3states.moving) {
	x += lengthdir_x (moveSpeed, dir) * global.deltaTime;
	y += lengthdir_y (moveSpeed, dir) * global.deltaTime;
} else if (state == Enemy3states.arrived) {

}

