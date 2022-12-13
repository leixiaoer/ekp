define(["dojo/_base/declare"],function(declare){
	
	return declare("km.pindagate.common.OtherReasonResponseMixin",null ,{
		
		formatData:function(){
			var result=this.inherited(arguments),
				autoAddOther=this.questionDef.autoAddOther,
				otherText=this.questionDef.otherText;
			//其他选项
			if(autoAddOther){
				var tmp={};
				tmp.value='other';
				tmp.text=otherText;
				tmp.img=[];
				result.push(tmp);
			}
			return result;
		}
		
		
	});
	
});