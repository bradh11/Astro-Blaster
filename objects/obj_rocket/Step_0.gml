/// @description Rocket step event

// Define the offset distances for thrust and bullet origin
var thrust_offset = 32; // Distance from the center to the bottom of the rocket
var bullet_offset = 32; // Distance from the center to the top of the rocket

#region // Weapon Selector

if (keyboard_check_pressed(vk_shift)) {
    global.current_weapon_type = cycle_weapon_type();
}

#endregion

#region // Weapon Controls

// Update weapon position
var pos = get_weapon_position();
weapon.x = pos.x;
weapon.y = pos.y;
weapon.image_angle = image_angle;

// Shoot bullets using the current weapon's fire function
if (keyboard_check_pressed(vk_space)) {
    var fire_function = global.weapon_database[global.current_weapon_type].fire_function; // Corrected access
    script_execute(fire_function);
}

#endregion

if (rematerializing) {
    // Handle rematerialization timer
    audio_play_sound(snd_rocket_materialize, 1, false);

    rematerialize_timer -= 1;
    if (rematerialize_timer <= 0) {
        rematerializing = false;
        invincible = true;
        invincible_timer = 120; // 1 second of invincibility (assuming 60 fps)
    } else {
        // Emit particles during rematerialization
        part_particles_create(remat_part_sys, x, y, remat_part_type, 10);
    }
} else {
    // Apply forward thrust (thrust from the bottom of the rocket)
    if (keyboard_check(vk_up)) {
        var thrust = 0.05;
        var thrust_x = lengthdir_x(thrust, image_angle);
        var thrust_y = lengthdir_y(thrust, image_angle);
        speed_x += thrust_x;
        speed_y += thrust_y;

        // Create flame at the bottom of the rocket
        var flame_x = x + lengthdir_x(thrust_offset, image_angle + 180);
        var flame_y = y + lengthdir_y(thrust_offset, image_angle + 180);
        var flame = instance_create_layer(flame_x, flame_y, "Effects", obj_flame);
        flame.image_angle = image_angle; // Make sure the flame faces the same direction as the rocket
    }

    // Apply reverse thrust (without creating flame)
    if (keyboard_check(vk_down)) {
        var reverse_thrust = 0.05;
        var reverse_x = lengthdir_x(reverse_thrust, image_angle + 180); // Thrust in the opposite direction
        var reverse_y = lengthdir_y(reverse_thrust, image_angle + 180);
        speed_x += reverse_x;
        speed_y += reverse_y;
    }

    // Rotate right
    if (keyboard_check(vk_right)) {
        image_angle -= 5; // Rotate right
    }

    // Rotate left
    if (keyboard_check(vk_left)) {
        image_angle += 5; // Rotate left
    }

    // Apply friction to slow down the rocket
    var rocket_friction = 0.003; // Friction value to gradually slow down the rocket
    speed_x *= (1 - rocket_friction);
    speed_y *= (1 - rocket_friction);

    // Cap the speed to the maximum speed
    var current_speed = sqrt(speed_x * speed_x + speed_y * speed_y);
    if (current_speed > max_speed) {
        var scale = max_speed / current_speed;
        speed_x *= scale;
        speed_y *= scale;
    }

    // Update the object's position
    x += speed_x;
    y += speed_y;

    // Screen wrapping logic
    screen_wrap(self);

    // Handle invincibility timer
    if (invincible) {
        invincible_timer -= 1;
        if (invincible_timer <= 0) {
            invincible = false;
        }
    }
}