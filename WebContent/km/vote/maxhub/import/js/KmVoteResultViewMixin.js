define([
        "dojo/_base/declare",
        'dojo/_base/lang',
        "dojo/_base/array",
        'dojo/parser',
        'dojo/dom-construct',
        'dojo/query',
        "dojox/mobile/TransitionEvent",
        "dojo/text!../tmpl/result.jsp"
	], function(declare, lang, array, parser, domConstruct, query, TransitionEvent, viewTemplate) {
	
	return declare('km.vote.maxhub.KmVoteResultViewMixin', null ,{
		
		_initViewEvent : function(view){
			this.inherited(arguments);
			//查看投票记录
			var resultNode = query('.mhResultNode',view.domNode)[0];
			resultNode && this.connect(resultNode,'click',lang.hitch(this,function(){
				this._openResultView();
			}));
		},
		
		_openResultView : function(){
			var self = this;
			//未初始化,先创建一个view
			if(!this.resultView){
				this.resultViewTemplateString = lang.replace(viewTemplate,{
					title : this.docSubject,
					creator : this.creator,
					expireTime : this.expireTime,
					fdId : this.fdId
				});
				parser.parse(domConstruct.create('div',{ innerHTML : this.resultViewTemplateString },query('#content')[0] ,'last'))
					.then(function(widgetList) {
						array.forEach(widgetList, function(widget, index) {
							if(index == 0){
								self._initResultView(widget);
								self.resultView = widget;
							}
						});
						var opts = {
							transition : 'slide',
							moveTo : self.resultView.id
						};
						self.resultView.show();
						new TransitionEvent(document.body ,  opts ).dispatch();
				});
			}else{
				var opts = {
					transition : 'slide',
					moveTo : this.resultView.id
				};
				self.resultView.show();
				new TransitionEvent(document.body ,  opts ).dispatch();
			}
		},
		
		_initResultView : function(view){
			//返回
			var backNode = query('.mhBackNode',view.domNode)[0];
			backNode && this.connect(backNode,'click',lang.hitch(this,function(){
				this.resultView && this.resultView.hide();
			}));
		}
		
	});
	
})