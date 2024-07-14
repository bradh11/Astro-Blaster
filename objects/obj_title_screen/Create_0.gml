/// Create Event of obj_title_screen

enum MENU_STATE {
    MAIN,
    PLAYER_SELECT
}

menu_state = MENU_STATE.MAIN;
menu_options = ["Start Game", "Select Player", "Quit Game"];
selected_option = 0;

player_options = ["Rocket 1", "Rocket 2"];
player_scales = [1, 0.2];
selected_player = 0;

global.selected_player_object = obj_rocket;
global.selected_player_scale = 1;

if (!audio_is_playing(snd_intro_music)) {
    audio_play_sound(snd_intro_music, 10, true);
}