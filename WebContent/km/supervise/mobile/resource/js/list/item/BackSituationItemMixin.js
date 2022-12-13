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
	
	var item = declare("km.supervise.list.item.BackItemMixin", [ItemBase], {
		tag:"li",
		
		baseClass:"lui_db_flag_content_item",
		
		href : 'javascript:void(0);',
		
		buildRendering:function(){
			this.inherited(arguments);
			
			this.domNode = this.containerNode= this.srcNodeRef
				|| domConstruct.create(this.tag,{className:this.baseClass});
			
			//右侧内容
			var contentContainer=domConstruct.create("div", { className: "lui_db_flag_content_item_wrap"}, this.containerNode); 
			//反馈日
			domConstruct.create("h3",{className:"muiSubject",innerHTML:this.fdBackDay },contentContainer);
			
			//涉及阶段
			this.backNode = domConstruct.create("div",{},contentContainer);
			domConstruct.create("span",{className:"lui_db_flag_content_item_tit",innerHTML:msg['mobile.back.stage']+"：" },this.backNode);
			domConstruct.create("span",{innerHTML:this.fdBackStage},this.backNode);
			
			//反馈情况
			this.stageNode = domConstruct.create("div",{},contentContainer);
			domConstruct.create("span",{className:"lui_db_flag_content_item_tit",innerHTML:msg['mobile.back.situation']+"：" },this.stageNode);
			this.contentNode = domConstruct.create("div",{className:"lui_db_flag_content_list"},this.stageNode);
			var results = this.results;
			if(results.length > 0){
				for(var j=results.length-1; j >= 0; j--){
					var fdStatus = results[j].fdStatus;
					var fdName = results[j].fdName;
					var resultNode;
					if(fdStatus == '0'){
						resultNode = domConstruct.create("p",{className:"blue"},this.contentNode);
					}else if(fdStatus == '1'){
						resultNode = domConstruct.create("p",{className:"purple"},this.contentNode);
					}else if(fdStatus == '2'){
						resultNode = domConstruct.create("p",{className:"red"},this.contentNode);
					}else if(fdStatus == '3'){
						resultNode = domConstruct.create("p",{className:"orange"},this.contentNode);
					}
					domConstruct.create("i",{},resultNode);
					domConstruct.create("span",{innerHTML:fdName},resultNode);
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