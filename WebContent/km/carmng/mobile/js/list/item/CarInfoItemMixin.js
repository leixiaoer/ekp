define([
    "dojo/_base/declare",
    "dojo/dom-construct",
    "dojo/dom-class",
	"dojo/dom-style",
	"dojo/dom-attr",
    "dojox/mobile/_ItemBase",
   	"mui/util",
	"dojo/date/locale" ,
	"dojo/date",
	"mui/i18n/i18n!sys-mobile",
	"mui/i18n/i18n!km-carmng"
	], function(declare, domConstruct,domClass , domStyle , domAttr , ItemBase , util, locale,dateUtil,msg,carmngMsg) {
	
	var item = declare("km.carmng.list.item.CarInfoItemMixin", [ItemBase], {
		tag:"div",
		
		buildRendering:function(){
			
			//历史调度
			if(this.type=='dispatcher'){
				this.domNode = this.containerNode= this.srcNodeRef
				|| domConstruct.create(this.tag,{className:'muiCarTimeAxisContent'});
			this.inherited(arguments);
			//右侧内容
			var header=domConstruct.create("div",{className:"header"},this.containerNode);
			
			//时间轴
			domConstruct.create("i",{className:"mui mui-date"},header);
			
			domConstruct.create("span", { className: "time",innerHTML:carmngMsg['mui.kmCarmngDispatchersInfo.docCreateTime']+' '+this.start+' ~ '+this.end}, header);//时间

			if(this.fdFlag=="0"){
				domConstruct.create("a", { className: "muiCarBtn",innerHTML:carmngMsg["mui.kmCarmngDispatchersInfo.fdFlag1"]}, header);//状态
			}else if(this.fdFlag=="1"){
				domConstruct.create("a", { className: "muiCarBtn returned",innerHTML:carmngMsg["mui.kmCarmngDispatchersInfo.fdFlag2"]}, header);//状态
			}
	         var Icon=domConstruct.create("div",{className:"iconItem"},this.containerNode);
	         var box = domConstruct.create("div",{className:"iconBox"},Icon);
	         domConstruct.create("img", { src: this.hostsrc}, box);//用户头像
	         domConstruct.create("h4",{innerHTML:this.fdHost},Icon);
	         
	         var tel = domConstruct.create("div",{className:"detailItem",innerHTML:'<i class="mui mui-tel"></i>'+this.fdApplicationPhone},this.containerNode);
	         var place = domConstruct.create("div",{className:"detailItem",innerHTML:'<i class="mui mui-location"></i>'+util.formatText(this.fdPlaceName)},this.containerNode);
		  }
			//违章 infringeTime  fdHost  hostsrc  fdVehiclesNo  fdInfringeFee fdInfringeSite
			if(this.type=='infringe'){
				this.domNode = this.containerNode = this.srcNodeRef
						|| domConstruct.create(this.tag);
				this.contentNode = domConstruct.create(
						'div', {
							className: "cardLifeLabelItem"
						}, this.domNode);
				var node1 = domConstruct.create("div" ,{
					className: "cardLifeLabelItemDot mui mui-dot",
					innerHTML : ""
				}, this.contentNode);
				var node2 = domConstruct.create("div" ,{
					className: "cardLifeLabelItemTitle",
					innerHTML : carmngMsg["mui.kmCarmngInfringeInfo.fdInfringeTime"]+' '+this.infringeTime
				}, this.contentNode);
				var node3 = domConstruct.create("div" ,{
					className: "cardLifeNodeItem",
					innerHTML : ""
				}, this.contentNode);
				var node4 = domConstruct.create("div" ,{
					className: "cardLifeNodeItemContainer",
					innerHTML : ""
				}, node3);
				var node5 = domConstruct.create("div" ,{
					className: "cardLifeNodeInfo",
					innerHTML : '<img class="cardLifeNodeImage" src="'+this.hostsrc+'" alt=""><h4>'+this.fdHost+'</h4>'
				}, node4);
				var node6 = domConstruct.create("div" ,{className: "cardLifeNodeContent"}, node4);
				var nodeUl=domConstruct.create("ul" ,{className: "carRecordList"}, node6);
				domConstruct.create("li" ,{
					className: "",
					innerHTML : '<span class="recordTitle"><i class="mui mui-carUse"></i>'+carmngMsg['mui.kmCarmngInfomation.carNo']+'</span><span>'+util.formatText(this.fdVehiclesNo)+'</span>'
				}, nodeUl);
				domConstruct.create("li" ,{
					className: "",
					innerHTML : '<span class="recordTitle"><i class="mui mui-carPrice"></i>'+carmngMsg['mui.kmCarmngInfringeInfo.fdInfringeFee']+'</span><span>'+(this.fdInfringeFee!=null?this.fdInfringeFee:"0")+carmngMsg['mui.kmCarmngRegisterInfo.fee.unit']+'</span>'
				}, nodeUl);
				domConstruct.create("li" ,{
					className: "",
					innerHTML : '<span class="recordTitle"><i class="mui mui-location"></i>'+carmngMsg['mui.kmCarmngInfringeInfo.fdInfringeSite']+'</span><span>'+util.formatText(this.fdInfringeSite)+'</span>'
				}, nodeUl);
			}
			//保险  registerDate登记日期  fdVehiclesNo车牌号  start end开始结束日期  fdInsuranceFee保险金额  fdInsurancePrice保险价值 fdInsuranceNo保单号
			if(this.type=='insurance'){
				this.domNode = this.containerNode = this.srcNodeRef
				|| domConstruct.create(this.tag);
				this.contentNode = domConstruct.create(
						'div', {
							className: "cardLifeLabelItem"
						}, this.domNode);
				var node1 = domConstruct.create("div" ,{
					className: "cardLifeLabelItemDot mui mui-dot",
					innerHTML : ""
				}, this.contentNode);
				var node2 = domConstruct.create("div" ,{
					className: "cardLifeLabelItemTitle",
					innerHTML : carmngMsg['mui.kmCarmngInsuranceInfo.fdRegisterTime']+' '+this.registerDate
				}, this.contentNode);
				var node3 = domConstruct.create("div" ,{
					className: "cardLifeNodeItem",
					innerHTML : ""
				}, this.contentNode);
				var node4 = domConstruct.create("div" ,{
					className: "cardLifeNodeItemContainer",
					innerHTML : ""
				}, node3);
				var node5 = domConstruct.create("div" ,{
					className: "cardLifeNodeInfo",
					innerHTML : '<img class="cardLifeNodeImage" src="'+this.carImg+'" alt=""><h4>'+this.fdVehiclesNo+'</h4>'
				}, node4);
				var node6 = domConstruct.create("div" ,{className: "cardLifeNodeContent"}, node4);
				var nodeUl=domConstruct.create("ul" ,{className: "carRecordList"}, node6);
				domConstruct.create("li" ,{
					className: "",
					innerHTML : '<span class="recordTitle"><i class="mui mui-carTime"></i>'+carmngMsg['mui.kmCarmngInfomation.fdInsutanceTime']+' </span><span>'+this.start+' ~ '+this.end+'</span>'
				}, nodeUl);
				domConstruct.create("li" ,{
					className: "",
					innerHTML : '<span class="recordTitle"><i class="mui mui-carPrice"></i>'+carmngMsg['mui.kmCarmngInsuranceInfo.fdInsuranceFee']+' </span><span>'+(this.fdInsuranceFee!=null?this.fdInsuranceFee:"0")+carmngMsg['mui.kmCarmngRegisterInfo.fee.unit']+'</span>'
				}, nodeUl);
				domConstruct.create("li" ,{
					className: "",
					innerHTML : '<span class="recordTitle"><i class="mui mui-carCost"></i>'+carmngMsg['mui.kmCarmngInsuranceInfo.fdInsurancePrice']+' </span><span>'+(this.fdInsurancePrice!=null?this.fdInsurancePrice:"0")+carmngMsg['mui.kmCarmngRegisterInfo.fee.unit']+'</span>'
				}, nodeUl);
				domConstruct.create("li" ,{
					className: "",
					innerHTML : '<span class="recordTitle"><i class="mui mui-carNum"></i>'+carmngMsg['mui.kmCarmngInsuranceInfo.order']+'</span><span>'+util.formatText(this.fdInsuranceNo)+'</span>'
				}, nodeUl);
			}
			
			//保养  fdMaintenanceTime保养日期   fdHost hostsrc送修人  fdVehiclesNo车牌号 fdMaintenanceFee保养费 
			if(this.type=='maintenance'){
				this.domNode = this.containerNode = this.srcNodeRef
				|| domConstruct.create(this.tag);
				this.contentNode = domConstruct.create(
						'div', {
							className: "cardLifeLabelItem"
						}, this.domNode);
				var node1 = domConstruct.create("div" ,{
					className: "cardLifeLabelItemDot mui mui-dot",
					innerHTML : ""
				}, this.contentNode);
				var node2 = domConstruct.create("div" ,{
					className: "cardLifeLabelItemTitle",
					innerHTML : carmngMsg['mui.kmCarmngMaintenanceInfo.fdMaintenanceTime']+' '+this.fdMaintenanceTime
				}, this.contentNode);
				var node3 = domConstruct.create("div" ,{
					className: "cardLifeNodeItem",
					innerHTML : ""
				}, this.contentNode);
				var node4 = domConstruct.create("div" ,{
					className: "cardLifeNodeItemContainer",
					innerHTML : ""
				}, node3);
				var node5 = domConstruct.create("div" ,{
					className: "cardLifeNodeInfo",
					innerHTML : '<img class="cardLifeNodeImage" src="'+this.hostsrc+'" alt=""><h4>'+this.fdHost+'</h4>'
				}, node4);
				var node6 = domConstruct.create("div" ,{className: "cardLifeNodeContent"}, node4);
				var nodeUl=domConstruct.create("ul" ,{className: "carRecordList"}, node6);
				domConstruct.create("li" ,{
					className: "",
					innerHTML : '<span class="recordTitle"><i class="mui mui-carUse"></i>'+carmngMsg['mui.kmCarmngInfomation.carNo']+' </span><span>'+this.fdVehiclesNo+'</span>'
				}, nodeUl);
				domConstruct.create("li" ,{
					className: "",
					innerHTML : '<span class="recordTitle"><i class="mui mui-carPrice"></i>'+carmngMsg['mui.kmCarmngMaintenanceInfo.fdMaintenanceFee']+' </span><span>'+(this.fdMaintenanceFee!=null?this.fdMaintenanceFee:"0")+carmngMsg['mui.kmCarmngRegisterInfo.fee.unit']+'</span>'
				}, nodeUl);
				domConstruct.create("li" ,{
					className: "",
					innerHTML : '<span class="recordTitle"><i class="mui mui-carPrice"></i>'+carmngMsg['mui.kmCarmngMaintenanceInfo.fdRepairFee']+' </span><span>'+(this.fdRepairFee!=null?this.fdRepairFee:"0")+carmngMsg['mui.kmCarmngRegisterInfo.fee.unit']+'</span>'
				}, nodeUl);
			}
		},
		startup:function(){
			if(this._started){ return; }
			this.inherited(arguments);
		},
	
		_setLabelAttr: function(text){
			if(text)
				this._set("label", text);
		}
	});
	return item;
});