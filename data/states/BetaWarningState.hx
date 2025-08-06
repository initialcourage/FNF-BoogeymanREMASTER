import funkin.backend.MusicBeatState;

function postUpdate() {
    MusicBeatState.skipTransIn = MusicBeatState.skipTransOut = skipTransition = true;

    FlxG.switchState(new ModState('Boogie'));
}