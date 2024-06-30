/// Step Event
var dx = lengthdir_x(speed, direction);
var dy = lengthdir_y(speed, direction);
x += dx;
y += dy;
distance_traveled += point_distance(0, 0, dx, dy);

// Screen wrapping
screen_wrap(self);

// Check for collision or out of range
if (distance_traveled >= range) {
    instance_destroy();
}

// Add collision checking here if needed
