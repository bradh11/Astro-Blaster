/// @description Asteroid step event

// Rotate the asteroid slowly
image_angle += rotation_speed;

// Screen wrapping logic
screen_wrap(self);