define(["dojo/_base/declare","dojo/dom-construct","dojo/dom-style","dojo/topic",
        "dojox/charting/Chart","dojox/charting/axis2d/Default","dojox/charting/plot2d/Columns"],
		function(declare,domConstruct,domStyle,topic,Chart,Default,Columns){
	
	return declare("km.pindagate.common.ColumnsStatisticMixin",null,{
		
		colors :['#5484ed','#a4bdfc','#46d6db',"#7ae7bf","#51b749",'#fbd75b','#ffb878','#ff887c','#dc2127','#dbadff','#e1e1e1','#d7af00','#f08800','#df5500','#a9706f','#8d6c8d','#617488','#6f82a9','#5a8d87','#898a4e'] ,
		
		renderColumns:function(statistic,srcNodeRef){
			var columnsNode = domConstruct.create('div',{className:'columnsNode'},srcNodeRef),
			 	columnsChart = new Chart(columnsNode);
			
			
			columnsChart.addPlot('default',{
				type: Columns,
				gap:5, 
				minBarSize:2
			});//基础参数 
			var increaseArray = [],
				labelTextColorArray = [];
			for(var i = 0;i < statistic.series.length; i++){
				for(var j = 0;j < statistic.series[i].array.length; j++){
					var sum = increaseArray[j] || 0;
					sum += statistic.series[i].array[j];
					increaseArray[j] = sum;
				}
				columnsChart.addSeries("Series "+i, increaseArray.slice(0) ,{
					stroke: {color: this.colors[i %  this.colors.length ] }, 
					fill: this.colors[i %  this.colors.length ]
				});
				
				if(statistic.series[i].name){
					labelTextColorArray.push({
						text:statistic.series[i].name,
						color:this.colors[i %  this.colors.length ]
					});
				}
			}
			columnsChart.addAxis("x",{
				labelFunc:function(index){
					if( statistic.labels.length < 1 || parseInt(index)!= index ){
						return ' ';
					}else{
						if(statistic.labels[index - 1]){
							var result = '',
								each = 9 - statistic.labels.length;
							if(each < 1 ){
								each = 1;
							}
							for(var i =0;i<statistic.labels[index - 1].length;i++){
								result+=statistic.labels[index - 1][i];
								if(i != 0 && i % each == 0){
									result+='<br/>';
								}
							}
						}
						return result;
					}
				}
			});//x轴
			columnsChart.addAxis("y", {
				vertical: true, 
				fixLower: "major", 
				fixUpper: "major", 
				min: 0,
				labelFunc:function(index){
					if( parseInt(index)!= index ){
						return ' ';
					}else{
						return index;
					}
				}
			});//y轴
			columnsChart.render();
			
			var optionNode = domConstruct.create('div',{className:'optionNode'},columnsNode,'first');
			if(labelTextColorArray.length > 0){
				for(var i = 0;i<labelTextColorArray.length;i++){
					var optionNodeContainer = domConstruct.create('div',{ className:'optionNodeContainer'},optionNode);
					domConstruct.create('span',{ className:'',innerHTML:labelTextColorArray[i].text },optionNodeContainer);
					var _color = domConstruct.create('span',{ className:'optionNodeColor'},optionNodeContainer);
					domStyle.set(_color,'background-color',labelTextColorArray[i].color);
				}
			}
			
		}
		
	});
	
});