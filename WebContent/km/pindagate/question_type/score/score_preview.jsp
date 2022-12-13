<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<script type="text/javascript">
var score_fdQuestionDef = null;
function autoResize(obj){
	obj.height = obj.contentWindow.document.body.scrollHeight + 20;	
}
function score_init(index){
	var divId = "${JsParam.divId}";
	if($('#fdQuestionDef'+index).val() == null || $('#fdQuestionDef'+index).val() == "" || $('#fdQuestionDef'+index).val() == "delete")
		return;
	score_fdQuestionDef = eval("("+($('#fdQuestionDef'+index).val())+")");
	$('#'+divId).append(score_getTableHTML(index));
}
/**
 * 根据题目序号返回一个单选题表单
 */
function score_getTableHTML(index){
	var tableHTML = '<table class="options_tb" width=90% id="score_TB'+index+'">';
	tableHTML += '<tr class="options"><td><p name="tip" style="display:none;position:relative;color:red;"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.preview.editTip"/>';
	tableHTML += '<span onclick="score_edit('+index+');" style="position:absolute;top: 0px;right: 30px;cursor: pointer;color:red;"><bean:message key="button.edit"/></span>';
	tableHTML += '<span onclick="deleteQuestion('+index+');" style="position:absolute;top: 0px;right: 0px;cursor: pointer;color:red;"><bean:message key="button.delete"/></span></p>';
	tableHTML += score_getTitleHTML(index);
	tableHTML += score_getOptionsHTML(index);
	tableHTML += '</td></tr></table>';
	return tableHTML;
}
function score_getTitleHTML(index){
	var serialNum = $('#serialNum'+index).val();
	var titleHTML = '<tr><td>';
	titleHTML += '<div class="pi_txtTitle pi_txtTitle_no">'+serialNum+'、</div>';
	var title = score_fdQuestionDef.subject;
	title = title.replace("<p>", "");
	title = title.replace("</p>", "");
	title = title.replace(/<img/g, '<img  onMouseOver="showTooltip(event, this.src)" onMouseOut="hideTooltip();"');
	titleHTML += '<span class="pi_txtTitle" id="fdTitle'+index+'" name="fdTitle'+index+'" onclick="modifyTitleVal(this);">'+title+'</span>';
	if(score_fdQuestionDef.willAnswer)
		titleHTML += '<span class="pi_txtRequire">*</span>';
	titleHTML += '<span class="pi_txtStrong"> ['+$('#quesTypeName'+index).val()+']</span>';
	if(score_fdQuestionDef.willAnswer == true){
		titleHTML += '<span class="pi_txtStrong"> ';
		titleHTML += '[<bean:message bundle="km-pindagate" key="kmPindagateQuestion.flag.willAnswer"/>]</span>';
	}
	titleHTML += '</td></tr>';
	if(score_fdQuestionDef.attachmentIds != ''){
		var atturl = "<c:url value='/km/pindagate/km_pindagate_question/kmPindagateQuestion.do?method=viewAtt&attachmentIds="+score_fdQuestionDef.attachmentIds+"'  />";
		titleHTML += '<tr><td>';
		titleHTML += '<iframe id="attFrame" onload="autoResize(this)" src="';
		titleHTML += atturl;
		titleHTML +='" width=100% height=100% frameborder=0 scrolling=no>';
		titleHTML +='</iframe>';
		titleHTML += '</td></tr>';
	}
	if(score_fdQuestionDef.tip != ''){
		titleHTML += '<tr><td><div class="pi_subjectExplain">';
		titleHTML += '<bean:message bundle="km-pindagate" key="kmPindagateQuestion.preview.titleDescription"/>'+$("<div></div>").append(score_fdQuestionDef.tip).text();
		titleHTML += '</div></td></tr>';
	}
	return titleHTML;
}
function score_getOptionsHTML(index){
	var optionsHTML = '<tr><td>';
	var optionIndex = 0;
	for(var key in score_fdQuestionDef.items){
		optionIndex++;
		var option = score_fdQuestionDef.items[key];
		optionsHTML += '<input type="radio" name="option'+index+'" value="'+optionIndex+'"/>'+option[0]+'  ('+option[1]+'<bean:message bundle="km-pindagate" key="kmPindagateResponse.points"/>)';
		optionsHTML += '</td></tr><tr><td>';
	}
	optionsHTML += '</td></tr>';
	return optionsHTML;
}
/**
* 编辑
*/
function score_edit(index){
	var obj = document.getElementById('fdQuestionDef'+index);
	var url = getContextPath()+"km/pindagate/question_type/score/score_edit.jsp";
	if(obj == null)
	  window.showModalDialog(url, "","dialogWidth=600px;dialogHeight=500px;");
	else
		window.showModalDialog(url, obj,"dialogWidth=600px;dialogHeight=500px;");
	if(obj.value != null && obj.value != ""){
		score_fdQuestionDef = eval("("+(obj.value)+")");
		var tableHTML = '<tr class="options"><td><p class="pi_txtRed" name="tip" style="display:none;position:relative;"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.preview.editTip"/><span onclick="singleSelect_edit('+index+');" style="position:absolute;top: 0px;right: 30px;cursor: pointer;"><bean:message key="button.edit"/></span><span style="position:absolute;top: 0px;right: 0px;cursor: pointer;"><bean:message key="button.delete"/></span></p></td></tr>';
		tableHTML += score_getTitleHTML(index);
		tableHTML += score_getOptionsHTML(index);
		tableHTML += '</td></tr>';
		$('#score_TB'+index).html(tableHTML);
		var title = score_fdQuestionDef.subject;
		title = title.replace("<p>", "");
		title = title.replace("</p>", "");
		title = title.replace(/<img/g, '<img  onMouseOver="showTooltip(event, this.src)" onMouseOut="hideTooltip();"');		
		$('span[name=fdTitle'+index+']').html(title);
		//$('span[name=fdTitle'+index+']').html($("<div></div>").append(score_fdQuestionDef.subject).text());
		setFdQuestionDef(score_fdQuestionDef,index);//更新题型定义的值
	}
}
function resizeToSmail(_this){
	  _this.style.width="300px"; 
	  _this.style.height ="300px"; 
	}
function resizeToLarge(_this){
	  _this.style.width="14px"; 
	  _this.style.height ="14px"; 
	}
score_init('${JsParam.index}');
</script>