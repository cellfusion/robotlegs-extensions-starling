//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.mediatorMap.impl
{
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;

	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMapping;
	
	import starling.display.DisplayObject;
	import starling.events.Event;

	public class StarlingMediatorManager
	{

		/*============================================================================*/
		/* Private Static Properties                                                  */
		/*============================================================================*/

		private static var UIComponentClass:Class;

		private static const flexAvailable:Boolean = checkFlex();

		private static const CREATION_COMPLETE:String = "creationComplete";

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private const _mappings:Dictionary = new Dictionary();

		private var _factory:StarlingMediatorFactory;

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		public function StarlingMediatorManager(factory:StarlingMediatorFactory)
		{
			_factory = factory;
		}

		/*============================================================================*/
		/* Private Static Functions                                                   */
		/*============================================================================*/

		private static function checkFlex():Boolean
		{
			try
			{
				UIComponentClass = getDefinitionByName('mx.core::UIComponent') as Class;
			}
			catch (error:Error)
			{
				// do nothing
			}
			return UIComponentClass != null;
		}



		public function addMediator(mediator:Object, item:Object, mapping:StarlingMediatorMapping):void
		{
			const displayObject:DisplayObject = item as DisplayObject;

			if (!displayObject) {
				initializeMediator(mediator, item);
				return;
			}

			if (mapping.autoRemoveEnabled)
			{
				// Watch this view for removal
				displayObject.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			}

			if (flexAvailable && (displayObject is UIComponentClass) && !displayObject['initialized'])
			{
				displayObject.addEventListener(CREATION_COMPLETE, function(e:Event):void
				{
					displayObject.removeEventListener(CREATION_COMPLETE, arguments.callee);
					// ensure that we haven't been removed in the meantime
					if (_factory.getMediator(displayObject, mapping))
						initializeMediator(mediator, displayObject);
				});
			}
			else
			{
				initializeMediator(mediator, displayObject);
			}

		}

		public function removeMediator(mediator:Object, item:Object, mapping:IMediatorMapping):void
		{
			const displayObject:DisplayObject = item as DisplayObject;

			if (displayObject)
				displayObject.removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);

			if (mediator)
				destroyMediator(mediator);
		}

		/*============================================================================*/
		/* Private Functions                                                          */
		/*============================================================================*/

		private function onRemovedFromStage(event:Event):void
		{
			_factory.removeMediators(event.target);
		}

		private function initializeMediator(mediator:Object, mediatedItem:Object):void
		{
			if ('preInitialize' in mediator)
				mediator.preInitialize();

			if ('viewComponent' in mediator)
				mediator.viewComponent = mediatedItem;

			if ('initialize' in mediator)
				mediator.initialize();

			if ('postInitialize' in mediator)
				mediator.postInitialize();
		}

		private function destroyMediator(mediator:Object):void
		{
			if ('preDestroy' in mediator)
				mediator.preDestroy();

			if ('destroy' in mediator)
				mediator.destroy();

			if ('viewComponent' in mediator)
				mediator.viewComponent = null;

			if ('postDestroy' in mediator)
				mediator.postDestroy();
		}
	}
}
