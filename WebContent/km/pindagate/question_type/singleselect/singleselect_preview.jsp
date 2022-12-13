<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<script type="text/javascript">
function autoResize(obj){
	obj.height = obj.contentWindow.document.body.scrollHeight + 20;	
}
var singleSelect_fdQuestionDef = null;
function singleSelect_init(index){
	var divId = "${JsParam.divId}";
	if($('#fdQuestionDef'+index).val() == null || $('#fdQuestionDef'+index).val() == "" || $('#fdQuestionDef'+index).val() == "delete")
		return;
	singleSelect_fdQuestionDef = eval("("+($('#fdQuestionDef'+index).val())+")");
	$('#'+divId).append(singleSelect_getTableHTML(index));
}
/**
 * 根据题目序号返回一个单选题表单
 */
function singleSelect_getTableHTML(index){
	var tableHTML = '<table class="options_tb" width=90% id="singleSelect_TB'+index+'">';
	tableHTML += '<tr class="options"><td><p name="tip" style="display:none;position:relative;color:red;"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.preview.editTip"/>';
	tableHTML += '<span onclick="singleSelect_edit('+index+');" style="position:absolute;top: 0px;right: 30px;cursor: pointer;color:red;"><bean:message key="button.edit"/></span>';
	tableHTML += '<span onclick="deleteQuestion('+index+');" style="position:absolute;top: 0px;right: 0px;cursor: pointer;color:red;"><bean:message key="button.delete"/></span></p></td></tr>';
	tableHTML += singleSelect_getTitleHTML(index);
	tableHTML += singleSelect_getOptionsHTML(index);
	tableHTML += '</table>';
	return tableHTML;
}
function singleSelect_getTitleHTML(index){
	var serialNum = $('#serialNum'+index).val();
	var titleHTML = '<tr><td>';
	titleHTML += '<div class="pi_txtTitle pi_txtTitle_no">'+serialNum+'、</div>';
	var title = singleSelect_fdQuestionDef.subject;
	title = title.replace("<p>", "");
	title = title.replace("</p>", "");
	title = title.replace(/<img/g, '<img  onMouseOver="showTooltip(event, this.src)" onMouseOut="hideTooltip();"');
	titleHTML += '<span class="pi_txtTitle" id="fdTitle'+index+'" name="fdTitle'+index+'" onclick="modifyTitleVal(this);">'+title+'</span>';
	if(singleSelect_fdQuestionDef.willAnswer)
		titleHTML += '<span class="pi_txtRequire">*</span>';
	titleHTML += '<span class="pi_txtStrong"> ['+$('#quesTypeName'+index).val()+']</span>';
	if(singleSelect_fdQuestionDef.willAnswer == true){
		titleHTML += '<span class="pi_txtStrong"> ';
		titleHTML += '[<bean:message bundle="km-pindagate" key="kmPindagateQuestion.flag.willAnswer"/>]</span>';
	}
	titleHTML += '</td></tr>';
	if(singleSelect_fdQuestionDef.attachmentIds != ''){
		var atturl = "<c:url value='/km/pindagate/km_pindagate_question/kmPindagateQuestion.do?method=viewAtt&attachmentIds="+singleSelect_fdQuestionDef.attachmentIds+"'  />";
		titleHTML += '<tr><td>';
		titleHTML += '<iframe id="attFrame" onload="autoResize(this)" src="';
		titleHTML += atturl;
		titleHTML +='" width=100% height=100% frameborder=0 scrolling=no>';
		titleHTML +='</iframe>';
		titleHTML += '</td></tr>';
	}
	if(singleSelect_fdQuestionDef.tip != ''){
		titleHTML += '<tr><td><div class="pi_subjectExplain">';
		titleHTML += '<bean:message bundle="km-pindagate" key="kmPindagateQuestion.preview.titleDescription"/>'+$("<div></div>").append(singleSelect_fdQuestionDef.tip).text();
		titleHTML += '</div></td></tr>';
	}
	return titleHTML;
}
function singleSelect_getOptionsHTML(index){
	var vlistColumnCount = 0;
	var optionsHTML = '<tr><td><table class="options_tb question_tb" width=100%"><tr><td>';
	if(singleSelect_fdQuestionDef.hlist){
		vlistColumnCount = singleSelect_fdQuestionDef.vlistColumnCount;
	}
	var optionIndex = 0;
	for(var key in singleSelect_fdQuestionDef.items){
		optionIndex++;
		var option = singleSelect_fdQuestionDef.items[key];
		var imgHTML = "";
		if(option[1] != null && option[1] != ""){
			var imgArr = option[1].split(";");
			for(var x=0; x<imgArr.length; x++){
				if(imgArr[x]!=0)
			imgHTML += '<img src="'+imgArr[x]+'"  border="1" onMouseOver="showTooltip(event, this.src)" onMouseOut="hideTooltip();" border="0"  width="14px" height="14px"/>&nbsp;&nbsp;';
			}
		}
		optionsHTML += '<input type="radio" name="option'+index+'" value="'+optionIndex+'"/>'+option[0]+'  '+imgHTML+''; 
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
	if(singleSelect_fdQuestionDef.autoAddOther){
		optionsHTML += '<tr><td colspan="'+ vlistColumnCount +'"><input type="radio" name="option'+index+'" value="'+optionIndex+'"/>';
		optionsHTML += singleSelect_fdQuestionDef.otherText;
		optionsHTML += '</td></tr><tr><td colspan="'+ vlistColumnCount +'"><textarea style="width:840px;height:80px" ></textarea></td></tr>';
						
		}
	if(singleSelect_fdQuestionDef.autoAddSelectReason){
		optionsHTML += '<tr><td colspan="'+ vlistColumnCount +'">'; //<span class="txtstrong">*</span>';
		optionsHTML += singleSelect_fdQuestionDef.selectReasonText;
		optionsHTML += '</td></tr><tr><td colspan="'+ vlistColumnCount +'"><textarea style="width:840px;height:80px"></textarea></td></tr>';
	}
	optionsHTML += '</table></td></tr>';
	return optionsHTML;
}
/**
 * 编辑
 */
function singleSelect_edit(index){
	var obj = document.getElementById('fdQuestionDef'+index);
	var url = getContextPath()+"km/pindagate/question_type_ui/singleselect/singleselect_edit.jsp";
	if(obj == null)
	  window.showModalDialog(url, "","dialogWidth=600px;dialogHeight=500px;");
	else
		window.showModalDialog(url, obj,"dialogWidth=600px;dialogHeight=500px;");
	if(obj.value != null && obj.value != ""){
		singleSelect_fdQuestionDef = eval("("+(obj.value)+")");
		var tableHTML = '<tr class="options"><td><p name="tip" style="display:none;position:relative;color:red;"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.preview.editTip"/> <span onclick="singleSelect_edit('+index+');" style="position:absolute;top: 0px;right: 30px;cursor: pointer;color:red;"><bean:message key="button.edit"/></span><span style="position:absolute;top: 0px;right: 0px;cursor: pointer;color:red;"><bean:message key="button.delete"/></span></p></td></tr>';
		tableHTML += singleSelect_getTitleHTML(index);
		tableHTML += singleSelect_getOptionsHTML(index);
		$('#singleSelect_TB'+index).html(tableHTML);
		var title = singleSelect_fdQuestionDef.subject;
		title = title.replace("<p>", "");
		title = title.replace("</p>", "");
		title = title.replace(/<img/g, '<img  onMouseOver="showTooltip(event, this.src)" onMouseOut="hideTooltip();"');		
		$('span[name=fdTitle'+index+']').html(title);
		setFdQuestionDef(singleSelect_fdQuestionDef,index);//更新题型定义的值
	}
}

//改变图片的大小
function resizeToSmail(_this){
  _this.style.width="300px"; 
  _this.style.height ="300px"; 
}
function resizeToLarge(_this){
  _this.style.width="14px"; 
  _this.style.height ="14px"; 
}
singleSelect_init('${JsParam.index}');
</script>