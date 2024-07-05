#macro TEXT new TextAction
#macro SPEAKER new SpeakerAction

function DialogueAction() constructor {
    act = function() { };
}

// Define new text to type out
function TextAction(_text) : DialogueAction() constructor {
    text = _text;

    act = function(textbox) {
        textbox.setText(text);
    }
}

// Set the speaker, optionally its portrait and side the portrait is on
function SpeakerAction(_name, _sprite = undefined, _side = undefined): DialogueAction() constructor {
    name = _name;
    sprite = _sprite;
    side = _side;

    act = function(textbox) {
        textbox.speaker_name = name;
        
        if (!is_undefined(sprite)) {
            textbox.portrait_sprite = sprite;
        }
        
        if (!is_undefined(side)) {
            textbox.portrait_side = side;
        }
        
        textbox.next();
    }
}