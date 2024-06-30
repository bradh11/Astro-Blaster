/// @description Enemy2 step event

// Horizontal movement
x += speed;

// Increase the frequency of vertical movement to create a zigzag pattern
if (irandom(20) < 5) { // Adjust the probability to control frequency of vertical movement
    y += irandom_range(-10, 10); // Adjust the range to control the vertical movement amount
}

// Screen wrapping logic
screen_wrap(self);

