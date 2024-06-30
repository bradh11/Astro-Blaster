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
            {type: obj_enemy1, count: 0, hp: 10},
            {type: obj_enemy2, count: 0, hp: 15}
        ],
        powerups: []
    };
	
	
    var level1 = {
        room: rm_level1, // Reference the room directly
        enemies: [
            {type: obj_enemy1, count: 5, hp: 10},
            {type: obj_enemy2, count: 3, hp: 15}
        ],
        powerups: [global.WEAPON_TYPE.SHOTGUN]
    };

    var level2 = {
        room: rm_level2, // Reference the room directly
        enemies: [
            {type: obj_enemy1, count: 10, hp: 20},
            {type: obj_enemy2, count: 5, hp: 25}
        ],
        powerups: [global.WEAPON_TYPE.LASER]
    };

    // Add more levels as needed
    global.levels = [level0, level1, level2];

    global.current_level = 0;
    global.score = 0; // Initialize score
}
