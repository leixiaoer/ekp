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
	
	var item = declare("km.supervise.list.item.DynamicItemMixin", [ItemBase,OpenProxyMixin], {
		tag:"li",
		
		baseClass:"lui_db_dynamic_item",
		
		href : 'javascript:void(0);',
		
		buildRendering:function(){
			this.inherited(arguments);
			
			this.domNode = this.containerNode= this.srcNodeRef
				|| domConstruct.create(this.tag,{className:this.baseClass});
			
			this.domNode.dojoClick = true;
			if(this.dynamicHref){
				this.proxyClick(this.domNode, this.dynamicHref, '_blank');
			}
			
			//内容
			var contentContainer = domConstruct.create("div", { className: "lui_db_dynamic_item_wrap"}, this.containerNode);
			
			var type_text,subject_text;
	    	switch(this.type) {
	    	case '1':
	    		type_text = msg["py.DuBanBianGeng"];
	    		subject_text = this.docSubject + msg['mobile.dynamic.change.reason'] + "：" + this.fdContent;
	    		break;
	    	case '2':
	    		type_text = msg["py.JieDuanFanKui"];
	    		subject_text = this.docCreator + msg['mobile.dynamic.back'] + "：" + this.fdContent;
	    		break;
	    	case '4':
	    		type_text = msg["py.DuBanBanJie"];
	    		subject_text = this.docCreator + msg['mobile.dynamic.tip1'] +"'" + this.docSubject + "'" +msg['mobile.dynamic.finish'];
	    		break;
	    	case '5':
	    		type_text = msg["py.DuBanZhongZhi"];
	    		subject_text = this.docCreator + msg['mobile.dynamic.tip1'] +"'" + this.docSubject + "'" +msg['mobile.dynamic.stop'];
	    		break;
	    	case '6':
	    		type_text = msg["py.DuBanKaoPing"];
	    		subject_text = this.docCreator + msg['mobile.dynamic.remark']+"'" + this.docSubject+"'";
	    		break;
	    	case '7':
	    		type_text = msg["py.leaderInstruction"];
	    		subject_text = this.docCreator + msg['mobile.dynamic.instruction']+"：" + this.fdContent;
	    		break;
	    	}

			domConstruct.create("p",{className:"lui_db_dynamic_item_tit",innerHTML:subject_text}, contentContainer);
			
			this.superviseNode = domConstruct.create("div",{className:"muiSuperviseItemNotice"}, contentContainer);
			
			domConstruct.create("span",{className:"lui_db_dynamic_item_desc", innerHTML: msg['kmSupervise.items'] + "：" + this.fdSupervise}, this.superviseNode);
			
			domConstruct.create("span",{className:"lui_db_dynamic_item_date", innerHTML: msg['kmSuperviseMain.fdChangeTime'] + "：" + this.docCreateTime}, this.superviseNode);
			
			domConstruct.create("div",{className:"lui_db_dynamic_item_flag", innerHTML:type_text}, this.superviseNode);
			
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