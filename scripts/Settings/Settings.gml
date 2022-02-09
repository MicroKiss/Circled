function GetNextPlayerSkin(playerSkin)
{
	if (playerSkin == playerSkin1)
		return playerSkin2;
	if (playerSkin == playerSkin2)
		return playerSkin3;
	if (playerSkin == playerSkin3)
		return playerSkin4;
	if (playerSkin == playerSkin4)
		return playerSkin5;
	if (playerSkin == playerSkin5)
		return playerSkin1;
}