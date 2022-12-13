Response_RegisterJsFile(Com_Parameter.ContextPath+"km/pindagate/question_type/singleselect/singleselect_response_script.js");
Response_IncludeJsFile(Com_Parameter.ContextPath+"km/pindagate/question_type_ui/relation/relation_showtopic_script.js");
Response_IncludeJsFile(Com_Parameter.ContextPath+"km/pindagate/question_type/question_type_lang.js");

/********************************************
 * 单选题初始化
 ********************************************/
function singleselect_init(index,divId){
	fdQuestionDef[index] = eval("("+($('#fdQuestionDef'+index).val())+")");
	$('#'+divId).append(singleSelect_getTableHTML(index));
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
		singleSelect_changeAnswerVal(index);
	});
	var answer = $("input[name='fdItems["+index+"].fdDraftAnswer']").val();
	if(answer != ""){
		$("input[name='fdItems["+index+"].fdAnswer']").val(answer);
		$("input[name='option"+index+"']").val([answer]);
		$("textarea[name='fdItems["+index+"].fdOther']").val($("input[name='fdItems["+index+"].fdDraftOther']").val());
		if(answer == "other"){		
			$("input[name='fdItems["+index+"].fdOther']").css("display","");
		}
		//选择原因
		$("textarea[name='fdItems["+index+"].fdSelectReason']").val($("input[name='fdItems["+index+"].fdDraftSelectReason']").val());
		if(answer == "selectReason"){		
			$("input[name='fdItems["+index+"].fdSelectReason']").css("display","");
		}
		singleSelect_changeAnswerVal(index);
	}
}

/**********************************************
 * 根据题目序号返回一个单选题表单
 *********************************************/
function singleSelect_getTableHTML(index){
	var tableHTML = '<table class="options_tb" width=90% id="singleSelect_TB'+index+'">';
	tableHTML += singleSelect_getTitleHTML(index);
	tableHTML += singleSelect_getOptionsHTML(index);
	tableHTML += '</table>';
	return tableHTML;
}
 
/********************************************
 * 题头
 *********************************************/
function singleSelect_getTitleHTML(index){
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
function singleSelect_getOptionsHTML(index){
	var vlistColumnCount = 0;
	var optionsHTML = '<tr><td><table class="options_tb question_tb" width=100%"><tr><td>';
	if(fdQuestionDef[index].hlist){
		vlistColumnCount = fdQuestionDef[index].vlistColumnCount;
	}
	var optionIndex = 0;
	var items = fdQuestionDef[index].items;
	for(var key=0; key<items.length; key++){
		optionIndex++;
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
		
		//if(option[1] != null && option[1] != "")
		var option = option[0].replace(/[<>&"]/g,function(c){return {'<':'&lt;','>':'&gt;','&':'&amp;','"':'&quot;'}[c];});
		optionsHTML += '<input class="pindagate_radio" type="radio" name="option'+index+'" value="'+key+'"/>'+option+'  '+imgHTML+''; 
		if(vlistColumnCount > 0){
			if((parseInt(optionIndex)) % vlistColumnCount == 0)
				optionsHTML += '</td></tr><tr><td>';
			else
				optionsHTML += '</td><td>';
			hasTd = true;
		}
		else{
			optionsHTML += '</td></tr><tr><td>';
		}
		if(key == items.length-1) {
			optionsHTML += '</td></tr>';
		}
	}
	if(fdQuestionDef[index].autoAddOther){
		optionsHTML += '<tr><td colspan="'+ vlistColumnCount +'"><input type="radio" name="option'+index+'" value="other"/>';
		optionsHTML += fdQuestionDef[index].otherText;
		optionsHTML += '</td></tr><tr><td colspan="'+ vlistColumnCount +'"><textarea name="fdItems['+index+'].fdOther"'+
						' style="display:none;width:840px;height:80px" ></textarea></td></tr>';
	}                      
	//选择原因
	if(fdQuestionDef[index].autoAddSelectReason){
		//optionsHTML += '<tr><td colspan="'+ vlistColumnCount +'"><input type="checkbox" name="option'+index+'" value="selectReason"/>';
		optionsHTML += '<tr><td colspan="'+ vlistColumnCount +'">';
		optionsHTML += fdQuestionDef[index].selectReasonText;
		optionsHTML += '</td></tr><tr><td colspan="'+ vlistColumnCount +'"><textarea name="fdItems['+index+'].fdSelectReason"'+
						' style="display:none;width:840px;height:80px"></textarea></td></tr>';
	}
	optionsHTML += '</table></td></tr>';
	return optionsHTML;
}

/********************************************
*选项答案发现变化时，重新设置隐藏域中答案的值。
********************************************/
function singleSelect_changeAnswerVal(index){
	$("input:radio[name='option"+index+"']").each(function(){
		  if(this.checked){
			  $("input[name='fdItems["+index+"].fdAnswer']").val(this.value);
			  if(this.value == 'other')
				  $("input[name='fdItems["+index+"].fdAnswerTxt']").val(fdQuestionDef[index].otherText);
			  //else if(this.value == 'selectReason') //选择原因  	 
			  else
				  $("input[name='fdItems["+index+"].fdAnswerTxt']").val(fdQuestionDef[index].items[this.value][0]);
			  singleSelect_setValidateResultVal(index);

			  if(this.value == "other"){
				  $("textarea[name='fdItems["+index+"].fdOther']").css("display","");
			  }else{
				  $("textarea[name='fdItems["+index+"].fdOther']").css("display","none"); 
			  }
			  //}else if(this.value == "selectReason"){ //选择原因 
				 // $("input[name='fdItems["+index+"].fdSelectReason']").css("display","");
			 // }else {
			      //$("input[name='fdItems["+index+"].fdOther']").css("display","none");
			  //}
			singleSelect_setHasAnswerVal(index);//是否完成
			}
			 $("textarea[name='fdItems["+index+"].fdAnswerTxt']").val(fdQuestionDef[index].selectReasonText);
			 $("textarea[name='fdItems["+index+"].fdSelectReason']").css("display","");
	}); 
	showTopic(index,"singleSelect");
}

/**********************************************
 * 设置答题校验后的结果，validateResult隐藏域的值
 * 格式：{canSave:true|false,message:""}
 * 属性1：canSave: true(校验通过，允许提交)、false(校验不通过，不允许提交)
 * 属性2：message: 返回信息，多条信息用\r\n隔开
 *********************************************/
function singleSelect_setValidateResultVal(index){
	 if(fdQuestionDef[index].willAnswer){
		  var validateResult = {canSave:true,message:""};
			$('input[id="validateResult'+index+'"]').val(JSON.stringify(validateResult));
		}
}
 /**************************************************
 * 设置题目是否完成，hasAnswer隐藏域的值
 * 格式：true|false
 *************************************************/
 function singleSelect_setHasAnswerVal(index,answerVal){
		$('input[id="hasAnswer'+index+'"]').val("true");
		caculateProgress();//重新计算进度条
 }