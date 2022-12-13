define(["dojo/_base/declare","dijit/_WidgetBase","mui/rtf/_ImageResizeMixin","dojox/charting/Chart","dojox/charting/axis2d/Default","dojox/charting/plot2d/Bars",
        "dojo/dom-construct","dojo/dom-style","dojo/html","dojo/query","dojo/topic","dojo/request","mui/util","dojo/ready","mui/i18n/i18n!km-pindagate:mobile",
        "dojo/dom","dojo/on"],
		function(declare,WidgetBase,_ImageResizeMixin,Chart,Default,Bars,domConstruct,domStyle,html,query,topic,request,util,ready,msg,dom,on){
	
	return declare("km.pindagate.base.BaseStatistic",[WidgetBase,_ImageResizeMixin],{
		
		lazy:true,//是否延迟渲染
		
		hasRender:false,//组件是否已渲染
		
		buildRendering:function(){
			this.inherited(arguments);
			this.initProperties();//属性
			if(!this.lazy){
				this.render();//渲染
			}
		},
		
		//属性初始化
		initProperties:function(){
			this.inherited(arguments);
			if(this.context){
				this.renderNode = this.context.renderNode;
				this.data = this.context.data;
			}
		},
		
		render:function(){
			var self =this;
			if(!this.hasRender){
				this.renderTitle();	//题头
				this.renderTip();//摘要、说明
				this.renderProgess();//参与进度条
				this.renderBody();//内容
				ready(function(){
					self.formatContent(self.context.renderNode);
				})
			}
			this.hasRender=true;
		},
		
		renderTitle:function(){
			var renderNode=this.renderNode,
			data = this.data,
			subject=this.formatStr(data.fdQuestionDef.subject),
			willAnswer=data.fdQuestionDef.willAnswer;
			var dataNum = data.serialNum;
			if (dataNum<=10) {
				dataNum="0"+dataNum
			}
		
			this.titileFlag=domConstruct.create('div',{className:'pindagate_body_tit_flag' },renderNode);
			domConstruct.create('span',{innerHTML:data.quesTypeName},this.titileFlag);
			//标题
			var subjectNode=domConstruct.create('div',{className:'pindagate_body_tit' },renderNode);
			var subjectNum = domConstruct.create('span',{innerHTML:dataNum,className:'pindagate_body_tit_num' },subjectNode);
			//是否必答
			if(willAnswer){
				domConstruct.create('span',{innerHTML:'*',className:'muiRequire' },subjectNode);
			}
			this.subjectDesc=domConstruct.create('span',{className:'pindagate_body_tit_desc' },subjectNode);
			domConstruct.create('span',{innerHTML:subject },this.subjectDesc);
			
		},
			
			renderTip:function(){
				var	renderNode=this.renderNode, 
					data = this.data,
					tip=this.formatStr(data.fdQuestionDef.tip);
				if(tip){
					this.tipNode=domConstruct.create('div',{innerHTML:tip,className:'muiListSummary' },renderNode);
				}
		},
		
		renderProgess:function(){
			var	renderNode=this.renderNode, 
				data = this.data,
				statistic = data.fdStatistic,
				total = parseInt(statistic.notInvolvedNumber) + parseInt(statistic.participateNumber);
			domConstruct.create('div',{className:'progressContainer', innerHTML:statistic.participateNumber+'/'+ total +'('+ msg['mobile.kmPindagateMain.hasParticipate'] +'/' + msg['mobile.kmPindagateMain.total'] + ')' },renderNode);
		},
		
		renderBody:function(){
			//for override
		},
		
		handlePaging:function(args){
			var currentPage=args.currentPage,
				pageType=args.pageType || 'one',//分页类型,one:一道题一页(适合移动端)、many:多道题一页(适合PC端)
				myPage=this.pageno;
			if(pageType=='one'){
				myPage=this.serialNum;
			}
			if(pageType=='one' || pageType == 'many'){
				if(myPage == currentPage){
					this.show();
				}else{
					this.hide();
				}
			}
			topic.publish("/mui/list/toTop", null ,{y: 0 });
		},
		
		//显示本题
		show:function(){
			this.render();
			domStyle.set(this.context.renderNode,'display','block');
		},
		
		//隐藏本题
		hide:function(){
			domStyle.set(this.context.renderNode,'display','none');
		},
		
		//格式化字符串
		formatStr:function(str){
			return str.replace(/<p>/g,"").replace(/<\/p>/g,"<br>").replace(/\n/g,"").replace(/(<br>)+$/g,"");;
		},
		
		//格式化选项数据
		formatData:function(datas){
			var statistic = {},
				series = datas.items,
				labels = datas.options;
			labels = labels.slice(1,labels.length);
			statistic.labels = labels;
			
			var seriesArray = [];
			//parseInt
			if(series.length > 0){
				if(series[0] instanceof Array){
					for(var i =0;i<series.length;i++){
						var singleObj = this.formatSingleData(series[i]);
						seriesArray.push(singleObj);
					}
				}else{
					var singleObj = this.formatSingleData(series);
					seriesArray.push(singleObj);
				}
			}
			statistic.series = seriesArray;
			return statistic;
		},
		
		formatSingleData:function(series){
			var singleObj = {name:series[0],array:[]};
			for(var i = 1;i < series.length;i++){
				series[i] = parseInt(series[i]);
				singleObj.array.push(series[i]);
			}
			return singleObj;
		}
		
		
	});
	
});