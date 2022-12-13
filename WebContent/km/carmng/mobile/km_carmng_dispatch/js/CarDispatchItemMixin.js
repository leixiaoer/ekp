define([
    "dojo/_base/declare",
    "dojo/dom-construct",
    "dojo/dom-class",
	"dojo/dom-style",
	"dojo/dom-attr",
    "dojox/mobile/_ItemBase",
   	"mui/util",
   	"sys/mportal/mobile/OpenProxyMixin" ,
   	"mui/i18n/i18n!km-carmng"
	], function(declare, domConstruct,domClass , domStyle , domAttr , ItemBase , util, OpenProxyMixin,carmngMsg) {
	var item = declare("km.carmng.list.item.ProcessItemMixin", [ItemBase, OpenProxyMixin], {
		tag:"li",

		baseClass:"muiProcessItem muiListItemCard",
		
		buildRendering:function(){
			this.domNode = this.containerNode = this.srcNodeRef || domConstruct.create(this.tag,{className:'muiCarList'});
			this.contentNode = domConstruct.create('a', {}, this.domNode);
			this.inherited(arguments);
			this.buildInternalRender(); 	
		},
		buildInternalRender : function() {
			if(this.href){
				this.proxyClick(this.contentNode, this.href, '_blank');
			}
			var TopNode = domConstruct.create("div",{className:"muiCarListContentTop muiFontSizeM "},this.contentNode);
			domConstruct.create("div",{className:"muiCarListContentTopTitle",innerHTML:this.label},TopNode);
			
			var bottomNode = domConstruct.create("div",{className:"muiCarListContentBottom muiFontSizeS muiFontColorMuted"},this.contentNode);
			domConstruct.create("span",{innerHTML:"申请人："+this.creator},bottomNode);
			domConstruct.create("span",{innerHTML:"随车人数："+this.fdUserNumber+"人"},bottomNode);
			domConstruct.create("span",{innerHTML:"提交时间："+this.created},bottomNode);
			var UseCarTimeText = carmngMsg['mui.kmCarmngApplication.fdUseTime']+"："+this.fdStartTime+" "+carmngMsg['mui.kmCarmng.message.title0']+" "+this.fdEndTime;
			domConstruct.create("span",{innerHTML:UseCarTimeText},bottomNode);
		},
		startup:function(){
			if(this._started){ return; }
			this.inherited(arguments);
		},
	
		_setLabelAttr: function(text){
			if(text)
				this._set("label", text);
		},
		_onDispatcher :function(evt){
			evt.stopEvent();
		}
	});
	return item;
});