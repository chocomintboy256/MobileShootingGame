package  
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author sere
	 */
	public class Tama extends MovieClip
	{
		public var escapefg:Boolean = false;
		public function Tama() 
		{
			
		}
		public function move():void 
		{
			y -= 20;
			
			if ( y < 0 - 5 ) 
				escapefg = true;
		}
	}

}