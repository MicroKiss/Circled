enum Enemy3states
{
	moving,
	arrived
}

destination[0] = room_width / 2;
destination[1] = room_height / 2;

dir = point_direction (x, y, destination[0], destination[1]);

sprite_index = enemy2Sprite;
image_angle = dir;