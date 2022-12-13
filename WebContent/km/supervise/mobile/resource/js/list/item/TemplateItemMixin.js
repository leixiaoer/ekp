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
	
	var item = declare("km.supervise.list.item.TemplateItemMixin", [ItemBase,OpenProxyMixin], {
		tag:"div",
		
		baseClass:"lui_sm_mcs_item",
		
		href : 'javascript:void(0);',
		
		buildRendering:function(){
			this.inherited(arguments);
			
			this.domNode = this.containerNode= this.srcNodeRef
				|| domConstruct.create(this.tag,{className:this.baseClass});
			
			this.domNode.dojoClick = true;
			if(this.href){
				//需要把status=10之类的改成#path=0
				var selfHref = this.href;
				var status = util.getUrlParameter(selfHref,"status") || '';
				if(status == '10'){
					selfHref = selfHref + '#path=4';
				}else if (status == '20'){
					selfHref = selfHref + '#path=2';
				}else if (status == '30'){
					selfHref = selfHref + '#path=1';
				}
				this.proxyClick(this.domNode, selfHref, '_blank');
			}
			
			//内容
			this.itemDivNode = domConstruct.create("div",{className:"lui_sm_mcsi_Text_box"},this.containerNode);
			if(this.status == "10"){
				domConstruct.create("span",{className:"lui_sm_mcsi_bigText lui_sm_mcsi_bigText-blue",innerHTML:this.count},this.itemDivNode);
				domConstruct.create("span",{className:"lui_sm_mcsi_smallText",innerHTML:"/"+this.allCount},this.itemDivNode);
				
			}else if(this.status == "20"){
				domConstruct.create("span",{className:"lui_sm_mcsi_bigText lui_sm_mcsi_bigText-orange",innerHTML:this.count},this.itemDivNode);
				domConstruct.create("span",{className:"lui_sm_mcsi_smallText",innerHTML:"/"+this.allCount},this.itemDivNode);
			}
			else if(this.status == "30"){
				domConstruct.create("span",{className:"lui_sm_mcsi_bigText lui_sm_mcsi_bigText-red",innerHTML:this.count},this.itemDivNode);
				domConstruct.create("span",{className:"lui_sm_mcsi_smallText",innerHTML:"/"+this.allCount},this.itemDivNode);
			}
			domConstruct.create("span",{className:"lui_sm_mcs_itemName",innerHTML:this.templateName},this.containerNode);
			
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