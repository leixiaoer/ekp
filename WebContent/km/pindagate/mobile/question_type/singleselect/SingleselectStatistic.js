define(["dojo/_base/declare","../common/BaseStatistic","../common/ColumnsStatisticMixin","../common/PieStatisticMixin","dojo/dom-construct"],
		function(declare,BaseStatistic,ColumnsStatisticMixin,PieStatisticMixin,domConstruct){
	
	return declare("km.pindagate.singleselect.SingleselectStatistic",[BaseStatistic,ColumnsStatisticMixin,PieStatisticMixin],{
		
		
		renderBody:function(){
			var	srcNodeRef=this.renderNode, 
				data = this.data,
				statistic = this.formatData(data.fdStatistic);
			if(data.fdQuestionDef.statisticPic == 'pie'){
				//call from PieStatisticMixin
				this.renderPies(statistic,srcNodeRef);
			}else{
				//call from ColumnsStatisticMixin
				this.renderColumns(statistic,srcNodeRef);
			}
			
		}
		
		
	});
	
});