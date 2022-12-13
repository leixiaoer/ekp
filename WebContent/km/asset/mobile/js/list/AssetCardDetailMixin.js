/**资产查看更多详情 **/
define([
    "dojo/_base/declare", 
    "dojo/_base/array",
    "dojo/text!../tmpl/cardlife.html",
    'dojo/dom-construct',
    "dojox/mobile/TransitionEvent",
    'dojo/parser',
    'dijit/registry',
    'dojo/_base/lang',
    'dojo/query'
    ],function(declare,array,detailTemplate,domConstruct,TransitionEvent,parser,registry,lang,query){
	
	return declare("km.asset.AssetCardDetailMixin", null, {
		
		startup:function(){
			this.connect(this.domNode, 'click','openDeatailView');
		},						
		openDeatailView : function(){
			var opts = {
				transition : 'slide',
				moveTo:'cardDetailInfoView'
			};
			new TransitionEvent(this.personMoreNode || document.body ,  opts ).dispatch();
		}
	});
});