// obj_textbox step event

if (global.input_context == "dialogue") {
    // Get input
    var confirm = keyboard_check_pressed(confirm_key);

    // Type out the text
    text_progress = min(text_progress + text_speed, text_length);

    // Ignore inputs when delay is active
    if (input_delay > 0) {
        input_delay--;
        exit;
    }

    // Are we finished typing?
    if (text_progress == text_length) {
        if (confirm) {
            next();
        }
    } else if (confirm) {
        text_progress = text_length;
    }
}

// Check if we need to destroy this instance and end dialogue
if (current_action >= array_length(actions)) {
    show_debug_message("Dialogue complete. Destroying textbox.");
    persistent = false;
    instance_destroy();
    TransitionFinished();
}