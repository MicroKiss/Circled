draw_self ();

if (wantsToThrow)
	draw_sprite (playerWantsSprite, 0, x, y - sprite_height)

if (global.DEBUG)
	draw_arrow(x,y,x+lengthdir_x(100,lastDir),y+lengthdir_y(100,lastDir),10)
