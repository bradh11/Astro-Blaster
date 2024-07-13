/// @description Create event for power-ups parent

weapon_type = noone;
show_debug_message("Created powerup. Initial weapon_type: " + string(weapon_type));

horizontal_speed = 1; // Adjust the speed as needed
vertical_speed = 1; // Adjust the amplitude of the sine wave
vertical_frequency = 0.05; // Adjust the frequency of the sine wave
time = random(360); // Start at a random point in the sine wave

// Initial direction for random motion
direction = random(360);