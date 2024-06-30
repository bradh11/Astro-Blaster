// obj_rocket Collision Event with obj_powerup
if (other.weapon_type != undefined) {
    var powerup_type = other.weapon_type;

    // Add the weapon to the inventory if not already present
    if (!array_contains(global.weapon_inventory, powerup_type)) {
        array_push(global.weapon_inventory, powerup_type);
    }

    // Change current weapon to the new power-up weapon
    global.current_weapon_type = powerup_type;

    // Play the power-up sound (assuming snd_powerup is your power-up sound)
    audio_play_sound(snd_powerup, 10, false);

    // Destroy the power-up after collection
    instance_destroy(other);
} else {
    show_debug_message("Error: weapon_type is undefined for the power-up object.");
}
