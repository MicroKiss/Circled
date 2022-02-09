other.attributes.currHealth -= damage;

if	(other.object_index == Player1) {
	GameUI.player1Hits++;
} else if (other.object_index == Player2) {
	GameUI.player2Hits++;
}
instance_destroy();