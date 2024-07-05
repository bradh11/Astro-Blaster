// obj_textbox create event

// make it persitent temporarily so it lasts across room transitions
persistent = true; 

// Typing sound settings
use_typing_sound = true;
typing_sounds = [snd_typing1, snd_typing2, snd_typing3]; // Replace with your actual sound asset names
typing_sound_interval = 1; // Play sound for every character
last_typed_char = 0; // Keep track of the last character that played a sound

// Input
confirm_key = vk_space; // button to press to go to the next page
max_input_delay = 5; // how many frames to ignore input
input_delay = max_input_delay;

// Position
margin = 16; // how much space the textbox gets from the edges of the screen
padding = 8; // how much space things inside the textbox get
width = display_get_gui_width() - margin * 2;
height = sprite_height;

x = (display_get_gui_width() - width) / 2;
y = display_get_gui_height() - height - margin;

// Text
text_font = fnt_text; // Ensure this font exists
text_color = c_white;
text_speed = 0.6;
text_x = padding;
text_y = padding * 3;
text_width = width - padding * 2;

// Portrait
portrait_x = padding;
portrait_y = padding;

// Speaker
speaker_x = padding;
speaker_y = 0;
speaker_font = fnt_name; // Ensure this font exists
speaker_color = #FAF0E6;

/// Private properties
/*** LOOK BUT DO NOT EDIT! ***/
actions = [];
current_action = -1;

text = "";
text_progress = 0;
text_length = 0;

portrait_sprite = -1;
portrait_width = sprite_get_width(spr_portrait);
portrait_height = sprite_get_height(spr_portrait);
portrait_side = PORTRAIT_SIDE.LEFT;

enum PORTRAIT_SIDE {
    LEFT,
    RIGHT
}

speaker_name = "";
speaker_width = sprite_get_width(spr_name);
speaker_height = sprite_get_height(spr_name);

show_debug_message("Textbox created");

/// Methods
/*** Generally you never need to call these manually ***/

// Start a conversation
setTopic = function(topic) {
    actions = global.topics[$ topic];
    current_action = -1;
    show_debug_message("Topic set: " + topic + ", Actions: " + string(array_length(actions)));
    next();
}

// Move to the next action, or close the textbox if out of actions
next = function() {
    current_action++;
    show_debug_message("Next action: " + string(current_action) + "/" + string(array_length(actions)));
    if (current_action >= array_length(actions)) {
        show_debug_message("All actions complete");
    } else {
        actions[current_action].act(id);
    }
}

// Set the text that should be typed out
setText = function(newText, newVoiceSound = undefined) {
    text = newText;
    text_length = string_length(newText);
    text_progress = 0;
    last_typed_char = 0; // Reset this when setting new text
    if (newVoiceSound != undefined && !use_typing_sound) {
        if (audio_is_playing(voice_sound)) {
            audio_stop_sound(voice_sound);
        }
        voice_sound = audio_play_sound(newVoiceSound, 10, false);
    }
}