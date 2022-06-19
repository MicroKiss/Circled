//vertexCount must be even
enum states
{
	carried,
	thrown,
	laying,
	dragged
}

if (vertexCount % 2 == 1)
	throw ("vertexCount is odd");
	
history = [];

vertexArray[segmentCount] = 0;
middlePoints = [];
array_resize (middlePoints, 2);

for (var i = 0;i < vertexCount;++i) {
	vertexArray[i][0] = (1 - (i / segmentCount)) * Player1.x + (i /  segmentCount) * Player2.x;
	vertexArray[i][1] = (1 - (i / segmentCount)) * Player1.y + (i /  segmentCount) * Player2.y;
}
