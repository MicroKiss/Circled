
		

if(isCircle) {


	var originalColor = draw_get_color ();
	draw_set_colour(c_green);
	draw_ellipse (ellipseXL, ellipseYT, ellipseXR, ellipseYB, false);
	//for (var i = 0; i < array_length (middlePoints); ++i) {
	//    draw_circle (middlePoints[i][0],middlePoints[i][1],5,false);
	//}
	draw_set_colour(originalColor);
}
		
draw_primitive_begin (pr_linestrip);
for (var i = 0; i < array_length (vertexArray); ++i) {
	draw_vertex(vertexArray[i][0], vertexArray[i][1]);
}
draw_primitive_end ();


//history

for (var i = 0;i < array_length (history);++i) {
	draw_primitive_begin(pr_linestrip);
	for (var j = 0;j < array_length (history[i]);++j) {
		draw_vertex (history[i][j][0], history[i][j][1]);
	}
	draw_primitive_end ();
}