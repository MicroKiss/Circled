var Shoot = function() {
	var newBullet =  instance_create_depth (x, y, depth, Bullet)
	newBullet.dir = bulletDir;
	bulletDir = (bulletDir + 90) mod 360;
}
timer = time_source_create (time_source_game, 2, time_source_units_seconds, Shoot, [], -1)

time_source_start (timer)