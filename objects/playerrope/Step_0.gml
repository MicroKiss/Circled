RopeHandleStateChanges ();

if (state == "thrown") {
	RopeMoveThrownRope ();
	RopeThrownCheckAndKill ();
	RopeDynamicMovement ();
} else {
	RopeEndsToPlayers ();
	RopeDynamicMovement ();
	RopeRubberEffectBetweenPlayers ()
	RopeCircleCheckAndKill ();
}



