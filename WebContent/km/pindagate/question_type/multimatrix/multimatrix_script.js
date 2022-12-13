Response_RegisterJsFile(Com_Parameter.ContextPath+"km/pindagate/question_type/multimatrix/multimatrix_script.js");
Response_IncludeJsFile(Com_Parameter.ContextPath+"km/pindagate/question_type/question_type_lang.js");

/*************************************************
 * 矩阵多选题初始化
 **************************************************/
function multiMatrix_init(index,divId){
	fdQuestionDef[index] = eval("("+($('#fdQuestionDef'+index).val())+")");
	$('#'+divId).append(multiMatrix_getTableHTML(index)); 
	if(fdQuestionDef[index].hlist){ //判断问题是按行显示还是按列显示
	multiMatrix_getContent_col(index);}
	else {
	multiMatrix_getContent_row(index);	
	}
	//如果为必选题，则设置一个validateResult隐藏域，值为{canSave:true|false,message:""}格式
	if(fdQuestionDef[index].willAnswer){
		var validateResult = {canSave:false,
				message:Question_Type_Lang.Common.prePix + $('#serialNum'+index).val()
				+Question_Type_Lang.Common.questionItem+Question_Type_Lang.Common.notNull};
		$('<input type="hidden" name="validateResult" id="validateResult'+index+'">').val(JSON.stringify(validateResult))
				.appendTo($('#'+divId));
	}
	$("input:checkbox[id='option"+index+"']").click(function(){
		multiMatrix_changeAnswerVal(index);
	});
	var answer = $("input[name='fdItems["+index+"].fdDraftAnswer']").val();
	if(answer!=null&&answer != ""){
		$("input[name='fdItems["+index+"].fdAnswer']").val(answer);
		var answerArr = answer.split(";");
		for(var i=0;i<answerArr.length;i++){
			$("input[name='option"+index+'_'+answerArr[i].substring(0,1)+"'][value="+answerArr[i]+"]").attr("checked",true);//;
		}
		multiMatrix_changeAnswerVal(index);	
	}
}

/**************************************************
* 根据题目序号返回一个矩阵多选的表格
*************************************************/
function multiMatrix_getTableHTML(index){
	var tableHTML = '<table class="options_tb" width=90% id="multiMatrix_TB'+index+'">';
	tableHTML += multiMatrix_getTitleHTML(index);
	tableHTML += '</td></tr><tr><td id="multimatrixquestion'+index+'"></td></tr>';//
	tableHTML += '<table>';
	return tableHTML;
}

