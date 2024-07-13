/// description: Default weapon definition

function create_default_weapon() {
    return {
        name: "Default",
        cooldown: 15,
        damage: 20,
        range: 350,
        bullet_speed: 6,
        weapon_sprite: spr_wpn_default,
        bullet_sprite: spr_wpn_default_bullet,
        fire_sound: snd_wpn_default_fire,
        powerup_sprite: undefined,
        fire_function: function() {
			var player = get_current_player();
			if (player == noone) {
			    show_debug_message("Error: No current player set");
			    return;
			}
            var pos = get_weapon_position();
            create_bullet(pos.x, pos.y, player.image_angle, self.bullet_speed, self.bullet_sprite, self.range, self.damage, self);
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


