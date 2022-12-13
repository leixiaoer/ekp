Response_RegisterJsFile(Com_Parameter.ContextPath+"km/pindagate/question_type/singleselect/singleselect.js");
Response_IncludeJsFile(Com_Parameter.ContextPath+"km/pindagate/question_type/question_type_lang.js");
Com_IncludeFile("data.js");	

var singleSelect_fdTitleDef = null;
function singleSelect_init(index){
	var divId = "${param.divId}";
	if($('#fdTitleDef'+index).val() == null || $('#fdTitleDef'+index).val() == "")
		return;
	singleSelect_fdTitleDef = eval("("+($('#fdTitleDef'+index).val())+")");
	$('#'+divId).append(singleSelect_getTableHTML(index));
}
/**
 * 根据题目序号返回一个单选题表单
 */
function singleSelect_getTableHTML(index){
	var tableHTML = '<table class="options_tb" width=90% id="singleSelect_TB'+index+'">';
	tableHTML += '<tr class="options"><td><p class="pi_txtRed" name="tip" style="display:none;">'+Data_GetResourceString("km-pindagate:kmPindagate.msg.description")+'</p>';
	tableHTML += singleSelect_getTitleHTML(index);
	tableHTML += singleSelect_getOptionsHTML(index);
	tableHTML += '</td></tr></table>';
	return tableHTML;
}
function singleSelect_getTitleHTML(index){
	var titleHTML = '<tr><td>';
	if(singleSelect_fdTitleDef.willAnswer)
		titleHTML += '<span class="pi_txtStrong">*</span>';
	titleHTML += '<span class="pi_txtTitle" id="fdTitle'+index+'" name="fdTitle'+index+'" onclick="modifyTitleVal(this);">'+$('#fdTitle'+index).val()+'</span>';
	titleHTML += '<span class="pi_txtStrong"> ['+$('#quesTypeName'+index).val()+']</span>';
	titleHTML += '</td></tr>';
	return titleHTML;
}
function singleSelect_getOptionsHTML(index){
	var vlistColumnCount = 0;
	var optionsHTML = '<tr><td><table class="options_tb" width=100%"><tr><td>';
	if(singleSelect_fdTitleDef.hlist){
		vlistColumnCount = singleSelect_fdTitleDef.vlistColumnCount;
	}
	var optionIndex = 0;
	for(var key in singleSelect_fdTitleDef.items){
		optionIndex++;
		var option = singleSelect_fdTitleDef.items[key];
		var imgHTML = "";
		if(option[1] != null && option[1] != "")
			imgHTML = '<img src="'+option[1]+'" border="0" />';
		optionsHTML += '<input type="radio" name="option'+index+'" value="'+optionIndex+'"/>'+option[0]+'  '+imgHTML+''; 
		if(vlistColumnCount > 0){
			if((parseInt(optionIndex)) % vlistColumnCount == 0)
				optionsHTML += '</td><td><tr><td>';
			else
				optionsHTML += '</td><td>';
		}
		else{
			optionsHTML += '</td></tr><tr><td>';
		}
	}
	if(singleSelect_fdTitleDef.autoAddOther){
		optionsHTML += '<input type="radio" name="option'+index+'" value="'+optionIndex+'"/>';
		optionsHTML += singleSelect_fdTitleDef.otherText;
		optionsHTML += '<input style="width:'+singleSelect_fdTitleDef.otherTextSize*12+'px;" class="inputSgl">';
	}
	optionsHTML += '</td></tr></table></td></tr>';
	return optionsHTML;
}