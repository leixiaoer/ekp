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
	"dojo/_base/lang"
	], function(declare, domConstruct,domClass , domStyle , domAttr , ItemBase , util,i18n,locale,lang) {
	
	var item = declare("km.supervise.list.item.InstructionItemMixin", [ItemBase], {
		tag:"div",
		
		baseClass:"lui_asc_item",
		
		href : 'javascript:void(0);',
		
		buildRendering:function(){
			this.inherited(arguments);
			
			this.domNode = this.containerNode= this.srcNodeRef
				|| domConstruct.create(this.tag,{className:this.baseClass});
			
          	//内容
			var contentContainer= this.containerNode;
			
			var item = domConstruct.create("div",{className:"lui_asc_item_img"},contentContainer);
			//头像
			if (this.icon) {
				this.iconNode = domConstruct.create("img",{src: this.icon },item);
			}
			
			this.desc = domConstruct.create("div",{className:"lui_asc_item_desc"},contentContainer);
			//创建者
			this.docCreator = domConstruct.create("div",{},this.desc);
			domConstruct.create("p",{innerHTML:this.docCreatorName},this.docCreator);
			//批示内容
			this.content = domConstruct.create("div",{},this.desc);
			domConstruct.create("p",{innerHTML:this.docContent},this.content);
			//时间
			this.timeNode = domConstruct.create("div",{},this.desc);
			domConstruct.create("p",{innerHTML:this.docCreateTime},this.timeNode);
			if(this.canDel == 'true'){
				var delNode = domConstruct.create("div",{className:"lui_asc_item_delete"},this.timeNode);
				delNode.dojoClick = true;
				this.connect(delNode, 'click', function() {
					delInstruction(this.fdId);
				});
			}
		
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