/// @description listen for space bar to confirm dialog
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
}
else if (confirm) {
	text_progress = text_length;
}