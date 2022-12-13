Response_RegisterJsFile(Com_Parameter.ContextPath+"km/pindagate/question_type/scorematrix/scorematrix_script.js");
Response_IncludeJsFile(Com_Parameter.ContextPath+"km/pindagate/question_type/question_type_lang.js");

Com_IncludeFile("data.js");	
/***********************************************
 * 矩阵评分题初始化
 ************************************************/
function scorematrix_init(index,divId){
	fdQuestionDef[index] = eval("("+($('#fdQuestionDef'+index).val())+")");
	$('#'+divId).append(scoreMatrix_getTableHTML(index));
	if(fdQuestionDef[index].hlist){ //判断问题是按行显示还是按列显示
		scoreMatrix_getContent_col(index);
	}
	else{
		scoreMatrix_getContent_row(index);
	}
	//如果为必选题，则设置一个validateResult隐藏域，值为{canSave:true|false,message:""}格式
	if(fdQuestionDef[index].willAnswer){
		var validateResult = {canSave:false,message:Question_Type_Lang.Common.prePix + $('#serialNum'+index).val()
				+Question_Type_Lang.Common.questionItem+Question_Type_Lang.Common.notNull};
		$('<input type="hidden" name="validateResult" id="validateResult'+index+'">').val(JSON.stringify(validateResult)).
				appendTo($('#'+divId));
	}
	$(":radio[id='option"+index+"']").click(function(){
		scoreMatrix_changeAnswerVal(index);
	});
	var answer = $("input[name='fdItems["+index+"].fdDraftAnswer']").val();
	if(answer!=null&&answer != ""){
		$("input[name='fdItems["+index+"].fdAnswer']").val(answer);
		var answerArr = answer.split(";");
		for(var i=0;i<answerArr.length;i++){
			$("input[name='option"+index+"_"+answerArr[i].substring(0,1)+"'][value="+answerArr[i]+"]").attr("checked",true);
		}	
		scoreMatrix_changeAnswerVal(index);
	}
}

/*************************************************
* 根据题目序号返回一个矩阵的表格
************************************************/
function scoreMatrix_getTableHTML(index){
	var tableHTML = '<table class="options_tb" width=90% id="scoreMatris_TB'+index+'">';
	tableHTML += scoreMatrix_getTitleHTML(index);
	tableHTML += '</td></tr><tr><td id="scorematrixquestion'+index+'"></td></tr>';
	tableHTML += '</table>';
	return tableHTML;
}

/***********************************************
*得到展现题目所需的html代码
***********************************************/
function scoreMatrix_getTitleHTML(index){
	var serialNum = $('#serialNum'+index).val();
	var titleHTML = '<tr><td>';
	titleHTML += '<div class="pi_txtTitle pi_txtTitle_no">'+serialNum+'、</div>';
	if(fdQuestionDef[index].willAnswer)
		titleHTML += '<span class="pi_txtStrong">*</span>';
	if($('#fdSubjectImg'+index).val() != null && $('#fdSubjectImg'+index).val() != "" ){
		titleHTML += '<img src="'+$('#fdSubjectImg'+index).val()+'" onMouseOver="resizeToSmail(this);" '+
					 'onMouseOut="resizeToLarge(this);" border="0"  width="14px" height="14px"/>';
	}
	titleHTML += '<span class="pi_txtStrong"> ['+$('#quesTypeName'+index).val()+']</span>';
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
		titleHTML += Question_Type_Lang.Common.titleDescription+ $("<div></div>").append(fdQuestionDef[index].tip).html();
		titleHTML += '</div></td></tr>';
	}
	return titleHTML;
}

/***********************************************
*得到问题和选项的主要内容-矩阵问题按行排序
***********************************************/
function scoreMatrix_getContent_row(index){
	var optionsHTML = '<table>';
	optionsHTML += '<tr>';
	optionsHTML += '<td align="center"></td>';
	for(var key in fdQuestionDef[index].options){
		optionsHTML += '<td align="center">'+fdQuestionDef[index].options[key][0]+'('+fdQuestionDef[index].options[key][1]+Question_Type_Lang.Common.points+')'+'</td>';
	}
	optionsHTML += '</tr>';
	for(var itemskey in fdQuestionDef[index].items){
		var option = fdQuestionDef[index].items[itemskey];
		var imgHTML = "";
		if(option[1] != null && option[1] != ""){
			var imgArr = option[1].split(";");
			for(var x=0; x<imgArr.length; x++){
				if(imgArr[x]!=0)
					imgHTML += '<img src="'+imgArr[x]+'" border="1" onMouseOver="showTooltip(event, this.src)" '+
								'onMouseOut="hideTooltip();" border="0"  width="14px" height="14px"/>&nbsp;&nbsp;';
			}
		}optionsHTML += '<tr>';
		optionsHTML += '<td align="center">'+fdQuestionDef[index].items[itemskey][0]+imgHTML+'</td>';
		for(var optionskey in fdQuestionDef[index].options){
			optionsHTML += '<td align="center"><input type="radio" id="option'+index+'" name="option'+index+"_"+
							itemskey+'" value="'+itemskey+'_'+optionskey+'"/></td>';
		}
		optionsHTML += '</tr>';
	}
	optionsHTML += '</table>';
	$('#scorematrixquestion'+index).html(optionsHTML);
}

