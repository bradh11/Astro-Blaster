/// obj_rocket Collision Event with obj_powerup
var powerup_type = other.weapon_type;
show_debug_message("Collided with powerup. Type: " + (is_struct(powerup_type) ? powerup_type.name : "undefined"));

if (is_struct(powerup_type) && !is_undefined(powerup_type.name)) {
    var weapon_added = add_weapon_to_inventory(powerup_type, self);
    
    if (weapon_added) {
        // Switch to the new weapon
        current_weapon_index = array_length(weapon_inventory) - 1;
        current_weapon_type = powerup_type;
        if (instance_exists(weapon)) {
            weapon.type = current_weapon_type;
            weapon.sprite_index = current_weapon_type.weapon_sprite;
        }
        
        // Play a pickup sound
        if (audio_exists(snd_powerup)) {
            audio_play_sound(snd_powerup, 5, false);
        } else {
            show_debug_message("Warning: snd_powerup does not exist");
        }
        
        // Destroy the powerup
        instance_destroy(other);
    } else {
        // The weapon is already in the inventory
        show_debug_message("Weapon already in inventory");
    }
} else {
    show_debug_message("Error: Invalid powerup type");
}