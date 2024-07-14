/// description: Shotgun weapon definition
function create_shotgun_weapon() {
    return {
        name: "Shotgun",
        cooldown: 30,
        damage: 10,
        range: 300,
        bullet_speed: 8,
        weapon_sprite: spr_wpn_shotgun,
        bullet_sprite: spr_wpn_shotgun_bullet,
        fire_sound: snd_wpn_shotgun_fire,
        powerup_sprite: spr_wpn_shotgun_powerup,
        fire_function: function() {
            var player = get_current_player();
            if (player == noone) {
                show_debug_message("Error: No current player set");
                return;
            }
            var pos = get_weapon_position();
            repeat(random_range(5, 7)) {
                var bullet_direction = player.image_angle + random_range(-15, 15);
                create_bullet(pos.x, pos.y, bullet_direction, self.bullet_speed, self.bullet_sprite, self.range * 0.6, self.damage, self);
            }
            audio_play_sound(self.fire_sound, 5, false);
        },
        particle_effect: function(x, y) {
            if (!part_system_exists(global.particle_system)) {
                show_debug_message("Error: Particle system does not exist. Creating new system.");
                global.particle_system = part_system_create();
            }

            var part = create_shotgun_particle();
            
            if (!variable_global_exists("emitter") || !part_emitter_exists(global.particle_system, global.emitter)) {
                global.emitter = part_emitter_create(global.particle_system);
            }

            part_emitter_region(global.particle_system, global.emitter, 
                                x - 8, x + 8, 
                                y - 8, y + 8, 
                                ps_shape_ellipse, ps_distr_gaussian);
            part_emitter_burst(global.particle_system, global.emitter, part, 25);
            
            if (!variable_global_exists("active_effects")) {
                global.active_effects = ds_list_create();
            }

            if (ds_exists(global.active_effects, ds_type_list)) {
                ds_list_add(global.active_effects, {
                    part_type: part,
                    lifetime: 120,
                    creation_time: get_timer() / 1000
                });
            } else {
                show_debug_message("Error: Cannot add to global.active_effects, it is not a valid ds_list");
                part_type_destroy(part);
            }
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