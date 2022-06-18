vertexArray[0][0] = Player1.x;
vertexArray[0][1] = Player1.y;
vertexArray[vertexCount - 1][0] = Player2.x;
vertexArray[vertexCount - 1][1] = Player2.y;

{ // rope dynamic movement
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

	vertexArray[0][0] = Player1.x;
	vertexArray[0][1] = Player1.y;
	vertexArray[vertexCount - 1][0] = Player2.x;
	vertexArray[vertexCount - 1][1] = Player2.y;
}
//	// rubber rope effect between Players 
if (point_distance(Player1.x,Player1.y,Player2.x,Player2.y) > maxPlayerDistance) {
	var dir = point_direction(Player1.x,Player1.y,Player2.x,Player2.y);
	var speedMultiplier = 1.4;
	Player1.vx += lengthdir_x(Player1.spd,dir) * speedMultiplier * global.deltaTime;
	Player1.vy += lengthdir_y(Player1.spd,dir) * speedMultiplier * global.deltaTime;
	Player2.vx -= lengthdir_x(Player2.spd,dir) * speedMultiplier * global.deltaTime;
	Player2.vy -= lengthdir_y(Player2.spd,dir) * speedMultiplier * global.deltaTime;
}



ellipseXL = vertexArray[0][0];
ellipseXR = vertexArray[0][0];
ellipseYT = vertexArray[0][1];
ellipseYB = vertexArray[0][1];
//for (var i = 0; i < array_length (middlePoints); ++i) {
//	middlePoints[i][0] = 0; //x
//	middlePoints[i][1] = 0; //y
//	middlePoints[i][2] = 0; //usedPoints
//}
//check if makes circle and kill enemy
isCircle = false;

if (Distance(vertexArray[0],vertexArray[vertexCount - 1]) < 30) {
	isCircle = true;
	var ignoredCirclePortion = floor (vertexCount /2/3);
	for (var i = 0; i < vertexCount / 2; ++i) {
	    var dis = Distance(vertexArray[i],vertexArray[vertexCount / 2 + i]);
		if (dis < circleTreshold) {
			isCircle = false;
			break;
		}
		
		{//collisionHelp
			ellipseXL = min (ellipseXL, vertexArray[i][0], vertexArray[vertexCount / 2 + i][0]);
			ellipseXR = max (ellipseXR, vertexArray[i][0], vertexArray[vertexCount / 2 + i][0]);
			ellipseYT = min (ellipseYT, vertexArray[i][1], vertexArray[vertexCount / 2 + i][1]);
			ellipseYB = max (ellipseYB, vertexArray[i][1], vertexArray[vertexCount / 2 + i][1]);
		}
		{// point1
			//middlePoints[0][0] += vertexArray[i][0] + vertexArray[vertexCount / 2 + i][0];
			//middlePoints[0][1] += vertexArray[i][1] + vertexArray[vertexCount / 2 + i][1];
			//middlePoints[0][2] += 2;
		}
		{// point2
			//if (i < ignoredCirclePortion) {
			//	middlePoints[1][0] += vertexArray[vertexCount / 2 + i][0];
			//	middlePoints[1][1] += vertexArray[vertexCount / 2 + i][1];
			//	middlePoints[1][2]++;
			//} else if (i > vertexCount /2 - ignoredCirclePortion) {
			//	middlePoints[1][0] += vertexArray[i][0];
			//	middlePoints[1][1] += vertexArray[i][1];
			//	middlePoints[1][2]++;
			//} else {
			//	middlePoints[1][0] += vertexArray[i][0] + vertexArray[vertexCount / 2 + i][0];
			//	middlePoints[1][1] += vertexArray[i][1] + vertexArray[vertexCount / 2 + i][1];
			//	middlePoints[1][2] += 2;
			//}
		}
	}
	ellipseXL += 30;
	ellipseXR -= 30;
	ellipseYT += 30;
	ellipseYB -= 30;
	
	if (isCircle) {
		//middlePoints[0][0] /= middlePoints[0][2];
		//middlePoints[0][1] /= middlePoints[0][2];
		//middlePoints[1][0] /= middlePoints[1][2];
		//middlePoints[1][1] /= middlePoints[1][2];
		
		
		var inst = collision_ellipse (ellipseXL, ellipseYT, ellipseXR, ellipseYB, Enemy, false, false);
		if (inst != noone) {
			audio_play_sound(applauseSound, 0, 0);
			with (inst) instance_destroy();
			array_resize(history,array_length(history) + 1);
			history[array_length(history) - 1] = [];
			for (var j = 0;j < array_length (vertexArray);++j) {
				history[array_length(history) - 1][j] = [];
				array_copy (history[array_length(history) - 1][j], 0, vertexArray[j], 0, array_length(vertexArray[j]));
			}
		}
		
		/*
		for (var i = 0; i < array_length (middlePoints); ++i) {
			var inst;
			inst = instance_position(middlePoints[i][0], middlePoints[i][1], Enemy);
			if (inst != noone) {
				audio_play_sound(applauseSound, 0, 0);
				with (inst) instance_destroy();
				array_resize(history,array_length(history) + 1);
				history[array_length(history) - 1] = [];
				for (var j = 0;j < array_length (vertexArray);++j) {
					history[array_length(history) - 1][j] = [];
					array_copy (history[array_length(history) - 1][j], 0, vertexArray[j], 0, array_length(vertexArray[j]));
				}
			
			}
		}
		*/

	}
}
