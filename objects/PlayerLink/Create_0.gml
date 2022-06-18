//vertexCount must be even

if (vertexCount % 2 == 1)
	throw ("vertexCount is odd");
	
history = [];

vertexArray[segmentCount] = 0;
middlePoints =	[ [0, 0, 0], [0, 0, 0] ] //x,y,usedPoints

for (var i = 0;i < vertexCount;++i) {
	vertexArray[i][0] = (1 - (i / segmentCount)) * Player1.x + (i /  segmentCount) * Player2.x;
	vertexArray[i][1] = (1 - (i / segmentCount)) * Player1.y + (i /  segmentCount) * Player2.y;
}
