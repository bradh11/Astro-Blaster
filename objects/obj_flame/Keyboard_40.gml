/// @description Key down for up arrow

// Play the rocket sound if not already playing
if (!audio_is_playing(snd_flame1)) {
    audio_play_sound_at(snd_flame1, x, y, 0, 0, 0, 0, 0.2, true, 1); // Play the sound looped at volume 0.2
}
