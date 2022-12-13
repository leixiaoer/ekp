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
	
	var item = declare("km.supervise.list.item.ChangeItemMixin", [ItemBase,OpenProxyMixin], {
		tag:"li",
		
		baseClass:"",
		
		href : 'javascript:void(0);',
		
		buildRendering:function(){
			this.inherited(arguments);
			
			this.domNode = this.containerNode= this.srcNodeRef
				|| domConstruct.create(this.tag,{className:this.baseClass});
			
			this.domNode.dojoClick = true;
			if(this.href){
				this.proxyClick(this.domNode, this.href, '_blank');
			}
			
          	//内容
			var contentContainer=domConstruct.create("div", { className: "lui_asc_item_content"}, this.containerNode);
			//名称
			this.docSubjectNode = domConstruct.create("div",{className:"lui_asc_item_content_title"},contentContainer);
			domConstruct.create("span",{innerHTML:this.docSubject},this.docSubjectNode);
			
			//变更人
			this.personNode = domConstruct.create("div",{className:"lui_asc_item_text"},contentContainer);
			domConstruct.create("span",{innerHTML:msg['kmSuperviseMain.fdChangePerson']+"：" },this.personNode);
			domConstruct.create("span",{innerHTML:this.fdChangePersonName },this.personNode);
			
			//变更时间
			this.timeNode = domConstruct.create("div",{className:"lui_asc_item_text"},contentContainer);
			domConstruct.create("span",{innerHTML:msg['kmSuperviseMain.fdChangeTime']+"：" },this.timeNode);
			domConstruct.create("span",{innerHTML:this.fdChangeTime },this.timeNode);
			
			//变更原因
			this.descNode = domConstruct.create("div",{className:"lui_asc_item_text"},contentContainer);
			domConstruct.create("span",{innerHTML:msg['kmSuperviseMain.fdChangeDesc']+"：" },this.descNode);
			domConstruct.create("span",{innerHTML:this.fdChangeDesc },this.descNode);
			
			//文档状态
			this.docStatusNode = domConstruct.create("div",{className:"lui_asc_item_text"},contentContainer);
			domConstruct.create("span",{innerHTML:msg['kmSuperviseMain.doStatus']+"：" },this.docStatusNode);
			domConstruct.create("span",{innerHTML:this.docStatus },this.docStatusNode);
			
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