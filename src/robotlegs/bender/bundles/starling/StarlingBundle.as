package robotlegs.bender.bundles.starling
{

	import robotlegs.bender.bundles.shared.configs.StarlingContextViewListenerConfig;
	import robotlegs.bender.extensions.contextView.StarlingContextViewExtension;
	import robotlegs.bender.extensions.contextView.StarlingStageSyncExtension;
	import robotlegs.bender.extensions.directCommandMap.DirectCommandMapExtension;
	import robotlegs.bender.extensions.enhancedLogging.InjectableLoggerExtension;
	import robotlegs.bender.extensions.enhancedLogging.TraceLoggingExtension;
	import robotlegs.bender.extensions.eventCommandMap.EventCommandMapExtension;
	import robotlegs.bender.extensions.eventDispatcher.EventDispatcherExtension;
	import robotlegs.bender.extensions.localEventMap.LocalEventMapExtension;
	import robotlegs.bender.extensions.mediatorMap.StarlingMediatorMapExtension;
	import robotlegs.bender.extensions.modularity.StarlingModularityExtension;
	import robotlegs.bender.extensions.viewManager.ManualStarlingStageObserverExtension;
	import robotlegs.bender.extensions.viewManager.StarlingStageObserverExtension;
	import robotlegs.bender.extensions.viewManager.StarlingViewManagerExtension;
	import robotlegs.bender.extensions.vigilance.VigilanceExtension;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.IExtension;

	public class StarlingBundle implements IExtension
	{
		public function extend(context:IContext):void
		{
			context.install(
				TraceLoggingExtension,
				VigilanceExtension,
				InjectableLoggerExtension,
				StarlingContextViewExtension,
				EventDispatcherExtension,
				StarlingModularityExtension,
				StarlingStageSyncExtension,
				DirectCommandMapExtension,
				EventCommandMapExtension,
				LocalEventMapExtension,
				StarlingViewManagerExtension,
				StarlingStageObserverExtension,
				ManualStarlingStageObserverExtension,
				StarlingMediatorMapExtension);

			context.configure(StarlingContextViewListenerConfig);
		}
	}
}