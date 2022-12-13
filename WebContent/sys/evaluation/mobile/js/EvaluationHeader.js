define( [ "dojo/_base/declare", 
          "dojo/dom-class","dijit/_WidgetBase","dojo/dom-style",
      	"dojo/dom-construct",'dojo/topic','dojo/request', "mui/util", 
      	'dojo/_base/array','dojo/dom-geometry', "mui/rating/Rating",
      	"dojox/mobile/viewRegistry","mui/i18n/i18n!sys-evaluation", "dojo/dom"], 
      	function(declare,  domClass,
      			_WidgetBase, domStyle,domConstruct,topic,request, util, array,
      			domGeometry, Rating, viewRegistry,Msg,dom) {

	return declare("sys.evaluation.EvaluationHeader", [ _WidgetBase ], {
		
		fdModelId: "",
		
		fdModelName : "",
		
		scoreDetail : [],
		
		evalCount : 0, 
		
		baseClass:"evaluationHeader",
		
		url:"/sys/evaluation/sys_evaluation_main/sysEvaluationMain.do?method=dataScore&fdModelId=!{fdModelId}&fdModelName=!{fdModelName}",
		
		
		_setScoreDetailAttr : function() {
							var arr = new Array();
							for ( var i = 0; i < 5; i++) {
								arr.push( {  
									"score" : i,
									"times" : 0,
									"star" : 5 - i
								});
							}
							this.scoreDetail = arr;
						},
		
		startup : function() {
			this.inherited(arguments);
			this._request();
		},
		
		
		_request : function() {
			var url = util.urlResolver(this.url, {
				"fdModelId" : this.fdModelId,
				"fdModelName" : this.fdModelName
			});
			request.get(util.formatUrl(url), {
				handleAs : "json"
			}).then(
					function(response) {
						this.evaData = response;
						topic.publish(
								"/sys/evaluation/header/data",
								this,  response
								);
					},
					function(err) {
						topic.publish(
								"/sys/evaluation/header/data",
								this, {
									"error" : true,
									"msg" : err
								});
					});
		},
		
		postCreate: function(){
			this.subscribe("/sys/evaluation/header/data" , "_onCompleted");
			this.subscribe('/mui/list/onPull', 'handleOnReload');
			this.subscribe('/mui/list/onReload', 'handleOnReload');
		},
		
		buildRendering : function() {
			this.inherited(arguments);
			//评分
			domConstruct.create("div", {className : 'muiEvaluationHeaderContainerTitle',innerHTML:Msg['mui.sysEvaluation.mobile.eval.score.text']}, this.domNode);
			this.container = domConstruct.create("div", {className : 'muiEvaluationHeaderContainer'}, this.domNode);
		},
		
		_onCompleted : function(obj, data) {
			if(data.error) {
				this.container.innerHTML = Msg["mui.sysEvaluation.mobile.header.err"];
				return;
			}
			if(this.content) {
				this._initData();
				domConstruct.empty(this.container);
			}
			
			this.content = domConstruct.create("div", {className : 'muiEvaluationHeaderContent'}, this.container);
			this.buildLeftContent(data);
			this.buildRightContent(data);
			//点评个数设置
			var evalCountHtml="("+this.evalCount+")";
			dom.byId('barEvalCount').innerText=evalCountHtml;
		},
		
		buildLeftContent :  function(data) {
			array.forEach(data.detail, function(item) {
				var times = parseInt(item.times);
			    this.scoreDetail[parseInt(item.score)].times = times;
				//计算总数
				this.evalCount += times;
			}, this); 
			var leftDom =  domConstruct.create("div", {className: 'muiEvaluationHeaderLeft'}, this.content);
			var average = data.average;
			var scoreHtml = "";
			var leftClassName = "muiEvaluationHeaderScore";
			if(this.evalCount <= 0) {
				leftClassName = "muiEvaluationHeaderNone";
				scoreHtml = Msg["mui.sysEvaluation.mobile.header.noScore"];
			} else {
				var result = (average.toString()).indexOf(".");
				if(result == -1) {
					//不含有小数点
			        average=average+".0"
			    } 
				scoreHtml = average +  "<span class='muiEvaluationScoreUnit'>" + Msg["mui.sysEvaluation.mobile.header.score"] +"</span>"; 
			}
			domConstruct.create("div" ,{className:leftClassName, innerHTML:scoreHtml }, leftDom);
			var widget = new Rating({
				value :  average
			});
			leftDom.appendChild(widget.domNode);
		},
		
		buildRightContent :  function(data) {
			
			//最大点评数的宽度
			var evalCountWith=0;
			if(this.evalCount){
				var maxEvalCount=0;
				array.forEach(this.scoreDetail, function(item) {
					if(item.times>maxEvalCount){
						maxEvalCount=item.times
					}
				}, this);
				//点评最大数位数,+1为距离左边宽度为7px
				var maxEvalCountNum = maxEvalCount.toString().length+1;
				//宽度
				evalCountWith=7*maxEvalCountNum
			}
			
			this.leftDom = domConstruct.create("div", {
								className : 'muiEvaluationHeadeRight'
							}, this.content);
			var uldom = domConstruct.create("ul", {
				className : 'muiEvaluationHistogramContainer'
			}, this.leftDom);
			var cw  = domGeometry.getContentBox(uldom).w - 45-evalCountWith;
			
			array.forEach(this.scoreDetail, function(item) {
				if(this.evalCount <= 0 ) {
					item.item_with = "0px";
				} else {
					var percent = item.times / this.evalCount ;
					item.percent = (percent* 100) + "%";
					item.item_with = percent * cw  + "px";
				}
				this._buildHistogram(uldom, item, cw);
			}, this);
			
			domConstruct.create("div" ,{className:'muiEvaluationHeadeCount', innerHTML:(Msg["mui.sysEvaluation.mobile.header.count"].replace('%count%',this.evalCount)) }, this.leftDom);

		},
		
		_buildHistogram: function(dom, item, cw) {
			
			var __li = domConstruct.create("li", {
				className : 'muiEvaluationHistogram'
			}, dom);
			
			//星级
			var ratingHtml=""
			for(var i=0;i<item.star;i++){
				ratingHtml+='<i class="muiStartOff"></i>'
			}
			
			var muiEvaluationHistogramTitleDom =domConstruct.create("span", {
				className : 'muiEvaluationHistogramTitle',
				innerHTML : ratingHtml
			}, __li);
			//评分柱子
			var histogram = domConstruct.create("span", {
				className : 'muiEvaluationHistogramContent'
			}, __li);
			domStyle.set(histogram, {"width" : cw + "px"});
			var histogramBody =  domConstruct.create("span", {
				className : 'muiEvaluationHistogramBody'
			}, histogram);
			domStyle.set(histogramBody, {"width" : item.item_with});
			
			//后面的个数
			if(this.evalCount > 0) {
				domConstruct.create("span", {
					className : 'muiEvaluationHistogramNum',
					innerHTML : item.times
				}, __li);
			}
		},
		
		destroyContainerRendering : function() {
			if(this.container) {
				domConstruct.empty(this.container);
			}
		},
		
		_initData : function() {
			this.evalCount = 0;
			this._setScoreDetailAttr();
		},
		
		handleOnReload :function(widget, handle) {
			var scroll = viewRegistry.getEnclosingScrollable(this.domNode);
			if (widget === scroll) {
				this._request(handle);
			}
		}
		
	});
});