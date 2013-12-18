//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.mediatorMap
{
	import org.swiftsuspenders.Injector;
	
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorFactory;
	import robotlegs.bender.extensions.mediatorMap.api.IStarlingMediatorMap;
	import robotlegs.bender.extensions.mediatorMap.api.IStarlingMediatorMap;
	import robotlegs.bender.extensions.mediatorMap.impl.MediatorFactory;
	import robotlegs.bender.extensions.mediatorMap.impl.StarlingMediatorManager;
	import robotlegs.bender.extensions.mediatorMap.impl.StarlingMediatorMap;
	import robotlegs.bender.extensions.viewManager.api.IStarlingViewHandler;
	import robotlegs.bender.extensions.viewManager.api.IStarlingViewManager;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.IExtension;
	import robotlegs.bender.framework.api.IInjector;

	public class StarlingMediatorMapExtension implements IExtension
	{

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private var _injector:IInjector;

		private var _mediatorMap:StarlingMediatorMap;

		private var _viewManager:IStarlingViewManager;


		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		public function extend(context:IContext):void
		{
			context.beforeInitializing(beforeInitializing)
					.beforeDestroying(beforeDestroying)
					.whenDestroying(whenDestroying);

			_injector = context.injector;
			_injector.map(IStarlingMediatorMap).toSingleton(StarlingMediatorMap);
		}

		/*============================================================================*/
		/* Private Functions                                                          */
		/*============================================================================*/

		private function beforeInitializing():void
		{
			_mediatorMap = _injector.getInstance(IStarlingMediatorMap);
			if (_injector.satisfiesDirectly(IStarlingViewManager))
			{
				_viewManager = _injector.getInstance(IStarlingViewManager);
				_viewManager.addViewHandler(_mediatorMap);
			}
		}

		private function beforeDestroying():void
		{
			_mediatorMap.unmediateAll();
			if (_injector.satisfiesDirectly(IStarlingViewManager))
			{
				_viewManager = _injector.getInstance(IStarlingViewManager);
				_viewManager.removeViewHandler(_mediatorMap);
			}
		}

		private function whenDestroying():void
		{
			if (_injector.satisfiesDirectly(IStarlingMediatorMap))
			{
				_injector.unmap(IStarlingMediatorMap);
			}
		}
	}
}
