//配置页对话框
function dialogSelect(mul, key, idField, nameField, action){
	var rowIndex;
	if(idField.indexOf('*')>-1 && window.DocListFunc_GetParentByTagName){
		var tr=DocListFunc_GetParentByTagName('TR');
		var tb= DocListFunc_GetParentByTagName("TABLE");
		var tbInfo = DocList_TableInfo[tb.id];
		rowIndex=tr.rowIndex-tbInfo.firstIndex;
	}
	var dialogCfg = formOption.dialogs[key];
	if(dialogCfg){
		var params='';
		var inputs=getDialogInputs(idField);
		if(inputs){
			for(var i=0;i<inputs.length;i++){
				var argu = inputs[i];
				var modelVal;
				if(argu["value"].indexOf('*')>-1){
					//入参来自明细表
					modelVal=$form(argu["value"],idField.replace("*",rowIndex)).val();
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
					modelVal=$form(argu["value"]).val();
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
		var tempUrl = 'sys/ui/js/category/common-template.jsp?dialogType=opener&modelName=' + dialogCfg.modelName + '&_key=dialog_' + idField;
		if(mul==true){
			tempUrl += '&mulSelect=true';
		}else{
			tempUrl += '&mulSelect=false';
		}
		var dialog = new KMSSDialog(mul,true);
		dialog.URL = Com_Parameter.ContextPath + tempUrl;
		var source = dialogCfg.sourceUrl;
		var type=getParamValueByName(source,"type");
		if("transfer"==type){
			params+='&type='+type;
		}
		var propKey = '__dialog_' + idField + '_dataSource';
		dialog[propKey] = function(){
			return source+params;
		};
		window[propKey] = dialog[propKey];
		propKey =  'dialog_' + idField;
		dialog[propKey] = function(rtnInfo){
			if(rtnInfo==null) return;
			var datas = rtnInfo.data;
			var rtnDatas=[],ids=[],names=[];
			for(var i=0;i<datas.length;i++){
				var rowData = domain.toJSON(datas[i]);
				rtnDatas.push(rowData);
				ids.push($.trim(rowData[rtnInfo.idField]));
				names.push($.trim(rowData[rtnInfo.nameField]));
			}
			if(idField.indexOf('*')>-1){
				//明细表
				$form(idField,idField.replace("*",rowIndex)).val(ids.join(";"));
				$form(nameField,idField.replace("*",rowIndex)).val(names.join(";"));
			}else{
				//主表
				$form(idField).val(ids.join(";"));
				$form(nameField).val(names.join(";"));
			}
			if(action){
				action(rtnDatas);
			}
			//出参处理
			var outputs=getDialogOutputs(idField);
			if(outputs){
				if(rtnDatas.length==1){
					for(var i=0;i<outputs.length;i++){
						var output=outputs[i];
						if(output["value"].indexOf('*')>-1){
							$form(output["value"],output["value"].replace("*",rowIndex)).val(rtnDatas[0][output["key"]]);
						}else{
							$form(output["value"]).val(rtnDatas[0][output["key"]]);
						}
					}
				}
			}
		};
		domain.register(propKey,dialog[propKey]);
		dialog.Show(800,500);
	}
}

function batchAddRow(key,idField,nameField,displayProp,optTB){
	if(optTB==null)
		optTB = DocListFunc_GetParentByTagName("TABLE");
	else if(typeof(optTB)=="string")
		optTB = document.getElementById(optTB);
	var dialogCfg = formOption.dialogs[key];
	if(dialogCfg){
		var params='';
		var inputs=getDialogInputs(idField);
		if(inputs){
			for(var i=0;i<inputs.length;i++){
				var argu = inputs[i];
				if(argu["value"].indexOf('*')>-1){
					//入参来自明细表,不处理
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
		var tempUrl = 'sys/ui/js/category/common-template.jsp?dialogType=opener&modelName=' + dialogCfg.modelName + '&_key=dialog_' + idField+'&mulSelect=true';
		var dialog = new KMSSDialog(true,true);
		dialog.URL = Com_Parameter.ContextPath + tempUrl;
		var source = dialogCfg.sourceUrl;
		var propKey = '__dialog_' + idField + '_dataSource';
		dialog[propKey] = function(){
			return source+params;
		};
		window[propKey] = dialog[propKey];
		propKey =  'dialog_' + idField;
		dialog[propKey] = function(rtnInfo){
			if(rtnInfo==null) return;
			var data = rtnInfo.data;
			if(data.length>0){
				var outputs=getDialogOutputs(idField);
				for(var i=0;i<data.length;i++){
    				var newRow=DocList_AddRow(optTB);
					var tbInfo = DocList_TableInfo[optTB.id];
					var refIdField=idField.replace("*",newRow.rowIndex-tbInfo.firstIndex); 
					var rowData = domain.toJSON(data[i]);
					//id,name
					$form(idField,refIdField).val(rowData['fdId']);
					$form(nameField,refIdField).val(rowData[displayProp]);
					//出参
					if(outputs){
    					for(var j=0;j<outputs.length;j++){
							var output=outputs[j];
							$form(output["value"],refIdField).val(rowData[output["key"]]);
    					}
					}
				}
			}
		};
		domain.register(propKey,dialog[propKey]);
		dialog.Show(800,500);
	}
};


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
}
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
}

window.onload=function(){
	bindDialogLink();
	// 函数注册
	formOption.fn = {
		sum : function(data, detailTable, func){
			var size = formOption.fn.count(data, detailTable);
			var result = 0;
			for(var i=0; i<size; i++){
				result += func(data, i);
			}
			return result;
		},
		avg : function(data, detailTable, func){
			var size = formOption.fn.count(data, detailTable);
			if(size==0){
				return 0;
			}
			return formOption.fn.sum(data, detailTable, func)*1.0/size;
		},
		count : function(data, detailTable){
			for(var o in data){
				var _detailTable = getDetailTable(o);
				if(_detailTable==detailTable && $.isArray(data[o])){
					return data[o].length;
				}
			}
			return 0;
		},
		dateDiffMin:function(beginTime,endTime){
			return Math.round((endTime.getTime()-beginTime.getTime())/1000/60);
		},
		dateDiffDay:function(beginTime,endTime){
			return Math.round((endTime.getTime()-beginTime.getTime())/1000/60/60/24);
		},
		dateMerge:function(date,time){
			return new Date(date.getTime()+time.getTime());
		},
		dateAddDay:function(date,add){
			return new Date(date.getTime()+add*24*60*60*1000);
		},
		dateAddMin:function(date,add){
			return new Date(date.getTime()+add*60*1000);
		}
	};
	// key:detailTableId, value:[attrLink]
	var detailTableAttrLinks = {};
	bindAttrLinks();
	function bindAttrLinks(){
		if(formOption.attrLinks==null || formOption.attrLinks.length==0){
			return;
		}
		for(var i=0;i<formOption.attrLinks.length;i++){
			var attrLink = formOption.attrLinks[i];
			var conditions = attrLink.conditions;
			var inputs = [];
			var detailTables = [];
			for(var j=0; j<conditions.length; j++){
				var condition = conditions[j];
				if(condition.inputs){
					for(var k=0; k<condition.inputs.length; k++){
						if($.inArray(condition.inputs[k], inputs)==-1){
							inputs.push(condition.inputs[k]);
							var detailTable = getDetailTable(condition.inputs[k]);
							if(detailTable && $.inArray(detailTable, detailTables)==-1){
								detailTables.push(detailTable);
							}
						}
					}
				}
			}
			attrLink.inputs = inputs;
			// 明细表事件
			for(var j=0; j<detailTables.length; j++){
				var detailTableAttrLink = detailTableAttrLinks['TABLE_DocList_'+detailTables[j]];
				if(detailTableAttrLink==null){
					detailTableAttrLink = detailTableAttrLinks['TABLE_DocList_'+detailTables[j]] = [];
				}
				detailTableAttrLink.push(attrLink);
			}
			// 表单事件
			$form.bind({
				field : inputs,
				attrLink : attrLink,
				onValueChange:function(event){
					var eventDetail = getDetailTable(event.field);
					if(eventDetail){
						var detailTable = getDetailTable(event.listener.attrLink.outputs[0]);
						if(eventDetail==detailTable){
							eventDetail = event.field.substring(eventDetail.length+1, event.field.indexOf(']'));
						}else{
							eventDetail = null;
						}
					}
					fireAttrLink(event.listener.attrLink, eventDetail);
				}
			});
			// 初次加载
			fireAttrLink(attrLink);
		}
	}
	var detailTableValueLinks = {};
	bindValueLinks();
	function bindValueLinks(){
		if(formOption.valueLinks==null || formOption.valueLinks.length==0){
			return;
		}
		for(var i=0;i<formOption.valueLinks.length;i++){
			var valueLink = formOption.valueLinks[i];
			var inputs = valueLink.inputs;
			var detailTables = [];
			if(inputs){
				for(var j=0; j<inputs.length; j++){
					var input = inputs[j];
					var detailTable = getDetailTable(input);
					if(detailTable && $.inArray(detailTable, detailTables)==-1){
						detailTables.push(detailTable);
					}
				}
			}
			// 明细表事件
			for(var j=0; j<detailTables.length; j++){
				var detailTableValueLink = detailTableValueLinks['TABLE_DocList_'+detailTables[j]];
				if(detailTableValueLink==null){
					detailTableValueLink = detailTableValueLinks['TABLE_DocList_'+detailTables[j]] = [];
				}
				detailTableValueLink.push(valueLink);
			}
			// 表单事件
			$form.bind({
				field : inputs,
				valueLink : valueLink,
				onValueChange:function(event){
					var eventDetail = getDetailTable(event.field);
					if(eventDetail){
						var detailTable = getDetailTable(event.listener.valueLink.output);
						if(eventDetail==detailTable){
							eventDetail = event.field.substring(eventDetail.length+1, event.field.indexOf(']'));
						}else{
							eventDetail = null;
						}
					}
					fireValueLink(event.listener.valueLink, eventDetail);
				}
			});
		}
	}
	
	var detailTableOptionLinks={};
	bindOptionLinks();
	function bindOptionLinks(){
		if(formOption.optionLinks==null||formOption.optionLinks.length==0){
			return;
		}
		for(var i=0;i<formOption.optionLinks.length;i++){
			var optionLink = formOption.optionLinks[i];
			var conditions = optionLink.conditions;
			var inputs = [];
			var detailTables = [];
			for(var j=0; j<conditions.length; j++){
				var condition = conditions[j];
				if(condition.inputs){
					for(var k=0; k<condition.inputs.length; k++){
						if($.inArray(condition.inputs[k], inputs)==-1){
							inputs.push(condition.inputs[k]);
							var detailTable = getDetailTable(condition.inputs[k]);
							if(detailTable && $.inArray(detailTable, detailTables)==-1){
								detailTables.push(detailTable);
							}
						}
					}
				}
			}
			optionLink.inputs = inputs;
			// 明细表事件
			for(var j=0; j<detailTables.length; j++){
				var detailTableOptionLink = detailTableOptionLinks['TABLE_DocList_'+detailTables[j]];
				if(detailTableOptionLink==null){
					detailTableOptionLink = detailTableOptionLinks['TABLE_DocList_'+detailTables[j]] = [];
				}
				detailTableOptionLink.push(optionLink);
			}
			// 表单事件
			$form.bind({
				field : inputs,
				optionLink : optionLink,
				onValueChange:function(event){
					var eventDetail = getDetailTable(event.field);
					if(eventDetail){
						var detailTable = getDetailTable(event.listener.optionLink.output);
						if(eventDetail==detailTable){
							eventDetail = event.field.substring(eventDetail.length+1, event.field.indexOf(']'));
						}else{
							eventDetail = null;
						}
					}
					fireOptionLink(event.listener.optionLink, eventDetail);
				}
			});
			// 初次加载
			fireOptionLink(optionLink);
		}
	}
	
	function fireOptionLink(optionLink, fieldIndex){
		var detailTable = getDetailTable(optionLink.output);
		var data = {};
		if(detailTable){
			// 明细表
			if(fieldIndex==null){
				// 不带下标，分开计算
				var size = $form(optionLink.output).size();
				for(var i=0; i<size; i++){
					execCondition(i);
				}
			}else{
				// 带下标
				execCondition(fieldIndex);
			}
		}else{
			// 非明细表
			execCondition();
		}
		function execCondition(fieldIndex){
			for(var i=0; i<optionLink.conditions.length; i++){
				var condition = optionLink.conditions[i];
				var result = execLinkValue(data, condition.inputs, condition.value, fieldIndex);
				if(result==true){
					var optionVal=condition.optionValue;
					if(fieldIndex!=null){
						if('radio'==optionLink.displayType){
							var oldVal=$('input[name="'+optionLink.output.replace('*', fieldIndex)+'"]:checked').val();
							$('input[name="'+optionLink.output.replace('*', fieldIndex)+'"]').parent().hide();
							$('input[name="'+optionLink.output.replace('*', fieldIndex)+'"]').removeAttr('checked');
							for(var j=0;j<optionVal.length;j++){
								if(optionVal[j].value==oldVal){
									$('input[name="'+optionLink.output.replace('*', fieldIndex)+'"][value="'+optionVal[j].value+'"]').prop('checked',true);
								}
								$('input[name="'+optionLink.output.replace('*', fieldIndex)+'"][value="'+optionVal[j].value+'"]').parent().show();
							}
						}else if('select'==optionLink.displayType){
							var oldVal=$('select[name="'+optionLink.output.replace('*', fieldIndex)+'"] option:selected').val();
							$('select[name="'+optionLink.output.replace('*', fieldIndex)+'"] option').each(function(){
								if($(this).val().length>0){
									$(this).attr('selected',false);
									$(this).hide();
								}
							});
							for(var j=0;j<optionVal.length;j++){
								if(optionVal[j].value==oldVal){
									$('select[name="'+optionLink.output.replace('*', fieldIndex)+'"] option[value="'+optionVal[j].value+'"]').prop('selected',true);
								}
								$('select[name="'+optionLink.output.replace('*', fieldIndex)+'"] option[value="'+optionVal[j].value+'"]').show();
							}
						}
					}else{
						if('radio'==optionLink.displayType){
							var oldVal=$('input[name="'+optionLink.output+'"]:checked').val();
							$('input[name="'+optionLink.output+'"]').parent().hide();
							$('input[name="'+optionLink.output+'"]').removeAttr('checked');
							for(var j=0;j<optionVal.length;j++){
								if(optionVal[j].value==oldVal){
									$('input[name="'+optionLink.output+'"][value="'+optionVal[j].value+'"]').prop('checked',true);
								}
								$('input[name="'+optionLink.output+'"][value="'+optionVal[j].value+'"]').parent().show();
							}
						}else if('select'==optionLink.displayType){
							var oldVal=$('select[name="'+optionLink.output+'"] option:selected').val();
							$('select[name="'+optionLink.output+'"] option').each(function(){
								if($(this).val().length>0){
									$(this).attr('selected',false);
									$(this).hide();
								}
							});
							for(var j=0;j<optionVal.length;j++){
								if(optionVal[j].value==oldVal){
									$('select[name="'+optionLink.output+'"] option[value="'+optionVal[j].value+'"]').prop('selected',true);
								}
								$('select[name="'+optionLink.output+'"] option[value="'+optionVal[j].value+'"]').show();
							}
						}
					}
					return;
				}
			}
		}
	}
	
	
	bindDetailTable();
	function bindDetailTable(){
		if(window.DocList_Info==null){
			return;
		}
		for(var i=0; i<DocList_Info.length; i++){
			var tb = document.getElementById(DocList_Info[i]);
			if(tb==null){
				continue;
			}
			$(tb).bind({
				'table-add':function(e, row){
					var tbId = e.target.id;
					var fieldIndex = row.rowIndex - DocList_TableInfo[tbId].firstIndex;
					if(detailTableAttrLinks[tbId]){
						for(var i=0; i<detailTableAttrLinks[tbId].length; i++){
							fireAttrLink(detailTableAttrLinks[tbId][i], fieldIndex);
						}
					}
					if(detailTableValueLinks[tbId]){
						for(var i=0; i<detailTableValueLinks[tbId].length; i++){
							fireValueLink(detailTableValueLinks[tbId][i], fieldIndex);
						}
					}
					if(detailTableOptionLinks[tbId]){
						for(var i=0; i<detailTableOptionLinks[tbId].length; i++){
							fireOptionLink(detailTableOptionLinks[tbId][i], fieldIndex);
						}
					}
				},
				'table-delete':function(e){
					var tbId = e.target.id;
					setTimeout(function(){
						if(detailTableAttrLinks[tbId]){
							for(var i=0; i<detailTableAttrLinks[tbId].length; i++){
								var attrLink = detailTableAttrLinks[tbId][i];
								if(getDetailTable(attrLink.outputs[0])==null){
									fireAttrLink(attrLink);
								}
							}
						}
						if(detailTableValueLinks[tbId]){
							for(var i=0; i<detailTableValueLinks[tbId].length; i++){
								var valueLink = detailTableValueLinks[tbId][i];
								if(getDetailTable(valueLink.output)==null){
									fireValueLink(valueLink);
								}
							}
						}
						if(detailTableOptionLinks[tbId]){
							for(var i=0; i<detailTableOptionLinks[tbId].length; i++){
								var optionLink = detailTableOptionLinks[tbId][i];
								if(getDetailTable(optionLink.output)==null){
									fireOptionLink(optionLink);
								}
							}
						}
					}, 100);
				}
			});
		}
	}
	addLinkValidates();
	function addLinkValidates(){
		var linkValidates=formOption.linkValidates;
		if(linkValidates!=null&&linkValidates.length>0){
			var _validation = $KMSSValidation();
			for(var i=0;i<linkValidates.length;i++){
				var iden=linkValidates[i].iden;
				var message=linkValidates[i].message;
				_validation.addValidator(iden,message,function(v,e,o){
					var linkValidate=getLinkValidateByIden(o.iden+'(iden)');
					if(linkValidate==null){
						return true;
					}
					var func=linkValidate.value;
					var inputs=linkValidate.inputs;
					var outputs=linkValidate.outputs;
					var data={};
					var detailTable = getDetailTable(outputs[0]);
					var eventDetail = getDetailTable(e.name);
					if(eventDetail){
						if(eventDetail==detailTable){
							eventDetail = e.name.substring(eventDetail.length+1,e.name.indexOf(']'));
						}else{
							eventDetail = null;
						}
					}
					if(detailTable){
						// 明细表
						if(eventDetail==null){
							// 不带下标，分开计算
							var size = $form(outputs[0]).size();
							for(var i=0; i<size; i++){
								var result=execLinkValue(data,inputs,func,i);
								return result==null?true:result;
							}
						}else{
							// 带下标
							var result=execLinkValue(data,inputs,func,eventDetail);
							return result==null?true:result;
						}
					}else{
						// 非明细表
						var result=execLinkValue(data,inputs,func);
						return result==null?true:result;
					}
				});
			}
		}
	}
	
	function getLinkValidateByIden(iden){
		var linkValidates=formOption.linkValidates;
		if(linkValidates!=null||linkValidates.length>0){
			for(var i=0;i<linkValidates.length;i++){
				if(iden==linkValidates[i].iden){
					return linkValidates[i];
				}
			}
		}
		return null;
	}
};
function bindDialogLink(){
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
					$form(targetFields[i],event.field).val(''); 
				}
			}
		});
	}
}
function getDetailTable(field){
	var index = field.indexOf('[');
	if(index==-1){
		return null;
	}
	return field.substring(0, index);
}
function fireAttrLink(attrLink, fieldIndex){
	var detailTable = getDetailTable(attrLink.outputs[0]);
	var data = {};
	if(detailTable){
		// 明细表
		if(fieldIndex==null){
			// 不带下标，分开计算
			var size = $form(attrLink.outputs[0]).size();
			for(var i=0; i<size; i++){
				execCondition(i);
			}
		}else{
			// 带下标
			execCondition(fieldIndex);
		}
	}else{
		// 非明细表
		execCondition();
	}
	function execCondition(fieldIndex){
		for(var i=0; i<attrLink.conditions.length; i++){
			var condition = attrLink.conditions[i];
			var result = execLinkValue(data, condition.inputs, condition.value, fieldIndex);
			if(result==true){
				for(var j=0; j<attrLink.outputs.length; j++){
					if(fieldIndex!=null){
						$form(attrLink.outputs[j].replace('*', fieldIndex)).editLevel(condition.editLevel);
					}else{
						$form(attrLink.outputs[j]).editLevel(condition.editLevel);
					}
				}
				return;
			}
		}
	}
}
function fireValueLink(valueLink, fieldIndex){
	var detailTable = getDetailTable(valueLink.output);
	var data = {};
	if(detailTable){
		// 明细表
		if(fieldIndex==null){
			// 不带下标，分开计算
			var size = $form(valueLink.output).size();
			for(var i=0; i<size; i++){
				execValue(i);
			}
		}else{
			// 带下标
			execValue(fieldIndex);
		}
	}else{
		// 非明细表
		execValue();
	}
	function execValue(fieldIndex){
		var result = execLinkValue(data, valueLink.inputs, valueLink.value, fieldIndex);
		if(result!=null){
			result=$form.str(result,formOption.dataType[valueLink.output]);
			if(fieldIndex!=null){
				$form(valueLink.output.replace('*', fieldIndex)).val(result);
			}else{
				$form(valueLink.output).val(result);
			}
		}
	}
}
function execLinkValue(data, inputs, func, fieldIndex){
	if(inputs){
		for(var i=0; i<inputs.length; i++){
			var input = inputs[i];
			if(data[input]==null || fieldIndex!=null && input.indexOf('*')>-1){
				// 加载数据
				var value = null;
				if(input.indexOf('*')>-1){
					if(fieldIndex!=null){
						value = $form(input.replace('*', fieldIndex)).val();
					}else{
						value = $form(input).val();
					}
				}else{
					value = $form(input).val();
					if(value==null && formInitData!=null){
						value = formInitData[input];
					}
				}
				value = $form.format(value, formOption.dataType[input]);
				if($.isArray(value)){
					for(var j=0; j<value.length; j++){
						if(value[j]==null){
							return null;
						}
					}
				}else{
					if(value==null){
						return null;
					}
				}
				data[input] = value;
			}
		}
	}
	return func(data);
}

//获取链接中的参数名及参数值
function getParamValueByName(url,name){
	var params = url.substr(1).split("&"), paramsObject = {};
	for (var i = 0; i < params.length; i++) {
		if (!params[i])
			continue;
		var a = params[i].split("=");
		if(a[0] == name){
			return decodeURIComponent(a[1]);
		}
	}
	return "";
}