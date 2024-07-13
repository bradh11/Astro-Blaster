/// description: Laser weapon definition

function create_laser_weapon() {
    return {
        name: "Laser",
        cooldown: 45,
        damage: 35,
        range: 500,
        bullet_speed: 12,
        weapon_sprite: spr_wpn_laser,
        bullet_sprite: spr_wpn_laser_bullet,
        fire_sound: snd_wpn_laser_fire,
        powerup_sprite: spr_wpn_laser_powerup,
        fire_function: function() {
            var pos = get_weapon_position();
            var laser = create_bullet(pos.x, pos.y, obj_rocket.image_angle, self.bullet_speed, self.bullet_sprite, self.range, self.damage, self);
            laser.image_xscale = 3;
            audio_play_sound(self.fire_sound, 5, false);
        },
        particle_effect: function(x, y) {
            var parts = create_laser_particle();
            
            part_emitter_region(global.particle_system, global.emitter, 
                                x - 8, x + 8, 
                                y - 8, y + 8, 
                                ps_shape_ellipse, ps_distr_gaussian);
            
            part_emitter_burst(global.particle_system, global.emitter, parts[0], 50);  // Ember burst
            part_emitter_burst(global.particle_system, global.emitter, parts[1], 30);  // Spark burst
            part_emitter_burst(global.particle_system, global.emitter, parts[2], 20);  // Smoke burst
            
			ds_list_add(global.active_effects, {
			    part_type: parts[0],
			    lifetime: 180,
			    creation_time: get_timer() / 1000
			});
			ds_list_add(global.active_effects, {
			    part_type: parts[1],
			    lifetime: 500,
			    creation_time: get_timer() / 1000
			});
			ds_list_add(global.active_effects, {
			    part_type: parts[2],
			    lifetime: 120,
			    creation_time: get_timer() / 1000
			});
        }
    };
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
    part_type_life(spark, 60, 500);

    var smoke = part_type_create();
    part_type_shape(smoke, pt_shape_smoke);
    part_type_size(smoke, 0.05, 0.2, 0.005, 0);
    part_type_scale(smoke, 1, 1);
    part_type_color_mix(smoke, c_dkgray, c_gray);
    part_type_color_rgb(smoke, 150, 180, 150, 180, 150, 180);
    part_type_alpha3(smoke, 0.7, 0.5, 0);
    part_type_speed(smoke, 0.3, 1.2, -0.03, 0);
    part_type_direction(smoke, 0, 360, 0, 1);
    part_type_orientation(smoke, 0, 360, 0.5, 0, true);
    part_type_life(smoke, 15, 120);

    return [ember, spark, smoke];
}

