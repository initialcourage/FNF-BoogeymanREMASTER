var menuItems:FlxTypedGroup<FunkinSprite>;
var options:Array<FunkinSprite> = ['terminal', 'gadget', 'eli', 'solar'];

var curSelect:Int = 0;

function create() {
    camera = cred = new FlxCamera();
    FlxG.cameras.add(cred, false).bgColor = FlxColor.TRANSPARENT;

    bg = new FunkinSprite();
    bg.makeSolid(1, 1, FlxColor.BLACK);
    bg.setGraphicSize(FlxG.width, FlxG.height);
    bg.screenCenter();
    bg.alpha = 0;
    FlxTween.tween(bg, {alpha: 0.88}, .4);
    add(bg);

    textBG = new FunkinSprite();
    textBG.makeSolid(1, 1, FlxColor.fromRGB(20, 20, 20));
    textBG.setGraphicSize(900, 500);
    textBG.screenCenter();
    textBG.alpha = 0;
    FlxTween.tween(textBG, {alpha: 1}, .4);
    add(textBG);

    add(devText = new FunkinText(0, 150, 0, '--------- DA DEVS!! ---------', 32, false)).font = Paths.font('simpson.ttf');
    devText.antialiasing = Options.antialiasing;
    devText.alpha = 0;
    devText.screenCenter(FlxAxes.X);
    FlxTween.tween(devText, {alpha: 1}, .4);

    add(devName = new FunkinText(0, 230, 0, "", 32, false)).font = Paths.font('simpson.ttf');
    devName.antialiasing = Options.antialiasing;
    devName.alpha = 0;
    FlxTween.tween(devName, {alpha: 1}, .4);

    add(devDesc = new FunkinText(0, 0, 0, "", 32, false)).font = Paths.font('simpson.ttf');
    devDesc.antialiasing = Options.antialiasing;
    devDesc.alpha = 0;
    devDesc.alignment = 'center';
    FlxTween.tween(devDesc, {alpha: 1}, .4);

    add(menuItems = new FlxTypedGroup());
    for(i => options in options) {
        menuItems.add(menuItem = new FunkinSprite());
        menuItem.loadSprite(Paths.image('menus/credits/' + options));
        menuItem.scale.set(0.4, 0.4);
        switch(options) {
            case 'terminal':
                menuItem.x = 80;
                menuItem.y = FlxG.height / 1.96;
            case 'gadget':
                menuItem.x = 350;
                menuItem.y = FlxG.height / 2.1;
            case 'eli':
                menuItem.x = 510;
                menuItem.y = FlxG.height / 2.44;
            case 'solar':
                menuItem.x = 710;
                menuItem.y = FlxG.height / 2.44;
        }
        menuItem.antialiasing = Options.antialiasing;
    }

    changeDev(0);
}

function update() {
    if(controls.BACK) close();
    if(controls.LEFT_P || controls.RIGHT_P) changeDev(controls.LEFT_P ? -1 : 1);
    if(controls.ACCEPT) selectDev();
}

function changeDev(change:Int = 0) {
    curSelect = FlxMath.wrap(curSelect + change, 0, menuItems.length - 1);

    switch(options[curSelect]) {
        case 'terminal':
            devName.text = 'TERMINALANGST:';
            devName.screenCenter(FlxAxes.X);
            devDesc.text = 'Coded everything & made the music.';
            devDesc.screenCenter();
        case 'gadget':
            devName.text = 'GADGETCHROME:';
            devName.screenCenter(FlxAxes.X);
            devDesc.text = 'Drew the Album Cover, the Icons and the Background.';
            devDesc.screenCenter();
        case 'eli':
            devName.text = '[WHOS.ELI]:';
            devName.screenCenter(FlxAxes.X);
            devDesc.text = 'Drew the sprites.';
            devDesc.screenCenter();
        case 'solar':
            devName.text = 'RESURRECTIONSOLAR:';
            devName.screenCenter(FlxAxes.X);
            devDesc.text = 'Charted the song.';
            devDesc.screenCenter();
    }
}

function selectDev() {
    switch(options[curSelect]) {
        case 'terminal':
            CoolUtil.openURL('https://x.com/terminalangst');
        case 'gadget':
            CoolUtil.openURL('https://bsky.app/profile/gadgetchrome.teamorigin.org/');
        case 'eli':
            CoolUtil.openURL('https://x.com/wh0tfiselii');
        case 'solar':
            CoolUtil.openURL('https://x.com/solarresurrect');
    }
}