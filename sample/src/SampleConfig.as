/**
 * Author: Mk-10:cellfusion
 */
package
{
	import robotlegs.bender.extensions.mediatorMap.api.IStarlingMediatorMap;
	import robotlegs.bender.framework.api.IConfig;

	import starling.display.DisplayObjectContainer;

	public class SampleConfig implements IConfig
	{
		[Inject]
		public var contextView:DisplayObjectContainer;

		[Inject]
		public var mediatorMap:IStarlingMediatorMap;

		public function configure():void
		{
			mediatorMap.map(SampleView).toMediator(SampleMediator);

			contextView.addChild(new SampleView());
		}
	}
}
