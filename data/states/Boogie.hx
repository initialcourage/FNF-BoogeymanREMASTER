import funkin.backend.MusicBeatState;

function create() {
    MusicBeatState.skipTransIn = true;
    FlxG.camera.flash(FlxColor.BLACK, .25);
    FlxG.sound.play(Paths.sound('boogie'), .6);

    gomer = new FunkinSprite();
    gomer.loadSprite(Paths.image('game/gomernbarter'));
    gomer.screenCenter();
    add(gomer);

    text = new FunkinText(0, 100, 0, "THIS MOD CONTAINS FLASHING LIGHTS, YOU'RE WARNED N' SHIT LIKE THAT.\n\n\n\n\n\n\nGOMER!!!!!!!!!!!", 24, false);
    text.font = Paths.font('simpson.ttf');
    text.antialiasing = gomer.antialiasing = Options.antialiasing;
    text.screenCenter(FlxAxes.X);
    add(text);

    new FlxTimer().start(5.5, function() FlxG.switchState(new TitleState()));
}