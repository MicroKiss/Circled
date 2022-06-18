var count = 2;
if (current_time > 30000)
	count = min (floor (current_time / 10000), 10)
for (var i = 0; i < count; ++i) {
	var randX, randY;
	if (irandom (1) == 0) {
		randX = irandom (1) * room_width;
		randY = random_range (0, room_height);
	} else {
		randX = random_range (0, room_width);
		randY = irandom (1) * room_height;
	}
	var enemy = instance_create_depth (randX, randY, depth-1, Enemy2);
	enemy.movSpeed = min (25 + current_time / 10000, 200)
}

alarm_set (0, 5 * room_speed);