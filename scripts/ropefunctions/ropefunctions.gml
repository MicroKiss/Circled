function RopeEndsToPlayers ()
{
	vertexArray[0][0] = Player1.x;
	vertexArray[0][1] = Player1.y;
	vertexArray[vertexCount - 1][0] = Player2.x;
	vertexArray[vertexCount - 1][1] = Player2.y;
}


function RopeDynamicMovement()
{
	for (var i = 1; i < vertexCount / 2; ++i) {
		var distance = Distance (vertexArray[i],vertexArray[i - 1]);
		if (distance > maxRopeSegmentDistance) {
			var dir = Direction(vertexArray[i],vertexArray[i-1]);
			
			vertexArray[i][0] += lengthdir_x((distance - maxRopeSegmentDistance), dir);
			vertexArray[i][1] += lengthdir_y((distance - maxRopeSegmentDistance), dir);
		}
		var distance = Distance (vertexArray[vertexCount - i], vertexArray[vertexCount - i - 1]);
		if (distance > maxRopeSegmentDistance) {
			var dir = Direction(vertexArray[vertexCount - i - 1],vertexArray[vertexCount - i]);
			vertexArray[vertexCount - i - 1][0] += lengthdir_x((distance - maxRopeSegmentDistance), dir);
			vertexArray[vertexCount - i - 1][1] += lengthdir_y((distance - maxRopeSegmentDistance), dir);
		}
	}
	var middleDistanceDiff = Distance (vertexArray[vertexCount / 2 - 1], vertexArray[vertexCount / 2]);
	if (middleDistanceDiff > maxRopeSegmentDistance) {
		middlePosX = (vertexArray[vertexCount / 2 - 1][0] + vertexArray[vertexCount / 2][0]) /2;
		middlePosY = (vertexArray[vertexCount / 2 - 1][1] + vertexArray[vertexCount / 2][1]) /2;
		var dir = Direction (vertexArray[vertexCount / 2 - 1],vertexArray[vertexCount / 2]);
		vertexArray[vertexCount / 2 - 1][0] = middlePosX - lengthdir_x(maxRopeSegmentDistance / 2, dir);
		vertexArray[vertexCount / 2 - 1][1] = middlePosY - lengthdir_y(maxRopeSegmentDistance / 2, dir);
		vertexArray[vertexCount / 2][0] = middlePosX + lengthdir_x(maxRopeSegmentDistance / 2, dir);
		vertexArray[vertexCount / 2][1] = middlePosY + lengthdir_y(maxRopeSegmentDistance / 2, dir);
	}
	for (var i = vertexCount / 2 - 2; i >= 0; --i) {
		var distance = Distance (vertexArray[i],vertexArray[i + 1]);
		if (distance > maxRopeSegmentDistance) {
			var dir = Direction(vertexArray[i],vertexArray[i+1]);
			vertexArray[i][0] += lengthdir_x((distance - maxRopeSegmentDistance), dir);
			vertexArray[i][1] += lengthdir_y((distance - maxRopeSegmentDistance), dir);
		}
		var distance = Distance (vertexArray[vertexCount - 1 - i], vertexArray[vertexCount - 1 - i - 1]);
		if (distance > maxRopeSegmentDistance) {
			var dir = Direction(vertexArray[vertexCount - 1 - i],vertexArray[vertexCount - 1 - i - 1]);
			vertexArray[vertexCount - 1 - i][0] += lengthdir_x((distance - maxRopeSegmentDistance), dir);
			vertexArray[vertexCount - 1 - i][1] += lengthdir_y((distance - maxRopeSegmentDistance), dir);
		}
	}

}


function RopeRubberEffectBetweenPlayers ()
{
	vertexArray[0][0] = Player1.x;
	vertexArray[0][1] = Player1.y;
	vertexArray[vertexCount - 1][0] = Player2.x;
	vertexArray[vertexCount - 1][1] = Player2.y;
	if (point_distance(Player1.x,Player1.y,Player2.x,Player2.y) > maxPlayerDistance) {
		var dir = point_direction(Player1.x,Player1.y,Player2.x,Player2.y);
		var speedMultiplier = 1.4;
		Player1.vx += lengthdir_x(Player1.spd,dir) * speedMultiplier * global.deltaTime;
		Player1.vy += lengthdir_y(Player1.spd,dir) * speedMultiplier * global.deltaTime;
		Player2.vx -= lengthdir_x(Player2.spd,dir) * speedMultiplier * global.deltaTime;
		Player2.vy -= lengthdir_y(Player2.spd,dir) * speedMultiplier * global.deltaTime;
	}
}
	
	
function RopeCircleCheckAndKill () 
{
	ellipseXL = vertexArray[0][0];
	ellipseXR = vertexArray[0][0];
	ellipseYT = vertexArray[0][1];
	ellipseYB = vertexArray[0][1];

	//check if makes circle and kill enemy
	isCircle = false;
	if (Distance(vertexArray[0],vertexArray[vertexCount - 1]) < 30) {
		isCircle = true;
		for (var i = 0; i < vertexCount / 2; ++i) {
		    var dis = Distance(vertexArray[i],vertexArray[vertexCount / 2 + i]);
			if (dis < circleTreshold) {
				isCircle = false;
				break;
			}
			ellipseXL = min (ellipseXL, vertexArray[i][0], vertexArray[vertexCount / 2 + i][0]);
			ellipseXR = max (ellipseXR, vertexArray[i][0], vertexArray[vertexCount / 2 + i][0]);
			ellipseYT = min (ellipseYT, vertexArray[i][1], vertexArray[vertexCount / 2 + i][1]);
			ellipseYB = max (ellipseYB, vertexArray[i][1], vertexArray[vertexCount / 2 + i][1]);
		
		}
		ellipseXL += 30;
		ellipseXR -= 30;
		ellipseYT += 30;
		ellipseYB -= 30;
	
		if (isCircle) {
			var enemy = collision_ellipse (ellipseXL, ellipseYT, ellipseXR, ellipseYB, Enemy, false, false);
			if (enemy != noone) {
				RopeKillEnemy (enemy)
			}
		}
	}
}