/***********************************************
*得到问题和选项的主要内容-矩阵问题按列排序
***********************************************/
function scoreMatrix_getContent_col(index){
	 var optionsHTML = '<table>';
		optionsHTML += '<tr>';
		optionsHTML += '<td align="center"></td>';
		for(var key in fdQuestionDef[index].items){
			var option = fdQuestionDef[index].items[key];
			var imgHTML = "";

			if(option[1] != null && option[1] != ""){
				var imgArr = option[1].split(";");
				for(var x=0; x<imgArr.length; x++){
					if(imgArr[x]!=0)
						imgHTML += '<img src="'+imgArr[x]+'" border="1" onMouseOver="showTooltip(event, this.src)" '+
									'onMouseOut="hideTooltip();" border="0"  width="14px" height="14px"/>&nbsp;&nbsp;';
				}
			}
			optionsHTML += '<td align="center">'+fdQuestionDef[index].items[key][0]+imgHTML+'</td>';
		}
		optionsHTML += '</tr>';
		for(var optionskey in fdQuestionDef[index].options){
			optionsHTML += '<tr>';
			optionsHTML += '<td align="center">'+fdQuestionDef[index].options[optionskey][0]+'('+
							fdQuestionDef[index].options[optionskey][1]+Data_GetResourceString("km-pindagate:kmPindagate.msg.score")+')'+'</td>';
			for(var itemskey in fdQuestionDef[index].items){
				optionsHTML += '<td align="center"><input type="radio" id="option'+index+'" name="option'+index+
								"_"+itemskey+'" value="'+itemskey+'_'+optionskey+'"/></td>';
			}
			optionsHTML += '</tr>';
		}
		optionsHTML += '</table>';
		$('#scorematrixquestion'+index).html(optionsHTML);
}

/***********************************************
*选项答案发现变化时，重新设置隐藏域中答案的值。
***********************************************/
function scoreMatrix_changeAnswerVal(index){
	var answerVal = "";
	var answerTxt = "";
	var optionsIndex;
	for(var itemskey in fdQuestionDef[index].items){
		$("input:radio[name='option"+index+"_"+itemskey+"']").each(function(){
		  	if(this.checked){
				answerVal += this.value +";";
				//optionsIndex  = this.value.substring(1,2);
				optionsIndexs = this.value.split("_");
				answerTxt += fdQuestionDef[index].options[optionsIndexs[1]][0];
			}
		});
		answerTxt += "\r\n";
	}
	if(answerTxt.length>0)
		answerTxt = answerTxt.substring(0,answerTxt.length - 2);
	if(answerVal.length>0)
		answerVal = answerVal.substring(0,answerVal.length-1);
	$("input[name='fdItems["+index+"].fdAnswer']").val(answerVal);
	$("input[name='fdItems["+index+"].fdAnswerTxt']").val(answerTxt);
	if(fdQuestionDef[index].willAnswer){
		scoreMatrix_setValidateResultVal(index,answerVal);
	}
}
/*************************************************
 * 设置答题校验后的结果，validateResult隐藏域的值
 * 格式：{canSave:true|false,message:""}
 * 属性1：canSave: true(校验通过，允许提交)、false(校验不通过，不允许提交)
 * 属性2：message: 返回信息，多条信息用\r\n隔开
 ************************************************/
function scoreMatrix_setValidateResultVal(index,answerVal){
	var totalQuestion = 0;//矩阵问题总数
	var validateResult = "";//校验结果
	for(var key in fdQuestionDef[index].items){
		totalQuestion++;
	}
	var answers = answerVal.split(";");
	if(totalQuestion>answers.length){
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