function scr_init_level() {
    show_debug_message("Initializing level: " + string(global.current_level));

    var level_index = global.current_level;

    // Reset lives
    global.lives = 3;

    // Reset weapons to defaults
    global.weapon_database = {};
    global.weapon_database[global.WEAPON_TYPE.DEFAULT] = global.weapon_settings[global.WEAPON_TYPE.DEFAULT];

    // Get the level configuration
    var level_config = global.levels[level_index];

    // Ensure "Enemies" and "PowerUps" layers exist
    if (!layer_exists("Enemies")) {
        layer_create(-100, "Enemies");
    }
    if (!layer_exists("PowerUps")) {
        layer_create(-101, "PowerUps");
    }

    // Spawn enemies
    for (var i = 0; i < array_length(level_config.enemies); i++) {
        var enemy_config = level_config.enemies[i];
        for (var j = 0; j < enemy_config.count; j++) {
            var enemy = instance_create_layer(random(room_width), random(room_height), "Enemies", enemy_config.type);
            enemy.hp = enemy_config.hp;
        }
    }

    // Spawn power-ups
    for (var i = 0; i < array_length(level_config.powerups); i++) {
        var powerup_type = level_config.powerups[i];
        var powerup;
        switch (powerup_type) {
            case global.WEAPON_TYPE.SHOTGUN:
                powerup = instance_create_layer(random(room_width), random(room_height), "PowerUps", obj_shotgun_powerup);
                break;
            case global.WEAPON_TYPE.LASER:
                powerup = instance_create_layer(random(room_width), random(room_height), "PowerUps", obj_laser_powerup);
                break;
            // Add more cases for other power-ups
        }
    }
}