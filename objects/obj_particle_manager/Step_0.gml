/// Step Event of obj_particle_manager
part_system_update(global.part_system);
for (var i = ds_list_size(global.active_effects) - 1; i >= 0; i--) {
    var effect_data = global.active_effects[| i];
    if (!is_struct(effect_data) || !variable_struct_exists(effect_data, "lifetime")) {
        ds_list_delete(global.active_effects, i);
        continue;
    }
    
    effect_data.lifetime -= 1;
    
    if (effect_data.lifetime <= 0) {
        // Clean up the effect
        if (variable_struct_exists(effect_data, "cleanup_list") && ds_exists(effect_data.cleanup_list, ds_type_list)) {
            for (var j = 0; j < ds_list_size(effect_data.cleanup_list); j++) {
                var cleanup_item = effect_data.cleanup_list[| j];
                if (is_struct(cleanup_item) && variable_struct_exists(cleanup_item, "part_type")) {
                    if (part_type_exists(cleanup_item.part_type)) {
                        part_type_destroy(cleanup_item.part_type);
                    }
                }
            }
            ds_list_destroy(effect_data.cleanup_list);
        }
        if (variable_struct_exists(effect_data, "emitter") && part_emitter_exists(global.part_system, effect_data.emitter)) {
            part_emitter_destroy(global.part_system, effect_data.emitter);
        }
        ds_list_delete(global.active_effects, i);
    }
}