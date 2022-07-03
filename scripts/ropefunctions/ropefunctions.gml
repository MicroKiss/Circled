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
	if (state == states.thrown) { 
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
	var lastColor = draw_get_color (); 
	if (state == states.laying)
		draw_set_colour (c_fuchsia);
	
	
	draw_primitive_begin (pr_linestrip);
	for (var i = 0; i < array_length (vertexArray); ++i) {
		draw_vertex(vertexArray[i][0], vertexArray[i][1]);
	}
	draw_primitive_end ();
	
	draw_set_color (lastColor);
}


function RopeHandleStateChanges () 
{	
	if (state == states.carried) {
		if (Player1.wantsToThrow && Player2.wantsToThrow) {
			state = states.thrown;
			dir1 = Player1.lastDir;
			dir2 = Player2.lastDir;
			moveSpeed1 = 1000 + 5 * (abs (Player1.vx) + abs (Player1.vy));
			moveSpeed2 = 1000 + 5 * (abs (Player2.vx) + abs (Player2.vy));
		}
	} else if (state == states.thrown) {
		if (moveSpeed1 == 0 && moveSpeed2 == 0) {
			state = states.laying;
		}
	} else if (state == states.laying) {
		RopeHandlePickup ();
	} else if (state == states.dragged) {
		if (draggedBy == noone )
			throw ("Someone must drag it")
		RopeHandlePickup ();
	}
	
	CheckEnemyRopeGrabber ();
}


function RopeMoveThrownRope () 
{
	if (moveSpeed1 > 0 || moveSpeed2 > 0 ) {
		var dx, dy;
		dx = lengthdir_x (moveSpeed1, dir1) * global.deltaTime;
		dy = lengthdir_y (moveSpeed1, dir1) * global.deltaTime;
		
		if (!position_meeting (vertexArray[0][0] + dx, vertexArray[0][1], Solid)) {
			vertexArray[0][0] += dx;
		} else {
			dir1 = 180 - dir1;
		}
		
		if (!position_meeting (vertexArray[0][0], vertexArray[0][1] + dy, Solid)) {
			vertexArray[0][1] += dy;
		} else {
			dir1 = 360 - dir1;
		}
		
		dx = lengthdir_x (moveSpeed2, dir2) * global.deltaTime;
		dy = lengthdir_y (moveSpeed2, dir2) * global.deltaTime;
		
		if (!position_meeting (vertexArray[vertexCount - 1][0] + dx, vertexArray[vertexCount - 1][1], Solid)) {
			vertexArray[vertexCount - 1][0] += dx;
		} else {
			dir2 = 180 - dir2;
		}
		
		if (!position_meeting (vertexArray[vertexCount - 1][0], vertexArray[vertexCount - 1][1] + dy, Solid)) {
			vertexArray[vertexCount - 1][1] += dy;
		} else {
			dir2 = 360 - dir2;
		}
		
		if (moveSpeed1 > 50 )
			moveSpeed1 -=  moveSpeed1 * 0.8 * global.deltaTime;
		else 
			moveSpeed1 = 0;
		
		if (moveSpeed2 > 50 )
			moveSpeed2 -=  moveSpeed2 * 0.8 * global.deltaTime;
		else 
			moveSpeed2 = 0;
	}
}


function RopeThrownCheckAndKill ()
{
	if (vertexCount < 11)
		throw ("vertexCount smaller than 11");
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
	audio_play_sound (applauseSound, 1, 0);
	with (enemy) instance_destroy ();
	array_resize (history,array_length(history) + 1);
	history[array_length(history) - 1] = [];
	for (var j = 0;j < array_length (vertexArray);++j) {
		history[array_length(history) - 1][j] = [];
		array_copy (history[array_length (history) - 1][j], 0, vertexArray[j], 0, array_length (vertexArray[j]));
	}
	
	if instance_number (GameUI) {
		GameUI.killedEnemies++;
	}
}


function RopeHandlePickup ()
{
	if (state == states.laying) {
		var players = ds_list_create ();
		var num = collision_circle_list (vertexArray[0][0], vertexArray[0][1], 10, Player, false, true, players, false);
		if (num > 0) {
			for (var i = 0; i < num; ++i;) {
				if (players[| i].inputs.use) {
					state = states.dragged;
					draggedByTheBeginning = true;
					draggedBy = players[| i];
					return;
				}
			}
		}
		var num = collision_circle_list (vertexArray[vertexCount -1][0], vertexArray[vertexCount -1][1], 10, Player, false, true, players, false);
		if (num > 0) {
			for (var i = 0; i < num; ++i;) {
				if (players[| i].inputs.use) {
					state = states.dragged;
					draggedByTheBeginning = false;
					draggedBy = players[| i];
					return;
				}
			}
		}
	} else if (state == states.dragged) {
		var player;
		if (draggedBy.object_index == Player1) {
			if (draggedByTheBeginning)
				player = collision_circle (vertexArray[vertexCount - 1][0], vertexArray[vertexCount - 1][1], 10, Player2, false, true);
			else 
				player = collision_circle (vertexArray[0][0], vertexArray[0][1], 10, Player2, false, true);
		} else if (draggedBy.object_index == Player2) {
			if (draggedByTheBeginning)  
				player = collision_circle (vertexArray[vertexCount - 1][0], vertexArray[vertexCount - 1][1], 10, Player1, false, true);
			else
				player = collision_circle (vertexArray[0][0], vertexArray[0][1], 10, Player1, false, true);
		} 
		
		if (player != noone && player.inputs.use) {
			if (draggedByTheBeginning && draggedBy.object_index == Player2
			||	!draggedByTheBeginning && draggedBy.object_index == Player1) {
				for (var i = 0; i < vertexCount/2; ++i) {
					var tempX = vertexArray[i][0];
					var tempY = vertexArray[i][1];
					vertexArray[i][0] = vertexArray[vertexCount - 1 - i][0];
					vertexArray[i][1] = vertexArray[vertexCount - 1 - i][1];
					vertexArray[vertexCount - 1 - i][0] = tempX;
					vertexArray[vertexCount - 1 - i][1] = tempY;
				}
			}
			state = states.carried;
			draggedBy = noone;
		}
	}
}


function RopeEndToDraggingPlayer ()
{
	if (draggedByTheBeginning) {
		vertexArray[0][0] = draggedBy.x;
		vertexArray[0][1] = draggedBy.y;
	} else {
		vertexArray[vertexCount - 1][0] = draggedBy.x;
		vertexArray[vertexCount - 1][1] = draggedBy.y;
	}
}


function CheckEnemyRopeGrabber () 
{
	if (vertexCount < 11)
		throw ("vertexCount smaller than 11");
	for (var i = 0; i < vertexCount - 10  ; i += vertexCount / 11) {
		if (i + 11 >= vertexCount)
			i = vertexCount - 12;
		var enemy = collision_line (vertexArray[i][0], vertexArray[i][1],
									vertexArray[i + 11][0], vertexArray[i + 11][1],
									EnemyRopeGrabber, false, true);
		if (enemy != noone) {
			if (enemy.canGrab == true) {
				enemy.canGrab = false;
				
				var Reload = function(e) {
					e.canGrab = true;
					show_debug_message ("meghivodtam");
					// TODO itt baj van mert valamiéert nem csak egyszer hivodik valszeg ezt az egesz fgügvényt ekl legy state függő ifbe
				}
				timer = time_source_create (time_source_game, 5, time_source_units_seconds, Reload, [enemy])

				time_source_start (timer)
				state = states.laying;
			}
		}
	}
}