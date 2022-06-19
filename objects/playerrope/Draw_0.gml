if (global.DEBUG)
	RopeDrawHitMarker ();
if (state == states.thrown) {
	draw_set_color(c_green);
	draw_circle (vertexArray[0][0], vertexArray[0][1], 10, false);
	draw_set_color(c_blue);
	draw_circle (vertexArray[vertexCount - 1][0], vertexArray[vertexCount - 1][1], 10, false);
	draw_set_color(c_white);
} else {
}
RopeDrawRope ();
RopeDrawHistory ();