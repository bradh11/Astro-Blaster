/// @description Enemy step event

// Rotate the asteroid slowly
image_angle += rotation_speed;

// Screen wrapping logic
screen_wrap(self);

// Update and clean up particle effects
for (var i = ds_list_size(active_particle_effects) - 1; i >= 0; i--) {
    var effect_data = active_particle_effects[| i];
    if (update_weapon_particle_effect(effect_data)) {
        ds_list_delete(active_particle_effects, i);
    }
}

// Handle any remaining old-style cleanup (can be removed once fully transitioned)
if (variable_instance_exists(id, "particle_cleanup_list")) {
    for (var i = ds_list_size(particle_cleanup_list) - 1; i >= 0; i--) {
        var cleanup_struct = particle_cleanup_list[| i];
        cleanup_struct.timer--;
        if (cleanup_struct.timer <= 0) {
            if (variable_struct_exists(cleanup_struct, "part_type")) {
                part_type_destroy(cleanup_struct.part_type);
            }
            if (variable_struct_exists(cleanup_struct, "part_emitter")) {
                part_emitter_destroy(global.part_system, cleanup_struct.part_emitter);
            }
            ds_list_delete(particle_cleanup_list, i);
        }
    }
}