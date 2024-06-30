// Collision Event with obj_bullet
if (other.object_index == obj_bullet) {
	
	// Play explosion sound
    audio_play_sound(snd_bullet_hit, 1, false);

    // Calculate the actual damage taken
    var damage_taken = min(other.damage, hp);
    
    // Reduce health by the actual damage taken
    hp -= damage_taken;
	
    // Increment the score by the actual damage taken
    global.score += damage_taken;

    // Destroy the bullet
    with (other) {
        instance_destroy();
    }

    // Check health and destroy enemy if health is zero or less
    if (hp <= 0) {
        // Play explosion sound
        audio_play_sound(snd_explosion, 1, false);
        
        // Create explosion effect
        instance_create_layer(x, y, "Effects", oExplosion);
        
        // Destroy the instance
        instance_destroy();
		
        // Check if all enemies are defeated
        var all_enemies_defeated = true;
        for (var i = 0; i < array_length(global.levels[global.current_level].enemies); i++) {
            var enemy_type = global.levels[global.current_level].enemies[i].type;
            if (instance_number(enemy_type) > 0) {
                all_enemies_defeated = false;
                break;
            }
        }

        if (all_enemies_defeated) {
            // Transition to the next level
            scr_next_level();
        }
    }
}
