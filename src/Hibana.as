package  
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author sere
	 */
	public class Hibana extends MovieClip 
	{
		public var initfg:Boolean = false;
		public var escapefg:Boolean = false;
		public function Hibana() { stop(); }
		public function move():void 
		{
			if ( !initfg ) { initfg = true; return; }
			
			nextFrame();
			if ( currentFrame == totalFrames ) 
				escapefg = true;
		}
		
	}

}