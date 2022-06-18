

function GetNextPlayerSkin(player)
{
	var skinCount = array_length (playerSkins);
	playerSkin = player.sprite_index;
	var i = 0;
	for (; i < skinCount; ++i) {
		if (playerSkins[i] == playerSkin)
			break;
	}
	var nextSkinIndex = (i + 1) % skinCount;
	if (playerSkins[nextSkinIndex] == Player1.sprite_index 
	||  playerSkins[nextSkinIndex] == Player2.sprite_index) 
		nextSkinIndex = (nextSkinIndex + 1) % skinCount;
	player.sprite_index = playerSkins[nextSkinIndex];
}