import funkin.backend.MusicBeatState;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;
import funkin.menus.ModSwitchMenu;
import funkin.editors.EditorPicker;
import funkin.options.OptionsMenu;
import flixel.effects.FlxFlicker;

var options:Array<FunkinText> = ['START', 'OPTIONS', 'CREDITS'];
var menuItems:FlxTypedGroup<FunkinText>;
var curSelect:Int = 0;
var selectedSomethin:Bool = false;

function create() {
    if(FlxG.sound.music == null || FlxG.sound.music != null) CoolUtil.playMenuSong();
    FlxG.cameras.flash(FlxColor.BLACK, .25);
    MusicBeatState.skipTransIn = true;

    barter = new FunkinSprite();
    barter.loadSprite(Paths.image('menus/beegee'));
    add(barter);

    grid = new FlxBackdrop(FlxGridOverlay.createGrid(40, 40, 80, 80, true, FlxColor.fromRGB(80, 80, 80), FlxColor.fromRGB(40, 40, 40)));
    grid.alpha = 0.75;
    grid.velocity.set(25, 0);
    add(grid);

    bg = new FunkinSprite();
    bg.makeSolid(1, 1, FlxColor.BLACK);
    bg.setGraphicSize(600, 600);
    bg.alpha = 0.78;
    bg.screenCenter();
    add(bg);

    logo = new FunkinSprite(0, 100);
    logo.loadSprite(Paths.image('menus/logo'));
    add(logo);

    text = new FunkinText(0, FlxG.height / 1.23, 0, 'Codename Engine BETA (Legacy-0.1.0)\nPress [TAB] to switch Mods.', 24, false);
    text.font = Paths.font('simpson.ttf');
    text.alignment = 'center';
    add(text);

    add(menuItems = new FlxTypedGroup());
    for(i => options in options) {
        menuItems.add(menuItem = new FunkinText(0, 0, 0, options, 48, false));
        menuItem.font = Paths.font('simpson.ttf');
        menuItem.y = 240 + ((menuItem.ID = i) * 135);
        menuItem.screenCenter(FlxAxes.X);
        menuItem.alpha = 0.65;
        menuItem.antialiasing = logo.antialiasing = text.antialiasing = Options.antialiasing;
    }

    changeItem(0);
    text.screenCenter(FlxAxes.X);
    logo.screenCenter(FlxAxes.X);
}

function update() {
    if(controls.SWITCHMOD) {
        persistentUpdate = !(persistentDraw = true);
        openSubState(new ModSwitchMenu());
    }
    
    if(FlxG.keys.justPressed.SEVEN) {
        persistentUpdate = !(persistentDraw = true);
        openSubState(new EditorPicker());
    }

    if(controls.UP_P || controls.DOWN_P) changeItem(controls.DOWN_P ? 1 : -1);
    if(controls.ACCEPT) {
        selectedSomethin = true;
        CoolUtil.playMenuSFX(1);
        
        FlxFlicker.flicker(menuItems.members[curSelect], 1, 0.06, true);
        new FlxTimer().start(1, function() {
            selectItem();
        });
    }
}

function changeItem(change:Int = 0) {
    curSelect = FlxMath.wrap(curSelect + change, 0, menuItems.length - 1);

    CoolUtil.playMenuSFX(0);

    menuItems.forEach(function(item:FunkinText) {
        if(item.ID == curSelect) {
            item.alpha = 1;
            item.color = FlxColor.YELLOW;
        } else {
            item.alpha = 0.65;
            item.color = FlxColor.WHITE;
        }
    });
}

function selectItem() {
    switch(options[curSelect]) {
        case 'START':
            persistentUpdate = !(persistentDraw = true);
            openSubState(new ModSubState('substates/DiffSelect'));
        case 'OPTIONS': FlxG.switchState(new OptionsMenu());
        case 'CREDITS':
            persistentUpdate = !(persistentDraw = true);
            openSubState(new ModSubState('substates/Creds'));
    }
}

function beatHit() {
    logo.scale.set(1.05, 1.05);
    FlxTween.tween(logo.scale, {x: 1, y: 1}, .3);
}