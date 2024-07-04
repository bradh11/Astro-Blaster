/// @description Explosion create event

// Initialize the explosion animation
image_speed = 0.5; // Adjust the speed of the animation

// Set depth of the explosion object
depth = -100;

// Create the particle system
part_sys = part_system_create();

// Create the particle type
part_type = part_type_create();
part_type_shape(part_type, pt_shape_explosion);
part_type_size(part_type, 0.2, 0.5, 0, 0);
part_type_color1(part_type, c_orange);
part_type_alpha3(part_type, 1, 0.5, 0);
part_type_speed(part_type, 1, 5, 0, 0);
part_type_direction(part_type, 0, 360, 0, 0);
part_type_gravity(part_type, 0.1, 270);
part_type_life(part_type, 20, 40);

// Create the particle emitter
part_emitter = part_emitter_create(part_sys);
part_emitter_region(part_sys, part_emitter, x-10, x+10, y-10, y+10, ps_shape_ellipse, ps_distr_gaussian);
part_emitter_burst(part_sys, part_emitter, part_type, 100);
