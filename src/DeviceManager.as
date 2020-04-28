package  
{
	/**
	 * ...
	 * @author sere
	 */
	import flash.desktop.NativeApplication;
	import flash.display.Stage;
	import flash.events.Event;
	public class DeviceManager 
	{
		public static function addEventDeviceDeactive(stage:Stage):void 
		{
			stage.addEventListener( Event.DEACTIVATE, deactive_handler );
		}
		//
		// バックキーを押すなどしてアプリケーションがアクティビティではなくなった時に実行
		private static function deactive_handler(e:Event):void 
		{
			NativeApplication.nativeApplication.exit();    //アプリの終了
		}
		
	}

}