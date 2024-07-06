/// scr_weapon_particles

function create_weapon_particle_effect(weapon_type, xx, yy) {
    var effect_data = {
        emitter: part_emitter_create(global.part_system),
        cleanup_list: ds_list_create(),
        x: xx,
        y: yy,
        lifetime: 300  // Duration of the effect in steps (4 seconds at 60 FPS)
    };

    switch(weapon_type) {
        case global.WEAPON_TYPE.DEFAULT:
            create_default_particle_effect(effect_data);
            break;
        case global.WEAPON_TYPE.SHOTGUN:
            create_shotgun_particle_effect(effect_data);
            break;
        case global.WEAPON_TYPE.LASER:
            create_laser_particle_effect(effect_data);
            break;
        // Add cases for other weapon types as needed
    }

    ds_list_add(global.active_effects, effect_data);
    return effect_data;
}

function create_default_particle_effect(effect_data) {
    var part = create_default_particle();
    
    part_emitter_region(global.part_system, effect_data.emitter, 
                        effect_data.x - 10, effect_data.x + 10, 
                        effect_data.y - 10, effect_data.y + 10, 
                        ps_shape_ellipse, ps_distr_gaussian);
    part_emitter_burst(global.part_system, effect_data.emitter, part, 50);
    
    ds_list_add(effect_data.cleanup_list, {part_type: part});
}

function create_shotgun_particle_effect(effect_data) {
    var part = create_shotgun_particle();
    
    part_emitter_region(global.part_system, effect_data.emitter, 
                        effect_data.x - 8, effect_data.x + 8, 
                        effect_data.y - 8, effect_data.y + 8, 
                        ps_shape_ellipse, ps_distr_gaussian);
    part_emitter_burst(global.part_system, effect_data.emitter, part, 25);
    
    ds_list_add(effect_data.cleanup_list, {part_type: part});
}

function create_laser_particle_effect(effect_data) {
    var parts = create_laser_particle();
    
    part_emitter_region(global.part_system, effect_data.emitter, 
                        effect_data.x - 8, effect_data.x + 8, 
                        effect_data.y - 8, effect_data.y + 8, 
                        ps_shape_ellipse, ps_distr_gaussian);
    
    part_emitter_burst(global.part_system, effect_data.emitter, parts[0], 50);  // Ember burst
    part_emitter_burst(global.part_system, effect_data.emitter, parts[1], 30);  // Spark burst
    part_emitter_burst(global.part_system, effect_data.emitter, parts[2], 20);  // Smoke burst
    
    ds_list_add(effect_data.cleanup_list, {part_type: parts[0]});
    ds_list_add(effect_data.cleanup_list, {part_type: parts[1]});
    ds_list_add(effect_data.cleanup_list, {part_type: parts[2]});
}

function create_default_particle() {
    var part = part_type_create();
    part_type_shape(part, pt_shape_flare);
    part_type_size(part, 0.1, 0.3, -0.01, 0);
    part_type_scale(part, 1, 1);
    part_type_color3(part, c_yellow, c_orange, c_red);
    part_type_alpha3(part, 1, 0.8, 0);
    part_type_speed(part, 1, 3, -0.1, 0);
    part_type_direction(part, 0, 360, 0, 0);
    part_type_life(part, 15, 60);
    return part;
}

function create_shotgun_particle() {
    var part = part_type_create();
    part_type_shape(part, pt_shape_smoke);
    part_type_size(part, 0.05, 0.2, 0.005, 0);
    part_type_scale(part, 1, 1);
    part_type_color_mix(part, c_dkgray, c_gray);
    part_type_color_rgb(part, 150, 180, 150, 180, 150, 180);
    part_type_alpha3(part, 0.7, 0.5, 0);
    part_type_speed(part, 0.3, 1.2, -0.03, 0);
    part_type_direction(part, 0, 360, 0, 1);
    part_type_orientation(part, 0, 360, 0.5, 0, true);
    part_type_life(part, 15, 120);
    return part;
}

function create_laser_particle() {
    var ember = part_type_create();
    part_type_shape(ember, pt_shape_pixel);
    part_type_size(ember, 0.5, 1, -0.01, 0);
    part_type_scale(ember, 1, 1);
    part_type_color3(ember, c_red, c_orange, c_yellow);
    part_type_alpha3(ember, 1, 0.8, 0.2);
    part_type_speed(ember, 0.5, 1.5, -0.03, 0);
    part_type_direction(ember, 70, 110, 0, 2);
    part_type_orientation(ember, 0, 360, 0, 0, true);
    part_type_blend(ember, true);
    part_type_life(ember, 40, 180);

    var spark = part_type_create();
    part_type_shape(spark, pt_shape_star);
    part_type_size(spark, 0.05, 0.15, -0.002, 0);
    part_type_scale(spark, 1, 1);
    part_type_color3(spark, c_white, c_yellow, c_blue);
    part_type_alpha3(spark, 1, 0.8, 0);
    part_type_speed(spark, 1, 3, -0.05, 0);
    part_type_direction(spark, 0, 360, 0, 0);
    part_type_orientation(spark, 0, 360, 1, 0, true);
    part_type_blend(spark, true);
    part_type_life(spark, 60, 300);

    var smoke = part_type_create();
    part_type_shape(smoke, pt_shape_cloud);
    part_type_size(smoke, 0.1, 0.3, 0.01, 0);
    part_type_scale(smoke, 1, 1);
    part_type_color3(smoke, c_dkgray, c_gray, c_ltgray);
    part_type_alpha3(smoke, 0.2, 0.1, 0);
    part_type_speed(smoke, 0.2, 0.5, -0.01, 0);
    part_type_direction(smoke, 70, 110, 0, 1);
    part_type_orientation(smoke, 0, 360, 0.5, 0, true);
    part_type_life(smoke, 30, 300);

    return [ember, spark, smoke];
}