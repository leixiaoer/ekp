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
	"mui/util","mui/i18n/i18n!km-supervise:*",
	"mui/openProxyMixin"
	], function(declare, domConstruct,domClass , domStyle , domAttr , ItemBase , util,i18n,locale,util,Msg,OpenProxyMixin) {
	
	var item = declare("km.supervise.list.item.ManageAndChargeItemMixin", [ItemBase,OpenProxyMixin], {
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
			var contentContainer = this.containerNode;
			var rightContainer = domConstruct.create("div",{className:""},contentContainer);
			var leftContainer = domConstruct.create("div",{className:""},contentContainer);
			
			//标题
			this.labelNode = domConstruct.create("div",{className:"lui_asc_item_title"},leftContainer);
			if(this.docStatusNew == "00" || this.docStatusNew == "10" || this.docStatusNew == "20"){
				var subjectNode = domConstruct.create("span",{className:"lui_asc_item_subject"},this.labelNode);
				if(this.status){
					subjectNode.appendChild(domConstruct.toDom(this.status));
				}
				if(this.docSubject){
					subjectNode.appendChild(domConstruct.toDom(this.docSubject));
				}
			}else{
				this.subject = domConstruct.create("span",{className:"lui_asc_item_subject",innerHTML:this.docSubject },this.labelNode);
			}

			var bottomNode = domConstruct.create("div",{className:"lui_asc_info_box"},contentContainer);
			var UlNode = domConstruct.create("ul",{className:""},bottomNode);
			
			//主办单位
			this.unitNode = domConstruct.create("li",{className:"lui_asc_item_text"},UlNode);
			domConstruct.create("span",{innerHTML:Msg['kmSuperviseMain.fdSysUnit']+"："},this.unitNode);
			domConstruct.create("span",{innerHTML:this.fdSysUnitName },this.unitNode);
			
			//负责人
			this.sponsorNode = domConstruct.create("li",{className:"lui_asc_item_text"},UlNode);
			domConstruct.create("span",{innerHTML:Msg['kmSuperviseMain.fdSponsor']+"："},this.sponsorNode);
			domConstruct.create("span",{innerHTML:this.fdSponsor },this.sponsorNode);
			
			//计划时间
			this.planNode = domConstruct.create("li",{className:"lui_asc_item_text"},UlNode);
			domConstruct.create("span",{innerHTML:Msg['mobile.main.plan.time']+"：" },this.planNode);
			var planText = this.fdStartTime + "~" + this.fdFinishTime;
			domConstruct.create("span",{innerHTML:planText },this.planNode);
			
			//状态
			if(this.fdStatusNew){
				if(this.fdStatusNew == "20"){//即将超期
					domConstruct.create("span",{className:"lui_asc_item_notice warning",innerHTML:this.fdStatusNewText},bottomNode);
				}else if(this.fdStatusNew == "30"){//已超期
					domConstruct.create("span",{className:"lui_asc_item_notice warning",innerHTML:this.fdStatusNewText},bottomNode);
				}else{
					domConstruct.create("span",{className:"lui_asc_item_notice",innerHTML:this.fdStatusNewText },bottomNode);
				}
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