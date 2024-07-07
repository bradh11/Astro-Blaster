/// @description Alien step event

// Screen wrapping logic
screen_wrap(self);
// Increment the time variable
time += vertical_frequency;

// Calculate the vertical offset using a sine wave
var vertical_offset = vertical_speed * sin(time);

// Update the position
x += horizontal_speed;
y += vertical_offset;

// Set random rotation speed
var min_rotation_speed = 0;
var max_rotation_speed = 0;
rotation_speed = irandom_range(min_rotation_speed, max_rotation_speed);
