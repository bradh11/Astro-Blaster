/// obj_hud Draw GUI Event
// Get the viewport dimensions
var gui_width = display_get_gui_width();
var gui_height = display_get_gui_height();

// Get the camera dimensions
var camera_width = camera_get_view_width(view_camera[0]);
var camera_height = camera_get_view_height(view_camera[0]);

// Calculate scaling factors
var scale_x = gui_width / camera_width;
var scale_y = gui_height / camera_height;

// Set font (make sure this font exists in your project)
draw_set_font(fnt_hud);

// Set alpha for semi-transparency
var hud_alpha = 0.2;  // Increased transparency

// Define common HUD dimensions
var hud_height = 30 * scale_y;  // Fixed height
var hud_y = 10 * scale_y;  // Fixed y position

// Draw the lives banner at the top left of the room
var banner_x = 10 * scale_x;
var banner_width = 150 * scale_x;  // Reduced width

// Background for the banner
draw_set_color(c_black);
draw_set_alpha(hud_alpha);
draw_rectangle(banner_x, hud_y, banner_x + banner_width, hud_y + hud_height, false);

// Draw the lives text
draw_set_color(c_white);
draw_set_alpha(1);  // Full opacity for text
draw_text(banner_x + 10 * scale_x, hud_y + (hud_height / 2) - (string_height("Lives: " + string(global.lives)) / 2), "Lives: " + string(global.lives));

// Draw the score at the top right of the room
var score_x = gui_width - (160 * scale_x);  // Adjust position for smaller width
var score_width = 150 * scale_x;  // Reduced width

// Background for the score
draw_set_color(c_black);
draw_set_alpha(hud_alpha);
draw_rectangle(score_x, hud_y, score_x + score_width, hud_y + hud_height, false);

// Draw the score text
draw_set_color(c_white);
draw_set_alpha(1);  // Full opacity for text
draw_text(score_x + 10 * scale_x, hud_y + (hud_height / 2) - (string_height("Score: " + string(global.score)) / 2), "Score: " + string(global.score));

// Draw the weapon info in the top middle only if obj_rocket exists
if (instance_exists(obj_rocket)) {
    // Get the current weapon data from the player object
    var current_weapon_type = obj_rocket.current_weapon_type;
    var weapon_name = current_weapon_type.name;
    var weapon_sprite = current_weapon_type.weapon_sprite;
    
    // Weapon sprite scaling factor
    var weapon_scale = 1.5 * scale_x; // Adjust this value to make the sprite larger or smaller
    
    // Calculate dimensions
    var weapon_sprite_width = sprite_get_width(weapon_sprite) * weapon_scale;
    var weapon_sprite_height = sprite_get_height(weapon_sprite) * weapon_scale;
    var name_width = string_width(string_upper(weapon_name));
    
    // Calculate weapon info rectangle dimensions
    var weapon_width = weapon_sprite_width + name_width + 20 * scale_x; // Reduced padding to bring sprite and name closer
    var center_x = gui_width / 2;
    var shift_left = 40 * scale_x; // Adjust this value to shift more or less to the left
    var weapon_x = center_x - weapon_width / 2 - shift_left;
    
    // Background for the weapon info
    draw_set_color(c_black);
    draw_set_alpha(hud_alpha);
    draw_rectangle(weapon_x, hud_y, weapon_x + weapon_width, hud_y + hud_height, false);
    
    // Draw the weapon sprite
    var sprite_x = weapon_x + 10 * scale_x + weapon_sprite_width / 2;
    var sprite_y = hud_y + hud_height / 2;
    draw_set_alpha(1);  // Full opacity for sprite
    draw_sprite_ext(weapon_sprite, 0, sprite_x, sprite_y, weapon_scale, weapon_scale, 0, c_white, 1);
    
    // Draw the weapon name
    draw_set_color(c_white);
    draw_set_alpha(1);  // Full opacity for text
    draw_set_valign(fa_middle);
    var text_x = sprite_x + weapon_sprite_width / 2 - 35 * scale_x; // Reduced padding to bring sprite and name closer
    var text_y = hud_y + hud_height / 2;
    draw_text(text_x, text_y, string_upper(weapon_name));
    draw_set_valign(fa_top); // Reset vertical alignment
}

// Reset draw settings
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_font(-1);