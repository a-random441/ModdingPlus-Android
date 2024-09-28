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
	var zoom:Float = -1; // If -1, zoom is automatically calculated to fit the window dimensions.
	
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
		addChild(new FlxGame(0, 0, TitleState, 1, gameWidth, gameHeight, zoom, OptionsHandler.options.fpsCap, OptionsHandler.options.fpsCap, true));
		//#if !mobile
		addChild(new FPS(10, 3, 0xFFFFFF));
		addChild(new MemoryCounter(10, 3, 0xFFFFFF));
		//#end
	}
        private function setupGame():Void
	{
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;

		if (zoom == -1)
		{
			var ratioX:Float = stageWidth / gameWidth;
			var ratioY:Float = stageHeight / gameHeight;
			zoom = Math.min(ratioX, ratioY);
			gameWidth = Math.ceil(stageWidth / zoom);
			gameHeight = Math.ceil(stageHeight / zoom);
		}
}
