// Other Event (User Event 0) - Fire Event
if (can_shoot) {
    fire_weapon(type);
    cooldown = type.cooldown;
    can_shoot = false;
}