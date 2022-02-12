if (other.object_index == Player1) {
	global.player1Skin = GetNextPlayerSkin(Player1.sprite_index);
	Player1.sprite_index = global.player1Skin
} else {
	global.player2Skin = GetNextPlayerSkin(Player2.sprite_index);
	Player2.sprite_index = global.player2Skin
}
 
 
dir = point_direction(x,y,other.x,other.y);
other.x += lengthdir_x(5,dir);
other.y += lengthdir_y(5,dir);
other.vx = lengthdir_x(other.spd/5,dir) ;
other.vy = lengthdir_y(other.spd/5,dir) ;