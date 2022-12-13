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
	"mui/i18n/i18n!km-supervise:*"
	], function(declare, domConstruct,domClass , domStyle , domAttr , ItemBase , util,i18n,locale,util,msg) {
	
	var item = declare("km.supervise.list.item.NotPlanItemMixin", [ItemBase], {
		tag:"div",
		
		baseClass:"lui_asc_item",
		
		href : 'javascript:void(0);',
		
		buildRendering:function(){
			this.inherited(arguments);
			
			this.domNode = this.containerNode= this.srcNodeRef
				|| domConstruct.create(this.tag,{className:this.baseClass});
			
          	//内容
			var contentContainer=this.containerNode;
			//标题
			this.labelNode = domConstruct.create("div",{className:"lui_asc_item_title"},contentContainer);
			domConstruct.create("span",{innerHTML:this.docSubject },this.labelNode);
			//domConstruct.create("span",{innerHTML:this.docSubject },this.labelNode);
			
			//计划时间
			this.planNode = domConstruct.create("div",{className:"lui_asc_item_text"},contentContainer);
			domConstruct.create("span",{innerHTML:msg['mobile.main.plan.time']+"：" },this.planNode);
			var planText = this.fdPlanStartTime + "~" + this.fdPlanEndTime;
			domConstruct.create("span",{innerHTML:planText },this.planNode);
			
			//承办单位
			if(this.fdUnitName){
				this.unitNode = domConstruct.create("div",{className:"lui_asc_item_text"},contentContainer);
				domConstruct.create("span",{innerHTML:msg['kmSuperviseTask.fdUnit']+"："  },this.unitNode);
				domConstruct.create("span",{innerHTML:this.fdUnitName },this.unitNode);
			}
			
			//承办人
			if(this.fdSponsorName){
				this.personNode = domConstruct.create("div",{className:"lui_asc_item_text"},contentContainer);
				domConstruct.create("span",{innerHTML:msg['kmSuperviseTask.fdSponsor']+"：" },this.personNode);
				domConstruct.create("span",{innerHTML:this.fdSponsorName },this.personNode);
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