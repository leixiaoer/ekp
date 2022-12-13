Response_RegisterJsFile(Com_Parameter.ContextPath+"km/pindagate/question_type/singleselect/singleMatrix_response_script.js");
Response_IncludeJsFile(Com_Parameter.ContextPath+"km/pindagate/question_type/question_type_lang.js");
/***********************************************
 * 矩阵单选题初始化
 ***********************************************/
function singleMatrix_init(index,divId){
	fdQuestionDef[index] = eval("("+($('#fdQuestionDef'+index).val())+")");
	$('#'+divId).append(singleMatrix_getTableHTML(index));
	//判断问题是按行显示还是按列显示
	if(fdQuestionDef[index].hlist){ 
		singleMatrix_getContent_col(index);
	}else{
		singleMatrix_getContent_row(index);
	}
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
	
	$(":radio[id='option"+index+"']").click(function(){
		singleMatrix_changeAnswerVal(index);
	});
	var answer = $("input[name='fdItems["+index+"].fdDraftAnswer']").val();
	if(answer!=null&&answer != ""){
		$("input[name='fdItems["+index+"].fdAnswer']").val(answer);
		var answerArr = answer.split(";");
		for(var i=0;i<answerArr.length;i++){
			$("input[name='option"+index+"_"+answerArr[i].substring(0,answerArr[i].indexOf('_'))+"'][value="+answerArr[i]+"]").attr("checked",true);//;
		}
		//选择原因
		$("textarea[name='fdItems["+index+"].fdSelectReason']").val($("input[name='fdItems["+index+"].fdDraftSelectReason']").val());
		if(answer == "selectReason"){		
			$("input[name='fdItems["+index+"].fdSelectReason']").css("display","");
		}
		singleMatrix_changeAnswerVal(index);
		
	}
	
}

/***********************************************
* 根据题目序号返回一个矩阵单选的表格
************************************************/
function singleMatrix_getTableHTML(index){
	var tableHTML = '<table class="options_tb" width=90% id="singleMatris_TB'+index+'">';
	tableHTML += singleMatrix_getTitleHTML(index);
	tableHTML += '</td></tr><tr><td id="singlematrixquestion'+index+'"></td></tr>';//
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
*得到展现题目所需的html代码
***********************************************/
function singleMatrix_getTitleHTML(index){
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
		var atturl = Com_Parameter.ContextPath+"km/pindagate/km_pindagate_question/kmPindagateQuestion.do?method=viewAtt&attachmentIds="
					+fdQuestionDef[index].attachmentIds;
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
		titleHTML += Question_Type_Lang.Common.titleDescription+'<div class="pi_subjectExplain_content">'+tip+'</div>';
		titleHTML += '</div></td></tr>';
	}
	return titleHTML;
}

/********************************************
*得到问题和选项的主要内容-矩阵问题按行排序
********************************************/
function singleMatrix_getContent_row(index){
	var optionsHTML = '<table class="question_tb">';
	optionsHTML += '<tr>';
	optionsHTML += '<td></td>';
	for(var key in fdQuestionDef[index].options){
		var option = fdQuestionDef[index].options[key];
		var imgHTML = "";
		if(option[1] != null && option[1] != ""){
			var imgArr = option[1].split(";");
			for(var x=0; x<imgArr.length; x++){
				if(imgArr[x]!=0){
					imgHTML += '<img class="pindagate_img" src="'+imgArr[x]+'" border="1" onclick="previewTooltip(event, this.src)"/>';
				}
			}
		}
		optionsHTML += '<td>'+fdQuestionDef[index].options[key][0]+imgHTML+'</td>';
	}
	optionsHTML += '</tr>';
	for(var itemskey in fdQuestionDef[index].items){
		var option = fdQuestionDef[index].items[itemskey];
		var imgHTML = "";
		if(option[1] != null && option[1] != ""){
			var imgArr = option[1].split(";");
			for(var x=0; x<imgArr.length; x++){
				if(imgArr[x]!=0){
					imgHTML += '<img class="pindagate_img" src="'+imgArr[x]+'" border="1" onclick="previewTooltip(event, this.src)"/>';
				}
			}
		}
		optionsHTML += '<tr>';
		optionsHTML += '<td>'+fdQuestionDef[index].items[itemskey][0]+imgHTML+'</td>';
		for(var optionskey in fdQuestionDef[index].options){
			optionsHTML += '<td align="center"><input class="pindagate_radio"  type="radio" id="option'+index+'" name="option'+index+"_"+itemskey+
							'" value="'+itemskey+'_'+optionskey+'"/></td>';
		}
		optionsHTML += '</tr>';
	}
	optionsHTML += '</table>';
	$('#singlematrixquestion'+index).html(optionsHTML);
}

