/// @description Transition to the next level
function scr_next_level() {
    // Check if global.current_level is initialized
    if (!variable_global_exists("current_level")) {
        global.current_level = 0;
        show_debug_message("Warning: global.current_level was not initialized. Setting to 0.");
    }
	show_debug_message("Transitioning from: " + string(global.current_level));

    // Increment the current level
    global.current_level++;
	target_level = global.current_level;
	
    show_debug_message("Incrementing level to: " + string(target_level));

    // Check if there are more levels
    if (global.current_level < array_length(global.levels)) {
        // Play level transition sound
        audio_play_sound(snd_level_transition, 1, false);

        // Get the next level configuration
        var next_level_config = global.levels[global.current_level];
        show_debug_message("Next level config: " + string(next_level_config));

        // Go to the next level's room
        if (room_exists(next_level_config.room)) {
            show_debug_message("Transitioning to room: " + string(next_level_config.room));
            
			TransitionStart(target_level, seq_fade_out, seq_fade_in, next_level_config.dialogue);
			
			
        } else {
            show_debug_message("Error: The room does not exist.");
        }
    } else {
        // No more levels, go to game over or victory screen
        show_debug_message("No more levels. Going to victory screen.");
        room_goto(rm_victory);
    }
}