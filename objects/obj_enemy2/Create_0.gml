/// @description Create event for obj_enemy2

// Initialize health
hp = 100;
max_hp = hp; // Set max_hp to the initial health value


horizontal_speed = 2; // Adjust the speed as needed
vertical_speed = 2; // Adjust the amplitude of the sine wave
vertical_frequency = 0.1; // Adjust the frequency of the sine wave
time = 0; // Time variable to drive the sine wave

// Set random rotation speed
var min_rotation_speed = 0;
var max_rotation_speed = 0;
rotation_speed = irandom_range(min_rotation_speed, max_rotation_speed);

// obj_enemy1 particle 
particle_cleanup_list = ds_list_create();
active_particle_effects = ds_list_create();