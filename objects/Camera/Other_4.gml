if (instance_number (Camera) != 1)
	throw ("Too many Cameras");

view_enabled = true;
view_visible[0] = true;

camera = camera_create ();
x = global.width / 2;
y = global.height / 2;
var vm = matrix_build_lookat (x,y,-10,
							  x,y,0,
							  0,1,0);
							  
var pm = matrix_build_projection_ortho (1920, 1080, 1, 1000);

camera_set_view_mat (camera, vm);
camera_set_proj_mat (camera, pm);
view_camera[0] = camera;


trans = TransitionPlaceSequence (inTransition1);