RopeHandleStateChanges ();

if (state == states.thrown) {
	RopeMoveThrownRope ();
	RopeThrownCheckAndKill ();
	RopeDynamicMovement ();
} else if (state = states.carried) {
	RopeEndsToPlayers ();
	RopeDynamicMovement ();
	RopeRubberEffectBetweenPlayers ()
	RopeCircleCheckAndKill ();
} else if (state = states.laying) {
	
} else if (state = states.dragged) {
	RopeEndToDraggingPlayer ()
	RopeDynamicMovement ();
}



