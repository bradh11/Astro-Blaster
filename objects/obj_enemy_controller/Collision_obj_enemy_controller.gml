/// @description Collision with another oEnemy1

// Adjust the direction to simulate a bounce
var temp_direction = direction;

// Calculate new directions for both asteroids
direction = point_direction(x, y, other.x, other.y) + 180;
other.direction = point_direction(other.x, other.y, x, y) + 180;

// Ensure they retain their speed
speed = max(speed, 1); // Ensure a minimum speed
other.speed = max(other.speed, 1);
