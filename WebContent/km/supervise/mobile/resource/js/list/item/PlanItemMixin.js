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
	
	var item = declare("km.supervise.list.item.PlanItemMixin", [ItemBase,OpenProxyMixin], {
		tag:"div",
		
		baseClass:"lui_asc_item",
		
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
			var contentContainer=this.containerNode;
			progressContainer=domConstruct.create("div", { className: "progress"}, contentContainer);
			//标题
			this.labelNode = domConstruct.create("div",{className:"lui_asc_item_title"},contentContainer);
			domConstruct.create("span",{innerHTML:this.docSubject },this.labelNode);
			//domConstruct.create("span",{innerHTML:this.docSubject },this.labelNode);
			
			//计划时间
			this.planNode = domConstruct.create("div",{className:"lui_asc_item_text"},contentContainer);
			domConstruct.create("span",{innerHTML:"计划时间：" },this.planNode);
			var planText = this.fdPlanStartTime + "~" + this.fdPlanEndTime;
			domConstruct.create("span",{innerHTML:planText },this.planNode);
			
			//承办单位
			this.unitNode = domConstruct.create("div",{className:"lui_asc_item_text"},contentContainer);
			domConstruct.create("span",{innerHTML:"承办单位：" },this.unitNode);
			domConstruct.create("span",{innerHTML:this.fdUnitName },this.unitNode);
			
			//承办人
			this.personNode = domConstruct.create("div",{className:"lui_asc_item_text"},contentContainer);
			domConstruct.create("span",{innerHTML:"承办人：" },this.personNode);
			domConstruct.create("span",{innerHTML:this.fdSponsorName },this.personNode);
			
			//进度
			this._buildProgress(this.fdTaskProgress,progressContainer);
			
		},
		
		startup:function(){
			if(this._started){ return; }
			this.inherited(arguments);
		},
		
		_buildProgress:function(progress,containerNode){
			if(progress == null || progress == ""){
				progress = "0";
			}
			progress=progress.replace('%','');
			//角度=360度*progress/100
			var deg=(18*parseInt(progress)/5);
			var pie_left=domConstruct.create("div",{className:"pie_left"},containerNode);
			var left=domConstruct.create("div",{className:"left"},pie_left);
			if(deg > 180){
				var _deg=deg-180;
				domStyle.set(left,'transform','rotate('+_deg+'deg)');
				domStyle.set(left,'-webkit-transform','rotate('+_deg+'deg)');
			}
			var pie_right=domConstruct.create("div",{className:"pie_right"},containerNode);
			var right=domConstruct.create("div",{className:"right"},pie_right);
			if(deg < 180){
				domStyle.set(right,'transform','rotate('+deg+'deg)');
				domStyle.set(right,'-webkit-transform','rotate('+deg+'deg)');
			}else{
				domStyle.set(right,'transform','rotate(180deg)');
				domStyle.set(right,'-webkit-transform','rotate(180deg)');
			}
			var mask=domConstruct.create("div",{className:"mask",innerHTML:'%'},containerNode);
			var span=domConstruct.create("span",{innerHTML:progress});
			domConstruct.place(span,mask,'first');
			
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