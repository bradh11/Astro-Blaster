/// scr_weapon_system.gml

function init_weapon_system() {
    show_debug_message("Initializing weapon system...");
    
    initialize_weapons();
    initialize_particle_system();
    
    // Initialize default weapon inventory
    global.default_weapon_inventory = [global.WEAPON_TYPE.DEFAULT];

    show_debug_message("Weapon system initialized successfully.");
}

function initialize_particle_system() {
    global.particle_system = part_system_create();
    part_system_depth(global.particle_system, -100);  // Adjust depth as needed
    global.active_effects = ds_list_create();
    global.emitter = part_emitter_create(global.particle_system);
}

function initialize_weapons() {
    global.WEAPON_TYPE = {
        DEFAULT: create_default_weapon(),
        SHOTGUN: create_shotgun_weapon(),
        LASER: create_laser_weapon(),
        SOUNDWAVE: create_soundwave_weapon()
    };
}

function create_default_weapon() {
    return {
        name: "Default",
        cooldown: 15,
        damage: 20,
        range: 350,
        bullet_speed: 6,
        weapon_sprite: spr_weapon_default,
        bullet_sprite: spr_bullet_default,
        fire_sound: snd_fire_default,
        powerup_sprite: undefined,
        fire_function: function() {
            var pos = get_weapon_position();
            create_bullet(pos.x, pos.y, obj_rocket.image_angle, self.bullet_speed, self.bullet_sprite, self.range, self.damage, self);
            audio_play_sound(self.fire_sound, 10, false);
        },
        particle_effect: function(x, y) {
            var part = part_type_create();
            part_type_shape(part, pt_shape_flare);
            part_type_size(part, 0.1, 0.3, -0.01, 0);
            part_type_scale(part, 1, 1);
            part_type_color3(part, c_yellow, c_orange, c_red);
            part_type_alpha3(part, 1, 0.8, 0);
            part_type_speed(part, 1, 3, -0.1, 0);
            part_type_direction(part, 0, 360, 0, 0);
            part_type_life(part, 15, 60);
            
            part_particles_create(global.particle_system, x, y, part, 50);
            part_type_destroy(part);
        }
    };
}

function create_shotgun_weapon() {
    return {
        name: "Shotgun",
        cooldown: 30,
        damage: 10,
        range: 300,
        bullet_speed: 8,
        weapon_sprite: spr_weapon_shotgun,
        bullet_sprite: spr_bullet_shotgun,
        fire_sound: snd_fire_shotgun,
        powerup_sprite: spr_shotgun_powerup,
        fire_function: function() {
            var pos = get_weapon_position();
            repeat(random_range(5, 7)) {
                var bullet_direction = obj_rocket.image_angle + random_range(-15, 15);
                create_bullet(pos.x, pos.y, bullet_direction, self.bullet_speed, self.bullet_sprite, self.range * 0.6, self.damage, self);
            }
            audio_play_sound(self.fire_sound, 5, false);
        },
        particle_effect: function(x, y) {
            var part = create_shotgun_particle();
            
            part_emitter_region(global.particle_system, global.emitter, 
                                x - 8, x + 8, 
                                y - 8, y + 8, 
                                ps_shape_ellipse, ps_distr_gaussian);
            part_emitter_burst(global.particle_system, global.emitter, part, 25);
            
			ds_list_add(global.active_effects, {
			    part_type: part,
			    lifetime: 120,
			    creation_time: get_timer() / 1000
			});
        }
    };
}

