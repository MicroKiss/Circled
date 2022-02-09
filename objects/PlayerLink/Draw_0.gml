draw_primitive_begin(pr_linestrip);
for (var i = 0;i < array_length_1d(vertexArray);++i) {
	draw_vertex(vertexArray[i][0], vertexArray[i][1]);
}

draw_primitive_end();



if(isCircle) {
	draw_set_colour(c_green);
	draw_circle(middlePointX,middlePointY,5,false);
} else {
	draw_set_colour(c_white);
}

//history

for (var i = 0;i < array_length_1d(history);++i) {
	draw_primitive_begin(pr_linestrip);
	for (var j = 0;j < array_length_1d(history[i]);++j) {
		draw_vertex(history[i][j][0], history[i][j][1]);
	}
	draw_primitive_end();
}