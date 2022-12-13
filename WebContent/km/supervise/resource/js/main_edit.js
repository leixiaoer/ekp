Com_AddEventListener(window,'load',function(){
	seajs.use(['lui/jquery','lui/dialog','lui/dialog_common'], function($, dialog, dialogCommon){
		var formValiduteObj = $KMSSValidation(document.forms[formOption.formName]);
		
		createNewFormBlankCate();
		function createNewFormBlankCate(){
			var url = location.href;
			var cateId = Com_GetUrlParameter(url,'i.docTemplate');
			var method = Com_GetUrlParameter(url,'method');
			if((cateId==null || cateId=='') && method=='add' && formOption.mode.substring(0,5)=='main_'){
				url = Com_SetUrlParameter(url,'i.docTemplate',null);
				url = url+ (url.indexOf("?")>-1?"&":"?") + "i.docTemplate=!{id}" 
				if(formOption.mode=='main_scategory'){
					dialog.simpleCategoryForNewFile(formOption.templateName, url,
			    			false,null,null,null,'_self');
				}else if(formOption.mode=='main_template'){
					dialog.categoryForNewFile(formOption.templateName, url,
				                false,null,null,null,'_self');
				}else if(formOption.mode=='main_other'){
					var context = formOption.createDialogCtx;
		    		var sourceUrl = context.sourceUrl;
		    		var params={};
		    		if(context.params){
		    			for(var i=0;i<context.params.length;i++){
			    			var argu = context.params[i];
			    			for(var field in argu){
			    				var tmpFieldObj = document.getElementsByName(field);
			    				if(tmpFieldObj.length>0){
			    					params['c.' + argu[field] + '.'+field] = tmpFieldObj[0].value;
			    				}
			    			}
			    		}
		    		}
		    		dialogCommon.dialogSelectForNewFile(context.modelName, sourceUrl, params, url, null, null, '_self');
				}
			}
		}
		
		function validateOpt(cancel){
			if(formValiduteObj!=null && formOption.subjectField!=''){
				if(cancel){
					formValiduteObj.removeElements(document.forms[formOption.formName],'required');
					formValiduteObj.resetElementsValidate($("input[name='" + formOption.subjectField + "']").get(0));
				}else{
					formValiduteObj.resetElementsValidate(document.forms[formOption.formName]);
				}
			}
		} 
		
		window.dialogSelect=function(mul, key, idField, nameField){
			if(idField.indexOf('*')>-1 && window.DocListFunc_GetParentByTagName){
				//明细表
				dialogSelectForDetail(mul, key, idField, nameField);
			}else{
				var dialogCfg = formOption.dialogs[key];
	    		if(dialogCfg){
	    			var params='';
	    			var inputs=getDialogInputs(idField);
	    			if(inputs){
	    				for(var i=0;i<inputs.length;i++){
	    					var argu = inputs[i];
	    					var modelVal=$form(argu["value"]).val();
	    					if(modelVal==null||modelVal==''){
	    						if(argu["required"]=="true"){
	    							alert("对话框参数未配置");
	    							return;
	    						}
	    						params+='&'+argu["key"]+'='+formInitData[argu["value"]];
	    					}else{
	    						params+='&'+argu["key"]+'='+modelVal;
	    					}
	    				}
	    			}
	    			dialogCommon.dialogSelect(dialogCfg.modelName,
	    					mul,dialogCfg.sourceUrl+params, null, idField, nameField,null,function(data){
	    				var outputs=getDialogOutputs(idField);
	    				if(outputs){
							if(data.length==1){
								for(var i=0;i<outputs.length;i++){
									var output=outputs[i];
									$form(output["value"]).val(data[0][output["key"]]);
	        					}
							}
	    				}
	    			});
	    		}
			}
    	}
		
		function dialogSelectForDetail(mul, key, idField, nameField){
			var tr=DocListFunc_GetParentByTagName('TR');
			var tb= DocListFunc_GetParentByTagName("TABLE");
			var tbInfo = DocList_TableInfo[tb.id];
			var refIdField=idField.replace("*",tr.rowIndex-tbInfo.firstIndex); 
			var refNameField=nameField.replace("*",tr.rowIndex-tbInfo.firstIndex); 
			var dialogCfg = formOption.dialogs[key];
    		if(dialogCfg){
    			var params='';
    			var inputs=getDialogInputs(idField);
    			if(inputs){
    				for(var i=0;i<inputs.length;i++){
    					var argu = inputs[i];
    					if(argu["value"].indexOf('*')>-1){
    						//入参来自明细表
    						var modelVal=$form(argu["value"],refIdField).val();
        					if(modelVal==null||modelVal==''){
        						if(argu["required"]=="true"){
        							alert("对话框参数未配置");
        							return;
        						}
        					}else{
        						params+='&'+argu["key"]+'='+modelVal;
        					}
    					}else{
    						//入参来自主表
    						var modelVal=$form(argu["value"]).val();
	    					if(modelVal==null||modelVal==''){
	    						if(argu["required"]=="true"){
	    							alert("对话框参数未配置");
	    							return;
	    						}
	    						params+='&'+argu["key"]+'='+formInitData[argu["value"]];
	    					}else{
	    						params+='&'+argu["key"]+'='+modelVal;
	    					}
    					}
    					
    				}
    			}
    			dialogCommon.dialogSelect(dialogCfg.modelName,
    					mul,dialogCfg.sourceUrl+params, null, refIdField, refNameField,null,function(data){
    				var outputs=getDialogOutputs(idField);
    				if(outputs){
						if(data.length==1){
							for(var i=0;i<outputs.length;i++){
								var output=outputs[i];
								$form(output["value"],refIdField).val(data[0][output["key"]]);
        					}
						}
    				}
    			});
    		}
		}
		
		function getDialogInputs(idField){
			var dialogLinks=formOption.dialogLinks;
			if(dialogLinks==null||dialogLinks.length==0){
				return null;
			}
			for(var i=0;i<dialogLinks.length;i++){
				var dialogLink=dialogLinks[i];
				if(idField==dialogLink.idField){
					return dialogLink.inputs;
				}
			}
			return null;
		};
		
		function getDialogOutputs(idField){
			var dialogLinks=formOption.dialogLinks;
			if(dialogLinks==null||dialogLinks.length==0){
				return null;
			}
			for(var i=0;i<dialogLinks.length;i++){
				var dialogLink=dialogLinks[i];
				if(idField==dialogLink.idField){
					return dialogLink.outputs;
				}
			}
			return null;
		};
		
		window.submitForm = function(status, method, isDraft){
			if(isDraft == true){
				validateOpt(true);
			}else{
				validateOpt(false);
			}
			var action = document.forms[formOption.formName].action;
			document.forms[formOption.formName].action = Com_SetUrlParameter(action,"docStatus",status);
			Com_Submit(document.forms[formOption.formName], method);
		}
	});
});
window.onload=function(){
	var dialogLinks=formOption.dialogLinks;
	if(dialogLinks==null||dialogLinks.length==0){
		return null;
	}
	for(var i=0;i<dialogLinks.length;i++){
		var sourceFields=[];
		var targetFields=[];
		var dialogLink=dialogLinks[i];
		for(var j=0;j<dialogLink.inputs.length;j++){
			var input=dialogLink.inputs[j];
			sourceFields.push(input['value']);
		}
		for(var k=0;k<dialogLink.outputs.length;k++){
			var output=dialogLink.outputs[k];
			targetFields.push(output['value']);
		}
		targetFields.push(dialogLink.idField);
		targetFields.push(dialogLink.nameField);
		$form.bind({
			field:sourceFields,
			targetFields : targetFields,
			onValueChange:function(event){
				var targetFields = event.listener.targetFields;
				for(var i=0;i<targetFields.length;i++){
					$form(targetFields[i], event.field).val(''); 
				}
			}
		});
	}
};
