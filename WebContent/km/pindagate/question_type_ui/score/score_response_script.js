Response_RegisterJsFile(Com_Parameter.ContextPath+"km/pindagate/question_type/score/score_response_script.js");
Response_IncludeJsFile(Com_Parameter.ContextPath+"km/pindagate/question_type/question_type_lang.js");

/***********************************************
 * 评分题初始化
 ************************************************/
function score_init(index,divId){
	fdQuestionDef[index] = eval("("+($('#fdQuestionDef'+index).val())+")");
	$('#'+divId).append(score_getTableHTML(index));
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
	
	$(":radio[name='option"+index+"']").click(function(){
		score_changeAnswerVal(index);
	});
	var answer = $("input[name='fdItems["+index+"].fdDraftAnswer']").val();
	if(answer!=null&&answer != ""){
		$("input[name='fdItems["+index+"].fdAnswer']").val(answer);
		$("input[name='option"+index+"']").val([answer]);
		//选择原因
		$("textarea[name='fdItems["+index+"].fdSelectReason']").val($("input[name='fdItems["+index+"].fdDraftSelectReason']").val());
		if(answer == "selectReason"){		
			$("input[name='fdItems["+index+"].fdSelectReason']").css("display","");
		}
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
	//选择原因
	if(fdQuestionDef[index].autoAddSelectReason){
		tableHTML += '<tr><td style="padding-bottom:10px;">';
		tableHTML += fdQuestionDef[index].selectReasonText;
		tableHTML += '</td></tr><tr><td><textarea name="fdItems['+index+'].fdSelectReason"'+
						' style="width:840px;height:80px"></textarea></td></tr>';
	}
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
		titleHTML +='" width=100% height=100% frameborder=0 scrolling=no>';
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
 /***********************************************
 * 选项
 ************************************************/
function score_getOptionsHTML(index){
	var optionsHTML = '<tr><td  style="padding:0px 0px 10px;">';
	var optionIndex = 0;
	for(var key in fdQuestionDef[index].items){
		optionIndex++;
		var option = fdQuestionDef[index].items[key];
		optionsHTML += '<input type="radio" name="option'+index+'" value="'+key+'"/>'+option[0]+
						'  ('+option[1]+Question_Type_Lang.Common.points+')';
		optionsHTML += '</td></tr><tr><td  style="padding:0px 0px 10px;">';
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
			  $("input[name='fdItems["+index+"].fdAnswerTxt']").val(fdQuestionDef[index].items[this.value][0]+"("+fdQuestionDef[index].items[this.value][1]+"分)");
			  $("input[name='fdItems["+index+"].fdScore']").val(fdQuestionDef[index].items[this.value][1]);
			  score_setvalidateResultVal(index);
			  score_setHasAnswerVal(index);
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
/**************************************************
* 设置题目是否完成，hasAnswer隐藏域的值
* 格式：true|false
*************************************************/
function score_setHasAnswerVal(index){
	$('input[id="hasAnswer'+index+'"]').val("true");
	caculateProgress();//重新计算进度条
}