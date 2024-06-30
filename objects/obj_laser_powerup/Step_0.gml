// Step Event for obj_shotgun_powerup and obj_laser_powerup
direction += random_range(-5, 5); // Randomly change direction
speed = 1; // Move slowly
if (x < 0 || x > room_width) direction = 180 - direction; // Bounce off walls
if (y < 0 || y > room_height) direction = 360 - direction; // Bounce off top/bottom

// Screen wrapping
screen_wrap(self);