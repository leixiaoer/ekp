define(["dojo/_base/declare","../common/BaseStatistic","../common/ColumnsStatisticMixin","dojo/dom-construct"],
		function(declare,BaseStatistic,ColumnsStatisticMixin,domConstruct){
	
	return declare("km.pindagate.singlematrix.SinglematrixStatistic",[BaseStatistic,ColumnsStatisticMixin],{
		
		
		renderBody:function(){
			var	srcNodeRef=this.renderNode, 
				data = this.data,
				statistic = this.formatData(data.fdStatistic);
			//call from ColumnsStatisticMixin
			this.renderColumns(statistic,srcNodeRef);
		}
		
		
	});
	
});