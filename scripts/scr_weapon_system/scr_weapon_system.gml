/// scr_weapon_system.gml

function init_weapon_system() {
    show_debug_message("Initializing weapon system...");
    
    initialize_weapons();
    initialize_particle_system();
    
    // Initialize default weapon inventory
    global.default_weapon_inventory = [global.WEAPON_TYPE.DEFAULT];

    show_debug_message("Weapon system initialized successfully.");
}

function initialize_particle_system() {
    global.particle_system = part_system_create();
    part_system_depth(global.particle_system, -100);  // Adjust depth as needed
    global.active_effects = ds_list_create();
    global.emitter = part_emitter_create(global.particle_system);
}

function initialize_weapons() {
    global.WEAPON_TYPE = {
        DEFAULT: create_default_weapon(),
        SHOTGUN: create_shotgun_weapon(),
        LASER: create_laser_weapon(),
        SOUNDWAVE: create_soundwave_weapon()
    };
}

function fire_weapon(weapon_type) {
    weapon_type.fire_function();
}

function create_weapon_particle_effect(weapon_type, x, y) {
    weapon_type.particle_effect(x, y);
}

function get_weapon_position() {
    var offset_distance_x = sprite_get_width(obj_rocket.sprite_index) / 4;
    var offset_distance_y = sprite_get_height(obj_rocket.sprite_index) / 4;
    var wx = obj_rocket.x + lengthdir_x(offset_distance_x, obj_rocket.image_angle);
    var wy = obj_rocket.y + lengthdir_y(offset_distance_y, obj_rocket.image_angle);
    return {x: wx, y: wy};
}

function create_bullet(_x, _y, _direction, _speed, _sprite, _range, _damage, _weapon_type) {
    var bullet = instance_create_depth(_x, _y, 0, obj_bullet);
    bullet.direction = _direction;
    bullet.speed = _speed;
    bullet.sprite_index = _sprite;
    bullet.range = _range;
    bullet.damage = _damage;
    bullet.weapon_type = _weapon_type;
    return bullet;
}

function add_weapon_to_inventory(weapon_type) {
    with (obj_rocket) {
        if (!is_struct(weapon_type) || is_undefined(weapon_type.name)) {
            show_debug_message("Error: Invalid weapon type");
            return false;
        }
        
        var weapon_exists = false;
        for (var i = 0; i < array_length(weapon_inventory); i++) {
            if (is_struct(weapon_inventory[i]) && weapon_inventory[i].name == weapon_type.name) {
                weapon_exists = true;
                break;
            }
        }
        
        if (!weapon_exists) {
            array_push(weapon_inventory, weapon_type);
            show_debug_message("Added " + weapon_type.name + " to inventory");
            return true;
        } else {
            show_debug_message("Weapon already in inventory");
            return false;
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

function cleanup_particles() {
    var current_time_ms = get_timer() / 1000; // Get current time in milliseconds
    for (var i = ds_list_size(global.active_effects) - 1; i >= 0; i--) {
        var effect = global.active_effects[| i];
        if (current_time_ms - effect.creation_time > effect.lifetime) {
            part_type_destroy(effect.part_type);
            ds_list_delete(global.active_effects, i);
        }
    }
}

show_debug_message("Weapon system script loaded successfully.");