// Create Event of obj_rocket

// Initial speed and position settings
speed_x = 0;
speed_y = 0;
max_speed = 7;
start_x = x;
start_y = y;

#region // Initial weapon selection

    // Create the weapon instance
    weapon = instance_create_depth(x, y, 0, obj_weapon);
    weapon.sprite_index = global.weapon_database[global.WEAPON_TYPE.DEFAULT].weapon_sprite;
    weapon.type = global.current_weapon_type;
    
#endregion

#region // Rematerialize after being destroyed

    // Initialize invincibility timer
    invincible = false;
    invincible_timer = 0;

    // Particle system for rematerialization
    remat_part_sys = part_system_create();
    remat_part_type = part_type_create();
    part_type_shape(remat_part_type, pt_shape_spark);
    part_type_size(remat_part_type, 0.2, 1, 0, 0);
    part_type_color1(remat_part_type, c_white);
    part_type_alpha3(remat_part_type, 0, 1, 0);
    part_type_speed(remat_part_type, 1, 3, 0, 0);
    part_type_direction(remat_part_type, 0, 360, 0, 0);
    part_type_gravity(remat_part_type, 0, 0);
    part_type_life(remat_part_type, 30, 60);

    rematerializing = false;
    rematerialize_timer = 0;

#endregion