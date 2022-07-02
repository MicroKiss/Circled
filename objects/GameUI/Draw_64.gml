draw_sprite (hpBar, 0, hpBarStartX, hpBarStartY)
draw_sprite_stretched (hpBarFiller, 0, hpBarStartX, hpBarStartY, hp*hpBarWidth, hpBarHeight);
draw_sprite (hpBar, 1, hpBarStartX, hpBarStartY)



draw_set_font (UIFont);
draw_text (10, hpBarStartY-50, "Player 1 hits: " + string (player1Hits));
draw_text (10, hpBarStartY, "Player 2 hits: " + string (player2Hits));
draw_text (10, hpBarStartY-100, "Killed Enemies: " + string (killedEnemies));