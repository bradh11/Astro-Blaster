/// description: Soundwave weapon definition


function create_soundwave_weapon() {
    return {
        name: "Soundwave Gun",
        cooldown: 25,
        damage: 10,
        range: 250,
        bullet_speed: 7,
        weapon_sprite: spr_wpn_soundwave,
        bullet_sprite: spr_wpn_soundwave_bullet,
        fire_sound: snd_wpn_soundwave_fire,
        powerup_sprite: spr_wpn_soundwave_powerup,
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

