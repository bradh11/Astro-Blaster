#macro TEXT new TextAction

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