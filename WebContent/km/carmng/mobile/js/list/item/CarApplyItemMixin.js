define([
    "dojo/_base/declare",
    "dojo/dom-construct",
    "dojo/dom-class",
	"dojo/dom-style",
	"dojo/dom-attr",
    "dojox/mobile/_ItemBase",
   	"mui/util",
   	"sys/mobile/js/mui/openProxyMixin" ,
   	"mui/i18n/i18n!km-carmng:*"
	], function(declare, domConstruct,domClass , domStyle , domAttr , ItemBase , util, OpenProxyMixin,carmngMsg) {
	var item = declare("km.carmng.list.item.CarApplyItemMixin", [ItemBase, OpenProxyMixin], {
		tag:"li",

		baseClass:"muiProcessItem muiListItemCard",
		
		buildRendering:function(){
		   // this.domNode = domConstruct.create(this.tag, {className : 'muiProcessItem'}, this.containerNode);
			this.inherited(arguments);
			this.contentNode = domConstruct.create(
					this.tag, {
						className : 'carApplyItem  muiListItem'
					});
			//domStyle.set(this.contentNode,'background-color',"#fff");
			this.buildInternalRender();
			domConstruct.place(this.contentNode,this.containerNode);
		},
		buildInternalRender : function() {
			var itemClass = this.href ? {}:{className:'lock'};
			this.contentNode = domConstruct.create('div', itemClass);
			
			var headNode = domConstruct.create("div",{className:"muiListItemTop"},this.contentNode); // figure
			
			// 标题
			var subject = domConstruct.create("div",{className:"muiFontSizeM muiListItemTitle",
			innerHTML: '<div class="muiListItemTitleInner">'  +this.label+ '</div>'},headNode);
			
			// 人员图标
			var personImgBoxNode = domConstruct.create("div",{className:"muiListItemPerImgBox"},headNode);
			
			//用户头像  //util.formatUrl(this.icon)
			domConstruct.create("span", { className: "muiListItemPerImg",style:{background:'url(' + this.icon +') center center no-repeat',
			backgroundSize:'cover',display:'inline-block'}}, personImgBoxNode);

			// 创建人
			if(this.creator){
				var creatorNode = domConstruct.create("div",{className:"muiListItemCreator muiFontSizeS muiFontColorMuted"},headNode);
				creatorNode.innerText = this.creator;
			}

			if(this.status){
				var statusNode = domConstruct.create("div",{className:"muiListItemStatus muiFontSizeS muiFontColorMuted"},headNode);
				statusNode.innerHTML = this.status;
			}
			
			//subhead
			//bottom
			var subhead = domConstruct.create("div",{className:"muiListItemBottom muiFontSizeS muiFontColorMuted"},this.contentNode);
			
			// 发起时间
			if(this.created){
				domConstruct.create("div",{className:'muiListItemExpTimeInfo',
				innerHTML: carmngMsg["kmCarmngApplication.fdApplicationTime"]+':<span class="muiListItemExpTime"> '+this.created+'</span>'},subhead);
			}
			//信息
			if(this.summary){
				domConstruct.create("div",{className:'muiListItemMinorInfo',
				innerHTML:'<span class="muiListItemMinorItem"> '+this.summary+'</span>'},subhead);
			}
			
			if(this.href){
				this.proxyClick(this.contentNode, this.href, '_blank');
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
		_onDispatcher :function(evt){
			evt.stopEvent();
		}
	});
	return item;
});