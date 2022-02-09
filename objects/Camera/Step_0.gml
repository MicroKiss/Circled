if (instance_number(Player) < 2)
	return;

var xToFollow = (Player1.x + Player2.x)/2;
var yToFollow = (Player1.y + Player2.y)/2;

x += (xToFollow -x) /10;
y += (yToFollow -y) /10;

var vm = matrix_build_lookat (x,y,-10,
							  x,y,0,
							  0,1,0);
							  
//var pm = matrix_build_projection_ortho(1920,1080,1,1000);

camera_set_view_mat (camera,vm);
//camera_set_proj_mat (camera,pm);
view_camera[0] = camera;