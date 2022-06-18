RopeHandleThrowing ();

if (thrown) {
	RopeMoveThrownRope ();
	RopeThrownCheckAndKill ();
	RopeDynamicMovement ();
} else {
	RopeEndsToPlayers ();
	RopeDynamicMovement ();
	RopeRubberEffectBetweenPlayers ()
	RopeCircleCheckAndKill ();
}



