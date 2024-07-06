/// Destroy Event
// Clean up particle effects
if (variable_instance_exists(id, "active_particle_effects")) {
    for (var i = 0; i < ds_list_size(active_particle_effects); i++) {
        var effect_data = active_particle_effects[| i];
        if (part_emitter_exists(global.part_system, effect_data.emitter)) {
            part_emitter_destroy(global.part_system, effect_data.emitter);
        }
        if (ds_exists(effect_data.cleanup_list, ds_type_list)) {
            for (var j = 0; j < ds_list_size(effect_data.cleanup_list); j++) {
                var cleanup_item = effect_data.cleanup_list[| j];
                if (variable_struct_exists(cleanup_item, "part_type") && part_type_exists(cleanup_item.part_type)) {
                    part_type_destroy(cleanup_item.part_type);
                }
            }
            ds_list_destroy(effect_data.cleanup_list);
        }
    }
    ds_list_destroy(active_particle_effects);
}

// Clean up any remaining old-style particles (can be removed once fully transitioned)
if (variable_instance_exists(id, "particle_cleanup_list")) {
    for (var i = 0; i < ds_list_size(particle_cleanup_list); i++) {
        var cleanup_struct = particle_cleanup_list[| i];
        if (variable_struct_exists(cleanup_struct, "part_type") && part_type_exists(cleanup_struct.part_type)) {
            part_type_destroy(cleanup_struct.part_type);
        }
        if (variable_struct_exists(cleanup_struct, "part_emitter") && part_emitter_exists(global.part_system, cleanup_struct.part_emitter)) {
            part_emitter_destroy(global.part_system, cleanup_struct.part_emitter);
        }
    }
    ds_list_destroy(particle_cleanup_list);
}

// Add any additional cleanup code here
// For example, you might want to remove this enemy from any lists or arrays it's in