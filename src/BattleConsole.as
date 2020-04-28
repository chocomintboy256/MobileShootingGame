package  
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	/**
	 * ...
	 * @author sere
	 */
	public class BattleConsole extends MovieClip
	{
		public var score_txt:TextField;
		public function BattleConsole() { score = 0; }
		public function get score():Number { return Number( score_txt.text ); }
		public function set score(s:Number):void { score_txt.text = s.toString(); }
	}

}