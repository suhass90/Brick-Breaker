--------------sound table contains different sounds played across different levels of the game--------------
local soundTable = {
	
	hitSound = audio.loadSound( "hit.wav" ),--Sound when ball hits the bricks
	explodeSound = audio.loadSound( "explode.wav" ),--Sound when ball hits the bricks
	loselife = audio.loadSound( "result.wav" ),--Sound whwn ball goes of the screen(lose life)
	bgscore= audio.loadStream( "Arcade-Fantasy.wav" ),--Background music for level 1
	heartbreak=audio.loadStream( "heartbreak.wav" ),--Sound when ball hits the heart for the first time in level 2
	sadSound=audio.loadStream( "Sad Sound1.wav" ),--Sound when ball hits the smiley for the first time in level 3
	crySound=audio.loadStream( "Baby Crying1.wav" ),--Sound when ball hits the smiley for the second time in level 3
	level2bg=audio.loadStream( "8-Bit-Mayhem.mp3" ),--Background music for level 2
	level3bg=audio.loadStream( "Monkey-Drama.mp3" )--Background music for level 3
}
return soundTable;