function RopeDrawHistory ()
{
	for (var i = 0;i < array_length (history); ++i) {
		draw_primitive_begin(pr_linestrip);
		for (var j = 0;j < array_length (history[i]); ++j) {
			draw_vertex (history[i][j][0], history[i][j][1]);
		}
		draw_primitive_end ();
	}
}


function RopeDrawHitMarker ()
{
	var originalColor = draw_get_color ();
	draw_set_colour (c_red);
	if (thrown) { 
		for (var i = 0; i < vertexCount - 10  ; i += vertexCount / 11) {
			if (i + 11 >= vertexCount)
				i = vertexCount - 12;
				draw_line (vertexArray[i][0], vertexArray[i][1], vertexArray[i + 11][0], vertexArray[i + 11][1]);
		}
	} else if (isCircle) {

		draw_set_colour (c_green);
		draw_ellipse (ellipseXL, ellipseYT, ellipseXR, ellipseYB, false);

	}
	draw_set_colour (originalColor);
}


function RopeDrawRope ()
{
	draw_primitive_begin (pr_linestrip);
	for (var i = 0; i < array_length (vertexArray); ++i) {
		draw_vertex(vertexArray[i][0], vertexArray[i][1]);
	}
	draw_primitive_end ();
}


function RopeHandleThrowing () 
{
	if (!thrown && Player1.wantsToThrow && Player2.wantsToThrow) {
		thrown = true;
		dir1 = Player1.lastDir;
		dir2 = Player2.lastDir;
		moveSpeed1 = 500 + abs (Player1.vx) + abs (Player1.vy);
		moveSpeed2 = 500 + abs (Player2.vx) + abs (Player2.vy);
	}
}


function RopeMoveThrownRope () 
{
	if (moveSpeed1 > 0 || moveSpeed2 > 0 ) {
		vertexArray[0][0] += lengthdir_x (moveSpeed1, dir1) * global.deltaTime;
		vertexArray[0][1] += lengthdir_y (moveSpeed1, dir1) * global.deltaTime;
		vertexArray[vertexCount - 1][0] += lengthdir_x (moveSpeed2, dir2) * global.deltaTime;
		vertexArray[vertexCount - 1][1] += lengthdir_y (moveSpeed2, dir2) * global.deltaTime;
		if (moveSpeed1 > 30 )
			moveSpeed1 -=  moveSpeed1 * 0.5 *global.deltaTime;
		else 
			moveSpeed1 = 0;
		
		if (moveSpeed2 > 30 )
			moveSpeed2 -=  moveSpeed2 * 0.5 *global.deltaTime;
		else 
			moveSpeed2 = 0;
	}
}


function RopeThrownCheckAndKill ()
{
	if (vertexCount < 11)
		throw ("vertexCount smalelr than 11");
	for (var i = 0; i < vertexCount - 10  ; i += vertexCount / 11) {
		if (i + 11 >= vertexCount)
			i = vertexCount - 12;
		var enemy = collision_line (vertexArray[i][0], vertexArray[i][1],
									vertexArray[i + 11][0], vertexArray[i + 11][1],
									Enemy, false, true);
		if (enemy != noone)
			RopeKillEnemy (enemy)
	}
}


function RopeKillEnemy (enemy) 
{
	audio_play_sound(applauseSound, 0, 0);
	with (enemy) instance_destroy ();
	array_resize(history,array_length(history) + 1);
	history[array_length(history) - 1] = [];
	for (var j = 0;j < array_length (vertexArray);++j) {
		history[array_length(history) - 1][j] = [];
		array_copy (history[array_length(history) - 1][j], 0, vertexArray[j], 0, array_length(vertexArray[j]));
	}
}