/*************************************************
*得到展现题目所需的html代码
*************************************************/
function multiMatrix_getTitleHTML(index){
	var serialNum = $('#serialNum'+index).val();
	var titleHTML = '<tr><td>';
	titleHTML += '<div class="pi_txtTitle pi_txtTitle_no">'+serialNum+'、</div>';
	if(fdQuestionDef[index].willAnswer)
		titleHTML += '<span class="pi_txtStrong">*</span>';
	//titleHTML += '<span class="pi_txtTitle">'+$('#fdTitle'+index).val()+'</span>';
	if($('#fdSubjectImg'+index).val() != null && $('#fdSubjectImg'+index).val() != "" ){
		titleHTML += '<img src="'+$('#fdSubjectImg'+index).val()+'" onMouseOver="resizeToSmail(this);" '+
					 'onMouseOut="resizeToLarge(this);" border="0"  width="14px" height="14px"/>';
	}
	titleHTML += '<span class="pi_txtStrong"> ['+$('#quesTypeName'+index).val()+']</span>';
	if(fdQuestionDef[index].willAnswer == true){
		titleHTML += '<span class="pi_txtStrong"> ';
		titleHTML += '['+Question_Type_Lang.Common.willAnswer+']</span>';
	}
	if(fdQuestionDef[index].eachMinSelectNumber != ""){
		titleHTML += '<span class="pi_txtStrong"> [';
		titleHTML += Question_Type_Lang.Matrix.single;
		titleHTML += Question_Type_Lang.Matrix.questionItems;
		titleHTML += Question_Type_Lang.Common.selectAtLeast;
		titleHTML += fdQuestionDef[index].eachMinSelectNumber;
		titleHTML += Question_Type_Lang.Common.items;
		titleHTML += ']</span>';
	}
	var title = fdQuestionDef[index].subject;
	title = title.replace("<div>", "");
	title = title.replace("</div>", "");
	title = title.replace(/<img/g, '<img  onMouseOver="showTooltip(event, this.src)" onMouseOut="hideTooltip();"');
	titleHTML += '<div class="pi_txtTitle pi_txtTitle_content">'+title+'</div>';
	//titleHTML += '<span class="pi_txtTitle">'+$('#fdTitle'+index).val()+'</span>';
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

/*************************************************
*得到问题和选项的主要内容-矩阵问题按行排序
************************************************/
function multiMatrix_getContent_row(index){
	$('#multimatrixquestion'+index).append("<table id='multimatrixquestionTable"+index+"' ></table>");
	for(var itemskey in fdQuestionDef[index].items){
		$('#multimatrixquestionTable'+index).append('<tr id="multimatrixquestion'+index+itemskey+'"></tr>');
		for(var optionskey in fdQuestionDef[index].options){
			$('#multimatrixquestion'+index+itemskey).append('<td align="center"><input type="checkbox" id="option'+index+
					'" name="option'+index+'_'+itemskey+'" value="'+itemskey+'_'+optionskey+'"/></td>');
		}
	}
    $('#multimatrixquestionTable'+index).prepend('<tr id="multimatrixfirstTr'+index+'"></tr>');
    for(var key in fdQuestionDef[index].options){
    	var option = fdQuestionDef[index].options[key];
    	var imgHTML = "";
		if(option[1] != null && option[1] != ""){
			var imgArr = option[1].split(";");
			for(var x=0; x<imgArr.length; x++){
				if(imgArr[x]!=0)
					imgHTML += '<img src="'+imgArr[x]+'"  border="1" onMouseOver="showTooltip(event, this.src)"'+
					   ' onMouseOut="hideTooltip();" border="0"  width="14px" height="14px"/>&nbsp;&nbsp;';
			}
		}
		$("#multimatrixfirstTr"+index).append("<td align='center'>"+fdQuestionDef[index].options[key][0]+imgHTML+"</td>");
	}
	for(var key in fdQuestionDef[index].items){
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
		$('#multimatrixquestion'+index+key).prepend("<td align='center'>"+ fdQuestionDef[index].items[key][0]+imgHTML+"</td>");
	}
	 $('#multimatrixfirstTr'+index).prepend('<td align="center"></td>');
    
	}
/************************************************
*得到问题和选项的主要内容-矩阵问题按列排序
************************************************/
function multiMatrix_getContent_col(index){
	$('#multimatrixquestion'+index).append("<table id='multimatrixquestionTable"+index+"' ></table>");
	for(var optionskey in fdQuestionDef[index].options){
		$('#multimatrixquestionTable'+index).append('<tr id="multimatrixquestion'+index+optionskey+'"></tr>');
	}
	for(var itemskey in fdQuestionDef[index].items){
		for(var optionskey in fdQuestionDef[index].options){
			$('#multimatrixquestion'+index+optionskey).append('<td align="center"><input type="checkbox" id="option'+index+
					'" name="option'+index+'_'+itemskey+'" value="'+itemskey+'_'+optionskey+'"/></td>');
			}
	}
	$('#multimatrixquestionTable'+index).prepend('<tr id="multimatrixfirstTr'+index+'"></tr>');
	 for(var key in fdQuestionDef[index].items){
		 var option = fdQuestionDef[index].items[key];
		 var imgHTML = "";
			if(option[1] != null && option[1] != ""){
				var imgArr = option[1].split(";");
				for(var x=0; x<imgArr.length; x++){
					if(imgArr[x]!=0)
						imgHTML += '<img src="'+imgArr[x]+'"  border="1" onMouseOver="showTooltip(event, this.src)"'+
							' onMouseOut="hideTooltip();" border="0"  width="14px" height="14px"/>&nbsp;&nbsp;';
				}
			}
			$("#multimatrixfirstTr"+index).append("<td align='center'>"+fdQuestionDef[index].items[key][0]+imgHTML+"</td>");
		}
	 for(var key in fdQuestionDef[index].options){
		 var option = fdQuestionDef[index].options[key];
		 var imgHTML = "";
			if(option[1] != null && option[1] != ""){
				var imgArr = option[1].split(";");
				for(var x=0; x<imgArr.length; x++){
					if(imgArr[x]!=0)
						imgHTML += '<img src="'+imgArr[x]+'"  border="1" onMouseOver="showTooltip(event, this.src)" '+
									'onMouseOut="hideTooltip();" border="0"  width="14px" height="14px"/>&nbsp;&nbsp;';
				}
			}
			$('#multimatrixquestion'+index+key).prepend("<td align='center'>"+ fdQuestionDef[index].options[key][0]+imgHTML+"</td>");
		}
	 $('#multimatrixfirstTr'+index).prepend('<td align="center"></td>');
}

/************************************************
*选项答案发现变化时，重新设置隐藏域中答案的值。
************************************************/
function multiMatrix_changeAnswerVal(index){
	var answerVal = "";
	var answerTxt = "";
	var optionsIndex;
	for(var itemskey in fdQuestionDef[index].items){
		$("input:checkbox[name='option"+index+'_'+itemskey+"']").each(function(){
		  	if(this.checked){
				answerVal += this.value +";";
				//optionsIndex = this.value.substring(1,2);
				optionsIndexs = this.value.split("_");
				answerTxt += fdQuestionDef[index].options[optionsIndexs[1]][0] + ";";
			}
		});
		answerTxt += "\r\n";
	}
	if(answerVal.length>0)
		answerVal = answerVal.substring(0,answerVal.length-1);
	if(answerTxt.length>0)
		answerTxt = answerTxt.substring(0,answerTxt.length - 2);
	$("input[name='fdItems["+index+"].fdAnswer']").val(answerVal);
	$("input[name='fdItems["+index+"].fdAnswerTxt']").val(answerTxt);
	if(fdQuestionDef[index].willAnswer){
		multiMatrix_setValidateResultVal(index,answerVal);
	}
}
/**************************************************
 * 设置答题校验后的结果，validateResult隐藏域的值
 * 格式：{canSave:true|false,message:""}
 * 属性1：canSave: true(校验通过，允许提交)、false(校验不通过，不允许提交)
 * 属性2：message: 返回信息，多条信息用\r\n隔开
 *************************************************/
function multiMatrix_setValidateResultVal(index,answerVal){
	var canSave = true;
	var message = "";
	for(var key in fdQuestionDef[index].items){
		var currSelectNum = 0;//单个问题选项，当前选择数
		$("input:checkbox[name='option"+index+'_'+key+"']").each(function(){
			  if(this.checked){ currSelectNum++;}
		});
		if(currSelectNum==0){
			canSave = false;
			message += Question_Type_Lang.Common.prePix;
			message += $('#serialNum'+index).val();
			message += Question_Type_Lang.Common.questionItem+','+Question_Type_Lang.Common.prePix;
			message += (parseInt(key)+1);
			message += Question_Type_Lang.Common.someOne;
			message += Question_Type_Lang.Matrix.questionItems;
			message += Question_Type_Lang.Common.notNull+'\r\n';
		}else if(fdQuestionDef[index].eachMinSelectNumber != "" && fdQuestionDef[index].eachMinSelectNumber>currSelectNum){
			canSave = false;
			message += Question_Type_Lang.Common.prePix+$('#serialNum'+index).val()+Question_Type_Lang.Common.questionItem+
					','+Question_Type_Lang.Common.prePix+(parseInt(key)+1)+Question_Type_Lang.Common.someOne+
					Question_Type_Lang.Common.questionTitle+Question_Type_Lang.Common.selectAtLeast+
					fdQuestionDef[index].eachMinSelectNumber+Question_Type_Lang.Common.items+
					Question_Type_Lang.Common.symbol+"\r\n";
		}
	}
	if(message != "")
		message = message.substring(0,message.length-2);//去掉最后的\r\n
	var validateResult = {'canSave':canSave,'message':message};
	$('input[id="validateResult'+index+'"]').val(JSON.stringify(validateResult));
}