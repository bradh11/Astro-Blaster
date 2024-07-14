/// Step Event of obj_enemy_controller

// Rotate the asteroid slowly
image_angle += rotation_speed;

// Screen wrapping logic
screen_wrap(self);

// Check for collisions with bullets
var bullet = instance_place(x, y, obj_bullet);
if (bullet != noone) {
    // Reduce enemy health
    hp -= bullet.damage;
    
    // Create particle effect
    var weapon_type = bullet.weapon_type;
    if (weapon_type != undefined) {
        create_weapon_particle_effect(weapon_type, x, y);
    }
    
    // Destroy the bullet
    instance_destroy(bullet);
    
    // Check if enemy is destroyed
    if (hp <= 0) {
        // Create explosion effect
        instance_create_layer(x, y, "Instances", obj_explosion);
        
        // Increment score
        global.score += 10;
        
        // Destroy the enemy
        instance_destroy();
    }
}

// Update and clean up particle effects
if (ds_exists(active_particle_effects, ds_type_list)) {
    for (var i = ds_list_size(active_particle_effects) - 1; i >= 0; i--) {
        var effect_data = active_particle_effects[| i];
        if (update_weapon_particle_effect(effect_data)) {
            ds_list_delete(active_particle_effects, i);
        }
    }
}

// Handle any remaining old-style cleanup (can be removed once fully transitioned)
if (variable_instance_exists(id, "particle_cleanup_list")) {
    for (var i = ds_list_size(particle_cleanup_list) - 1; i >= 0; i--) {
        var cleanup_struct = particle_cleanup_list[| i];
        if (variable_struct_exists(cleanup_struct, "timer")) {
            cleanup_struct.timer--;
            if (cleanup_struct.timer <= 0) {
                if (variable_struct_exists(cleanup_struct, "part_type") && part_type_exists(cleanup_struct.part_type)) {
                    part_type_destroy(cleanup_struct.part_type);
                }
                if (variable_struct_exists(cleanup_struct, "part_emitter")) {
                    part_emitter_destroy(global.part_system, cleanup_struct.part_emitter);
                }
                ds_list_delete(particle_cleanup_list, i);
            }
        } else {
            // If timer doesn't exist, remove this struct from the list
            ds_list_delete(particle_cleanup_list, i);
        }
    }
}

// Handle cleanup of global particle effects
if (ds_exists(global.active_effects, ds_type_list)) {
    for (var i = ds_list_size(global.active_effects) - 1; i >= 0; i--) {
        var cleanup_struct = global.active_effects[| i];
        if (variable_struct_exists(cleanup_struct, "timer")) {
            cleanup_struct.timer--;
            if (cleanup_struct.timer <= 0) {
                // Perform cleanup
                if (variable_struct_exists(cleanup_struct, "part_type") && part_type_exists(cleanup_struct.part_type)) {
                    part_type_destroy(cleanup_struct.part_type);
                }
                ds_list_delete(global.active_effects, i);
            }
        } else {
            // If timer doesn't exist, remove this struct from the list
            ds_list_delete(global.active_effects, i);
        }
    }
}

// Check if all enemies are destroyed and transition to the next level
if (!instance_exists(obj_enemy_controller)) {
    scr_next_level();
}