/// obj_hud Draw GUI Event

// Set font (make sure this font exists in your project)
draw_set_font(fnt_hud);

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
var score_x = display_get_gui_width() - 210;
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
var weapon_x = display_get_gui_width() / 2 - 100;
var weapon_y = 10;
var weapon_width = 200;
var weapon_height = 32;

// Background for the weapon
draw_set_color(c_black);
draw_rectangle(weapon_x, weapon_y, weapon_x + weapon_width, weapon_y + weapon_height, false);

// Get the current weapon data from the player object
if (instance_exists(obj_rocket)) {
    var current_weapon_type = obj_rocket.current_weapon_type;
    
    if (current_weapon_type != undefined) {
        var weapon_name = current_weapon_type.name;
        var weapon_sprite = current_weapon_type.weapon_sprite;
        
        // Draw the weapon sprite
        var sprite_x = weapon_x + 5;
        var sprite_y = weapon_y + weapon_height / 2;
        if (sprite_exists(weapon_sprite)) {
            var scale = min(1.5, (weapon_height - 4) / sprite_get_height(weapon_sprite));
            draw_sprite_ext(weapon_sprite, 0, sprite_x, sprite_y, scale, scale, 0, c_white, 1);
            
            // Debug: Print sprite info
            show_debug_message("Drawing weapon sprite: " + sprite_get_name(weapon_sprite) + 
                               " at (" + string(sprite_x) + ", " + string(sprite_y) + 
                               ") with scale " + string(scale));
        } else {
            show_debug_message("Weapon sprite does not exist for " + weapon_name);
            draw_text(sprite_x, sprite_y, "No Sprite");
        }
        
        // Draw the weapon name
        draw_set_color(c_white);
        draw_set_valign(fa_middle);
        draw_text(sprite_x + 40, sprite_y, string_upper(weapon_name));
        draw_set_valign(fa_top);  // Reset vertical alignment
    } else {
        // Draw unknown weapon text if weapon data is not found
        draw_set_color(c_white);
        draw_text(weapon_x + 10, weapon_y + 8, "Unknown Weapon");
    }
} else {
    // Draw message if player object doesn't exist
    draw_set_color(c_white);
    draw_text(weapon_x + 10, weapon_y + 8, "Player Not Found");
}

// Reset draw settings
draw_set_color(c_white);
draw_set_font(-1);