Response_RegisterJsFile(Com_Parameter.ContextPath+"km/pindagate/question_type/multiselect/multiselect_script.js");
Response_IncludeJsFile(Com_Parameter.ContextPath+"km/pindagate/question_type/question_type_lang.js");

/***********************************************
 * 多选题初始化
 ************************************************/
function multiselect_init(index,divId){
	fdQuestionDef[index] = eval("("+($('#fdQuestionDef'+index).val())+")");
	$('#'+divId).append(multiSelect_getTableHTML(index));
	//如果为必选题，则设置一个validateResult隐藏域，值为{canSave:true|false,message:""}格式
	if(fdQuestionDef[index].willAnswer){
		var validateResult = {canSave:false,
				message:Question_Type_Lang.Common.prePix + $('#serialNum'+index).val()
				+Question_Type_Lang.Common.questionItem+Question_Type_Lang.Common.notNull};
		$('<input type="hidden" name="validateResult" id="validateResult'+index+'">').val(JSON.stringify(validateResult))
				.appendTo($('#'+divId));
	}
	$("input:checkbox[name='option"+index+"']").click(function(){
		multiSelect_changeAnswerVal(index);
	});
	var answer = $("input[name='fdItems["+index+"].fdDraftAnswer']").val();
	if(answer!=null&&answer != ""){
		$("input[name='fdItems["+index+"].fdAnswer']").val(answer);
		var answerArr = answer.split(";");
		for(var i=0;i<answerArr.length;i++){
			$("input[name='option"+index+"'][value="+answerArr[i]+"]").attr("checked",true);
		}
		$("textarea[name='fdItems["+index+"].fdOther']").val($("input[name='fdItems["+index+"].fdDraftOther']").val());
		if(answer.indexOf("other")>-1){		
			$("input[name='fdItems["+index+"].fdOther']").css("display","");
		}
		multiSelect_changeAnswerVal(index);
	}
}

/*************************************************
 * 根据题目序号返回一个多选题表单
 ************************************************/
function multiSelect_getTableHTML(index){
	var tableHTML = '<table class="options_tb" width=90% id="multiSelect_TB'+index+'">';
	tableHTML += multiSelect_getTitleHTML(index);
	tableHTML += multiSelect_getOptionsHTML(index);
	tableHTML += '</table>';
	return tableHTML;
}

/***********************************************
 * 题头
 ************************************************/
function multiSelect_getTitleHTML(index){
	var serialNum = $('#serialNum'+index).val();
	var titleHTML = '<tr><td>';
	titleHTML += '<div class="pi_txtTitle pi_txtTitle_no">'+serialNum+'、</div>';
	if(fdQuestionDef[index].willAnswer)
		titleHTML += '<span class="pi_txtStrong">*</span>';
	titleHTML += '<span class="pi_txtStrong"> ['+$('#quesTypeName'+index).val()+']</span>';
	if(fdQuestionDef[index].willAnswer == true){
		titleHTML += '<span class="pi_txtStrong"> ';
		titleHTML += '['+Question_Type_Lang.Common.willAnswer+']</span>';
	}
	if(fdQuestionDef[index].minSelectNumber != ""){
		titleHTML += '<span class="pi_txtStrong"> ';
		titleHTML += '['+Question_Type_Lang.Common.selectAtLeast;
		titleHTML += fdQuestionDef[index].minSelectNumber;
		titleHTML += Question_Type_Lang.Common.items+']</span>';
	}
	var title = fdQuestionDef[index].subject;
	title = title.replace("<div>", "");
	title = title.replace("</div>", "");
	title = title.replace(/<img/g, '<img  onMouseOver="showTooltip(event, this.src)" onMouseOut="hideTooltip();"');
	titleHTML += '<div class="pi_txtTitle pi_txtTitle_content">'+title+'</div>';
	titleHTML += '</td></tr>';
	if(fdQuestionDef[index].attachmentIds != ''){
		var atturl = Com_Parameter.ContextPath+"km/pindagate/km_pindagate_question/kmPindagateQuestion.do?method=viewAtt&attachmentIds="+
					fdQuestionDef[index].attachmentIds;
		titleHTML += '<tr><td>';
		titleHTML += '<iframe id="attFrame" onload="autoResize(this)" src="';
		titleHTML += atturl;
		titleHTML += '" width=100% height=100% frameborder=0 scrolling=no>';
		titleHTML += '</iframe>';
		titleHTML += '</td></tr>';
	}
	if(fdQuestionDef[index].tip != ''){
		titleHTML += '<tr><td><div class="pi_subjectExplain">';
		titleHTML += Question_Type_Lang.Common.titleDescription+$("<div></div>").append(fdQuestionDef[index].tip).html();
		titleHTML += '</div></td></tr>';
	}
	return titleHTML;
}
 
 /***********************************************
  *选项 
  ************************************************/
