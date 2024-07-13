/// @description Game settings script

function initialize_globals() {
    // Check if globals have been initialized
    if (!variable_global_exists("globals_initialized") || !global.globals_initialized) {
        show_debug_message("Initializing global variables...");

		global.current_player = noone;

        // Initialize global variables
        global.lives = 3;
        global.score = 0;
		global.input_context = "game";

        // Initialize the Weapon System
        show_debug_message("Calling scr_weapon_system...");
        init_weapon_system(); // Initialize the weapon database
        show_debug_message("scr_weapon_system called successfully");

        // Define levels
        show_debug_message("Calling scr_define_levels...");
        scr_define_levels();
        show_debug_message("Levels defined");

        // Set current level
        global.current_level = 0;
        show_debug_message("Current level set to: " + string(global.current_level));

        // Mark globals as initialized
        global.globals_initialized = true;

        show_debug_message("Initialization complete.");
    }
}

// Allow screen wrap for objects
function screen_wrap(obj) {
    if (obj.x > room_width) {
        obj.x = 0;
    } else if (obj.x < 0) {
        obj.x = room_width;
    }

    if (obj.y > room_height) {
        obj.y = 0;
    } else if (obj.y < 0) {
        obj.y = room_height;
    }
}

function set_current_player(player_object) {
	global.current_player = player_object;
}

function get_current_player() {
	return global.current_player;
}
		
function check_global_keys() {
    // Check if 'R' key is pressed
    if (keyboard_check_pressed(ord("R"))) {
        game_restart(); // Restart the current room
		
		// Call the initialize_globals function from scr_game_settings
		initialize_globals();
    }

    // Check if 'ESC' key is pressed
    if (keyboard_check_pressed(vk_escape)) {
        game_end(); // Exit the game
    }
}

function array_contains(array, value) {
    for (var i = 0; i < array_length(array); i++) {
        if (array[i] == value) {
            return true;
        }
    }
    return false;
}
