/// @description Weapon system script

global.WEAPON_TYPE = {
    DEFAULT: {
        name: "Default",
        cooldown: 15,
        damage: 20,
        range: 350,
        bullet_speed: 6,
        weapon_sprite: spr_weapon_default,
        bullet_sprite: spr_bullet_default,
        fire_sound: snd_fire_default
    },
    SHOTGUN: {
        name: "Shotgun",
        cooldown: 30,
        damage: 10,
        range: 300,
        bullet_speed: 8,
        weapon_sprite: spr_weapon_shotgun,
        bullet_sprite: spr_bullet_shotgun,
        fire_sound: snd_fire_shotgun
    },
    LASER: {
        name: "Laser",
        cooldown: 45,
        damage: 50,
        range: 500,
        bullet_speed: 12,
        weapon_sprite: spr_weapon_laser,
        bullet_sprite: spr_bullet_laser,
        fire_sound: snd_fire_laser
    }
};

function init_weapon_system() {
    show_debug_message("Initializing weapon system...");
    
    // Initialize default weapon inventory
    global.default_weapon_inventory = [global.WEAPON_TYPE.DEFAULT];

    show_debug_message("Weapon system initialized successfully.");
}

function get_weapon_position() {
    var offset_distance_x = sprite_get_width(obj_rocket.sprite_index) / 4;
    var offset_distance_y = sprite_get_height(obj_rocket.sprite_index) / 4;
    var wx = obj_rocket.x + lengthdir_x(offset_distance_x, obj_rocket.image_angle);
    var wy = obj_rocket.y + lengthdir_y(offset_distance_y, obj_rocket.image_angle);
    return {x: wx, y: wy};
}

function create_bullet(_x, _y, _direction, _speed, _sprite, _range, _damage) {
    var bullet = instance_create_depth(_x, _y, 0, obj_bullet);
    bullet.direction = _direction;
    bullet.speed = _speed;
    bullet.sprite_index = _sprite;
    bullet.range = _range;
    bullet.damage = _damage;
    return bullet;
}

function fire_weapon(weapon_type) {
    var pos = get_weapon_position();
    
    switch(weapon_type) {
        case global.WEAPON_TYPE.DEFAULT:
            create_bullet(pos.x, pos.y, obj_rocket.image_angle, weapon_type.bullet_speed, weapon_type.bullet_sprite, weapon_type.range, weapon_type.damage);
            audio_play_sound(weapon_type.fire_sound, 10, false);
            break;
        
        case global.WEAPON_TYPE.SHOTGUN:
            repeat(random_range(5, 7)) {
                var bullet_direction = obj_rocket.image_angle + random_range(-15, 15);
                create_bullet(pos.x, pos.y, bullet_direction, weapon_type.bullet_speed, weapon_type.bullet_sprite, weapon_type.range * 0.6, weapon_type.damage);
            }
            audio_play_sound(weapon_type.fire_sound, 5, false);
            break;
        
        case global.WEAPON_TYPE.LASER:
            var laser = create_bullet(pos.x, pos.y, obj_rocket.image_angle, weapon_type.bullet_speed, weapon_type.bullet_sprite, weapon_type.range, weapon_type.damage);
            laser.image_xscale = 3;
            audio_play_sound(weapon_type.fire_sound, 5, false);
            break;
    }
}

function add_weapon_to_inventory(weapon_type) {
    with (obj_rocket) {
        if (array_find_index(weapon_inventory, function(_weapon) { return _weapon == weapon_type; }) == -1) {
            array_push(weapon_inventory, weapon_type);
            show_debug_message("Added " + weapon_type.name + " to inventory");
        } else {
            show_debug_message("Weapon already in inventory");
        }
    }
}

function reset_weapon_inventory() {
    with (obj_rocket) {
        weapon_inventory = array_create(0);
        array_copy(weapon_inventory, 0, global.default_weapon_inventory, 0, array_length(global.default_weapon_inventory));
        current_weapon_index = 0;
        current_weapon_type = weapon_inventory[current_weapon_index];
        weapon.type = current_weapon_type;
        weapon.sprite_index = current_weapon_type.weapon_sprite;
    }
}

function cycle_weapon_type() {
    with (obj_rocket) {
        current_weapon_index = (current_weapon_index + 1) % array_length(weapon_inventory);
        return weapon_inventory[current_weapon_index];
    }
}

show_debug_message("Weapon system script loaded successfully.");