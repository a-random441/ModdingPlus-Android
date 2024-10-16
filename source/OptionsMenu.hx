package;

import Controls.Control;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import ui.FlxVirtualPad;
import options.CustomControlsState;

class OptionsMenu extends MusicBeatState
{
	var selector:FlxText;
	var curSelected:Int = 0;

	var controlsStrings:Array<String> = [];

	private var grpControls:FlxTypedGroup<Alphabet>;

	var _pad:FlxVirtualPad;

	var UP_P:Bool;
	var DOWN_P:Bool;
	var BACK:Bool;
	var ACCEPT:Bool;
	var CONTROLS:Bool;

	override function create()
	{
		var menuBG:FlxSprite = new FlxSprite().loadGraphic('assets/images/menuDesat.png');
		controlsStrings = CoolUtil.coolTextFile('assets/data/controls.txt');
		menuBG.color = 0xFFea71fd;
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = true;
		add(menuBG);

		grpControls = new FlxTypedGroup<Alphabet>();
		add(grpControls);

		for (i in 0...controlsStrings.length)
		{
			if (controlsStrings[i].indexOf('set') != -1)
			{
				var controlLabel:Alphabet = new Alphabet(0, (70 * i) + 30, controlsStrings[i].substring(3) + ': ' + controlsStrings[i + 1], true, false);
				controlLabel.isMenuItem = true;
				controlLabel.targetY = i;
				grpControls.add(controlLabel);
			}
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
		}

		_pad = new FlxVirtualPad(FULL, A_B_C);
		_pad.alpha = 0.75;
		this.add(_pad);

		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		UP_P = _pad.buttonUp.justPressed;
		DOWN_P = _pad.buttonDown.justPressed;
		LEFT = _pad.buttonLeft.pressed;

		#if android
		BACK = _pad.buttonB.justPressed || FlxG.android.justReleased.BACK;
		#else
		BACK = _pad.buttonB.justPressed;
		#end
			
		ACCEPT = _pad.buttonA.justReleased;
		CONTROLS = _pad.buttonC.justPressed;

		if (controls.ACCEPT || ACCEPT)
		{
			changeBinding();
		}

		if (isSettingControl)
			waitingInput();
		else
		{
			if (controls.BACK || BACK)
				LoadingState.loadAndSwitchState(new MainMenuState());
			if (controls.UP_MENU || UP_P)
				changeSelection(-1);
			if (controls.DOWN_MENU || DOWN_P)
				changeSelection(1);
		        if (CONTROLS){
				FlxG.switchState(new CustomControlsState());
			}
		}
	}

	function waitingInput():Void
	{
		if (FlxG.keys.getIsDown().length > 0)
		{
			PlayerSettings.player1.controls.replaceBinding(Control.LEFT || LEFT, Keys, FlxG.keys.getIsDown()[0].ID, null);
		}
		// PlayerSettings.player1.controls.replaceBinding(Control)
	}

	var isSettingControl:Bool = false;

	function changeBinding():Void
	{
		if (!isSettingControl)
		{
			isSettingControl = true;
		}
	}
	function changeSelection(change:Int = 0)
	{

		FlxG.sound.play('assets/sounds/scrollMenu' + TitleState.soundExt, 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = grpControls.length - 1;
		if (curSelected >= grpControls.length)
			curSelected = 0;

		// selector.y = (70 * curSelected) + 30;

		var bullShit:Int = 0;

		for (item in grpControls.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
	}
}
