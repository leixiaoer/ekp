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
	
	var item = declare("km.supervise.list.item.BackItemMixin", [ItemBase,OpenProxyMixin], {
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
			
			//反馈时间
			this.labelNode = domConstruct.create("div",{className:"lui_asc_item_title"},contentContainer);
			this.subject = domConstruct.create("span",{innerHTML:this.fdFeedbackTime },this.labelNode);
			//进度
			var fdStatus = this.fdStatus;
			if(fdStatus == "2"){
				domConstruct.create("div",{className:"lui_asc_item_notice",innerHTML:msg['enums.back.status.finish']},this.labelNode);
			}else{
				domConstruct.create("div",{className:"lui_asc_item_notice",innerHTML:msg['kmSuperviseTask.fdTaskProgress']+this.fdProgress+"%"},this.labelNode);
			}
          
			//反馈人
			this.personNode = domConstruct.create("div",{className:"lui_asc_item_text"},contentContainer);
			domConstruct.create("span",{innerHTML:msg['kmSuperviseBack.fdPerson']+"：" },this.personNode);
			domConstruct.create("span",{innerHTML:this.fdPersonName },this.personNode);
			
			//反馈部门
			this.unitNode = domConstruct.create("div",{className:"lui_asc_item_text"},contentContainer);
			domConstruct.create("span",{innerHTML:msg['kmSuperviseMain.fdSysUnit']+"：" },this.unitNode);
			domConstruct.create("span",{innerHTML:this.fdSysUnitName },this.unitNode);
			
			//进展情况
			this.docProcressNode = domConstruct.create("div",{className:"lui_asc_item_text"},contentContainer);
			domConstruct.create("span",{innerHTML:msg['kmSuperviseBack.docProgress']+"：" },this.docProcressNode);
			domConstruct.create("span",{innerHTML:this.docProgress },this.docProcressNode);
			
			//困难及措施
			this.docDifficultyNode = domConstruct.create("div",{className:"lui_asc_item_text"},contentContainer);
			domConstruct.create("span",{innerHTML:msg['kmSuperviseBack.docDifficulty']+"：" },this.docDifficultyNode);
			domConstruct.create("span",{innerHTML:this.docDifficulty },this.docDifficultyNode);
			
			//文档状态
			this.docStatusNode = domConstruct.create("div",{className:"lui_asc_item_text"},contentContainer);
			domConstruct.create("span",{innerHTML:msg['kmSuperviseBack.docStatus']+"：" },this.docStatusNode);
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