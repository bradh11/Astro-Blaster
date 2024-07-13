/// Step Event of obj_title_screen

if (global.input_context != "dialogue") {
    var key_up = keyboard_check_pressed(vk_up);
    var key_down = keyboard_check_pressed(vk_down);
    var key_select = keyboard_check_pressed(vk_space);
    var key_back = keyboard_check_pressed(vk_escape);

    switch (menu_state) {
        case MENU_STATE.MAIN:
            if (key_up) {
                selected_option = (selected_option - 1 + array_length(menu_options)) % array_length(menu_options);
            } else if (key_down) {
                selected_option = (selected_option + 1) % array_length(menu_options);
            }

            if (key_select) {
                switch (selected_option) {
                    case 0: // Start Game
                        audio_stop_sound(snd_intro_music);
                        show_debug_message("Initializing first level...");
                        global.current_level = 0;
                        show_debug_message("First level initialized");
                        scr_next_level();
                        break;
                    case 1: // Select Player
                        menu_state = MENU_STATE.PLAYER_SELECT;
                        selected_option = selected_player;
                        break;
                }
            }
            break;

        case MENU_STATE.PLAYER_SELECT:
            if (key_up) {
                selected_option = (selected_option - 1 + array_length(player_options)) % array_length(player_options);
            } else if (key_down) {
                selected_option = (selected_option + 1) % array_length(player_options);
            }

            if (key_select) {
                selected_player = selected_option;
                global.selected_player_object = (selected_player == 0) ? obj_rocket : obj_rocket_2;
                global.selected_player_scale = player_scales[selected_player];
                menu_state = MENU_STATE.MAIN;
                selected_option = 0;
            } else if (key_back) {
                menu_state = MENU_STATE.MAIN;
                selected_option = 1; // Return to "Select Player" option
            }
            break;
    }
}