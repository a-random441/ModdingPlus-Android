package;

import flixel.FlxGame;
import openfl.display.FPS;
import openfl.display.Sprite;
#if typebuild
import plugins.ExamplePlugin;
import plugins.ExamplePlugin.ExampleCharPlugin;
#end
class Main extends Sprite
{
	var gameWidth:Int = 1280; // Width of the game in pixels (might be less / more in actual pixels depending on your zoom).
	var gameHeight:Int = 720; // Height of the game in pixels (might be less / more in actual pixels depending on your zoom).
	
	#if sys
	public static var cwd:String;
	#end
	public function new()
	{
		#if typebuild
			// god is dead
			ExamplePlugin;
			ExampleCharPlugin;
		#end
		super();
		SUtil.uncaughtErrorHandler();
		SUtil.saveContent("idk", ".txt", "lololol");
		#if sys
		cwd = SUtil.getStorageDirectory();
		#end
		SUtil.checkFiles();
		addChild(new FlxGame(0, 0, TitleState, 1, gameWidth, gameHeight, OptionsHandler.options.fpsCap, OptionsHandler.options.fpsCap, true));
		//#if !mobile
		addChild(new FPS(10, 3, 0xFFFFFF));
		addChild(new MemoryCounter(10, 3, 0xFFFFFF));
		//#end
	}
}
