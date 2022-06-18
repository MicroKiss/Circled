if (other.object_index == Player1) {
	if (current_time - player1SelectionTime > selectionInterval) {
		player1SelectionTime = current_time
		GetNextPlayerSkin (Player1);
	}
} else if (other.object_index == Player2) {
	if (current_time - player2SelectionTime > selectionInterval) {
		player2SelectionTime = current_time
		GetNextPlayerSkin (Player2);
	}
}
 

dir = point_direction (x, y, other.x, other.y);
other.x += lengthdir_x (5,dir);
other.y += lengthdir_y (5,dir);
other.vx = lengthdir_x (other.spd/5, dir);
other.vy = lengthdir_y (other.spd/5, dir);