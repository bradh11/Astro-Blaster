/// Step Event of obj_particle_manager
part_system_update(global.part_system);

for (var i = ds_list_size(global.active_effects) - 1; i >= 0; i--) {
    var effect_data = global.active_effects[| i];
    effect_data.lifetime -= 1;
    
    if (effect_data.lifetime <= 0) {
        // Clean up the effect
        for (var j = 0; j < ds_list_size(effect_data.cleanup_list); j++) {
            var cleanup_item = effect_data.cleanup_list[| j];
            if (part_type_exists(cleanup_item.part_type)) {
                part_type_destroy(cleanup_item.part_type);
            }
        }
        if (part_emitter_exists(global.part_system, effect_data.emitter)) {
            part_emitter_destroy(global.part_system, effect_data.emitter);
        }
        ds_list_destroy(effect_data.cleanup_list);
        ds_list_delete(global.active_effects, i);
    }
}