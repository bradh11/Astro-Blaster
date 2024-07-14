/// Clean Up Event
if (part_system_exists(global.part_system)) {
    part_system_destroy(global.part_system);
}
if (ds_exists(global.active_effects, ds_type_list)) {
    ds_list_destroy(global.active_effects);
}