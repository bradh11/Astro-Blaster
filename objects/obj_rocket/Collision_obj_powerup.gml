/// obj_rocket Collision Event with obj_powerup

var powerup_type = other.weapon_type;

if (powerup_type != undefined) {
    var weapon_exists = false;
    for (var i = 0; i < array_length(weapon_inventory); i++) {
        if (weapon_inventory[i] == powerup_type) {
            weapon_exists = true;
            break;
        }
    }
    
    if (!weapon_exists) {
        array_push(weapon_inventory, powerup_type);
        current_weapon_index = array_length(weapon_inventory) - 1;
        current_weapon_type = powerup_type;
        weapon.type = current_weapon_type;
        weapon.sprite_index = current_weapon_type.weapon_sprite;
        
        show_debug_message("Added " + powerup_type.name + " to inventory");
        
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
    show_debug_message("Invalid powerup type");
}