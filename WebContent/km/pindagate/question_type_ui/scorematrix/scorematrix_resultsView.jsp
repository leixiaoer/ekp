<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript">
/**
 * 绘制题目信息(矩阵评分题)
 */
function function_${JsParam.index}(){
	var index = "${JsParam.index}";
	var divId = "${JsParam.divId}";
	fdQuestionDef[index] = eval("("+($('#fdQuestionDef'+index).val())+")");
	fdStatistic[index] = eval("("+($('#fdStatistic'+index).val())+")");
	$('#'+divId).prepend(scoreMatrix_getTableHTML(index));
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
	//画柱状图
	var g = new html5jp.graph.vbar("vbar"+index);
	if(!g) { return; }
	var items = fdStatistic[index].items;
	for(var key in fdStatistic[index].items){
		var item = [];
		for(var key2 in fdStatistic[index].items[key]){
			if(key2 == 0)
				item[key2] = fdStatistic[index].items[key][key2];
			else
				item[key2] = parseInt(fdStatistic[index].items[key][key2]);
		}
		items[key] = item;
	}
	var options = fdStatistic[index].options;
	options[0] = $('<div></div>').append(options[0]).text();
   	var options = {
   		x: options,
		y: [""]
   	};
	g.draw(items, options);
}
/**
 * 根据题目序号返回一个单选题表单
 */
function scoreMatrix_getTableHTML(index){
	var tableHTML = '<table class="options_tb" width=90% id="scoreSelect_TB'+index+'">';
	tableHTML += scoreMatrix_getTitleHTML(index);
	tableHTML += scoreMatrix_getProgressHTML(index);
	tableHTML += '</table>';
	return tableHTML;
}
function scoreMatrix_getTitleHTML(index){
	var serialNum = $('#serialNum'+index).val();
	var titleHTML = '<tr><td>';
	titleHTML += '<div class="pi_txtTitle pi_txtTitle_no">'+serialNum+'、</div>';
	var title = fdQuestionDef[index].subject;
	title=title.replace(/<p>/g,"").replace(/<\/p>/g,"<br>").replace(/\n/g,"").replace(/(<br>)+$/g,"");//格式化标题y
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
function scoreMatrix_getProgressHTML(index){
	var progressHTML = '<tr><td>';
	progressHTML += '<table class="pi_progress"><tr><td><bean:message bundle="km-pindagate" key="kmPindagateQuestionRes.involved"/></td><td><div id="participate'+index+'"></div></td><td><div id="participateTxt'+index+'"></td></tr></div>';
	progressHTML += '<table class="pi_progress"><tr><td><bean:message bundle="km-pindagate" key="kmPindagateQuestionRes.notInvolved"/></td><td><div id="notInvolved'+index+'"></div></td><td><div id="notInvolvedTxt'+index+'"></td></tr></div>';
	progressHTML += '</td></tr>';
	return progressHTML;
}
</script>
<div id="${HtmlParam.divId}" class="pi_question" style="margin-top: -15px">
	<div style="text-align: left">
		<canvas width="500" height="300" id="vbar${HtmlParam.index}"></canvas>
	</div>
</div>