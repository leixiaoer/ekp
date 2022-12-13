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
	"mui/openProxyMixin"
	], function(declare, domConstruct,domClass , domStyle , domAttr , ItemBase , util,i18n,locale,util,OpenProxyMixin) {
	
	var item = declare("km.supervise.list.item.ApprovalItemMixin", [ItemBase,OpenProxyMixin], {
		tag:"div",
		
		baseClass:"supervision-approva-box",
		
		href : 'javascript:void(0);',
		
		buildRendering:function(){
			this.inherited(arguments);
			
			this.domNode = this.containerNode= this.srcNodeRef
				|| domConstruct.create(this.tag,{className:this.baseClass});
			
			this.domNode.dojoClick = true;
			if(this.href){
				this.proxyClick(this.domNode, this.href, '_blank');
			}
			
			//右侧内容
			var contentContainer=this.containerNode;
			this.cardNode = domConstruct.create("div",{className:"supervision-card"},contentContainer);
			this.topNode = domConstruct.create("p",{className:"supervision-card-top",innerHTML:this.docSubject},this.cardNode);
			this.bottomNode = domConstruct.create("div",{className:"supervision-card-bottom"},this.cardNode);
			domConstruct.create("span",{innerHTML:this.fdType},this.bottomNode);//类型
			domConstruct.create("span",{innerHTML:this.docCreator},this.bottomNode);//创建人
			domConstruct.create("span",{innerHTML:this.docCreateTime},this.bottomNode);//创建时间
			
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