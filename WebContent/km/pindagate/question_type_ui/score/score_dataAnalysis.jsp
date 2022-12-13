<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript">
function function_${JsParam.index}(){
	var index = "${JsParam.index}";
	var divId = "${JsParam.divId}";
	fdQuestionDef[index] = eval("("+($('#fdQuestionDef'+index).val())+")");
	fdStatistic[index] = eval("("+($('#fdStatistic'+index).val())+")");
	$('#'+divId).prepend(score_getTableHTML(index));
	$('#content'+index).append(score_getDataAnalysisHTML(index));
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
	var o1 = new html5jp.progress("participate"+index, participate,"#5AB536");
	o1.draw();
	var notInvolved = {to: notInvolvedNumber*100/totalNum};
	var o2 = new html5jp.progress("notInvolved"+index, notInvolved,"#F28822");
	o2.draw();
	$('#participateTxt'+index).html("（"+participateNumber+" / "+pantNum+"）");
	$('#notInvolvedTxt'+index).html("（"+notInvolvedNumber+" / "+pantNum+"）");
	if(participateNumber == 0)participateNumber = 1;
	//各选项百分比
	for(var j = 1;j<fdStatistic[index].options.length;j++){
		var proportion = parseInt(fdStatistic[index].items[j]);
		var percentage = {to: proportion*100/participateNumber};
		var o3 = new html5jp.progress("dataAnalysis"+index+j, percentage,"#0B7ACF");
		o3.draw();
		$('#dataAnalysisTxt'+index+j).html("（"+proportion+"）");
	}
}
/**
 * 根据题目序号返回一个评分题表单
 */
function score_getTableHTML(index){
	var tableHTML = '<table class="options_tb" width=90% id="singleSelect_TB'+index+'">';
	tableHTML += score_getTitleHTML(index);
	tableHTML += score_getProgressHTML(index);
	tableHTML += '</table>';
	return tableHTML;
}
function score_getTitleHTML(index){
	var serialNum = $('#serialNum'+index).val();
	var titleHTML = '<tr><td>';
	titleHTML += '<div class="pi_txtTitle pi_txtTitle_no">'+serialNum+'、</div>';
	var title = fdQuestionDef[index].subject;
	title=title.replace(/<p>/g,"").replace(/<\/p>/g,"<br>").replace(/\n/g,"").replace(/(<br>)+$/g,"");//格式化标题
	title = title.replace(/<img/g, '<img  onMouseOver="showTooltip(event, this.src)" onMouseOut="hideTooltip();"');
	titleHTML += '<div class="pi_txtTitle pi_txtTitle_content">'+title+'</div>';
	if(fdQuestionDef[index].willAnswer)
		titleHTML += '<span class="pi_txtRequire">*</span>';
	titleHTML += '<span class="pi_txtStrong"> ['+$('#quesTypeName'+index).val()+']</span>';
	titleHTML += '</td></tr>';
	if(fdQuestionDef[index].tip != ''){
		var tip=fdQuestionDef[index].tip;
		titleHTML += '<tr><td><div class="pi_subjectExplain">';
		titleHTML += '<bean:message bundle="km-pindagate" key="kmPindagateQuestion.preview.titleDescription"/>'+'<div class="pi_subjectExplain_content">'+tip+'</div>';
		titleHTML += '</div></td></tr>';
	}
	return titleHTML;
}
function score_getProgressHTML(index){
	var progressHTML = '<tr><td>';
	progressHTML += '<table class="pi_progress"><tr><td><bean:message bundle="km-pindagate" key="kmPindagateQuestionRes.involved"/></td><td><div id="participate'+index+'"></div></td><td><div id="participateTxt'+index+'"></td></tr></div>';
	progressHTML += '<table class="pi_progress"><tr><td><bean:message bundle="km-pindagate" key="kmPindagateQuestionRes.notInvolved"/></td><td><div id="notInvolved'+index+'"></div></td><td><div id="notInvolvedTxt'+index+'"></td></tr></div>';
	progressHTML += '</td></tr>';
	return progressHTML;
}
function score_getDataAnalysisHTML(index){
	var dataAnalysisHTML = '<table class="pi_progress">';
	for(var i = 1;i<fdStatistic[index].options.length;i++){
		dataAnalysisHTML += '<tr><td>'+fdStatistic[index].options[i]+'</td><td><div id="dataAnalysis'+index+i+'"></div></td><td><div id="dataAnalysisTxt'+index+i+'"></div></td></tr>';
	}
	dataAnalysisHTML += '</table>';
	return dataAnalysisHTML;
}
</script>
<div id="${HtmlParam.divId}" class="pi_question" style="margin-top: -15px">
	<div style="text-align: left" id="content${HtmlParam.index}"></div>
</div>