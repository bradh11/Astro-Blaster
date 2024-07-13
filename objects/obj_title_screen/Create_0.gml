/// @description Title Screen create event
depth = 0; // Set to a higher value to ensure it is created after obj_global_controller


// Play intro audio
audio_play_sound(snd_intro_music, 1, true); // Set loop to true if you want it to loop

/// Create Event of obj_title_screen

enum MENU_STATE {
    MAIN,
    PLAYER_SELECT
}

menu_state = MENU_STATE.MAIN;
menu_options = ["Start Game", "Select Player"];
selected_option = 0;

player_options = ["Rocket 1", "Rocket 2"];
player_scales = [1, 0.2];  // Corresponding scales for each player object
selected_player = 0;

// Initialize the selected player object and scale
global.selected_player_object = obj_rocket;
global.selected_player_scale = 1;