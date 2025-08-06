import flixel.util.FlxStringUtil;
import flixel.ui.FlxBar;
import flixel.ui.FlxBarFillDirection;

var ratings:Array<Dynamic> = [['D', 0.5], ['C', 0.8], ['B', 0.85], ['A', 0.9], ['S', 1], ['S+', 1]];
PauseSubState.script = 'data/scripts/pause';

function postCreate() {
    accuracyTxt.visible = missesTxt.visible = scoreTxt.visible = false;
    healthBar.createFilledBar(FlxColor.RED, FlxColor.LIME);
    healthBar.percent = health;

    iconP1.setIcon('bart');
    iconP2.setIcon('homer');
    doIconBop = false;

    add(stats = new FunkinText(0, healthBar.y - 35, 0, 'SCORE: ???', 24, false)).font = Paths.font('simpson.ttf');
    stats.camera = camHUD;
    add(stats);

    timerBar = new FlxBar(0, FlxG.height / 60, FlxBarFillDirection.LEFT_TO_RIGHT, 510, 24);
    timerBar.createFilledBar(FlxColor.BLACK, FlxColor.YELLOW);
    timerBar.setRange(0, inst.length);
    timerBar.numDivisions = inst.length;
    timerBar.camera = camHUD;
    timerBar.screenCenter(FlxAxes.X);
    add(timerBar);

    add(timer = new FunkinText(0, timerBar.y - 5, 0, SONG.meta.displayName + ' - X:XX', 25, true)).font = Paths.font('simpson.ttf');
    timer.camera = camHUD;
    timer.borderSize = 1.5;

    timer.antialiasing = stats.antialiasing = Options.antialiasing;
}

function postUpdate() {
    get_stats();
    timerBar.value = inst.time;

    if(curBeat > -1) timer.text = SONG.meta.displayName + ' - ' + FlxStringUtil.formatTime(Conductor.songPosition / 1000, false);
    timer.screenCenter(FlxAxes.X);
}

function get_stats() {
    var rating = get_rating(accuracy);
    var acc = (FlxMath.roundDecimal(accuracy * 100, 2) == -100 ? '?%' : FlxMath.roundDecimal(accuracy * 100, 2) + '%');

    if(Options.ghostTapping) stats.text = 'Score: ' + songScore + ' | Misses: ' + misses + ' | Accuracy: ' + acc + ' [' + rating + ']'; else stats.text = 'Score: ' + songScore + ' | Combo Breaks: ' + misses + ' | Accuracy: ' + acc + ' [' + rating + ']';
    stats.screenCenter(FlxAxes.X);
}

function get_rating(accuracy:Float) {
    // haiii yasher!! :3
    if(accuracy < 0) return 'N/A';
    for (rating in ratings) if (accuracy < rating[1]) return rating[0];
    return ratings[ratings.length - 1][0];
}