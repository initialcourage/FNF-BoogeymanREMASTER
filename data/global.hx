import funkin.backend.utils.WindowUtils;
import funkin.backend.system.framerate.Framerate;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.display.Sprite;
import funkin.backend.system.MainState;

var redirectStates:Map<FlxState, String> = [
    TitleState => 'Menu',
    MainMenuState => 'Menu',
    FreeplayState => 'Menu',
];

var counter:TextField;
var format:TextFormat;
var _bg:Sprite;

function new() {
    format = new TextFormat(Paths.getFontName(Paths.font('simpson.ttf')), 18, FlxColor.WHITE);
    Main.instance.addChild(_bg = new Sprite());
    Main.instance.addChild(counter = new TextField()).defaultTextFormat = format;


    _bg.graphics.beginFill(0x000000);
    _bg.graphics.drawRect(0, 0, 100, 100);
    _bg.graphics.endFill();
    _bg.alpha = .5;
    _bg.x = _bg.y = 7;
    counter.x = counter.y = 9;

    MainState.betaWarningShown = false;
}

function update() {
    counter.text = 'FPS: ' + Framerate.fpsCounter.fpsNum.text + ' - RAM: ' + Framerate.memoryCounter.memoryText.text + Framerate.memoryCounter.memoryPeakText.text;
    counter.width = counter.textWidth + 10;
    counter.height = counter.textHeight + 10;
    setSize(counter.width, counter.height);

    if(Framerate.debugMode > 0) counter.visible = _bg.visible = true; else counter.visible = _bg.visible = false;
}

function preStateSwitch() {
    Framerate.fpsCounter.fpsNum.visible = Framerate.fpsCounter.fpsLabel.visible = Framerate.memoryCounter.memoryText.visible = Framerate.memoryCounter.memoryPeakText.visible = Framerate.codenameBuildField.visible = false;
    WindowUtils.winTitle = 'Friday Night Funkin\': Boogeyman Remastered';

    for (redirectState in redirectStates.keys()) {
        if (Std.isOfType(FlxG.game._requestedState, redirectState)) {
            FlxG.game._requestedState = new ModState(redirectStates.get(redirectState));
        }
    }
}

function setSize(width, height) {
    _bg.graphics.clear();
    _bg.graphics.beginFill(0x000000);
    _bg.graphics.drawRect(0, 0, width, height);
    _bg.graphics.endFill();
}

function destroy() {
    Framerate.fpsCounter.fpsNum.visible = Framerate.fpsCounter.fpsLabel.visible = Framerate.memoryCounter.memoryText.visible = Framerate.memoryCounter.memoryPeakText.visible = Framerate.codenameBuildField.visible = true;
    WindowUtils.resetTitle();
    Main.instance.removeChild(counter);
    Main.instance.removeChild(_bg);
    FlxG.game._filters = [];
}