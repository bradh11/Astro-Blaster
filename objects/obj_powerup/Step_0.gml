/// @description Step event for power-ups parent

// Increment the time variable
time += vertical_frequency;

// Calculate the vertical offset using a sine wave
var vertical_offset = vertical_speed * sin(time);

// Update the position with sine wave for vertical movement and random direction for horizontal
x += cos(direction) * horizontal_speed;
y += vertical_offset;

// Randomly change direction slightly
direction += random_range(-5, 5);

// Screen wrapping logic
screen_wrap(self);