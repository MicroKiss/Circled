var GenerateEnemy2 = function()
{
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
		/*var enemy = */
		instance_create_depth (randX, randY, depth-1, Enemy2);
		//enemy.movSpeed = min (25 + current_time / 10000, 200)
	}
}


var GenerateEnemy3 = function()
{
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
		var enemy = instance_create_depth (randX, randY, depth - 1, Enemy3);
		enemy.destination[0] = random_range (300, room_width  - 300);
		enemy.destination[1] = random_range (300, room_height - 300);
	
		dir = point_direction (enemy.x, enemy.y, enemy.destination[0], enemy.destination[1])
		enemy.dir = dir;
		enemy.image_angle = dir;
	}
}


timer1 = time_source_create (time_source_game, 10, time_source_units_seconds, GenerateEnemy2, [], -1)
timer2 = time_source_create (time_source_game, 20, time_source_units_seconds, GenerateEnemy3, [], -1)

time_source_start (timer1)
time_source_start (timer2)