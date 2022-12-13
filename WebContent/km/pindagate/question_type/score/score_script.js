Response_RegisterJsFile(Com_Parameter.ContextPath+"km/pindagate/question_type/score/score_script.js");
Response_IncludeJsFile(Com_Parameter.ContextPath+"km/pindagate/question_type/question_type_lang.js");

/***********************************************
 * 评分题初始化
 ************************************************/
function score_init(index,divId){
	fdQuestionDef[index] = eval("("+($('#fdQuestionDef'+index).val())+")");
	$('#'+divId).append(score_getTableHTML(index));
	//如果为必选题，则设置一个validateResult隐藏域，值为{canSave:true|false,message:""}格式
	if(fdQuestionDef[index].willAnswer){
		var validateResult = {canSave:false,message:Question_Type_Lang.Common.prePix + $('#serialNum'+index).val()
				+Question_Type_Lang.Common.questionItem+Question_Type_Lang.Common.notNull};
		$('<input type="hidden" name="validateResult" id="validateResult'+index+'">').val(JSON.stringify(validateResult))
				.appendTo($('#'+divId));
	}
	$(":radio[name='option"+index+"']").click(function(){
		score_changeAnswerVal(index);
	});
	var answer = $("input[name='fdItems["+index+"].fdDraftAnswer']").val();
	if(answer!=null&&answer != ""){
		$("input[name='fdItems["+index+"].fdAnswer']").val(answer);
		$("input[name='option"+index+"']").val([answer]);
		score_changeAnswerVal(index);		
	}
}

/*************************************************
 * 根据题目序号返回一个单选题表单
 ************************************************/
function score_getTableHTML(index){
	var tableHTML = '<table class="options_tb" width=90% id="score_TB'+index+'">';
	tableHTML += score_getTitleHTML(index);
	tableHTML += score_getOptionsHTML(index);
	tableHTML += '</table>';
	return tableHTML;
}

/***********************************************
 * 头部
 ************************************************/
function score_getTitleHTML(index){
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
 
 /***********************************************
  * 选项
  ************************************************/
function score_getOptionsHTML(index){
	var optionsHTML = '<tr><td>';
	var optionIndex = 0;
	for(var key in fdQuestionDef[index].items){
		optionIndex++;
		var option = fdQuestionDef[index].items[key];
		optionsHTML += '<input type="radio" name="option'+index+'" value="'+key+'"/>'+option[0]+
						'  ('+option[1]+Question_Type_Lang.Common.points+')';
		optionsHTML += '</td></tr><tr><td>';
	}
	optionsHTML += '</td></tr>';
	return optionsHTML;
}
  
/***********************************************
*选项答案发现变化时，重新设置隐藏域中答案的值。
***********************************************/
function score_changeAnswerVal(index){
	var answerVal = "";
	$("input:radio[name='option"+index+"']").each(function(){
		  if(this.checked){ 
			  $("input[name='fdItems["+index+"].fdAnswer']").val(this.value);
			  $("input[name='fdItems["+index+"].fdAnswerTxt']").val(fdQuestionDef[index].items[this.value][0]);
			  score_setvalidateResultVal(index);
		  }
	});
}
/*************************************************
* 设置答题校验后的结果，validateResult隐藏域的值
* 格式：{canSave:true|false,message:""}
* 属性1：canSave: true(校验通过，运行允许)、false(校验不通过，不允许提交)
* 属性2：message: 返回信息，多条信息用\r\n隔开
************************************************/
function score_setvalidateResultVal(index){
	var validateResult = {canSave:true,message:""};
	$('input[id="validateResult'+index+'"]').val(JSON.stringify(validateResult));
}