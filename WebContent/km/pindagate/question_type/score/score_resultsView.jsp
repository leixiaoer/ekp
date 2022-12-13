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
	$('#'+divId).prepend(score_getTableHTML(index));
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
	//统计结果图
	if(fdQuestionDef[index].statisticPic == "pie")
		score_graphPie(index);//饼图
	else 
		score_graphHistogram(index);//柱状图
}
/**
 * 根据题目序号返回一个单选题表单
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
	if(fdQuestionDef[index].willAnswer)
		titleHTML += '<span class="pi_txtStrong">*</span>';
	//titleHTML += '<span class="pi_txtTitle">'+$('#fdTitle'+index).val()+'</span>';
	titleHTML += '<span class="pi_txtStrong"> ['+$('#quesTypeName'+index).val()+']</span>';
	var title = fdQuestionDef[index].subject;
	title = title.replace("<div>", "");
	title = title.replace("</div>", "");
	title = title.replace(/<img/g, '<img  onMouseOver="showTooltip(event, this.src)" onMouseOut="hideTooltip();"');
	titleHTML += '<div class="pi_txtTitle pi_txtTitle_content">'+title+'</div>';
	//titleHTML += '<span class="pi_txtTitle">'+$('#fdTitle'+index).val()+'</span>';
	titleHTML += '</td></tr>';
	if(fdQuestionDef[index].tip != ''){
		titleHTML += '<tr><td><div class="pi_subjectExplain">';
		titleHTML += '<bean:message bundle="km-pindagate" key="kmPindagateQuestion.preview.titleDescription"/>'+$("<div class='pi_subjectExplain_content'></div>").append(fdQuestionDef[index].tip).text();
		titleHTML += '</div></td></tr>';
	}
	return titleHTML;
}
function score_getProgressHTML(index){
	var progressHTML = '<tr><td>';
	progressHTML += '<table><tr><td><bean:message bundle="km-pindagate" key="kmPindagateQuestionRes.involved"/></td><td><div id="participate'+index+'"></div></td><td><div id="participateTxt'+index+'"></td></tr></div>';
	progressHTML += '<table><tr><td><bean:message bundle="km-pindagate" key="kmPindagateQuestionRes.notInvolved"/></td><td><div id="notInvolved'+index+'"></div></td><td><div id="notInvolvedTxt'+index+'"></td></tr></div>';
	progressHTML += '</td></tr>';
	return progressHTML;
}
//饼图
function score_graphPie(index){
	var cg = new html5jp.graph.circle("vbar"+index);
	if( ! cg ) { return; }
	var items = [];
	var id = 0;
	for(var key in fdStatistic[index].options){
		if(key != 0){
			var item = [];
			item[0] = fdStatistic[index].options[key];
			item[1] = (fdStatistic[index].items[key] == "0") ? 0.0000001 : parseInt(fdStatistic[index].items[key]);
			items[id] = item;
			id++;
		}
	}
	var params = {
		backgroundColor: "#fff",
		shadow: true,
		captionNum: true,
		startAngle: -90
	};
	try{
		cg.draw(items, params);
		}catch(e){}
}
//柱状图
function score_graphHistogram(index){
	var g = new html5jp.graph.vbar("vbar"+index);
	if(!g) { return; }
	var items = [fdStatistic[index].items];
	for(var key in items[0]){
		if(key > 0){
			items[0][key] = parseInt(items[0][key]);
		}
	}
	var xx = [];
	var optionTxt = "";
	for(var key in fdStatistic[index].options){
		if(key == 0)
			optionTxt = $('<div></div>').append(fdStatistic[index].options[key]).text();
		else 
			optionTxt = fdStatistic[index].options[key];
		xx[key] = optionTxt;
	}
   	var options = {
   		x: xx,
		y: [""]
   	};
	g.draw(items, options);
}
</script>
<div id="${HtmlParam.divId}" class="pi_question" style="margin-top: -15px">
<div style="text-align: left"><canvas width="500" height="300" id="vbar${HtmlParam.index}"></canvas></div>
</div>