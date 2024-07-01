/// obj_hud Draw GUI Event
// Set font (make sure this font exists in your project)
draw_set_font(fnt_hud);

// Set alpha for semi-transparency
var hud_alpha = 0.5;  // Increased transparency

// Define common HUD dimensions
var hud_height = 32;
var hud_y = 10;

// Draw the lives banner at the top left of the room
var banner_x = 10;
var banner_width = 200;

// Background for the banner
draw_set_color(c_black);
draw_set_alpha(hud_alpha);
draw_rectangle(banner_x, hud_y, banner_x + banner_width, hud_y + hud_height, false);

// Draw the lives text
draw_set_color(c_white);
draw_set_alpha(1);  // Full opacity for text
draw_text(banner_x + 10, hud_y + 8, "Lives: " + string(global.lives));

// Draw the score at the top right of the room
var score_x = display_get_gui_width() - 210;
var score_width = 200;

// Background for the score
draw_set_color(c_black);
draw_set_alpha(hud_alpha);
draw_rectangle(score_x, hud_y, score_x + score_width, hud_y + hud_height, false);

// Draw the score text
draw_set_color(c_white);
draw_set_alpha(1);  // Full opacity for text
draw_text(score_x + 10, hud_y + 8, "Score: " + string(global.score));

// Draw the weapon info in the top middle only if obj_rocket exists
if (instance_exists(obj_rocket)) {
    // Get the current weapon data from the player object
    var current_weapon_type = obj_rocket.current_weapon_type;
    var weapon_name = current_weapon_type.name;
    var weapon_sprite = current_weapon_type.weapon_sprite;
    
    // Weapon sprite scaling factor
    var weapon_scale = 2; // Adjust this value to make the sprite larger or smaller
    
    // Calculate dimensions
    var weapon_sprite_width = sprite_get_width(weapon_sprite) * weapon_scale;
    var weapon_sprite_height = sprite_get_height(weapon_sprite) * weapon_scale;
    var name_width = string_width(string_upper(weapon_name));
    
    // Calculate weapon info rectangle dimensions
    var weapon_width = weapon_sprite_width + name_width + 30; // 10px padding on each side, 10px between sprite and name
    var weapon_x = display_get_gui_width() / 2 - weapon_width / 2; // Center the weapon info
    
    // Background for the weapon info
    draw_set_color(c_black);
    draw_set_alpha(hud_alpha);
    draw_rectangle(weapon_x, hud_y, weapon_x + weapon_width, hud_y + hud_height, false);
    
    // Draw the weapon sprite
    var sprite_x = weapon_x + 10 + weapon_sprite_width / 2;
    var sprite_y = hud_y + hud_height / 2;
    draw_set_alpha(1);  // Full opacity for sprite
    draw_sprite_ext(weapon_sprite, 0, sprite_x, sprite_y, weapon_scale, weapon_scale, 0, c_white, 1);
    
    // Debug: Draw a colored rectangle where the sprite should be
    draw_set_alpha(0.5);  // Semi-transparent for debug rectangle
    draw_rectangle_color(sprite_x - weapon_sprite_width/2, sprite_y - weapon_sprite_height/2, 
                         sprite_x + weapon_sprite_width/2, sprite_y + weapon_sprite_height/2, 
                         c_red, c_red, c_red, c_red, true);
    
    // Draw the weapon name
    draw_set_color(c_white);
    draw_set_alpha(1);  // Full opacity for text
    draw_set_valign(fa_middle);
    var text_x = sprite_x + weapon_sprite_width/2 + 10;
    var text_y = hud_y + hud_height / 2;
    draw_text(text_x, text_y, string_upper(weapon_name));
    draw_set_valign(fa_top); // Reset vertical alignment
    
    // Debug: Print weapon sprite info
    show_debug_message("Weapon Sprite: " + string(weapon_sprite) + ", Width: " + string(weapon_sprite_width) + ", Height: " + string(weapon_sprite_height));
}

// Reset draw settings
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_font(-1);