/********************************************
*得到问题和选项的主要内容-矩阵问题按列排序
********************************************/
function singleMatrix_getContent_col(index){
	 var optionsHTML = '<table class="question_tb">';
		optionsHTML += '<tr>';
		optionsHTML += '<td></td>';
		for(var key in fdQuestionDef[index].items){
			var option = fdQuestionDef[index].items[key];
			var imgHTML = "";
			if(option[1] != null && option[1] != ""){
				var imgArr = option[1].split(";");
				for(var x=0; x<imgArr.length; x++){
					if(imgArr[x]!=0){
						imgHTML += '<img class="pindagate_img" src="'+imgArr[x]+'" border="1" onclick="previewTooltip(event, this.src)"/>';
					}
				}
			}
			optionsHTML += '<td>'+fdQuestionDef[index].items[key][0]+imgHTML+'</td>';
		}
		optionsHTML += '</tr>';
		for(var optionskey in fdQuestionDef[index].options){
			var option = fdQuestionDef[index].options[optionskey];
			var imgHTML = "";
			if(option[1] != null && option[1] != ""){
				var imgArr = option[1].split(";");
				for(var x=0; x<imgArr.length; x++){
					if(imgArr[x]!=0){
						imgHTML += '<img class="pindagate_img" src="'+imgArr[x]+'" border="1" onclick="previewTooltip(event, this.src)"/>';
					}
				}
			}
			optionsHTML += '<tr>';
			optionsHTML += '<td>'+fdQuestionDef[index].options[optionskey][0]+imgHTML+'</td>';
			for(var itemskey in fdQuestionDef[index].items){
				optionsHTML += '<td align="center"><input class="pindagate_radio" type="radio" id="option'+index+'" name="option'+index+"_"+itemskey+
				'" value="'+itemskey+'_'+optionskey+'"/></td>';
			}
			optionsHTML += '</tr>';
		}
		optionsHTML += '</table>';
		$('#singlematrixquestion'+index).html(optionsHTML);
}

/********************************************
*选项答案发现变化时，重新设置隐藏域中答案的值。
********************************************/
function singleMatrix_changeAnswerVal(index){
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
		singleMatrix_setValidateResultVal(index,answerVal);//校验是否可以提交
	}
	singleMatrix_setHasAnswerVal(index,answerVal);//校验是否完成
}

/********************************************
 * 设置答题校验后的结果，validateResult隐藏域的值
 * 格式：{canSave:true|false,message:""}
 * 属性1：canSave: true(校验通过，允许提交)、false(校验不通过，不允许提交)
 * 属性2：message: 返回信息，多条信息用\r\n隔开
 ********************************************/
function singleMatrix_setValidateResultVal(index,answerVal){
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
 /**************************************************
 * 设置题目是否完成，hasAnswer隐藏域的值
 * 格式：true|false
 *************************************************/
 function singleMatrix_setHasAnswerVal(index,answerVal){
	 var hasAnswer = "true";
	 var totalQuestion = 0;//矩阵问题总数
	for(var key in fdQuestionDef[index].items){
		totalQuestion++;
	}
	var answers = answerVal.split(";");
	if(totalQuestion>answers.length){
		hasAnswer="false";
	}
	$('input[id="hasAnswer'+index+'"]').val(hasAnswer);
	caculateProgress();//重新计算进度条
 }