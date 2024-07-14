/// Create Event of obj_particle_manager
// Initialize global active effects list if it doesn't exist
if (!variable_global_exists("active_effects")) {
    global.active_effects = ds_list_create();
}
// Initialize global particle system if it doesn't exist
if (!variable_global_exists("part_system")) {
    global.part_system = part_system_create();
} else if (!part_system_exists(global.part_system)) {
    // If the variable exists but the system doesn't, create a new one
    global.part_system = part_system_create();
}
// Set automatic updates to false, we'll update manually in the Step event
part_system_automatic_update(global.part_system, false);

// Ability to call a cleanup action for particles between level transitions
function cleanup_all_particles() {
    for (var i = ds_list_size(global.active_effects) - 1; i >= 0; i--) {
        var effect_data = global.active_effects[| i];
        if (is_struct(effect_data) && variable_struct_exists(effect_data, "cleanup_list")) {
            if (ds_exists(effect_data.cleanup_list, ds_type_list)) {
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
            if (part_emitter_exists(global.part_system, effect_data.emitter)) {
                part_emitter_destroy(global.part_system, effect_data.emitter);
            }
        }
        ds_list_delete(global.active_effects, i);
    }
    part_system_clear(global.part_system);
}