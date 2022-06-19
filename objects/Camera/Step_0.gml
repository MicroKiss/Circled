var xToFollow = global.width / 2;
var yToFollow = global.height / 2;
if (instance_number (Player) == 2) {
	xToFollow = (Player1.x + Player2.x) / 2;
	yToFollow = (Player1.y + Player2.y) / 2;
}

x += (xToFollow - x) /10;
y += (yToFollow - y) /10;

var vm = matrix_build_lookat (x, y, -10,
							  x, y, 0,
							  0, 1, 0);
							  
//var pm = matrix_build_projection_ortho(1920,1080,1,1000);

camera_set_view_mat (camera, vm);
//camera_set_proj_mat (camera,pm);
view_camera[0] = camera;


if (layer_sequence_exists ("transition", trans)) {
	layer_sequence_x (trans, x);
	layer_sequence_y (trans, y);
}