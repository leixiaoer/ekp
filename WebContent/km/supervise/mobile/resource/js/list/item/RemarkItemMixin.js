define([
    "dojo/_base/declare",
    "dojo/dom-construct",
    "dojo/dom-class",
	"dojo/dom-style",
	"dojo/dom-attr",
    "dojox/mobile/_ItemBase",
   	"mui/util",
   	"mui/i18n/i18n",
	"dojo/date/locale",
	"mui/util",
	"mui/openProxyMixin",
	"mui/i18n/i18n!km-supervise:*"
	], function(declare, domConstruct,domClass , domStyle , domAttr , ItemBase , util,i18n,locale,util,OpenProxyMixin,msg) {
	
	var item = declare("km.supervise.list.item.FinishItemMixin", [ItemBase,OpenProxyMixin], {
		tag:"li",
		
		baseClass:"",
		
		href : 'javascript:void(0);',
		
		buildRendering:function(){
			this.inherited(arguments);
			
			this.domNode = this.containerNode= this.srcNodeRef
				|| domConstruct.create(this.tag,{className:this.baseClass});
			
//			this.domNode.dojoClick = true;
//			if(this.remarkHref){
//				this.proxyClick(this.domNode, this.remarkHref, '_blank');
//			}
			
			//内容
			var contentContainer=domConstruct.create("div", { className: "lui_asc_item_content"}, this.containerNode);
			//名称
			this.docSubjectNode = domConstruct.create("div",{className:"lui_asc_item_content_title"},contentContainer);
			domConstruct.create("span",{innerHTML:this.docSubject},this.docSubjectNode);
			
			//考评人
			this.personNode = domConstruct.create("div",{className:"lui_asc_item_text"},contentContainer);
			domConstruct.create("span",{innerHTML:msg['kmSuperviseMain.fdRemarker']+"：" },this.personNode);
			domConstruct.create("span",{innerHTML:this.fdRemarkerName },this.personNode);
			
			//考评时间
			this.timeNode = domConstruct.create("div",{className:"lui_asc_item_text"},contentContainer);
			domConstruct.create("span",{innerHTML:msg['kmSuperviseMain.fdRemarkTime']+"：" },this.timeNode);
			domConstruct.create("span",{innerHTML:this.fdRemarkTime },this.timeNode);
			
			//完成星级
			this.levelNode = domConstruct.create("div",{className:"lui_asc_item_text"},contentContainer);
			domConstruct.create("span",{innerHTML:msg['kmSuperviseMain.fdFinishLevel']+"：" },this.levelNode);
			domConstruct.create("span",{innerHTML:this.fdFinishLevel },this.levelNode);
			
			//评价说明
			this.descNode = domConstruct.create("div",{className:"lui_asc_item_text"},contentContainer);
			domConstruct.create("span",{innerHTML:msg['kmSuperviseMain.fdRemark']+"：" },this.descNode);
			domConstruct.create("span",{innerHTML:this.fdRemark },this.descNode);
			
		},
		
		startup:function(){
			if(this._started){ return; }
			this.inherited(arguments);
		},
	
		_setLabelAttr: function(text){
			if(text)
				this._set("label", text);
		},
		
		userClickAction : function(){
			return false;
		}
		
		
	});
	return item;
});