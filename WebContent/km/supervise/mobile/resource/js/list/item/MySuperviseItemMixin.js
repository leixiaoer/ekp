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
	"dojo/query",
	'dijit/registry',
	"mui/i18n/i18n!km-supervise:*"
	], function(declare, domConstruct,domClass , domStyle , domAttr , ItemBase , util,i18n,locale,util,OpenProxyMixin,query,registry,msg) {
	
	var item = declare("km.supervise.list.item.MySuperviseItemMixin", [ItemBase,OpenProxyMixin], {
		tag:"div",
		
		baseClass:"lui_db_mine_slide_item",
		
		href : 'javascript:void(0);',
		
		buildRendering:function(){
			this.inherited(arguments);
			
			this.domNode;
			if(this.fdType == "myCharge"){
				this.domNode = this.containerNode= this.srcNodeRef
					|| domConstruct.create(this.tag,{className:this.baseClass +" active"});
			}else{
				this.domNode = this.containerNode= this.srcNodeRef
					|| domConstruct.create(this.tag,{className:this.baseClass});
			}
			
			this.domNode.dojoClick = true;
			this.connect(this.domNode, 'click', function() {
				this.reloadMySupervise(this.fdType,this.domNode);
			});
			
			//内容
			this.itemDivNode = domConstruct.create("div",{},this.containerNode);
			domConstruct.create("p",{className:"lui_dmsi_num",innerHTML:this.allCount},this.itemDivNode);
			domConstruct.create("p",{className:"lui_dmsi_desc",innerHTML:this.desc},this.itemDivNode);
			
			this.detailNode = domConstruct.create("div",{className:"lui_dmsi_detail"},this.itemDivNode);
			this.soonDelayNode = domConstruct.create("div",{},this.detailNode);
			this.delayNode = domConstruct.create("div",{},this.detailNode);
			if(this.fdType == "myCharge"){
				domConstruct.create("span",{innerHTML:msg['enums.status.soon.delay']},this.soonDelayNode);
				domConstruct.create("span",{innerHTML:this.soonDelayCount},this.soonDelayNode);
				
				domConstruct.create("span",{innerHTML:msg['enums.status.delay']},this.delayNode);
				domConstruct.create("span",{innerHTML:this.delayCount},this.delayNode);
			}else{
				domConstruct.create("span",{innerHTML:msg['task.status.not.back']},this.soonDelayNode);
				domConstruct.create("span",{innerHTML:this.soonDelayCount},this.soonDelayNode);
				
				domConstruct.create("span",{innerHTML:msg['task.status.delay']},this.delayNode);
				domConstruct.create("span",{innerHTML:this.delayCount},this.delayNode);
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
		},
		reloadMySupervise : function(type,node){
			var items = query(".lui_db_mine_slide_item");
			for(var i = 0;i < items.length; i++){
				items[i].classList.remove("active");
			}
			node.classList.add("active");
			var myCharge = document.getElementById("myCharge");
			var myUndertakeAndSup = document.getElementById("myUndertakeAndSup");
			var undertakeMore = document.getElementById("undertakeMore");
			var supMore = document.getElementById("supMore");
			if(type == "myCharge"){
				myCharge.style.display='block';
				myUndertakeAndSup.style.display='none';
			}else{
				console.log(type)
				myCharge.style.display='none';
				myUndertakeAndSup.style.display='block';
				if(type=="myUndertake"){
					undertakeMore.style.display='-webkit-box';
					supMore.style.display='none';
				}else{
					supMore.style.display='-webkit-box';
					undertakeMore.style.display='none';
				}
				
				var href = "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=getUndertakeAndSupDatas&isDelay=true&rowsize=3&fdType="+type;
				registry.byId("undertakeAndSupList").set('url',href);
				registry.byId("undertakeAndSupList").reload();
			}
			
			
		}
		
		
	});
	return item;
});