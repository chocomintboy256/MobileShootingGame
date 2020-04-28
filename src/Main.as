package  
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author sere
	 */
	public class Main extends MovieClip
	{
		public var bStage:BattleStage;
		public var fps:FPS;
		public function Main():void 
		{
			DeviceManager.addEventDeviceDeactive(stage);
			
			bStage = addChild( new BattleStage() ) as BattleStage;
			fps = addChild( new FPS() ) as FPS;
		}
	}

}