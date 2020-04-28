package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author sere
	 */
	public class Bakuha extends MovieClip 
	{
		public var initfg:Boolean = false;
		public var escapefg:Boolean = false;
		public function Bakuha() { stop(); }
		public function move():void 
		{
			if ( !initfg ) { initfg = true; return; }
			
			nextFrame();
			if ( currentFrame == totalFrames ) 
				escapefg = true;
		}
		
	}

}