function multiSelect_getOptionsHTML(index){
	var vlistColumnCount = 0;
	var optionsHTML = '<tr><td><table class="options_tb" width=100%"><tr><td>';
	if(fdQuestionDef[index].hlist){
		vlistColumnCount = fdQuestionDef[index].vlistColumnCount;
	}
	var optionIndex = 0;
	for(var key in fdQuestionDef[index].items){
		optionIndex++;
		var option = fdQuestionDef[index].items[key];
		var imgHTML = "";
		if(option[1] != null && option[1] != ""){
			var imgArr = option[1].split(";");
			for(var x=0; x<imgArr.length; x++){
				if(imgArr[x]!=0)
					imgHTML += '<img src="'+imgArr[x]+'"  border="1" onMouseOver="showTooltip(event, this.src)" '+
								'onMouseOut="hideTooltip();" border="0"  width="14px" height="14px"/>&nbsp;&nbsp;';
			}
		}
		optionsHTML += '<input type="checkbox" name="option'+index+'" value="'+key+'"/>'+option[0]+'  '+imgHTML+''; 
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
	optionsHTML += '</td></tr>';
	if(fdQuestionDef[index].autoAddOther){
		optionsHTML += '<tr><td colspan="'+ vlistColumnCount +'"><input type="checkbox" name="option'+index+'" value="other"/>';
		optionsHTML += fdQuestionDef[index].otherText;
		optionsHTML += '</td></tr><tr><td colspan="'+ vlistColumnCount +'"><textarea name="fdItems['+
						index+'].fdOther" style="display:none;width:840px;height:80px" ></textarea></td></tr>';
	}
	optionsHTML += '</table></td></tr>';
	return optionsHTML;
}
  
/***********************************************
*选项答案发现变化时，重新设置隐藏域中答案的值。
***********************************************/
function multiSelect_changeAnswerVal(index){
	var answerVal = "";
	var answerTxt = "";
	$("input:checkbox[name='option"+index+"']").each(function(){
		 if(this.checked){
			answerVal += ";"+this.value;
			
			if(this.value == 'other')
				answerTxt += ";"+fdQuestionDef[index].otherText;
			 else
				answerTxt += ";"+fdQuestionDef[index].items[this.value][0];
				
			if(this.value == "other"){
				  $("textarea[name='fdItems["+index+"].fdOther']").css("display","");
			  }else{
				  $("textarea[name='fdItems["+index+"].fdOther']").css("display","none");
			  }
		 }
	});
	if(answerVal.length>0)
		answerVal = answerVal.substring(1);
	if(answerTxt.length>0)
		answerTxt = answerTxt.substring(1);
	$("input[name='fdItems["+index+"].fdAnswer']").val(answerVal);
	$("input[name='fdItems["+index+"].fdAnswerTxt']").val(answerTxt);
	if(fdQuestionDef[index].willAnswer){
		multiSelect_setvalidateResultVal(index,answerVal);
	}
}

/*************************************************
 * 设置答题校验后的结果，validateResult隐藏域的值
 * 格式：{canSave:true|false,message:""}
 * 属性1：canSave: true(校验通过，允许提交)、false(校验不通过，不允许提交)
 * 属性2：message: 返回信息，多条信息用\r\n隔开
 ************************************************/
function multiSelect_setvalidateResultVal(index,answerVal){
	var validateResult = "";//校验结果
	var answers = answerVal.split(";");
	if(fdQuestionDef[index].minSelectNumber != "" && fdQuestionDef[index].minSelectNumber>answers.length){
		validateResult = {canSave:false,
				message:Question_Type_Lang.Common.prePix+$('#serialNum'+index).val()+
				Question_Type_Lang.Common.questionItem+Question_Type_Lang.Common.selectAtLeast+
				fdQuestionDef[index].minSelectNumber+Question_Type_Lang.Common.items+
				Question_Type_Lang.Common.symbol};
		$('input[id="validateResult'+index+'"]').val(JSON.stringify(validateResult));
	}else if(fdQuestionDef[index].maxSelectNumber != "" && fdQuestionDef[index].maxSelectNumber<answers.length){
		validateResult = {canSave:false,
				message:Question_Type_Lang.Common.prePix+$('#serialNum'+index).val()+
				Question_Type_Lang.Common.questionItem+Question_Type_Lang.Common.selectAtMost+
				fdQuestionDef[index].maxSelectNumber+Question_Type_Lang.Common.items+
				Question_Type_Lang.Common.symbol};
		$('input[id="validateResult'+index+'"]').val(JSON.stringify(validateResult));
	}else{
		validateResult = {canSave:true,message:""};
		$('input[id="validateResult'+index+'"]').val(JSON.stringify(validateResult));
	}
	
}