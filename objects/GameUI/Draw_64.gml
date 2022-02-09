hp = (Player1.attributes.currHealth + Player2.attributes.currHealth) / (Player1.attributes.maxHealth + Player2.attributes.maxHealth);
hp = clamp(hp, 0, 1);
draw_sprite(hpBar,0,hpBarStartX,hpBarStartY)
draw_sprite_stretched(hpBarFiller,0,hpBarStartX,hpBarStartY,hp*hpBarWidth,hpBarHeight);
draw_sprite(hpBar,1,hpBarStartX,hpBarStartY)

draw_set_font(UIFont);
draw_text(hpBarStartX-100,hpBarStartY,"Player 1 hits: " + string(player1Hits));
draw_text(hpBarStartX+hpBarWidth + 10,hpBarStartY,"Player 2 hits: " + string(player2Hits));