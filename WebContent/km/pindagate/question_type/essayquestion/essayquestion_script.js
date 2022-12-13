Response_RegisterJsFile(Com_Parameter.ContextPath+"km/pindagate/question_type/essayquestion/essayquestion_script.js");
Response_IncludeJsFile(Com_Parameter.ContextPath+"km/pindagate/question_type/question_type_lang.js");

/*******************************************
 * 问答题初始化
 *******************************************/
function essayquestion_init(index,divId){
	fdQuestionDef[index] = eval("("+($('#fdQuestionDef'+index).val())+")");
	$('#'+divId).append(essayquestion_getTableHTML(index));
	//如果为必选题，则设置一个validateResult隐藏域，值为{canSave:true|false,message:""}格式
	if(fdQuestionDef[index].willAnswer){
		var validateResult = {canSave:false,
				message:Question_Type_Lang.Common.prePix + $('#serialNum'+index).val()
				+Question_Type_Lang.Common.questionItem+Question_Type_Lang.Common.notNull};
		$('<input type="hidden" name="validateResult" id="validateResult'+index+'">').val(JSON.stringify(validateResult))
				.appendTo($('#'+divId));
	}
	$("textarea[id='essayquestion"+index+"']").blur(function(){
		this.value = this.value.replace(/(\s*$)/g, "");
		if(this.value == null || this.value == ""){
			validateResult = {canSave:false,
					message:Question_Type_Lang.Common.prePix + $('#serialNum'+index).val()
					+Question_Type_Lang.Common.questionItem+Question_Type_Lang.Common.notNull};
			$('input[id="validateResult'+index+'"]').val(JSON.stringify(validateResult));
		}else{
			validateResult = {canSave:true,message:""};
			$('input[id="validateResult'+index+'"]').val(JSON.stringify(validateResult));
			$("input[name='fdItems["+index+"].fdAnswerTxt']").val(this.value);
		}
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
				'" onchange="value=checkLin(value);" name="fdItems['+index+
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
		titleHTML += '<span class="pi_txtStrong">*</span>';
	//titleHTML += '<span class="pi_txtTitle">'+$('#fdTitle'+index).val()+'</span>';
	titleHTML += '<span class="pi_txtStrong"> ['+$('#quesTypeName'+index).val()+']</span>';
	if(fdQuestionDef[index].willAnswer == true){
		titleHTML += '<span class="pi_txtStrong"> ';
		titleHTML += '['+Question_Type_Lang.Common.willAnswer+']</span>';
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
		titleHTML +='" width=100% height=100% frameborder=0 scrolling=no>';
		titleHTML +='</iframe>';
		titleHTML += '</td></tr>';
	}
	if(fdQuestionDef[index].tip != ''){
		titleHTML += '<tr><td><div class="pi_subjectExplain">';
		titleHTML += Question_Type_Lang.Common.titleDescription+$("<div></div>").append(fdQuestionDef[index].tip).html();
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