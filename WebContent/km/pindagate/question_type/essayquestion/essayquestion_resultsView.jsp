<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript">
function function_${JsParam.index}(){
	var index = "${JsParam.index}";
	var divId = "${JsParam.divId}";
	fdQuestionDef[index] = eval("("+($('#fdQuestionDef'+index).val())+")");
	fdStatistic[index] = eval("("+($('#fdStatistic'+index).val())+")");
	$('#'+divId).prepend(essayquestion_getTableHTML(index));
	//画“参与”、“跳过”进度条
	var totalNum = 10;
	if($('#fdParticipantNum').val() != null && $('#fdParticipantNum').val() != "")
		totalNum = parseInt($('#fdParticipantNum').val());
	var participateNumber = fdStatistic[index].participateNumber;
	var notInvolvedNumber = fdStatistic[index].notInvolvedNumber;
	var participate = {to: participateNumber*100/totalNum};
	var pantNum = $("#fdParticipantNum").val();
	if(participateNumber ==0 && notInvolvedNumber == 0){
		notInvolvedNumber = pantNum;
	}
	var o1 = new html5jp.progress("participate"+index, participate,"green");
	o1.draw();
	var notInvolved = {to: notInvolvedNumber*100/totalNum};
	var o2 = new html5jp.progress("notInvolved"+index, notInvolved,"#BBB");
	o2.draw();
	
	$('#participateTxt'+index).html("（"+participateNumber+" / "+pantNum+"）");
	$('#notInvolvedTxt'+index).html("（"+notInvolvedNumber+" / "+pantNum+"）");
	var otherDiv = '<br><div style="text-align: left;"><bean:message bundle="km-pindagate" key="kmPindagateResponse.allInfo"/>:“';
	otherDiv += '<a href="#" onclick="essayquestion_viewOtherAnswer('+index+');" style="cursor: pointer;"><bean:message bundle="km-pindagate" key="kmPindagateResponse.view"/></a>”</div>';
	$('#'+divId).append(otherDiv);
}
/**
 * 根据题目序号返回一个单选题表单
 */
function essayquestion_getTableHTML(index){
	var tableHTML = '<table class="options_tb" width=90% id="singleSelect_TB'+index+'">';
	tableHTML += essayquestion_getTitleHTML(index);
	tableHTML += essayquestion_getProgressHTML(index);
	tableHTML += '</table>';
	return tableHTML;
}
function essayquestion_getTitleHTML(index){
	var serialNum = $('#serialNum'+index).val();
	var titleHTML = '<tr><td>';
	titleHTML += '<div class="pi_txtTitle pi_txtTitle_no">'+serialNum+'、</div>';
	if(fdQuestionDef[index].willAnswer)
		titleHTML += '<span class="pi_txtStrong">*</span>';
	//titleHTML += '<span class="pi_txtTitle">'+$('#fdTitle'+index).val()+'</span>';
	titleHTML += '<span class="pi_txtStrong"> ['+$('#quesTypeName'+index).val()+']</span>';
	var title = fdQuestionDef[index].subject;
	title = title.replace("<div>", "");
	title = title.replace("</div>", "");
	title = title.replace(/<img/g, '<img  onMouseOver="showTooltip(event, this.src)" onMouseOut="hideTooltip();"');
	titleHTML += '<div class="pi_txtTitle pi_txtTitle_content">'+title+'</div>';
	titleHTML += '</td></tr>';
	if(fdQuestionDef[index].tip != ''){
		titleHTML += '<tr><td><div class="pi_subjectExplain">';
		titleHTML += '<bean:message bundle="km-pindagate" key="kmPindagateQuestion.preview.titleDescription"/>'+$("<div class='pi_subjectExplain_content'></div>").append(fdQuestionDef[index].tip).text();
		titleHTML += '</div></td></tr>';
	}
	return titleHTML;
}
function essayquestion_getProgressHTML(index){
	var progressHTML = '<tr><td>';
	progressHTML += '<table><tr><td><bean:message bundle="km-pindagate" key="kmPindagateQuestionRes.involved"/></td><td><div id="participate'+index+'"></div></td><td><div id="participateTxt'+index+'"></td></tr></div>';
	progressHTML += '<table><tr><td><bean:message bundle="km-pindagate" key="kmPindagateQuestionRes.notInvolved"/></td><td><div id="notInvolved'+index+'"></div></td><td><div id="notInvolvedTxt'+index+'"></td></tr></div>';
	progressHTML += '</td></tr>';
	return progressHTML;
}
/**
* 全部信息:“查看”
*/
function essayquestion_viewOtherAnswer(index)
{
	var questionId = $('#questionId'+index).val();
	Com_OpenWindow('<c:url value="/km/pindagate/km_pindagate_question_res/kmPindagateQuestionRes.do?method=list&questionId='+questionId+'" />');
}
</script>
<div id="${HtmlParam.divId}" class="pi_question" style="margin-top: -15px">
</div>