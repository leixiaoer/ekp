Response_RegisterJsFile(Com_Parameter.ContextPath+"km/pindagate/question_type/matrixfilled/matrixfilled_response_script.js");
Response_IncludeJsFile(Com_Parameter.ContextPath+"km/pindagate/question_type/question_type_lang.js");

/********************************************
 * 矩阵填空题
 ********************************************/
function matrixfilled_init(index,divId){
	fdQuestionDef[index] = eval("("+($('#fdQuestionDef'+index).val())+")");
	$('#'+divId).append(matrixfilled_getTableHTML(index));
	//如果为必选题，则设置一个validateResult隐藏域，值为{canSave:true|false,message:""}格式
	if(fdQuestionDef[index].willAnswer){
		var validateResult;
		var relationHide=$("input[name='fdItems["+index+"].fdDraftRelHide']").val();
		if (relationHide=="1") {
			validateResult = {canSave:true,message:""};
			$('<input type="hidden" name="validateResult" id="validateResult'+index+'">').val(JSON.stringify(validateResult))
			.appendTo($('#'+divId));
			$('<input type="hidden" name="hasAnswer" id="hasAnswer'+index+'">').val("true").appendTo($('#'+divId));
		}else{
			validateResult = {canSave:false,
					message:Question_Type_Lang.Common.prePix + $('#serialNum'+index).val()
					+Question_Type_Lang.Common.questionItem+Question_Type_Lang.Common.notNull};
			$('<input type="hidden" name="validateResult" id="validateResult'+index+'">').val(JSON.stringify(validateResult))
					.appendTo($('#'+divId));
			$('<input type="hidden" name="hasAnswer" id="hasAnswer'+index+'">').val("false").appendTo($('#'+divId));
		}
	}
	//设置一个hasAnswer隐藏域，值为true(已答)|false(未答)
	$("input[id='option"+index+"']").blur(function(){
		matrixfilled_changeAnswerVal(index);
		caculateProgress();//重新计算进度条
	});
	var answer = $("input[name='fdItems["+index+"].fdDraftAnswer']").val();
	if(answer!=null&&answer != ""){
		$("input[name='fdItems["+index+"].fdAnswer']").val(answer);
		var _split = "&___";
		var answerArr;
		//兼容历史数据
		if(answer.indexOf(_split)>-1){
			answerArr = answer.split(_split);
		}else{
			answerArr = answer.split(";");
		}
		for(var i=0;i<answerArr.length;i++){
			var nameShow = answerArr[i].substring(0,answerArr[i].indexOf(':'));
			var nameValue = answerArr[i].substring(nameShow.length+1,answerArr[i].length);
			$("input[name='"+nameShow+"']").val(nameValue);	
		}
		//选择原因
		$("textarea[name='fdItems["+index+"].fdSelectReason']").val($("input[name='fdItems["+index+"].fdDraftSelectReason']").val());
		if(answer == "selectReason"){		
			$("input[name='fdItems["+index+"].fdSelectReason']").css("display","");
		}
	}
	matrixfilled_changeAnswerVal(index)
}

/**********************************************
 * 根据题目序号返回一个单选题表单
 *********************************************/
function matrixfilled_getTableHTML(index){
	var tableHTML = '<table class="options_tb" width=90% id="matrixfilled_TB'+index+'">';
	tableHTML += matrixfilled_getTitleHTML(index);
	tableHTML += matrixfilled_getOptionsHTML(index);
	tableHTML += '</table>';
	return tableHTML;
}
 
/********************************************
 * 题头
 *********************************************/
function matrixfilled_getTitleHTML(index){
	var serialNum = $('#serialNum'+index).val();
	var titleHTML = '<tr><td>';
	titleHTML += '<div class="pi_txtTitle pi_txtTitle_no">'+serialNum+'、</div>';
	if(fdQuestionDef[index].willAnswer)
		titleHTML += '<span class="pi_txtRequire">*</span>';
	var title = fdQuestionDef[index].subject;
	title=title.replace(/<p>/g,"").replace(/<\/p>/g,"<br>").replace(/\n/g,"").replace(/(<br>)+$/g,"");//格式化标题
	//title = title.replace(/<img(?:.|\s)*?>/g, '');
	titleHTML += '<div class="pi_txtTitle pi_txtTitle_content">'+title+'</div>';
	titleHTML += '<span class="pi_txtStrong"> ['+$('#quesTypeName'+index).val()+']</span>';
	if(fdQuestionDef[index].willAnswer == true){
		titleHTML += '<span class="pi_txtStrong"> ';
		titleHTML += '['+Question_Type_Lang.Common.willAnswer+']</span>';
	} 
	titleHTML += '</td></tr>';
	if(fdQuestionDef[index].attachmentIds != 'null' && fdQuestionDef[index].attachmentIds != ''){//为修复ie8某些版本下stringify缺陷，增加!='null'判断
		var atturl = Com_Parameter.ContextPath+"km/pindagate/km_pindagate_question/kmPindagateQuestion.do?method=viewAtt&attachmentIds="
					+fdQuestionDef[index].attachmentIds;
		titleHTML += '<tr><td>';
		titleHTML += '<iframe id="attFrame" onload="autoResize(this)" src="';
		titleHTML += atturl;
		titleHTML +='" width="100%" height=0 frameborder=0 scrolling=no>';
		titleHTML +='</iframe>';
		titleHTML += '</td></tr>';
	}
	if(fdQuestionDef[index].tip != ''){
		var tip=fdQuestionDef[index].tip;
		titleHTML += '<tr><td><div class="pi_subjectExplain">';
		titleHTML += Question_Type_Lang.Common.titleDescription+'<div class="pi_subjectExplain_content">'+tip+'</div>';
		titleHTML += '</div></td></tr>';
	}
	return titleHTML;
}
/*********************************************
 * 选择项
 *********************************************/
