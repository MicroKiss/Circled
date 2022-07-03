global.roomTarget = -1;
global.midTransition = false;

//Called whenever you want to go from one room to another, using any combination of in/out sequences
function TransitionStart(_roomTarget, _typeOut)
{
	if (!global.midTransition)
	{
		audio_play_sound (transitionSound, 1, 0);
		global.midTransition = true;
		global.roomTarget = _roomTarget;
		TransitionPlaceSequence(_typeOut);
		return true;
	}
	else return false
}

//Places the sequences in the room
function TransitionPlaceSequence(_type)
{
	if (layer_exists("transition")) layer_destroy("transition")
	var _lay = layer_create(-1,"transition")
	if (instance_number (Camera) == 1)  
		return layer_sequence_create(_lay,Camera.x ,Camera.y ,_type);	
	else 
		return layer_sequence_create(_lay,global.width /2 ,global.height /2 ,_type);	

}

//Called as a moment at the end of an "Out" transition sequence
function TransitionChangeRoom()
{
	room_goto(global.roomTarget);
}

//Called as a moment at the end of an "In" transition sequence
function TransitionFinished()
{
	layer_sequence_destroy(self.elementID);
	global.midTransition = false;
}