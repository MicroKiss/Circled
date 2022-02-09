hp = (Player1.attributes.currHealth + Player2.attributes.currHealth) / (Player1.attributes.maxHealth + Player2.attributes.maxHealth);
hp = clamp(hp, 0, 1);

if (hp == 0)
	TransitionStart(room,outTransition1);