function matrixfilled_getOptionsHTML(index){
	var vlistColumnCount = 0;
	var optionsHTML = '<tr><td><table class="question_tb" width=100%"><tr><td class="matrixfilletd">';
	if(fdQuestionDef[index].hlist){
		vlistColumnCount = fdQuestionDef[index].vlistColumnCount;
	}
	var optionIndex = 0;
	for(var key in fdQuestionDef[index].items){
		optionIndex++;
		var option = fdQuestionDef[index].items[key];
		//if(option[1] != null && option[1] != "")
		var option = option[0].replace(/[<>&"]/g,function(c){return {'<':'&lt;','>':'&gt;','&':'&amp;','"':'&quot;'}[c];});
		optionsHTML += option+'</td>'+'<td style="width: 100%;text-align: left;"><input class="pindagate_radio" type="input" id="option'+index+'" name="option'+index+'_'+key+'"/>'; 
		if(vlistColumnCount > 0){
			if((parseInt(optionIndex)) % vlistColumnCount == 0)
				optionsHTML += '</td><td><tr><td>';
			else
				optionsHTML += '</td><td class="matrixfilletd">';
		}else{
			optionsHTML += '</td></tr><tr><td class="matrixfilletd">';
		}
	}
	optionsHTML += '</td></tr>';
	if(fdQuestionDef[index].autoAddOther){
		optionsHTML += '<tr><td colspan="'+ vlistColumnCount +'"><input type="radio" name="option'+index+'" value="other"/>';
		optionsHTML += fdQuestionDef[index].otherText;
		optionsHTML += '</td></tr><tr><td colspan="'+ vlistColumnCount +'"><textarea name="fdItems['+index+'].fdOther"'+
						' style="display:none;width:840px;height:80px" ></textarea></td></tr>';
	}                      
	optionsHTML += '</table></td></tr>';
	return optionsHTML;
}

/********************************************
*选项答案发现变化时，重新设置隐藏域中答案的值。
********************************************/
function matrixfilled_changeAnswerVal(index){
	var answerVal = "";
	var _split = "&___";
	for(var itemskey in fdQuestionDef[index].items){
		var option = fdQuestionDef[index].items[itemskey];
		 var itemsValue = $('input[name="option'+index+"_"+itemskey+'"]').val();
		 var key='option'+index+"_"+itemskey;
		 if (itemsValue) {//有值
			 answerVal+=key+":"+itemsValue+_split;
		 }
	}
	if(answerVal.length>0)
		answerVal = answerVal.substring(0,answerVal.length - _split.length);
	$("input[name='fdItems["+index+"].fdAnswer']").val(answerVal);
	$("input[name='fdItems["+index+"].fdAnswerTxt']").val(answerVal);
	if(fdQuestionDef[index].willAnswer){
		matrixfilled_setValidateResultVal(index,answerVal);//校验是否可以提交
	}
	matrixfilled_setHasAnswerVal(index,answerVal);//校验是否完成
	
}

/**********************************************
 * 设置答题校验后的结果，validateResult隐藏域的值
 * 格式：{canSave:true|false,message:""}
 * 属性1：canSave: true(校验通过，允许提交)、false(校验不通过，不允许提交)
 * 属性2：message: 返回信息，多条信息用\r\n隔开
 *********************************************/
function matrixfilled_setValidateResultVal(index,answerVal){
	var totalQuestion = 0;//矩阵填空问题总数
	var validateResult = "";//校验结果
	for(var key in fdQuestionDef[index].items){
			totalQuestion++;
	}
	var answers = answerVal.split("&___");
	if(totalQuestion>answers.length||answerVal==""){
		var remainNum = totalQuestion-answers.length;
		validateResult = {canSave:false,
				message:Question_Type_Lang.Common.prePix+$('#serialNum'+index).val()+
				Question_Type_Lang.Common.questionItem+Question_Type_Lang.Common.moreHas+
				remainNum+Question_Type_Lang.Matrix.matrixQuesNoAnswer};
		$('input[id="validateResult'+index+'"]').val(JSON.stringify(validateResult));
	}else{
		validateResult = {canSave:true,message:""};
		$('input[id="validateResult'+index+'"]').val(JSON.stringify(validateResult));
	}
}
 /**************************************************
 * 设置题目是否完成，hasAnswer隐藏域的值
 * 格式：true|false
 *************************************************/
 function matrixfilled_setHasAnswerVal(index,answerVal){
	 var hasAnswer = "true";
	 var totalQuestion = 0;//矩阵问题总数
	for(var key in fdQuestionDef[index].items){
		totalQuestion++;
	}
	var answers = answerVal.split("&___");
	if (answers==""||answers==null) {
		hasAnswer="false";
	}
	if(totalQuestion>answers.length){
		hasAnswer="false";
	}
	$('input[id="hasAnswer'+index+'"]').val(hasAnswer);
	caculateProgress();//重新计算进度条
 }