/// Draw Event of obj_title_screen

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fnt_title);
draw_set_color(c_white);

// Draw title
draw_text(room_width / 2, room_height / 3, "Astro Battle");

// Move menu items lower
var start_y = room_height * 3/4;  // Start at 3/4 of the screen height
var spacing = 60;  // Increased spacing to accommodate images

switch (menu_state) {
    case MENU_STATE.MAIN:
        for (var i = 0; i < array_length(menu_options); i++) {
            draw_set_color(selected_option == i ? c_yellow : c_white);
            draw_text(room_width / 2, start_y + i * spacing, menu_options[i]);
        }
        break;

    case MENU_STATE.PLAYER_SELECT:
        draw_text(room_width / 2, start_y - spacing, "Select Player");
        for (var i = 0; i < array_length(player_options); i++) {
            draw_set_color(selected_option == i ? c_yellow : c_white);
            
            // Draw rocket image with correct scale
            var rocket_sprite = (i == 0) ? spr_rocket : spr_rocket_2;
            var image_scale = player_scales[i] * 2;  // Adjusted multiplier for better visibility
            var image_y = start_y + i * spacing;
            draw_sprite_ext(rocket_sprite, 0, room_width/2 - 100, image_y, image_scale, image_scale, 0, c_white, 1);
            
            // Draw text next to the image
            draw_text(room_width/2 + 50, image_y, player_options[i]);
        }
        break;
}

// Draw instruction text at the bottom
draw_set_font(fnt_hud); // Switch to a smaller font for instructions
draw_set_color(c_white);
draw_text(room_width / 2, room_height - 30, "Use arrow keys to navigate, SPACE to select, ESC to go back");

// Reset drawing settings
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);