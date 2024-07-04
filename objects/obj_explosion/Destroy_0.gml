/// @description Explosion destroy event

// Destroy the particle system
part_type_destroy(part_type);
part_emitter_destroy(part_sys, part_emitter);
part_system_destroy(part_sys);
