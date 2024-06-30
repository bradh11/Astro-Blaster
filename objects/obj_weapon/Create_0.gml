/// Create Event
if (variable_global_exists("WEAPON_TYPE")) {
    var local_WEAPON_TYPE = global.WEAPON_TYPE; // Copy global WEAPON_TYPE to a local variable

    type = local_WEAPON_TYPE.DEFAULT; // Or whichever type you need to set
} else {
    show_debug_message("Error: WEAPON_TYPE is not defined. Make sure scr_weapon_system has been called.");
    type = -1; // Some default or error value
}

cooldown = 0;
can_shoot = true;