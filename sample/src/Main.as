package
{

	import flash.display.Sprite;
	import flash.text.TextField;

	import robotlegs.bender.bundles.starling.StarlingBundle;
	import robotlegs.bender.framework.api.IContext;

	import robotlegs.bender.framework.impl.Context;

	import starling.core.Starling;
	import starling.events.Event;

	public class Main extends Sprite
	{
		private var _starling:Starling;
		private var _context:IContext;
		public function Main()
		{
			_starling = new Starling(MainView, stage);
			_starling.addEventListener(Event.ROOT_CREATED, starlingReady);
			_starling.start();
		}

		private function starlingReady(event:Event):void
		{
			_context = new Context().install(StarlingBundle).configure(SampleConfig, _starling.stage);
		}
	}
}
