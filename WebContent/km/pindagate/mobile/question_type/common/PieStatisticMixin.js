define(["dojo/_base/declare","dojo/dom-construct","dojo/dom-style","dojo/topic",
        "dojox/charting/Chart","dojox/charting/axis2d/Default","dojox/charting/plot2d/Pie"],
		function(declare,domConstruct,domStyle,topic,Chart,Default,Pie){
	
	return declare("km.pindagate.common.PieStatisticMixin",null,{
		
		colors :['#5EB2ED','#D87A80','#FF7F50',"#39C7C8"] ,//蓝红橙绿
		
		renderPies:function(statistic,srcNodeRef){
			var pieNode = domConstruct.create('div',{className:'pieNode'},srcNodeRef),
				pieChart = new Chart(pieNode);
			var pieSeries = [],
				labelTextColorArray = [];
			if( statistic.series.length > 0){
				var __pieStatistic =  statistic.series[0],
					sum = 0;
				for(var i =0;i<__pieStatistic.array.length;i++){
					sum += __pieStatistic.array[i] || 0;
				}
				for(var i =0;i<__pieStatistic.array.length;i++){
					percent = (__pieStatistic.array[i]/sum *100).toFixed(1);
					pieSeries.push({
						y: __pieStatistic.array[i],
						text: __pieStatistic.array[i]+'('+percent+'%)',
						fill: this.colors[i % 4]
					});
					labelTextColorArray.push({
						text : statistic.labels[i],
						color :  this.colors[i % 4]
					});
				}
			}
			pieChart.addPlot('default',{
				type: Pie,
				labels: true,
				radius: 80,
				labelOffset: 35
			});//基础参数 
			pieChart.addSeries("Series a", pieSeries);
			pieChart.render();
			
			var optionNode = domConstruct.create('div',{className:'optionNode'},pieNode,'before');
			if(labelTextColorArray.length > 0){
				for(var i = 0;i<labelTextColorArray.length;i++){
					domConstruct.create('span',{ className:'',innerHTML:labelTextColorArray[i].text },optionNode);
					var _color = domConstruct.create('span',{ className:'optionNodeColor'},optionNode);
					domStyle.set(_color,'background-color',labelTextColorArray[i].color);
				}
			}
		}
	});
	
});