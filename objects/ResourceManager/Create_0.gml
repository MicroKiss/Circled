if (instance_number (ResourceManager) != 1)
	throw ("Too many ResourceManagers");

randomise ();
global.width = 1920;
global.height = 1080;
scale = min (1, display_get_height () / global.height);

window_set_size (global.width * scale, global.height * scale);
surface_resize (application_surface, global.width * scale, global.height * scale);
window_set_position (display_get_width () / 2 - (global.width * scale) / 2, display_get_height () / 2 - (global.height*scale) / 2);

display_set_gui_size (global.width*scale, global.height*scale);

global.player1Skin = playerSkin1;
global.player2Skin = playerSkin2;
paused = false;
screenShot = -1;

global.DEBUG = true;

var saveFileName = "highscore.dat";
global.saveFilePath = working_directory + saveFileName;

global.highScore = ReadHighScore ();