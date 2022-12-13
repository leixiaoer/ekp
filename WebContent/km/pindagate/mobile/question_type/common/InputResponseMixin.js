define(["dojo/_base/declare","mui/i18n/i18n!km-pindagate:mobile"],function(declare,msg){
	
	return declare("km.pindagate.common.InputResponseMixin", null ,{
		
		names : '',
		
		initMatrix : function(name){
			this.names = name ;
		},
		initForm : function(str){
			str=str.substring(0, str.length - 1);
			this.nameKey = str.split(';') ;
		},
		
		validate:function(value){
			this.inherited(arguments);
			value= value || this.value ;
			if(!value){
				return;
			}
			var errorIndex = -1;
			var formName=this.names.substring(0,this.names.length - 1);
			var formNameSplit=formName.split('&___');
			for(var i = 0;i < this.nameKey.length;i++){
				if(!formNameSplit[i]){
					errorIndex = i;
					break;
				}
			}
			if(errorIndex > -1 && this.questionDef && this.questionDef.willAnswer){
				this.validateResult.canSave=false;
				//this.validateResult.message = msg['mobile.kmPindagateMain.matrix.notnull'].replace("%serial%", (errorIndex+1));
				this.validateResult.message = "请填完所有填空题";
			}else{
				this.validateResult.canSave=true;
				this.validateResult.message = '';
			}
		}
		
	});
	
});