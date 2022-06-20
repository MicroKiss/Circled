var newBullet =  instance_create_depth (x, y, depth, Bullet)

newBullet.dir = bulletDir;
bulletDir = (bulletDir + 90) mod 360;

alarm_set (0, room_speed * 2)