package  
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author sere
	 */
	public class Math2
	{
		public static function getAngle(p1:Object,p2:Object):Number { return Math.atan2((p2.y - p1.y),(p2.x - p1.x)); }
		public static function getRange(p1:Object,p2:Object):Number { return Math.sqrt( Math.pow(p2.y-p1.y,2) + Math.pow(p2.x-p1.x,2) ); }
	}

}