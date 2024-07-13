function scr_init_level() {
    show_debug_message("Initializing level: " + string(global.current_level));
    var level_index = global.current_level;
    
    // Reset lives
    global.lives = 3;
    
    // Check if the selected player object already exists in the room
    var existing_player = instance_find(global.selected_player_object, 0);
    
    if (existing_player != noone) {
        // If the player object exists, update its position and scale
        show_debug_message("Updating existing player: " + object_get_name(global.selected_player_object));
        with (existing_player) {
            x = room_width / 2;
            y = room_height / 2;
            image_xscale = global.selected_player_scale;
            image_yscale = global.selected_player_scale;
        }
    } else {
        // If the player doesn't exist, create it
        var player = instance_create_layer(room_width / 2, room_height / 2, "Instances", global.selected_player_object);
        player.image_xscale = global.selected_player_scale;
        player.image_yscale = global.selected_player_scale;
        show_debug_message("Player spawned: " + object_get_name(global.selected_player_object) + " with scale " + string(global.selected_player_scale));
    }
    
    // Reset weapons to defaults (now after player object is ensured to exist)
    reset_weapon_inventory();
    
    // Get the level configuration
    var level_config = global.levels[level_index];
    
    // Ensure "Enemies" and "PowerUps" layers exist
    if (!layer_exists("Enemies")) {
        show_debug_message("Creating Enemy layer")
        layer_create(-100, "Enemies");
    }
    if (!layer_exists("PowerUps")) {
        show_debug_message("Creating Powerup layer")
        layer_create(-101, "PowerUps");
    }
    
    // Spawn enemies
    for (var i = 0; i < array_length(level_config.enemies); i++) {
        var enemy_config = level_config.enemies[i];
        show_debug_message("Spawning Enemies: " + string(enemy_config.count))
        for (var j = 0; j < enemy_config.count; j++) {
            var enemy = instance_create_layer(random(room_width), random(room_height), "Enemies", enemy_config.type);
            enemy.hp = enemy_config.hp;
            enemy.max_hp = enemy_config.hp;
        }
    }
    
    // Spawn power-ups
    for (var i = 0; i < array_length(level_config.powerups); i++) {
        var powerup_type = level_config.powerups[i];
        var weapon_powerup = instance_create_layer(random(room_width), random(room_height), "PowerUps", obj_powerup);
        
        // Set the weapon type
        weapon_powerup.weapon_type = powerup_type;
        
        // Set the sprite based on the weapon type
        if (powerup_type.powerup_sprite != undefined) {
            weapon_powerup.sprite_index = powerup_type.powerup_sprite;
        } else {
            // Use a default sprite if no specific powerup sprite is defined
            weapon_powerup.sprite_index = spr_default_powerup;
        }
    }
    
    // Update the player's weapon
    with (global.selected_player_object) {
        current_weapon_type = weapon_inventory[0];
        if (instance_exists(weapon)) {
            weapon.type = current_weapon_type;
            weapon.sprite_index = current_weapon_type.weapon_sprite;
        }
    }
    
    show_debug_message("Level initialized successfully.");
}