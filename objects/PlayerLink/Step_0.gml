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
	Player1.vx += lengthdir_x(Player1.attributes.movSpeed/40,dir);
	Player1.vy += lengthdir_y(Player1.attributes.movSpeed/40,dir);
	Player2.vx -= lengthdir_x(Player2.attributes.movSpeed/40,dir);
	Player2.vy -= lengthdir_y(Player2.attributes.movSpeed/40,dir);
}


//check if makes circle and kill enemy
isCircle = false;
if (Distance(vertexArray[0],vertexArray[vertexCount - 1]) < 30) {
	isCircle = true;
	 middlePointX = 0;
	 middlePointY = 0;
	
	for (var i = 0; i < vertexCount / 2; ++i) {
	    var dis = Distance(vertexArray[i],vertexArray[vertexCount / 2 + i]);
		if (dis < circleTreshold) {
			isCircle = false;
			break;
		}
		middlePointX += vertexArray[i][0] + vertexArray[vertexCount / 2 + i][0];
		middlePointY += vertexArray[i][1] + vertexArray[vertexCount / 2 + i][1];
	}
	if (isCircle) {
		middlePointX /= vertexCount;
		middlePointY /= vertexCount;
		var inst;
		inst = instance_position(middlePointX, middlePointY, Enemy);
		if (inst != noone) {
			audio_play_sound(applauseSound, 0, 0);
			with (inst) instance_destroy();
			array_resize(history,array_length_1d(history) + 1);
			history[array_length_1d(history) - 1] = [];
			for (var j = 0;j < array_length_1d (vertexArray);++j) {
				history[array_length_1d(history) - 1][j] = [];
				array_copy (history[array_length_1d(history) - 1][j], 0, vertexArray[j], 0, array_length_1d(vertexArray[j]));
			}
			
		}
	}
}
