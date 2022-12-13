define(["dojo/_base/declare","../common/BaseResponse","../common/RadioResponseMixin","../common/SelectReasonResponseMixin","dojo/dom-construct","mui/i18n/i18n!km-pindagate:mobile"],
		function(declare,BaseResponse,RadioResponseMixin,SelectReasonResponseMixin,domConstruct,msg){
	
	
	return declare("km.pindagate.score.ScoreResponse",[BaseResponse,RadioResponseMixin,SelectReasonResponseMixin],{
		
		//
		renderBody:function(){
			var renderNode=this.context.renderNode,
				name='option'+this.index,
				_items=this.formatData(this.questionDef.items),
				optionsContainer=domConstruct.create('div',{},renderNode);//options domNode
			
			//call from SelectResponseMixin
			this.renderRadioGroup({
				name : name,
				value : this.draftValue,
				items : _items, 
				srcNodeRef : optionsContainer,
				showStatus:this.showStatus
			});
			
			//call from SelectReasonResponseMixin
			name='fdItems['+this.index+'].fdSelectReason';
			this.renderSelectReason({
				name : name,
				value : this.draftSelectReason,
				srcNodeRef : renderNode
			});
			
		},
		
		//格式化选项数据
		formatData:function(datas,i){
			var result=[];
			for(var index=0;index<datas.length;index++){
				var data = datas[index],
					tmp={};
				tmp.value=index;
				tmp.text=data[0];
				tmp.mark=data[1];
				tmp.img=[];
				result.push(tmp);
			}
			return result;
		}
		
	});
	
});