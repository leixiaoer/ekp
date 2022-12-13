define(["dojo/_base/declare","mui/i18n/i18n!km-pindagate:mobile","dojo/dom"],function(declare,msg,dom){
	
	return declare("km.pindagate.common.MatrixResponseMixin", null ,{
		
		names : '',
		
		initMatrix : function(name){
			this.names += name + ';';
		},
		
		validate:function(value){
			var navVal=dom.byId("navSgin").value;
			navIndex=this.index;
			
			this.inherited(arguments);
			value= value || this.value ;
			if(!value){
				return;
			}
			var nameArray = (function(me){
				if(!me.names){
					return [];
				}else{
					var ___names = me.names.substring(0, me.names.length - 1);
					return ___names.split(';');
				}
			})(this);
			var errorIndex = -1;
			for(var i = 0;i < nameArray.length;i++){
				var name = nameArray[i];
				if(!this.value ||  !this.value[name]){
					errorIndex = i;
					break;
				}
			}
			if(errorIndex > -1 && this.questionDef && this.questionDef.willAnswer){
				this.validateResult.canSave=false;
				this.validateResult.message = msg['mobile.kmPindagateMain.matrix.notnull'].replace("%serial%", (errorIndex+1));
			}else{
				this.validateResult.canSave=true;
				this.validateResult.message = '';
			}
			if (navVal) {
				navVal=JSON.parse(navVal);
				if (navVal.indexOf(navIndex+1)>-1) {
					this.validateResult.canSave=true;
					this.validateResult.message='';
				}
			}
		}
		
	});
	
});