define(["dojo/_base/declare", "dojo/ready","dijit/_WidgetBase","dojo/dom-construct","lib/echart/echarts","dojo/dom-style","dojo/request","dojo/dom-geometry"], 
function(declare, ready, WidgetBase, domConstruct, echarts, domStyle, request,domGeometry) {
	return declare("km.supervise.mobile.chart", [WidgetBase], {
	
		url: "../km_supervise_main/kmSuperviseMain.do?method=getLeaderTopCount",
	
		baseClass: "muiLearnMissionList",
		
		buildRendering: function() {
			this.inherited(arguments);
			this.initEcharts();
	    },
	    
		getChartDomWidth: function(chartNode){
			var width = 0;
			if(chartNode){
				var width = domGeometry.getContentBox(chartNode).w;
				if(width==0){
				   return this.getChartDomWidth(chartNode.parentNode);
				}
			}
			return width;
		},
	
	    initEcharts: function(){
			var tabContainerNode = domConstruct.create('div', { className : 'muiTabsChartTabContainer' }, this.domNode);
			var width = this.getChartDomWidth(tabContainerNode);
			var chartNodeWidth = (width == 0? window.innerWidth : width) - 30;
			domStyle.set(tabContainerNode,'width', chartNodeWidth+'px' );
			domStyle.set(tabContainerNode,'height', '280px');
	    	var myChart = echarts.init(tabContainerNode);
	    	var promise = request.get(this.url);
	    	promise.response.then(function(result) {
	    		if (result.status == 200) {
	    			var datas = JSON.parse(result.data);
	    			var option = {
	    				tooltip : {
	    					trigger: 'item',
	    					formatter: "{a}<br/>{b}:{c}({d}%)"
	    				},
	    				calculable: true,
	    				series: [{
	    					name: '面积模式',
	    					type: 'pie',
	    					radius: [30, 110],
	    					center: ['50%', '50%'],
	    					roseType: 'area',
	    					color:['#FF6F6F','#FF8D8D','#69A0FD','#CFCFCF','#E5E5E5','#4B8FFF'],
	    					data: [
	    						{ value: datas[0].delayCount, name: '已超期'},
	    						{ value: datas[0].soonDelayCount, name: '即将超期'},
	    						{ value: datas[0].soonStartCount, name: '即将开始'},
	    						{ value: datas[0].finishCount, name: '已办结'},
	    						{ value: datas[0].stopCount, name: '已终止'},
	    						{ value: datas[0].normalCount, name: '正常推进'},
	    					],
	    					itemStyle: {
	    						normal:{
	    							label: {//指示到模块的标签文字
	    								show: true,
	    								formatter: '{b}\n{c}({d}%)'
	    							},
	    							labelLine:{
	    								show:true,
	    								length:-8,
	    								lineStyle:{ width:1 }
	    							}
	    						}
	    					},
	    				}]
	    			};
	    			myChart.setOption(option);
	    		}
	    	});
	    }
	})
})
