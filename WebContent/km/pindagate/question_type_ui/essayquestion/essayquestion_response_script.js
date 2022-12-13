Response_RegisterJsFile(Com_Parameter.ContextPath+"km/pindagate/question_type/essayquestion/essayquestion_response_script.js");
Response_IncludeJsFile(Com_Parameter.ContextPath+"km/pindagate/question_type/question_type_lang.js");

/*******************************************
 * 问答题初始化
 *******************************************/
function essayquestion_init(index,divId){
	fdQuestionDef[index] = eval("("+($('#fdQuestionDef'+index).val())+")");
	$('#'+divId).append(essayquestion_getTableHTML(index));
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
	$("textarea[id='essayquestion"+index+"']").blur(function(){
		var hasAnwser="true";
		this.value = this.value.replace(/(\s*$)/g, "");
		if(this.value == null || this.value == ""){
			validateResult = {canSave:false,
					message:Question_Type_Lang.Common.prePix + $('#serialNum'+index).val()
					+Question_Type_Lang.Common.questionItem+Question_Type_Lang.Common.notNull};
			$('input[id="validateResult'+index+'"]').val(JSON.stringify(validateResult));
			hasAnwser="false";
		}else{
			validateResult = {canSave:true,message:""};
			$('input[id="validateResult'+index+'"]').val(JSON.stringify(validateResult));
			$("input[name='fdItems["+index+"].fdAnswerTxt']").val(this.value);
		}
		$('input[id="hasAnswer'+index+'"]').val(hasAnwser);
		caculateProgress();//重新计算进度条
	});
	var answer = $("input[name='fdItems["+index+"].fdDraftAnswer']").val();
	if(answer!=null&&answer != ""){
		$("textarea[id='essayquestion"+index+"']").val(answer);	
		$("input[name='fdItems["+index+"].fdAnswerTxt']").val(answer);	
		validateResult = {canSave:true,message:""};
		$('input[id="validateResult'+index+'"]').val(JSON.stringify(validateResult));
	}
}

/*********************************************
 * 问答题表格
 **********************************************/
function essayquestion_getTableHTML(index){
	var tableHTML = '<table class="options_tb" width=90% id="essayquestion_TB'+index+'">';
	tableHTML += essayquestion_getTitleHTML(index);
	var textHeight = fdQuestionDef[index].inputHeight*16;//一行为16像素
	tableHTML += '</td></tr><tr><td align="left"><textarea id="essayquestion'+index+
				'" onchange="value=checkLin(value);" class="question_tb" name="fdItems['+index+
				'].fdAnswer" style="width:100%;height:'+textHeight+'px"></textarea></td></tr>';
	tableHTML += '<table>';
	return tableHTML;
}

/****************************************
 * 题头
 ***************************************/
function essayquestion_getTitleHTML(index){
	var serialNum = $('#serialNum'+index).val();
	var titleHTML = '<tr><td>';
	titleHTML += '<div class="pi_txtTitle pi_txtTitle_no">'+serialNum+'、</div>';
	if(fdQuestionDef[index].willAnswer)
		titleHTML += '<span class="pi_txtRequire">*</span>';
	var title = fdQuestionDef[index].subject;
	title=title.replace(/<p>/g,"").replace(/<\/p>/g,"<br>").replace(/\n/g,"").replace(/(<br>)+$/g,"");//格式化标题
	//title = title.replace(/<img(?:.|\s)*?>/g, '');
	//title = title.replace(/<img/g, '<img  onMouseOver="showTooltip(event, this.src)" onMouseOut="hideTooltip();"');
	titleHTML += '<div class="pi_txtTitle pi_txtTitle_content">'+title+'</div>';
	titleHTML += '<span class="pi_txtStrong"> ['+$('#quesTypeName'+index).val()+']</span>';
	if(fdQuestionDef[index].willAnswer == true){
		titleHTML += '<span class="pi_txtStrong"> ';
		titleHTML += '['+Question_Type_Lang.Common.willAnswer+']</span>';
	}
	titleHTML += '</td></tr>';
	if(fdQuestionDef[index].attachmentIds != 'null' && fdQuestionDef[index].attachmentIds != ''){//为修复ie8某些版本下stringify缺陷，增加!='null'判断
		var atturl = Com_Parameter.ContextPath+"km/pindagate/km_pindagate_question/kmPindagateQuestion.do?method=viewAtt&attachmentIds="+
					  fdQuestionDef[index].attachmentIds;
		titleHTML += '<tr><td>';
		titleHTML += '<iframe id="attFrame" onload="autoResize(this)" src="';
		titleHTML += atturl;
		titleHTML +='" width=100% height=0 frameborder=0 scrolling=no>';
		titleHTML +='</iframe>';
		titleHTML += '</td></tr>';
	}
	if(fdQuestionDef[index].tip != ''){
		var tip=fdQuestionDef[index].tip;
		titleHTML += '<tr><td><div class="pi_subjectExplain">';
		titleHTML += Question_Type_Lang.Common.titleDescription+'<div class="pi_subjectExplain_content">'+tip+'</div>';;
		titleHTML += '</div></td></tr>';
	}
	return titleHTML;
}
var maxLen=1000000;

/****************************************
 * 长度校验
 **************************************/
function checkLin(inputValue){
	if(inputValue.replace(/[^\x00-\xff]/g,"***").length>maxLen){
		alert(Question_Type_Lang.Essay.moreAlert.replace("%maxLen%",maxLen));
		return inputValue.substring(0, maxLen);
	}
	return inputValue;
}