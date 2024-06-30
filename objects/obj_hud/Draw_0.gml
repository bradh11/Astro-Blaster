/// @description Draw event for HUD

// Draw the lives banner at the top left of the room
var banner_x = 10;
var banner_y = 10;
var banner_width = 200;
var banner_height = 32;

// Background for the banner
draw_set_color(c_black);
draw_rectangle(banner_x, banner_y, banner_x + banner_width, banner_y + banner_height, false);

// Draw the lives text
draw_set_color(c_white);
draw_text(banner_x + 10, banner_y + 8, "Lives: " + string(global.lives));

// Draw the score at the top right of the room
var score_x = room_width - 210;
var score_y = 10;
var score_width = 200;
var score_height = 32;

// Background for the score
draw_set_color(c_black);
draw_rectangle(score_x, score_y, score_x + score_width, score_y + score_height, false);

// Draw the score text
draw_set_color(c_white);
draw_text(score_x + 10, score_y + 8, "Score: " + string(global.score));

// Draw the current weapon at the top center of the room
var weapon_x = room_width / 2 - 100;
var weapon_y = 10;
var weapon_width = 200;
var weapon_height = 32;

// Background for the weapon
draw_set_color(c_black);
draw_rectangle(weapon_x, weapon_y, weapon_x + weapon_width, weapon_y + weapon_height, false);

// Ensure WEAPON_TYPE and current_weapon_type are defined and accessible
if (variable_global_exists("WEAPON_TYPE") && variable_global_exists("current_weapon_type")) {
    // Get the name and sprite of the current weapon
    var weapon_name = "";
    var weapon_sprite = -1;
    
    var current_weapon_data = global.weapon_database[global.current_weapon_type];
    if (current_weapon_data != undefined) {
        weapon_name = string_replace(global.current_weapon_type, "_", " ");
        weapon_sprite = current_weapon_data.weapon_sprite;
    } else {
        weapon_name = "Unknown";
    }

    // Draw the weapon sprite
    var sprite_x = weapon_x + 10;
    var sprite_y = weapon_y + 16;
    if (weapon_sprite != -1) {
        var scale = 2; // Scale factor for zooming in
        draw_sprite_ext(weapon_sprite, 0, sprite_x, sprite_y, scale, scale, 0, c_white, 1);
    }

    // Draw the weapon name
    draw_set_color(c_white);
    draw_text(sprite_x + 40, sprite_y - 8, string_upper(weapon_name));
}
