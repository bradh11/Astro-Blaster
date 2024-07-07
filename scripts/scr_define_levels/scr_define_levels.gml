// Declare the levels globally
global.levels = undefined;
global.current_level = undefined;

// Define the scr_define_levels function
function scr_define_levels() {
    // Ensure these rooms exist in your project and are defined in the Room Editor
    // Do not redefine the room variables; instead, just reference them directly

    // Define level structures
	var level0 = {
        room: rm_title, // Reference the room directly
        enemies: [
            {type: obj_asteroid_med, count: 0, hp: 10},
            {type: obj_alien_med, count: 0, hp: 15}
        ],
        powerups: [],
		dialogue: undefined
    };
	
    var level1 = {
        room: rm_level1, // Reference the room directly
        enemies: [
            {type: obj_asteroid_med, count: 2, hp: 10},
            {type: obj_alien_med, count: 0, hp: 15}
        ],
        powerups: [],
		dialogue: "Level1"
    };

    var level2 = {
        room: rm_level2, // Reference the room directly
        enemies: [
            {type: obj_asteroid_med, count: 3, hp: 20},
            {type: obj_alien_med, count: 1, hp: 25},
			{type: obj_asteroid_sm, count: 1, hp: 20}
        ],
        powerups: [global.WEAPON_TYPE.SHOTGUN],
		dialogue: "Level2"
    };
	
    var level3 = {
        room: rm_level3, // Reference the room directly
        enemies: [
            {type: obj_asteroid_med, count: 5, hp: 30},
			{type: obj_asteroid_sm, count: 2, hp: 20},
            {type: obj_alien_med, count: 1, hp: 35},
			{type: obj_alien_lg, count: 1, hp: 250},
        ],
        powerups: [global.WEAPON_TYPE.LASER, global.WEAPON_TYPE.SHOTGUN],
		dialogue: undefined
    };
	
	var level4 = {
        room: rm_level4, // Reference the room directly
        enemies: [
            {type: obj_asteroid_med, count: 7, hp: 35},
			{type: obj_asteroid_sm, count: 2, hp: 20},
            {type: obj_alien_med, count: 2, hp: 40},
			{type: obj_alien_lg, count: 1, hp: 250},
        ],
        powerups: [global.WEAPON_TYPE.LASER, global.WEAPON_TYPE.SHOTGUN],
		dialogue: undefined
    };

	var level5 = {
        room: rm_level5, // Reference the room directly
        enemies: [
            {type: obj_asteroid_med, count: 12, hp: 35},
            {type: obj_alien_med, count: 2, hp: 50}
        ],
        powerups: [global.WEAPON_TYPE.LASER, global.WEAPON_TYPE.SHOTGUN],
		dialogue: undefined
    };

	var level6 = {
        room: rm_level6, // Reference the room directly
        enemies: [
            {type: obj_asteroid_med, count: 11, hp: 40},
			{type: obj_asteroid_sm, count: 5, hp: 35},
            {type: obj_alien_med, count: 3, hp: 50}
        ],
        powerups: [global.WEAPON_TYPE.LASER, global.WEAPON_TYPE.SHOTGUN],
		dialogue: undefined
    };

	var level7 = {
        room: rm_level7, // Reference the room directly
        enemies: [
            {type: obj_asteroid_med, count: 3, hp: 40},
			{type: obj_asteroid_sm, count: 3, hp: 40},
            {type: obj_alien_med, count: 3, hp: 50},
			{type: obj_alien_lg, count: 2, hp: 250},
        ],
        powerups: [global.WEAPON_TYPE.LASER, global.WEAPON_TYPE.SHOTGUN],
		dialogue: undefined
    };
	
	//Victory Level (should be last)
	var levelvictory = {
        room: rm_victory, // Reference the room directly
        enemies: [
            {type: obj_asteroid_med, count: 0, hp: 30},
            {type: obj_alien_med, count: 0, hp: 35}
        ],
        powerups: [],
		dialogue: "Victory"
    };
	
    // List the rooms and the order to play them.
    global.levels = [
		level0, 
		level1, 
		level2, 
		level3, 
		level4, 
		level5, 
		level6, 
		level7,
		levelvictory
		];

    global.current_level = 0;
    global.score = 0; // Initialize score
}
