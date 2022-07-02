function SaveHighScore (num) {
	if (num > global.highScore)	{
		global.highScore = num
		file = file_text_open_write (global.saveFilePath);
		file_text_write_real (file, global.highScore);
		file_text_close(file);
	}
}

function ReadHighScore () {
	show_debug_message(global.saveFilePath)
	file = file_text_open_read(global.saveFilePath);
	var readScore = 0;
	if (file != -1) {
		readScore = file_text_read_real(file);
		file_text_close(file);
	}
	return readScore;
}