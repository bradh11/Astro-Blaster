/// @description Insert description here
// You can write your code in this editor

// Decrease lifetime
lifetime -= 1;

// Destroy the flame when lifetime expires
if (lifetime <= 0) {
    instance_destroy();
}
