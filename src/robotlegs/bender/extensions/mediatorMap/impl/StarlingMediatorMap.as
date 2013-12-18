//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.mediatorMap.impl
{
	import flash.utils.Dictionary;
	
	import robotlegs.bender.extensions.matching.ITypeMatcher;
	import robotlegs.bender.extensions.matching.TypeMatcher;
	import robotlegs.bender.extensions.mediatorMap.api.IStarlingMediatorMap;
	import robotlegs.bender.extensions.mediatorMap.api.IStarlingMediatorViewHandler;
	import robotlegs.bender.extensions.mediatorMap.dsl.IMediatorMapper;
	import robotlegs.bender.extensions.mediatorMap.dsl.IMediatorUnmapper;
	import robotlegs.bender.extensions.viewManager.api.IStarlingViewHandler;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.ILogger;

	import starling.display.DisplayObject;
	
	public class StarlingMediatorMap implements IStarlingMediatorMap, IStarlingViewHandler
	{
		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/
		
		private const _mappers:Dictionary = new Dictionary();
		
		private var _logger:ILogger;

		private var _factory:MediatorFactory;

		private var _viewHandler:IStarlingMediatorViewHandler;

		private const NULL_UNMAPPER:IMediatorUnmapper = new NullMediatorUnmapper();

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/
		
		public function StarlingMediatorMap(context:IContext)
		{
			_logger = context.getLogger(this);
			_factory = new MediatorFactory(context.injector);
			_viewHandler = new StarlingMediatorViewHandler(_factory);
		}
		
		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/
		
		public function mapMatcher(matcher:ITypeMatcher):IMediatorMapper
		{
			return _mappers[matcher.createTypeFilter().descriptor] ||= createMapper(matcher);
		}
		
		public function map(type:Class):IMediatorMapper
		{
			const matcher:ITypeMatcher = new TypeMatcher().allOf(type);
			return mapMatcher(matcher);
		}
		
		public function unmapMatcher(matcher:ITypeMatcher):IMediatorUnmapper
		{
			return _mappers[matcher.createTypeFilter().descriptor] || NULL_UNMAPPER;
		}
		
		public function unmap(type:Class):IMediatorUnmapper
		{
			const matcher:ITypeMatcher = new TypeMatcher().allOf(type);
			return unmapMatcher(matcher);
		}
		
		public function handleView(view:DisplayObject, type:Class):void
		{
			_viewHandler.handleView(view, type);
		}
		
		public function mediate(item:Object):void
		{
			_viewHandler.handleItem(item, item['constructor'] as Class);
		}
		
		public function unmediate(item:Object):void
		{
			_factory.removeMediators(item);
		}

		public function unmediateAll():void
		{
			_factory.removeAllMediators();
		}
		
		/*============================================================================*/
		/* Private Functions                                                          */
		/*============================================================================*/
		
		private function createMapper(matcher:ITypeMatcher, viewType:Class = null):IMediatorMapper
		{
			return new StarlingMediatorMapper(matcher.createTypeFilter(), _viewHandler, _logger);
		}
	}
}