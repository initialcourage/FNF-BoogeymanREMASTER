import flixel.text.FlxTextFormatMarkerPair;
import flixel.text.FlxTextFormat;

var options:Array<FunkinText> = ['?Normal?', '*HARD*'];
var choices:FlxTypedGroup;
var curSelect:Int = 0;

function create() {
    camera = diffCam = new FlxCamera();
    FlxG.cameras.add(diffCam, false).bgColor = FlxColor.TRANSPARENT;

    add(bg = new FunkinSprite()).makeSolid(1, 1, FlxColor.BLACK);
    bg.setGraphicSize(1280, 720);
    bg.screenCenter();
    bg.alpha = 0;
    FlxTween.tween(bg, {alpha: 0.92}, .4);

    add(text = new FunkinText(0, 48, 0, '-------- CHOOSE YOUR DIFFICULTY --------', 32, false)).font = Paths.font('simpson.ttf');
    text.alpha = 0;
    text.screenCenter(FlxAxes.X);
    FlxTween.tween(text, {alpha: 1}, .4);

    album = new FunkinSprite(0, -536);
    album.loadSprite(Paths.image('menus/album'));
    album.setGraphicSize(500, 500);
    album.screenCenter(FlxAxes.X);
    album.alpha = 0;
    FlxTween.tween(album, {alpha: 1}, .4);
    add(album);

    add(choices = new FlxTypedGroup());
    for(i => options in options) {
        choices.add(diffs = new FunkinText(0, FlxG.height / 1.23, 0, options, 48, false));
        diffs.font = Paths.font('simpson.ttf');
        diffs.x = 405 + ((diffs.ID = i) * 320);
        diffs.applyMarkup(options, [new FlxTextFormatMarkerPair(new FlxTextFormat(FlxColor.YELLOW), "?"), new FlxTextFormatMarkerPair(new FlxTextFormat(FlxColor.RED), "*")]);
        diffs.alpha = 0.45;
    }
    changeChoice(0);
}

function update() {
    if(controls.BACK) {
        close();
    }

    if(controls.LEFT_P || controls.RIGHT_P) changeChoice(controls.RIGHT_P ? 1 : -1);
    if(controls.ACCEPT) selectChoice();
}

function changeChoice(change:Int = 0) {
    curSelect = FlxMath.wrap(curSelect + change, 0, choices.length - 1);
    CoolUtil.playMenuSFX(0);

    choices.forEach(function(item:FunkinText) {
        if (item.ID == curSelect) {
            item.alpha = 1;
        } else {
            item.alpha = 0.45;
        }
    });
}

function selectChoice() {
    switch(options[curSelect]) {
        case '?Normal?':
            PlayState.loadSong('boogeyman', 'normal');
            FlxG.switchState(new PlayState());
        case '*HARD*':
            PlayState.loadSong('boogeyman', 'hard');
            FlxG.switchState(new PlayState());
    }
}