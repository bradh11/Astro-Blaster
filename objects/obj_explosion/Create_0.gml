/// Create Event
image_speed = 0.5;
depth = -100;

part_type = part_type_create();
part_type_shape(part_type, pt_shape_explosion);
part_type_size(part_type, 0.2, 0.5, 0, 0);
part_type_color1(part_type, c_orange);
part_type_alpha3(part_type, 1, 0.5, 0);
part_type_speed(part_type, 1, 5, 0, 0);
part_type_direction(part_type, 0, 360, 0, 0);
part_type_gravity(part_type, 0.1, 270);
part_type_life(part_type, 20, 40);

part_emitter = part_emitter_create(global.part_system);
part_emitter_region(global.part_system, part_emitter, x-10, x+10, y-10, y+10, ps_shape_ellipse, ps_distr_gaussian);
part_emitter_burst(global.part_system, part_emitter, part_type, 100);