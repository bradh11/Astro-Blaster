/// @description: Level Transitions
global.mid_transition = false;
global.room_target = -1;
global.transition_sequence = noone;

function TransitionPlaceSequence(_type){
    if (layer_exists("transition")) layer_destroy("transition");
    var lay = layer_create(-9999, "transition");
    global.transition_sequence = layer_sequence_create(lay, 0, 0, _type);
}

function TransitionStart(_room_target, _type_out, _type_in, _dialogue_topic = undefined) {
    if (!global.mid_transition) {
        global.mid_transition = true;
        global.room_target = _room_target;
        global.current_dialogue_topic = _dialogue_topic;
        global._type_in = _type_in;
        
        if (global.current_dialogue_topic != undefined) {
            global.input_context = "dialogue";
            var textbox = instance_create_depth(0, 0, -999, obj_textbox);
            textbox.setTopic(global.current_dialogue_topic);
            textbox.persistent = true;
            show_debug_message("Textbox created with topic: " + string(global.current_dialogue_topic));
        }
        
        TransitionPlaceSequence(_type_out);
        
        // Schedule room change
        var transition_time = layer_sequence_get_length(global.transition_sequence);
        time_source_start(time_source_create(time_source_game, transition_time, time_source_units_frames, TransitionChangeRoom, [], 1, time_source_expire_after));
        
        return true;
    } else {
        return false;
    }
}

function TransitionChangeRoom() {
    room_goto(global.room_target);
    
    TransitionPlaceSequence(global._type_in);
    
    // If no dialogue, initialize the level immediately
    if (!instance_exists(obj_textbox)) {
        var transition_time = layer_sequence_get_length(global.transition_sequence);
        time_source_start(time_source_create(time_source_game, transition_time, time_source_units_frames, TransitionFinished, [], 1, time_source_expire_after));
    }
    // If dialogue exists, it will handle calling TransitionFinished when it's done
}

function TransitionFinished() {
    show_debug_message("TransitionFinished called");
    
    if (layer_sequence_exists("transition", global.transition_sequence)) {
        show_debug_message("Destroying transition sequence");
        layer_sequence_destroy(global.transition_sequence);
    } else {
        show_debug_message("No transition sequence to destroy");
    }
    
    global.mid_transition = false;
    global.input_context = "game";
    
    show_debug_message("About to call scr_init_level");
    scr_init_level();
    
    show_debug_message("Transition finished, level initialized");
}