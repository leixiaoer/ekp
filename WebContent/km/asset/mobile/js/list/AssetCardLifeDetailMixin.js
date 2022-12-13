/**资产生命周期 **/
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
	
	return declare("km.asset.AssetCardLifeDetailMixin", null, {
		
		startup:function(){
			this.connect(this.domNode, 'click','openDeatailView');
		},						
		openDeatailView : function(){
			registry.byId("cardLife").set('url',"/km/asset/km_asset_card/kmAssetCard.do?method=getCardLife4pda&cardId="+this.id);
			var opts = {
				transition : 'slide',
				moveTo:'basicInfoView'
			};
			new TransitionEvent(this.personMoreNode || document.body ,  opts ).dispatch();
			registry.byId("cardLife").reload();
		}
	});
});