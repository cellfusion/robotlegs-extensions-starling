//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.mediatorMap.impl
{
	import robotlegs.bender.extensions.matching.ITypeFilter;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMapping;
	import robotlegs.bender.extensions.mediatorMap.dsl.IMediatorConfigurator;
	
	public class StarlingMediatorMapping implements IMediatorMapping, IMediatorConfigurator
	{
		
		/*============================================================================*/
		/* Public Properties                                                          */
		/*============================================================================*/
		
		private var _matcher:ITypeFilter;
		
		public function get matcher():ITypeFilter
		{
			return _matcher;
		}
		
		private var _mediatorClass:Class;
		
		public function get mediatorClass():Class
		{
			return _mediatorClass;
		}
		
		private var _guards:Array = [];
		
		public function get guards():Array
		{
			return _guards;
		}
		
		private var _hooks:Array = [];
		
		public function get hooks():Array
		{
			return _hooks;
		}

		private var _autoRemoveEnabled:Boolean = true;

		public function get autoRemoveEnabled():Boolean
		{
			return _autoRemoveEnabled;
		}
		
		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/
		
		public function StarlingMediatorMapping(matcher:ITypeFilter, mediatorClass:Class)
		{
			_matcher = matcher;
			_mediatorClass = mediatorClass;
		}
		
		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/
		
		public function withGuards(... guards):IMediatorConfigurator
		{
			_guards = _guards.concat.apply(null, guards);
			return this;
		}
		
		public function withHooks(... hooks):IMediatorConfigurator
		{
			_hooks = _hooks.concat.apply(null, hooks);
			return this;
		}

		public function autoRemove(value:Boolean = true):IMediatorConfigurator
		{
			_autoRemoveEnabled = value;
			return this;
		}
	}
}