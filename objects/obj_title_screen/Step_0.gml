/// @description Title Screen step event

// Check if the spacebar is pressed to start the game
if (keyboard_check_pressed(vk_space)) {
    // Stop the intro music before transitioning to the next room
    audio_stop_sound(snd_intro_music);

    // Initialize the first level
    show_debug_message("Initializing first level...");
    global.current_level = 0; // Ensure current level is set to 0
    scr_init_level(); // Call the function to initialize the first level
    show_debug_message("First level initialized");

    // Go to the first level
    scr_next_level()
	
    show_debug_message("Transitioning to rm_level1");
}

// Check if 'ESC' key is pressed
if (keyboard_check_pressed(vk_escape)) {
    game_end(); // Exit the game
}
