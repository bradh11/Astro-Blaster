/// @description Enemy2 step event


// Increment the time variable
time += vertical_frequency;

// Calculate the vertical offset using a sine wave
var vertical_offset = vertical_speed * sin(time);

// Update the position
x += horizontal_speed;
y += vertical_offset;

// Screen wrapping logic
screen_wrap(self);