/**资产查看更多详情 **/
define([
    "dojo/_base/declare", 
    "dojo/_base/array",
    'dojo/dom-construct',
    "dojox/mobile/TransitionEvent",
    'dojo/parser',
    'dijit/registry',
    'dojo/_base/lang',
    'dojo/query'
    ],function(declare,array,detailTemplate,domConstruct,TransitionEvent,parser,registry,lang,query){
	
	return declare("km.carmng.CarDispatchInfoMixin", null, {
		
		startup:function(){
			this.connect(this.domNode, 'click','openDispatchInfolView');
		},						
		openDispatchInfolView : function(){
			var opts = {
				transition : 'slide',
				moveTo:'cardDispatchInfoView'
			};
			new TransitionEvent(this.personMoreNode || document.body ,  opts ).dispatch();
		}
	});
});