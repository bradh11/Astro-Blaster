/// Step Event
var weapon_data = global.weapon_database[type]; // Correctly access the weapon data

if (weapon_data != undefined) {
    // Handle cooldown and shooting logic
    if (cooldown > 0) {
        cooldown--;
    } else {
        can_shoot = true;
    }
} else {
    show_debug_message("Error: weapon_data is undefined for type " + string(type));
}
