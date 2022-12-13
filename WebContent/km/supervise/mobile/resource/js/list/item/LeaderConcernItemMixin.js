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
	"mui/util","mui/i18n/i18n!!km-supervise:*",
	"mui/openProxyMixin"
	], function(declare, domConstruct,domClass , domStyle , domAttr , ItemBase , util,i18n,locale,util,Msg,OpenProxyMixin) {
	
	var item = declare("km.supervise.list.item.LeaderConcernItemMixin", [ItemBase,OpenProxyMixin], {
		tag:"div",
		
		baseClass:"lui_asc_item muiListItemCard",
		
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
			
			//督办类别
			this.templetNode = domConstruct.create("li",{className:"lui_asc_item_text"},UlNode);
			domConstruct.create("span",{innerHTML:Msg['py.DuBanLeiBie']+"："},this.templetNode);
			domConstruct.create("span",{innerHTML:this.templateName },this.templetNode);
			
			//计划时间
			this.planNode = domConstruct.create("li",{className:"lui_asc_item_text"},UlNode);
			domConstruct.create("span",{innerHTML:Msg['mobile.main.plan.time']+"：" },this.planNode);
			var planText = this.fdStartTime + "~" + this.fdFinishTime;
			domConstruct.create("span",{innerHTML:planText },this.planNode);
			
			//关注领导
			this.leadNode = domConstruct.create("li",{className:"lui_asc_item_text"},UlNode);
			domConstruct.create("span",{innerHTML:Msg['mobile.lead.concern']+"：" },this.leadNode);
			domConstruct.create("span",{innerHTML:this.leaderConcernNames },this.leadNode);
			
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
		
		_getStatusInfo:function(value){
			var statusInfo={
				'00':{
					className:'muiTaskInactive'
				},
				'10':{
					className:'muiTaskInactive'
				},
				'11':{
					className:'muiTaskInactive'
				},
				'20':{
					className:'muiTaskInactive'
				},
				'30':{
					className:'muiTaskProgress'
				},
				'40':{
					className:'muiTaskComplete'
				},
				'50':{
					className:'muiTaskTerminate'
				},
				'60':{
					className:'muiTaskOverrule'
				}
			}
			return statusInfo[value];
		},
		
		userClickAction : function(){
			return false;
		}
		
		
	});
	return item;
});