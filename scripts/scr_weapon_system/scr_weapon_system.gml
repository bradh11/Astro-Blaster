/// @description Weapon system script

// Enum-like structure for weapon types
enum WEAPON_TYPE {
    DEFAULT = 0,
    SHOTGUN,
    LASER,
    COUNT
};

// Array for weapon names
global.weapon_names = [
    "DEFAULT",
    "SHOTGUN",
    "LASER"
];

function init_weapon_system() {
    show_debug_message("Initializing weapon system...");

    show_debug_message("WEAPON_TYPE initialized: " + string(global.weapon_names));

    function WeaponData(_type, _cooldown, _damage, _range, _bullet_speed, _fire_function, _weapon_sprite, _bullet_sprite, _fire_sound) constructor {
        type = _type;
        cooldown_max = _cooldown;
        damage = _damage;
        range = _range;
        bullet_speed = _bullet_speed;
        fire_function = _fire_function;
        weapon_sprite = _weapon_sprite;
        bullet_sprite = _bullet_sprite;
        fire_sound = _fire_sound;
    }

    global.weapon_settings = array_create(WEAPON_TYPE.COUNT);

    // Debug messages for checking values
    show_debug_message("Setting up DEFAULT weapon...");
    try {
        global.weapon_settings[WEAPON_TYPE.DEFAULT] = new WeaponData("DEFAULT", 30, 20, 350, 6, fire_default, spr_weapon_default, spr_bullet_default, snd_fire_default);
        show_debug_message("DEFAULT weapon set up successfully.");
    } catch (e) {
        show_debug_message("Error setting up DEFAULT weapon: " + e.message);
    }

    show_debug_message("Setting up SHOTGUN weapon...");
    try {
        global.weapon_settings[WEAPON_TYPE.SHOTGUN] = new WeaponData("SHOTGUN", 60, 10, 300, 8, fire_shotgun, spr_weapon_shotgun, spr_bullet_shotgun, snd_fire_shotgun);
        show_debug_message("SHOTGUN weapon set up successfully.");
    } catch (e) {
        show_debug_message("Error setting up SHOTGUN weapon: " + e.message);
    }

    show_debug_message("Setting up LASER weapon...");
    try {
        global.weapon_settings[WEAPON_TYPE.LASER] = new WeaponData("LASER", 90, 50, 500, 12, fire_laser, spr_weapon_laser, spr_bullet_laser, snd_fire_laser);
        show_debug_message("LASER weapon set up successfully.");
    } catch (e) {
        show_debug_message("Error setting up LASER weapon: " + e.message);
    }

    global.weapon_database = array_create(WEAPON_TYPE.COUNT);
    try {
        global.weapon_database[WEAPON_TYPE.DEFAULT] = global.weapon_settings[WEAPON_TYPE.DEFAULT];
        global.weapon_database[WEAPON_TYPE.SHOTGUN] = global.weapon_settings[WEAPON_TYPE.SHOTGUN];
        global.weapon_database[WEAPON_TYPE.LASER] = global.weapon_settings[WEAPON_TYPE.LASER];
        show_debug_message("Weapon database set up successfully.");
    } catch (e) {
        show_debug_message("Error setting up weapon database: " + e.message);
    }

    // Initialize weapon inventory with only the default weapon
    global.weapon_inventory = [WEAPON_TYPE.DEFAULT, WEAPON_TYPE.LASER];

    global.current_weapon_type = WEAPON_TYPE.DEFAULT;

    show_debug_message("Weapon system initialized successfully.");
}

function get_weapon_position() {
    var offset_distance_x = sprite_get_width(obj_rocket.sprite_index) / 4; // Adjust this value as needed
    var offset_distance_y = sprite_get_height(obj_rocket.sprite_index) / 4; // Adjust this value as needed
    var wx = obj_rocket.x + lengthdir_x(offset_distance_x, obj_rocket.image_angle);
    var wy = obj_rocket.y + lengthdir_y(offset_distance_y, obj_rocket.image_angle);
    return {x: wx, y: wy};
}

function create_bullet(_x, _y, _direction, _speed, _sprite, _range, _damage) {
    var bullet = instance_create_depth(_x, _y, 0, obj_bullet); // Use default depth
    bullet.direction = _direction;
    bullet.speed = _speed;
    bullet.sprite_index = _sprite;
    bullet.range = _range;
    bullet.damage = _damage;
    return bullet;
}

function fire_default() {
    var pos = get_weapon_position();
    var weapon_data = global.weapon_database[WEAPON_TYPE.DEFAULT];
    create_bullet(pos.x, pos.y, obj_rocket.image_angle, weapon_data.bullet_speed, weapon_data.bullet_sprite, weapon_data.range, weapon_data.damage);
    audio_play_sound(weapon_data.fire_sound, 10, false);
}

function fire_shotgun() {
    var pos = get_weapon_position();
    var weapon_data = global.weapon_database[WEAPON_TYPE.SHOTGUN];
    repeat(random_range(5, 7)) {
        var bullet_direction = obj_rocket.image_angle + random_range(-15, 15);
        create_bullet(pos.x, pos.y, bullet_direction, weapon_data.bullet_speed, weapon_data.bullet_sprite, weapon_data.range * 0.6, weapon_data.damage);
    }
    audio_play_sound(weapon_data.fire_sound, 5, false);
}

function fire_laser() {
    var pos = get_weapon_position();
    var weapon_data = global.weapon_database[WEAPON_TYPE.LASER];
    var laser = create_bullet(pos.x, pos.y, obj_rocket.image_angle, weapon_data.bullet_speed, weapon_data.bullet_sprite, weapon_data.range, weapon_data.damage);
    laser.image_xscale = 3; // Adjust this value to control the laser length
    audio_play_sound(weapon_data.fire_sound, 5, false);
}

function cycle_weapon_type() {
    var current_index = array_index_of(global.weapon_inventory, global.current_weapon_type);
    var next_index = (current_index + 1) % array_length(global.weapon_inventory);
    return global.weapon_inventory[next_index];
}

show_debug_message("Weapon system script loaded successfully.");
