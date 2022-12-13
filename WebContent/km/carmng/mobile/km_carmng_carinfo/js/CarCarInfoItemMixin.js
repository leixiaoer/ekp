define([
    "dojo/_base/declare",
    "dojo/dom-construct",
    "dojo/dom-class",
	"dojo/dom-style",
	"dojo/dom-attr",
    "dojox/mobile/_ItemBase",
   	"mui/util",
   	"sys/mportal/mobile/OpenProxyMixin" ,
   	"mui/i18n/i18n!km-carmng",
   	"mui/i18n/i18n!km-carmng:*"
	], function(declare, domConstruct,domClass , domStyle , domAttr , ItemBase , util, OpenProxyMixin,carmngMsg,Msg) {
	var item = declare("km.carmng.list.item.ProcessItemMixin", [ItemBase, OpenProxyMixin], {
		tag:"li",

		baseClass:"muiProcessItem muiListItemCard",
		
		buildRendering:function(){
			this._templated = !!this.templateString;
			if (!this._templated) {
				this.domNode = this.containerNode = this.srcNodeRef || domConstruct.create(this.tag,{className:'muiCarManageList'});
				this.contentNode = domConstruct.create('a', {}, this.domNode);
			}
			this.inherited(arguments);
			if (!this._templated)
			this.buildInternalRender();
		},
		buildInternalRender : function() {
		  	if(this.href){
				this.proxyClick(this.contentNode, this.href, '_blank');
			}
		    var leftNode = domConstruct.create("div" ,{
				className: "carManageIcon",
				//innerHTML : '<img src='+(this.fdImageUrl?util.formatUrl(this.fdImageUrl): util.formatUrl("/km/asset/mobile/js/list/item/defaulthead.jpg"))+'><span class="muiCarManageStateTag">'+carmngMsg['kmCarmngInformation.docStauts1']+'</span>'
				innerHTML : '<i style="background:url('+(this.fdImageUrl?util.formatUrl(this.fdImageUrl): util.formatUrl("/km/carmng/mobile/css/images/defaulthead.jpg"))+') center center no-repeat;background-size:cover;display:inline-block;"></i>'
			}, this.contentNode);
		    
			var rightNode = domConstruct.create("div", {className : 'carManageInfo'}, this.contentNode);
			var topNode = domConstruct.create("div", {className : 'carManageInfoTop'}, rightNode);
			domConstruct.create("div", {className: "carManageSub muiFontSizeM ", innerHTML :this.docSubject}, topNode);

			var statusNode = domConstruct.create("div", {className: "carManageSta muiFontSizeS"}, topNode);
			domConstruct.create("span", {className: "carManageStateTag", innerHTML :this.fdSeatNumber}, statusNode);
			if(this.docStatus=='1'){//多状态要判断this.docStatus
				domConstruct.create("span", {className: "carManageSeatNumTag SeatNumTag1", innerHTML :carmngMsg['mui.kmCarmngInformation.docStauts1']}, statusNode);
			} else if(this.docStatus=='2'){
				domConstruct.create("span", {className: "carManageSeatNumTag SeatNumTag2", innerHTML :carmngMsg['mui.kmCarmngInformation.docStauts2']}, statusNode);
			} else if(this.docStatus=='3'){
				domConstruct.create("span", {className: "carManageSeatNumTag SeatNumTag3", innerHTML :carmngMsg['mui.kmCarmngInformation.docStauts3']}, statusNode);
			}
			
			var bottomNode = domConstruct.create("div" , {className : 'carManageInfoBottom muiFontSizeS muiFontColorMuted'},rightNode);
			domConstruct.create("span", {innerHTML :Msg["kmCarmngInfomation.fdMotorcade"]+"："+this.fdMotorcadeName}, bottomNode);
			domConstruct.create("span", {innerHTML :Msg["kmCarmngInfomation.vehichesType"]+"："+this.fdVehichesType}, bottomNode);
			domConstruct.create("span", {innerHTML :Msg["kmCarmngInfomation.carNo"]+"："+this.fdNo}, bottomNode);
			if(this.fdDriverName!=""){//驾驶员不一定有
				domConstruct.create("span", {innerHTML :Msg["kmCarmngInfomation.fdDriverId"]+"："+this.fdDriverName}, bottomNode);
			}
			if(this.fdRefUrl) {
				this.href = this.fdRefUrl;
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