function create_laser_weapon() {
    return {
        name: "Laser",
        cooldown: 45,
        damage: 35,
        range: 500,
        bullet_speed: 12,
        weapon_sprite: spr_weapon_laser,
        bullet_sprite: spr_bullet_laser,
        fire_sound: snd_fire_laser,
        powerup_sprite: spr_laser_powerup,
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

function create_soundwave_weapon() {
    return {
        name: "Soundwave Gun",
        cooldown: 25,
        damage: 10,
        range: 250,
        bullet_speed: 7,
        weapon_sprite: spr_weapon_soundwave,
        bullet_sprite: spr_bullet_soundwave,
        fire_sound: snd_fire_soundwave,
        powerup_sprite: spr_soundwave_powerup,
        fire_function: function() {
            var pos = get_weapon_position();
            var num_waves = 5;
            for (var i = -num_waves; i <= num_waves; i++) {
                var wave_direction = obj_rocket.image_angle + i * 3;
                create_bullet(pos.x, pos.y, wave_direction, self.bullet_speed, self.bullet_sprite, self.range, self.damage, self);
            }
            audio_play_sound(self.fire_sound, 8, false);
        },
        particle_effect: function(x, y) {
            var wave = part_type_create();
            part_type_shape(wave, pt_shape_ring);
            part_type_size(wave, 0.1, 0.3, 0.05, 0);
            part_type_scale(wave, 1, 1);
            part_type_color3(wave, c_aqua, c_teal, c_blue);
            part_type_alpha3(wave, 0.7, 0.4, 0);
            part_type_speed(wave, 2, 4, -0.1, 0);
            part_type_direction(wave, 0, 360, 0, 0);
            part_type_life(wave, 30, 45);

            var debris = part_type_create();
            part_type_shape(debris, pt_shape_pixel);
            part_type_size(debris, 0.1, 0.3, -0.005, 0);
            part_type_scale(debris, 1, 1);
            part_type_color3(debris, c_aqua, c_teal, c_blue);
            part_type_alpha3(debris, 1, 0.6, 0);
            part_type_speed(debris, 2, 5, -0.1, 0);
            part_type_direction(debris, 0, 360, 0, 0);
            part_type_life(debris, 20, 40);

            part_particles_create(global.particle_system, x, y, wave, 1);
            part_particles_create(global.particle_system, x, y, debris, 50);

            part_type_destroy(wave);
            part_type_destroy(debris);
        }
    };
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

function fire_weapon(weapon_type) {
    weapon_type.fire_function();
}

function create_weapon_particle_effect(weapon_type, x, y) {
    weapon_type.particle_effect(x, y);
}

function get_weapon_position() {
    var offset_distance_x = sprite_get_width(obj_rocket.sprite_index) / 4;
    var offset_distance_y = sprite_get_height(obj_rocket.sprite_index) / 4;
    var wx = obj_rocket.x + lengthdir_x(offset_distance_x, obj_rocket.image_angle);
    var wy = obj_rocket.y + lengthdir_y(offset_distance_y, obj_rocket.image_angle);
    return {x: wx, y: wy};
}

function create_bullet(_x, _y, _direction, _speed, _sprite, _range, _damage, _weapon_type) {
    var bullet = instance_create_depth(_x, _y, 0, obj_bullet);
    bullet.direction = _direction;
    bullet.speed = _speed;
    bullet.sprite_index = _sprite;
    bullet.range = _range;
    bullet.damage = _damage;
    bullet.weapon_type = _weapon_type;
    return bullet;
}

function add_weapon_to_inventory(weapon_type) {
    with (obj_rocket) {
        if (!is_struct(weapon_type) || is_undefined(weapon_type.name)) {
            show_debug_message("Error: Invalid weapon type");
            return false;
        }
        
        var weapon_exists = false;
        for (var i = 0; i < array_length(weapon_inventory); i++) {
            if (is_struct(weapon_inventory[i]) && weapon_inventory[i].name == weapon_type.name) {
                weapon_exists = true;
                break;
            }
        }
        
        if (!weapon_exists) {
            array_push(weapon_inventory, weapon_type);
            show_debug_message("Added " + weapon_type.name + " to inventory");
            return true;
        } else {
            show_debug_message("Weapon already in inventory");
            return false;
        }
    }
}

function reset_weapon_inventory() {
    with (obj_rocket) {
        weapon_inventory = array_create(0);
        array_copy(weapon_inventory, 0, global.default_weapon_inventory, 0, array_length(global.default_weapon_inventory));
        current_weapon_index = 0;
        current_weapon_type = weapon_inventory[current_weapon_index];
        weapon.type = current_weapon_type;
        weapon.sprite_index = current_weapon_type.weapon_sprite;
    }
}

function cycle_weapon_type() {
    with (obj_rocket) {
        current_weapon_index = (current_weapon_index + 1) % array_length(weapon_inventory);
        return weapon_inventory[current_weapon_index];
    }
}

function cleanup_particles() {
    var current_time_ms = get_timer() / 1000; // Get current time in milliseconds
    for (var i = ds_list_size(global.active_effects) - 1; i >= 0; i--) {
        var effect = global.active_effects[| i];
        if (current_time_ms - effect.creation_time > effect.lifetime) {
            part_type_destroy(effect.part_type);
            ds_list_delete(global.active_effects, i);
        }
    }
}

show_debug_message("Weapon system script loaded successfully.");