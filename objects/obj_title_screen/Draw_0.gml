/// @description Title Screen draw event

// Draw the "Press Spacebar to Start" text
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fnt_title); // Assuming you have a font called fnt_title
draw_set_color(c_white);
draw_text(room_width / 2, room_height - 100, "Press Spacebar to Start");

// Reset font settings after drawing the title screen text
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(fnt_hud); // Reset to the HUD font or default font if needed
