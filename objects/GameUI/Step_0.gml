hp = (Player1.currHP + Player2.currHP) / (Player1.maxHP + Player2.maxHP);
hp = clamp(hp, 0, 1);

if (hp == 0)
	TransitionStart (menu, outTransition1);