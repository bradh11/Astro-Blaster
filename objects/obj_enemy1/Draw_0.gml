/// @description Draw event for asteroid with health bar

// Draw the asteroid sprite
draw_self();

// Health bar dimensions
var bar_width = 32;
var bar_height = 4;

// Health bar position (above the asteroid)
var bar_x = x - bar_width / 2;
var bar_y = y - sprite_height / 2 - bar_height - 5;

// Health bar background
draw_set_color(c_black);
draw_rectangle(bar_x, bar_y, bar_x + bar_width, bar_y + bar_height, false);

// Health bar fill
var health_percent = hp / max_hp; // Use max_hp for percentage calculation
var health_width = bar_width * health_percent;
draw_set_color(c_green);
draw_rectangle(bar_x, bar_y, bar_x + health_width, bar_y + bar_height, false);
