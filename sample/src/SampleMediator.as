/**
 * Author: Mk-10:cellfusion
 */
package
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	import robotlegs.bender.bundles.mvcs.Mediator;

	public class SampleMediator extends Mediator
	{
		[Inject]
		public var view:SampleView;

		private var _timer:Timer;
		public function SampleMediator()
		{
			super();

		}

		override public function initialize():void
		{
			trace("SampleMediator", "initialize");
			super.initialize();


			_timer = new Timer(1000, 1);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerCompleted);
			_timer.start();
		}

		override public function postDestroy():void
		{
			trace("SampleMediator", "postDestroy");
			super.postDestroy();

		}

		override public function destroy():void
		{
			trace("SampleMediator", "destroy");
			super.destroy();

		}

		private function timerCompleted(event:TimerEvent):void
		{
			trace("SampleMediator", "timerCompleted");

			view.removeFromParent();
		}
	}
}
