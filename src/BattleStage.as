package  
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import org.libspark.betweenas3.BetweenAS3;
	import org.libspark.betweenas3.events.TweenEvent;
	import org.libspark.betweenas3.easing.Bounce;
	/**
	 * ...
	 * @author sere
	 */
	public class BattleStage extends MovieClip
	{
		private var console:BattleConsole;
		private var bossGauge:BossGauge;
		private var battleSence:Sprite;
		public static var stageWidth:Number;
		public static var stageHeight:Number;
		
		private var sTime:Number = 10;
		private var aTime:Number = 0;
		private var nTime:Number = 0;
		public var player:Player;
		public var boss:Boss = null;
		private var tamalist:Vector.<Tama>;
		private var enetamalist:Vector.<Tama2>;
		private var enelist:Vector.<Ene>;
		private var effectlist:Array;
		public static var downfg:Boolean = false;
		public static var old_point:Point;
		
		public static var ins:BattleStage;
		public static function getMousePoint():Point { 
			old_point = ( downfg ? new Point( ins.battleSence.mouseX, ins.battleSence.mouseY ) : old_point ); 
			return new Point( old_point.x, old_point.y );
		}
		public function BattleStage() 
		{
			ins = this;
			addEventListener(Event.ADDED_TO_STAGE, adh );
			addEventListener(Event.ENTER_FRAME, ef );
			addEventListener(MouseEvent.MOUSE_DOWN, mh );
			addEventListener(MouseEvent.MOUSE_UP, mh );
			tamalist = new Vector.<Tama>();
			enetamalist = new Vector.<Tama2>();
			enelist = new Vector.<Ene>();
			effectlist = new Array();
			
			battleSence = addChild( new Sprite() ) as Sprite;
			console = addChild( new BattleConsole() ) as BattleConsole;
			player = battleSence.addChild(new Player()) as Player;
		}
		public function adh(e:Event):void 
		{
			stageWidth = stage.stageWidth;
			stageHeight = stage.stageHeight;
			
			player.x = stageWidth / 2;
			player.y = stageHeight - 180;
			
			old_point = new Point( player.x, player.y+60 );
			
			removeEventListener(Event.ADDED_TO_STAGE, adh);
		}
		public function ef(e:Event):void 
		{
			appe();
			shot();
			
			player.move();
			if ( boss != null ) boss.move();
			for each (var t:Tama in tamalist ) t.move();
			for each (var t2:Tama2 in enetamalist ) t2.move();
			for each (var en:Ene in enelist ) en.move();
			for each (var eff:MovieClip in effectlist ) eff.move();
			hit();
			
			player.visible = !player.escapefg;
//			boss.visible = !boss.escapefg;
			removeListObject( tamalist );
			removeListObject( enetamalist );
			removeListObject( enelist );
			removeListObject( effectlist );
		}
		public function hit():void 
		{
			for each (var e:Ene in enelist ) {
				if ( e.escapefg ) continue;
				for each (var t:Tama in tamalist ) {
					if ( t.escapefg ) continue;
					if ( t.hitTestObject( e ) ) {
						t.escapefg = true;
						if ( --e.life <= 0 ) {
							e.escapefg = true;
							console.score += 10;
							setEffect(t,Bakuha);
						}
						else 
							setEffect(t,Hibana);
					}
				}
				
				if ( e.escapefg ) continue;
				if ( player.escapefg ) continue;
				if ( player.hitTestObject( e ) ) {
					if ( --player.life <= 0 ) {
						player.escapefg = true;
						setEffect( player, Bakuha );
					}
					else setEffect( player, Hibana );
					
					if ( --e.life <= 0 ) {
						e.escapefg = true;
						setEffect(e, Bakuha);
					}
					else setEffect(e, Hibana );
					
				}
			}
			
			if ( player.escapefg ) return;
			for each (var t2:Tama2 in enetamalist ) 
			{
				if ( t2.escapefg ) continue;
				if ( t2.hitTestObject( player ) ) {
					t2.escapefg = true;
					if ( --player.life <= 0 ) {
						player.escapefg = true;
						setEffect( player, Bakuha );
					}
					else setEffect( player, Hibana );
				}
			}
			
			if ( boss == null ) return;
			if ( boss.escapefg ) return;
			for each ( t in tamalist ) {
				if ( t.escapefg ) continue;
				if ( boss.hitTestPoint( t.x, t.y, true ) )  {
					t.escapefg = true;
					if ( !boss.muteki_fg )  {
						if ( --boss.life <= 0 ) {
							boss.escapefg = true;
							console.score += 530;
							BetweenAS3.to( boss, { alpha:0 }, 3, Bounce.easeOut );
							setEffect( boss, Bakuha );
						}
						else setEffect( t, Hibana );
					}
				}
			}
			
		}
		public function setEffect(p1:Object,cls:Class):void 
		{
			var eff = new cls();
			eff.x = p1.x;
			eff.y = p1.y;
			
			battleSence.addChild( eff );
			effectlist.push( eff );
		}
		public function appe():void 
		{
			nTime++;
			if ( nTime < 30 * 45 ) {
				if ( ++aTime < 20 ) return;
				else aTime = 0;
				
				var e:Ene = new Ene();
				e.x = Math.floor(Math.random()*(stageWidth-60))+30;
				e.y = -10;
				
				battleSence.addChild(e);
				enelist.push(e);
			}
			else if ( nTime < 30 * 48 )	{
				// BOSS登場待ち
			}
			else if ( nTime == 30 * 48 ) {
				bossGauge = addChild( new BossGauge() ) as BossGauge;
				BetweenAS3.delay( 
					BetweenAS3.tween(bossGauge, { alpha:1 }, { alpha:0 }, 2 ),
				2.25 ).play();
				
				boss = battleSence.addChild( new Boss() ) as Boss;
				bossGauge.setDisp( boss, boss.life, boss.life );
			}
			else {
				// BOSS戦中
			}
			
		}
		public function shot():void 
		{
			if ( player.escapefg ) return;
			if ( !downfg ) return;
			if ( ++sTime < 10 ) return;
			else sTime = 0;
			
			var t:Tama = new Tama();
			t.x = player.x;
			t.y = player.y;
			
			battleSence.addChild(t);
			tamalist.push(t);
		}
		public function setEnetama(t:Tama2):Tama2 
		{
			battleSence.addChild(t);
			enetamalist.push(t);
			return t;
		}
		public function removeListObject(list:Object):void 
		{
			for (var i:int = 0; i < list.length; ( list[i].escapefg ? battleSence.removeChild(list.splice(i, 1)[0]):i++ ) ){};
		}
		public function mh(e:MouseEvent):void 
		{
			downfg = ( e.type == MouseEvent.MOUSE_DOWN ? true:false );
			sTime = ( e.type == MouseEvent.MOUSE_UP ? 10:sTime );
		}
		public function close():void 
		{
			removeEventListener(Event.ENTER_FRAME, ef );
			removeEventListener(MouseEvent.MOUSE_DOWN, mh );
			removeEventListener(MouseEvent.MOUSE_UP, mh );
		}
	}

}