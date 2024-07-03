/// @description: Level Transitions
global.mid_transition = false;
global.room_target = -1;

function TransitionPlaceSequence(_type){
	// @description: Places sequences in the room.
	if (layer_exists("transition")) layer_destroy("transition");
	var _lay = layer_create(-9999, "transition");
	layer_sequence_create(_lay, 0, 0, _type)
}

function TransitionStart(_room_target, _type_out, _type_in){
	// @description: Call whenever you want to go from one room to another
	if (!global.mid_transition) {
		global.mid_transition = true;
		global.room_target = _room_target;
		TransitionPlaceSequence(_type_out);
		layer_set_target_room(_room_target);
		TransitionPlaceSequence(_type_in);
		layer_reset_target_room();
		return true;
	}
	else {
		return false;
	}
}

function TransitionChangeRoom() {
	// @description: Called at a moment at the end of an "Out" transition sequence
	room_goto(global.room_target);
}

function TransitionFinished() {
	// @description: Called at a moment at the end of an "In" transition sequence
	layer_sequence_destroy(self.elementID);
	global.mid_transition = false;
	scr_init_level();
}