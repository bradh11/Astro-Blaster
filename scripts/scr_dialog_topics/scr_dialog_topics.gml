global.topics = {};

global.topics[$ "Level1"] = [
	SPEAKER("Commander", spr_commander, PORTRAIT_SIDE.LEFT),
	TEXT("{{ Radio crackle }}"),
	TEXT("Hello soldier, I have a new mission for you!"),
	TEXT("There is a serious threat to Earth, and you are the only one equipped to save us. You're starfighter is the last one left that can handle this mission."),
	SPEAKER("Captain", spr_captain, PORTRAIT_SIDE.LEFT),
	TEXT("Aye Commander! I'm ready...  Just tell me what i need to do!"),
	SPEAKER("Commander", spr_commander, PORTRAIT_SIDE.LEFT),
	TEXT("You must take out Nebulark - the most cunning villian in the galaxy. He is planning to destroy Earth."),
	SPEAKER("Captain", spr_captain, PORTRAIT_SIDE.LEFT),
	TEXT("Let's do this... Nebulark - Here I come!"),
];

global.topics[$ "Level2"] = [
	SPEAKER("Commander", spr_commander, PORTRAIT_SIDE.LEFT),
	TEXT("{{ Radio crackle }}"),
	TEXT("Great work Captain!"),
	TEXT("We've just learned that Nebulark's minions are dropping weapons all over the place."),
	SPEAKER("Nebular Minions", spr_alien_med, PORTRAIT_SIDE.LEFT),
	SPEAKER("Shotgun PowerUp", spr_wpn_shotgun_powerup, PORTRAIT_SIDE.RIGHT),
	TEXT("Look for the powerups that they've dropped and pick `em up. We have added nanobots to the outer skin of your ship and they can lock on the new weapons for you to use."),
	TEXT("Now go get em and kick some alien butt!"),
	SPEAKER("Captain", spr_captain, PORTRAIT_SIDE.LEFT),
	TEXT("Will do Commander!"),

];

global.topics[$ "Level5"] = [
	SPEAKER("Captain", spr_captain, PORTRAIT_SIDE.LEFT),
	TEXT("Whoah!!! What was that???"),
	SPEAKER("Commander", spr_commander, PORTRAIT_SIDE.LEFT),
	TEXT("Oh boy.  I didnt expect we would see them so early - That was one of Nebulark's bomber ships."),
	SPEAKER("Nebulark's Bomber", spr_alien_lg, PORTRAIT_SIDE.RIGHT),
	TEXT("They can take a lot of damage before they are destroyed. }}"),
	SPEAKER("Soundwave", spr_wpn_soundwave_powerup, PORTRAIT_SIDE.RIGHT),
	TEXT("We are going to need a more powerful weapon - keep an eye out for the Soundwave powerup... "),
	

];

// Additional levels here...



// Victory Level
global.topics[$ "Victory"] = [
	SPEAKER("Captain", spr_captain, PORTRAIT_SIDE.LEFT),
	TEXT("That was close! Commander, are you there??!!"),
	TEXT("Commander! I've defeated Nebulark, are you there???!"),
	TEXT("Commander!!!!!!!!!???"),
	SPEAKER("Nebulark", spr_nebulark, PORTRAIT_SIDE.LEFT),
	TEXT("There is no Commander, only Nebulark."),
	TEXT("Muhahhhaaaahhhhhahahaha...   Muhaaahhhwhhhaaaahahahhhhhha...."),
	

];