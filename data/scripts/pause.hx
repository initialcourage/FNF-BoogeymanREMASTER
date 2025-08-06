import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;
import funkin.backend.utils.FunkinParentDisabler;
import funkin.options.OptionsMenu;
import funkin.options.keybinds.KeybindsOptions;

var disabler:FunkinParentDisabler;
var menuItems:FlxTypedGroup<FunkinText>;
var options:Array<FunkinText> = ['CONTINUE', 'RESTART LEVEL', 'MODIFY KEYBINDS', 'OPTIONS', 'QUIT TO MAIN MENU'];
var curSelect:Int = 0;

function create(_) {
    _.cancel();
    camera = pause = new FlxCamera();
    FlxG.cameras.add(pause, false).bgColor = FlxColor.TRANSPARENT;

    add(disabler = new FunkinParentDisabler());
    bg = new FunkinSprite();
    bg.makeSolid(1, 1, FlxColor.BLACK);
    bg.setGraphicSize(FlxG.width, FlxG.height);
    bg.screenCenter();
    bg.alpha = 0.75;
    add(bg);

    add(itemBG = new FunkinSprite(160, 100)).loadSprite(Paths.image('menus/menuItemBG'));
    itemBG.scale.set(0.86, 0.86);
    itemBG.antialiasing = Options.antialiasing;

    text = new FunkinText(0, 100, 0, 'PAUSE MENU', 32, true);
    text.font = Paths.font('boulder.ttf');
    text.borderSize = 2.3;
    text.screenCenter(FlxAxes.X);
    add(text);

    add(menuItems = new FlxTypedGroup());
    for(i => options in options) {
        menuItems.add(menuItem = new FunkinText(0, 0, 0, options, 42, true));
        menuItem.y = 200 + ((menuItem.ID = i) * 50);
        menuItem.font = Paths.font('boulder.ttf');
        menuItem.borderSize = 2.3;
        menuItem.antialiasing = text.antialiasing = Options.antialiasing;

        menuItem.screenCenter(FlxAxes.X);
    }

    objective = new FunkinText(360, FlxG.height / 1.25, 0, 'I AM GOMERING IT', 24, true);
    objective.color = FlxColor.YELLOW;
    objective.font = Paths.font('quantico.ttf');
    add(objective);
    changeItem(0);
}

function update() {
    if(controls.BACK) close();
    if(controls.UP_P || controls.DOWN_P) changeItem(controls.DOWN_P ? 1 : -1);
    if(controls.ACCEPT) selectItem();
}

function changeItem(change:Int = 0) {
    curSelect = FlxMath.wrap(curSelect + change, 0, menuItems.length - 1);

    menuItems.forEach(function(item:FunkinText) {
        if (item.ID == curSelect) item.color = FlxColor.YELLOW; else item.color = FlxColor.WHITE;
    });
}

function selectItem() {
    switch(options[curSelect]) {
        case 'CONTINUE': close();
        case 'RESTART LEVEL': restartSong();
        case 'MODIFY KEYBINDS': openSubState(new KeybindsOptions());
        case 'OPTIONS': FlxG.switchState(new OptionsMenu());
        case 'QUIT TO MAIN MENU': FlxG.switchState(new MainMenuState());
    }
}

function restartSong() {
    parentDisabler.reset();
    game.registerSmoothTransition();
    FlxG.resetState();
}