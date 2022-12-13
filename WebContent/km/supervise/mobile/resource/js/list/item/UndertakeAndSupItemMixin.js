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
	
	var item = declare("km.supervise.list.item.UndertakeAndSupItemMixin", [ItemBase,OpenProxyMixin], {
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
			
			//承办阶段
			this.stageNode = domConstruct.create("li",{className:"lui_asc_item_text"},UlNode);
			domConstruct.create("span",{innerHTML:Msg['mobile.task.undertake.stage']+"：" },this.stageNode);
			domConstruct.create("span",{innerHTML:this.fdStage },this.stageNode);
			
			//承办人
			this.sponsorNode = domConstruct.create("li",{className:"lui_asc_item_text"},UlNode);
			domConstruct.create("span",{innerHTML:Msg['kmSuperviseTask.fdSponsor']+"：" },this.sponsorNode);
			domConstruct.create("span",{innerHTML:this.fdSponsor },this.sponsorNode);
			if(this.feedbackEnable == "true"){
				if(this.docStatus == "30"){
					//下一个反馈日
					this.backNode = domConstruct.create("li",{className:"lui_asc_item_text"},UlNode);
					
					var status = this.status;
					if(status == "-1"){
						domConstruct.create("span",{innerHTML:Msg['kmSuperviseBack.fdBackDay']+"：" },this.backNode);
						domConstruct.create("span",{innerHTML:this.backDay },this.backNode);
						domConstruct.create("i",{className:"lui_asc_item_notice warning",innerHTML:Msg['task.status.delay'] },this.backNode);
					}else if(status == "0"){
						domConstruct.create("span",{innerHTML:Msg['mobile.task.next.backDay']+"：" },this.backNode);
						domConstruct.create("span",{innerHTML:this.backDay },this.backNode);
						domConstruct.create("i",{className:"lui_asc_item_notice warning",innerHTML:Msg['task.status.not.back'] },this.backNode);
					}else if(status == "1"){
						domConstruct.create("span",{innerHTML:Msg['kmSuperviseBack.fdBackDay']+"：" },this.backNode);
						domConstruct.create("span",{innerHTML:this.backDay },this.backNode);
						domConstruct.create("i",{className:"lui_asc_item_notice",innerHTML:Msg['task.status.normal'] },this.backNode);
					}
					
					if(this.dealyCount){
						//往期超期未反馈
						this.delayNode = domConstruct.create("li",{className:"item-active"},UlNode);
						this.delayCountNode = domConstruct.create("div",{},this.delayNode);
						domConstruct.create("span",{innerHTML:Msg['mobile.task.delay.backDay']+"：" },this.delayCountNode);
						domConstruct.create("span",{innerHTML:this.dealyCount+Msg['mobile.task.delay.backDay.count'] },this.delayCountNode);
					}
				}
			}

			//状态
			if(this.docStatus){
				if(this.docStatus == "40"){
					domConstruct.create("span",{className:"lui_asc_item_notice",innerHTML:Msg['enums.doc_status.40']},bottomNode);
				}else if(this.docStatus == "50"){
					domConstruct.create("span",{className:"lui_asc_item_notice",innerHTML:Msg['enums.doc_status.50'] },bottomNode);
				}else if(this.docStatus == "60"){
					domConstruct.create("span",{className:"lui_asc_item_notice",innerHTML:Msg['enums.status.change'] },bottomNode);
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