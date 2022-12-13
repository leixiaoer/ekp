define([
    "dojo/_base/declare",
    "dojo/dom-construct",
    "dojo/dom-class",
	"dojo/dom-style",
	"dojo/dom-attr",
    "dojox/mobile/_ItemBase",
   	"mui/util",
   	"sys/mportal/mobile/OpenProxyMixin" ,
   	"mui/i18n/i18n!km-carmng"
	], function(declare, domConstruct,domClass , domStyle , domAttr , ItemBase , util, OpenProxyMixin,carmngMsg) {
	var item = declare("km.carmng.list.item.ProcessItemMixin", [ItemBase, OpenProxyMixin], {
		tag:"li",
		
		buildRendering:function(){
		  if(this.type == "apply"){
		   // this.domNode = domConstruct.create(this.tag, {className : 'muiProcessItem'}, this.containerNode);
			this.inherited(arguments);
			this.contentNode = domConstruct.create(
					this.tag, {
						className : 'carApplyItem  muiListItem'
					}, this.containerNode);
			//domStyle.set(this.contentNode,'background-color',"#fff");
			this.buildInternalRender();
	      }else if(this.type == "car"){
			  this._templated = !!this.templateString;
				if (!this._templated) {
					this.domNode = this.containerNode = this.srcNodeRef
							|| domConstruct.create(this.tag,{className:'muiCarManageList'});
					this.contentNode = domConstruct.create(
							'a', {}, this.domNode);
				}
				this.inherited(arguments);
				if (!this._templated)
					this.buildInternalRender();
		  }else if (this.type =="useDispatcher"){
			  this.domNode = this.containerNode = this.srcNodeRef
							|| domConstruct.create(this.tag,{className:'muiCarList'});
			  this.contentNode = domConstruct.create('a', {}, this.domNode);
			  this.inherited(arguments);
			  this.buildInternalRender(); 		
		  }else if (this.type =="evaluate"){
			  this.domNode = this.containerNode = this.srcNodeRef
				|| domConstruct.create(this.tag,{className:'muiCarList'});
			  this.contentNode = domConstruct.create('a', {}, this.domNode);
			  this.inherited(arguments);
				
			  this.buildInternalRender(); 		
		  }else if (this.type =="useRegister"){// 
			  this.domNode = this.containerNode = this.srcNodeRef
				|| domConstruct.create(this.tag,{className:'muiCarList'});
			  this.contentNode = domConstruct.create('a', {}, this.domNode);
			  this.inherited(arguments);
			  this.buildInternalRender();
		  }
		},
		buildInternalRender : function() {
		  if(this.type == "apply"){
				var rightArea = domConstruct.create("div",{className:"muiProcessRight"},this.contentNode);
				//domConstruct.create("img", { className: "muiProcessImg",src:this.icon}, rightArea);
				domConstruct.create("span", { className: "muiProcessImg",style:{background:'url(' + this.icon +') center center no-repeat',backgroundSize:'cover',display:'inline-block'}}, rightArea);
				domConstruct.create("a", { className: "muiProcessCreator muiAuthor",innerHTML:this.creator}, rightArea);
				domConstruct.create("span", { className: "muiProcessCreated muiListSummary", 
					innerHTML:this.created}, rightArea);
				
				var leftArea = domConstruct.create("a",{className:"muiProcessLeft"},this.contentNode);
				var title = domConstruct.create("h3",{className:"muiProcessTitle muiSubject"},leftArea);
				if(this.status){
					title.appendChild(domConstruct.toDom(this.status));
				}
				if(this.label){
					title.appendChild(domConstruct.toDom(this.label));
				}
				if(this.summary){
					var summary = domConstruct.create("p",{className:"muiProcessSummary muiListSummary",innerHTML:this.summary},leftArea);
					domConstruct.create("i",{className:"muiProcessSign mui mui-flowlist"},summary,"first");
				}
				if(this.href){
					this.proxyClick(leftArea, this.href, '_blank');
				}
		  }else if(this.type == "useDispatcher"){
			    if(this.href){
			    	this.proxyClick(this.contentNode, this.href, '_blank');
				}
			    this.dispHeadArea = domConstruct.create("div",{className:"muiCarListHeader"},this.contentNode);
			    var headLeft = domConstruct.create("div",{className:"muiCarLeft"},this.dispHeadArea);
			    var icon = '<img src="'+this.icon+'" alt="" />';
			    domConstruct.create("span", { className: "muiCarFigure",innerHTML:icon}, headLeft);
			    var carName = this.creator+"<em>"+carmngMsg['mui.kmCarmngDispatchersInfo.apply']+"</em>";
			    domConstruct.create("span", { className: "muiCarnName",innerHTML:carName}, headLeft);
			    domConstruct.create("span", { innerHTML:this.fdMotorcadeFdName}, headLeft);
			    
			    var headRight = domConstruct.create("div",{className:"muiCarRight"},this.dispHeadArea);
			    domConstruct.create("span", { className: "fleet",innerHTML:this.created+carmngMsg['mui.kmCarmngDispatchersInfo.submit']}, headRight);
			    
			    this.dispContentArea = domConstruct.create("div",{className:"muiCarListContent"},this.contentNode);
			    var title = domConstruct.create("h3", { className: "muiCarTitle"}, this.dispContentArea);
			    var titleText = this.label+"<em>("+this.fdUserNumber+"人)</em>";
			    domConstruct.create("span", { innerHTML:titleText}, title);
			   
			    var infoText = "<em>"+carmngMsg['mui.kmCarmngApplication.fdUseTime']+"：<span>"+this.fdStartTime+"</span><em>"+carmngMsg['mui.kmCarmng.message.title0']+"</em><span>"+this.fdEndTime+"</span>";
			    var info = domConstruct.create("div", { className: "muiCarInfo",innerHTML:infoText}, this.dispContentArea);
				
		  }else if(this.type == "evaluate"){
			  if(this.href){
				  this.proxyClick(this.contentNode, this.href, '_blank');
			  }
			  this.evalHeadArea = domConstruct.create("div",{className:"muiCarListHeader"},this.contentNode);
			    var headLeft = domConstruct.create("div",{className:"muiCarLeft"},this.evalHeadArea);
			    var icon = '<img src="'+this.icon+'" alt="" />';
			    domConstruct.create("span", { className: "muiCarFigure",innerHTML:icon}, headLeft);
			    domConstruct.create("span", { className: "muiCarnName",innerHTML:this.creator}, headLeft);
			    
			    this.evalContentArea = domConstruct.create("div",{className:"muiCarListContent"},this.contentNode);
			    var appInfoText = "<span>"+this.fdAppNames+"</span>";
			    var appInfo = domConstruct.create("h3", { className: "muiCarTitle",innerHTML:appInfoText}, this.evalContentArea);
			    
			    var carRateInfo = domConstruct.create("div", { className: "muiCarRateInfo"}, this.evalContentArea);
			    var emText = ""
			    var styleWidth = "";
			    if(this.fdEvaluationScore == "1"){
			    	emText = carmngMsg['mui.kmCarmngEvaluation.score1']
			    	styleWidth="width:20%"	
			    }else if(this.fdEvaluationScore == "2"){
			    	emText = carmngMsg['mui.kmCarmngEvaluation.score2']
				    styleWidth="width:40%"	
			    }else if(this.fdEvaluationScore == "3"){
			    	emText = carmngMsg['mui.kmCarmngEvaluation.score3']
				    styleWidth="width:60%"	
			    }else if(this.fdEvaluationScore == "4"){
			    	emText = carmngMsg['mui.kmCarmngEvaluation.score4']
				    styleWidth="width:80%"	
			    }else if(this.fdEvaluationScore == "5"){
			    	emText = carmngMsg['mui.kmCarmngEvaluation.score5']
				    styleWidth="width:100%"	
			    }
			    var rateEm = domConstruct.create("em", { className: "muiCarRateTitle",innerHTML:emText}, carRateInfo);
			    var rateSpan = domConstruct.create("span", { className: "muiRating",style:"position: relative"}, carRateInfo);
			   
			    var rateOffi = '<i class="mui mui-star-off mui-2 muiRatingOff"></i><i class="mui mui-star-off mui-2 muiRatingOff"></i><i class="mui mui-star-off mui-2 muiRatingOff"></i><i class="mui mui-star-off mui-2 muiRatingOff"></i><i class="mui mui-star-off mui-2 muiRatingOff"></i>';
			    var rateOni = '<i class="mui mui-star-on mui-2 muiRatingOn"></i><i class="mui mui-star-on mui-2 muiRatingOn"></i><i class="mui mui-star-on mui-2 muiRatingOn"></i><i class="mui mui-star-on mui-2 muiRatingOn"></i><i class="mui mui-star-on mui-2 muiRatingOn"></i>';
			    var rateOffDiv = domConstruct.create("div", { className: "muiRatingArea",innerHTML:rateOffi},rateSpan);
			    var rateOnDiv = domConstruct.create("div", { className: "muiRatingValue",style:styleWidth,innerHTML:rateOni},rateSpan);
				
		  } else if(this.type == "useRegister"){
			  if(this.href){
				  this.proxyClick(this.contentNode, this.href, '_blank');
			  }
			  this.regisHeadArea = domConstruct.create("div",{className:"muiCarListHeader"},this.contentNode);
			    var headLeft = domConstruct.create("div",{className:"muiCarLeft"},this.regisHeadArea);
			    var icon = '<img src="'+this.icon+'" alt="" />';
			    domConstruct.create("span", { className: "muiCarFigure",innerHTML:icon}, headLeft);
			    domConstruct.create("span", { className: "muiCarTitle",innerHTML:this.fdAppNames}, headLeft);
			    
			    this.regisContentArea = domConstruct.create("div",{className:"muiCarListContent"},this.contentNode);
			   
			    var carInfoText = "<em>"+carmngMsg['mui.kmCarmngInfomation.carNo']+"：</em><span>"+this.fdCarInfoNames+"</span>";
			    var carInfo = domConstruct.create("div", { className: "muiCarInfo muiCarPlateNum",innerHTML:carInfoText}, this.regisContentArea);
			   
			    var timeInfoText = "<em>"+carmngMsg['mui.kmCarmngDispatchersInfo.docCreateTime']+"：</em><span>"+this.fdStartTime+"</span>";
			    var timeInfo = domConstruct.create("div", { className: "muiCarInfo",innerHTML:timeInfoText}, this.regisContentArea);
			  
			    var dispatcherStatusColor = "";
			    if(this.fdFlag==0){
			    	dispatcherStatusColor = " muiDispatcherHold";
			    }else if(this.fdFlag==1){
			    	dispatcherStatusColor = " muiDispatcherUnhold";
			    }else if(this.fdFlag==2){
			    	dispatcherStatusColor = " muiDispatcherNoCar";
			    }
			    var __div = domConstruct.toDom("<div class='muiDispatcherStatusTag"+dispatcherStatusColor+"'>"+this.status+"</div>");
				domConstruct.place(__div,this.contentNode);
			  
		  }else if(this.type == "car"){
			  	if(this.href){
				  this.proxyClick(this.contentNode, this.href, '_blank');
				}
			  
			    var iconNode;
			    if(this.docStatus=='1'){
					iconNode = domConstruct.create("div" ,{
						className: "carManageIcon",
						//innerHTML : '<img src='+(this.fdImageUrl?util.formatUrl(this.fdImageUrl): util.formatUrl("/km/asset/mobile/js/list/item/defaulthead.jpg"))+'><span class="muiCarManageStateTag">'+carmngMsg['kmCarmngInformation.docStauts1']+'</span>'
						innerHTML : '<i style="background:url('+(this.fdImageUrl?util.formatUrl(this.fdImageUrl): util.formatUrl("/km/carmng/mobile/css/images/defaulthead.jpg"))+') center center no-repeat;background-size:cover;display:inline-block;"></i><span class="muiCarManageStateTag">'+carmngMsg['mui.kmCarmngInformation.docStauts1']+'</span>'
					}, this.contentNode);
		        }
		        if(this.docStatus=='2'){
					iconNode = domConstruct.create("div" ,{
						className: "carManageIcon",
						//innerHTML : '<img src='+(this.fdImageUrl?util.formatUrl(this.fdImageUrl): util.formatUrl("/km/asset/mobile/js/list/item/defaulthead.jpg"))+'><span class="muiCarManageStateTag repair">'+carmngMsg['kmCarmngInformation.docStauts2']+'</span>'
						innerHTML : '<i style="background:url('+(this.fdImageUrl?util.formatUrl(this.fdImageUrl): util.formatUrl("/km/carmng/mobile/css/images/defaulthead.jpg"))+') center center no-repeat;background-size:cover;display:inline-block;"></i><span class="muiCarManageStateTag repair">'+carmngMsg['mui.kmCarmngInformation.docStauts2']+'</span>'
					}, this.contentNode);
		        } 
		        if(this.docStatus=='3'){
					iconNode = domConstruct.create("div" ,{
						className: "carManageIcon",
						//innerHTML : '<img src='+(this.fdImageUrl?util.formatUrl(this.fdImageUrl): util.formatUrl("/km/asset/mobile/js/list/item/defaulthead.jpg"))+'><span class="muiCarManageStateTag scrap">'+carmngMsg['kmCarmngInformation.docStauts3']+'</span>'
						innerHTML : '<i style="background:url('+(this.fdImageUrl?util.formatUrl(this.fdImageUrl): util.formatUrl("/km/carmng/mobile/css/images/defaulthead.jpg"))+') center center no-repeat;background-size:cover;display:inline-block;"></i><span class="muiCarManageStateTag scrap">'+carmngMsg['mui.kmCarmngInformation.docStauts3']+'</span>'
					}, this.contentNode);
		        }
				var infoNode = domConstruct.create("div" , {className : 'carManageInfo'},this.contentNode);
				
				domConstruct.create("h3" , {innerHTML :this.docSubject},infoNode);
				domConstruct.create("span" , {className: "carManageTip",innerHTML :this.fdSeatNumber},infoNode);
				domConstruct.create("div" , {className: "carManageDetail",innerHTML :'<span><i class="mui mui-carType"></i>'+this.fdMotorcadeName+'</span><span><i class="mui mui-carGenre"></i>'+this.fdVehichesType+'</span>'},infoNode);
				var childNode  = domConstruct.create("div" , {className: "carManageDetail",innerHTML :'<span><i class="mui mui-carNum"></i>'+this.fdNo+'</span>'},infoNode);
				if(this.fdDriverName!=""){
					domConstruct.create("span" , {innerHTML :'<i class="mui mui-todo_person"></i>'+this.fdDriverName},childNode);
				}
				if(this.fdRefUrl) {
					this.href = this.fdRefUrl;
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
		_onDispatcher :function(evt){
			evt.stopEvent();
		}
	});
	return item;
});