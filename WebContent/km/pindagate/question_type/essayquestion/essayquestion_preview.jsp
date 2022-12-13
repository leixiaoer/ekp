<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<script>
var essayquestion_fdQuestionDef = null;
function autoResize(obj){
	obj.height = obj.contentWindow.document.body.scrollHeight + 20;	
}
function essayquestion_init(index){
	var divId = "${JsParam.divId}";
	if($('#fdQuestionDef'+index).val() == null || $('#fdQuestionDef'+index).val() == "" || $('#fdQuestionDef'+index).val() == "delete")
		return;
	essayquestion_fdQuestionDef = eval("("+($('#fdQuestionDef'+index).val())+")");
	$('#'+divId).append(essayquestion_getTableHTML(index));
}
function essayquestion_getTableHTML(index){
	var tableHTML = '<table class="options_tb" width=90% id="essayquestion_TB'+index+'">';
	tableHTML += '<tr class="options"><td><p name="tip" style="display:none;position:relative;color:red;"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.preview.editTip"/>';
	tableHTML += '<span onclick="essayquestion_edit('+index+');" style="position:absolute;top: 0px;right: 30px;cursor: pointer;color:red;"><bean:message key="button.edit"/></span>';
	tableHTML += '<span onclick="deleteQuestion('+index+');" style="position:absolute;top: 0px;right: 0px;cursor: pointer;color:red;"><bean:message key="button.delete"/></span></p></td></tr>';
	tableHTML += essayquestion_getTitleHTML(index);
	var textHeight = essayquestion_fdQuestionDef.inputHeight*16;//一行为16像素
	tableHTML += '</td></tr><tr><td  align="left" id="essayquestion'+index+'"><textarea style="width:100%;height:'+textHeight+'px"></textarea></td></tr>';
	tableHTML += '<table>';
	return tableHTML;
}
function essayquestion_getTitleHTML(index){
	var serialNum = $('#serialNum'+index).val();
	var titleHTML = '<tr><td>';
	titleHTML += '<div class="pi_txtTitle pi_txtTitle_no">'+serialNum+'、</div>';
	var title = essayquestion_fdQuestionDef.subject;
	title = title.replace("<p>", "");
	title = title.replace("</p>", "");
	title = title.replace(/<img/g, '<img  onMouseOver="showTooltip(event, this.src)" onMouseOut="hideTooltip();"');
	titleHTML += '<span class="pi_txtTitle" id="fdTitle'+index+'" name="fdTitle'+index+'" onclick="modifyTitleVal(this);">'+title+'</span>';
	if(essayquestion_fdQuestionDef.willAnswer)
		titleHTML += '<span class="pi_txtRequire">*</span>';
	titleHTML += '<span class="pi_txtStrong"> ['+$('#quesTypeName'+index).val()+']</span>';
	if(essayquestion_fdQuestionDef.willAnswer == true){
		titleHTML += '<span class="pi_txtStrong"> ';
		titleHTML += '[<bean:message bundle="km-pindagate" key="kmPindagateQuestion.flag.willAnswer"/>]</span>';
	}
	titleHTML += '</td></tr>';
	if(essayquestion_fdQuestionDef.attachmentIds != ''){
		var atturl = "<c:url value='/km/pindagate/km_pindagate_question/kmPindagateQuestion.do?method=viewAtt&attachmentIds="+essayquestion_fdQuestionDef.attachmentIds+"'  />";
		titleHTML += '<tr><td>';
		titleHTML += '<iframe id="attFrame" onload="autoResize(this)" src="';
		titleHTML += atturl;
		titleHTML +='" width=100% height=100% frameborder=0 scrolling=no>';
		titleHTML +='</iframe>';
		titleHTML += '</td></tr>';
	}
	if(essayquestion_fdQuestionDef.tip != ''){
		titleHTML += '<tr><td><div class="pi_subjectExplain">';
		titleHTML += '<bean:message bundle="km-pindagate" key="kmPindagateQuestion.preview.titleDescription"/>'+$("<div></div>").append(essayquestion_fdQuestionDef.tip).text();
		titleHTML += '</div></td></tr>';
	}
	return titleHTML;
}
/**
* 编辑
*/
function essayquestion_edit(index){
	var obj = document.getElementById('fdQuestionDef'+index);
	var url = getContextPath()+"km/pindagate/question_type_ui/essayquestion/essayquestion_edit.jsp";
	if(obj == null)
	  window.showModalDialog(url, "","dialogWidth=600px;dialogHeight=500px;");
	else
		window.showModalDialog(url, obj,"dialogWidth=600px;dialogHeight=500px;");
	if(obj.value != null && obj.value != ""){
		essayquestion_fdQuestionDef = eval("("+(obj.value)+")");
		var tableHTML = '<tr class="options"><td><p class="pi_txtRed" name="tip" style="display:none;position:relative;"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.preview.editTip"/>';
		tableHTML += '<span onclick="essayquestion_edit('+index+');" style="position:absolute;top: 0px;right: 30px;cursor: pointer;"><bean:message key="button.edit"/></span>';
		tableHTML += '<span onclick="deleteQuestion('+index+');" style="position:absolute;top: 0px;right: 0px;cursor: pointer;"><bean:message key="button.delete"/></span></p></td></tr>';
		tableHTML += essayquestion_getTitleHTML(index);
		var textHeight = essayquestion_fdQuestionDef.inputHeight*16;//一行为16像素
		tableHTML += '</td></tr><tr><td  align="left" id="essayquestion'+index+'"><textarea style="width:500px;height:'+textHeight+'px"></textarea></td></tr>';
		$('#essayquestion_TB'+index).html(tableHTML);
		var title = essayquestion_fdQuestionDef.subject;
		title = title.replace("<p>", "");
		title = title.replace("</p>", "");
		title = title.replace(/<img/g, '<img  onMouseOver="showTooltip(event, this.src)" onMouseOut="hideTooltip();"');		
		$('span[name=fdTitle'+index+']').html(title);
		setFdQuestionDef(essayquestion_fdQuestionDef,index);//更新题型定义的值
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
essayquestion_init('${JsParam.index}');
</script>
