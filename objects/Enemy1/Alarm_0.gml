var newBullet =  instance_create_depth(x,y,depth,Bullet)

newBullet.dir = dir;

dir = (dir + 1) mod 4;

alarm_set(0,room_speed * 2)