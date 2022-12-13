<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@include file="/km/pindagate/question_type_ui/common/common_preview_script.jsp"%>
<script type="text/javascript">
var _dialog;
seajs.use(['lui/dialog'], function(dialog){
	_dialog=dialog;
});
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
	var tableHTML = '<table class="options_tb question_tb" width=95% id="score_TB'+index+'">';
	tableHTML += '<tr class="options"><td><p name="tip" style="display:none;position:relative;color:red;">';
	tableHTML += '<a onclick="score_edit('+index+');" style="position:absolute;top: 0px;right: 50px;cursor: pointer;color:red;"><bean:message key="button.edit"/></a>';
	tableHTML += '<a onclick="deleteQuestion('+index+');" style="position:absolute;top: 0px;right: 0px;cursor: pointer;color:red;"><bean:message key="button.delete"/></a></p>';
	tableHTML += score_getTitleHTML(index);
	tableHTML += score_getOptionsHTML(index);
	tableHTML += '</td></tr></table>';
	return tableHTML;
}
function score_getTitleHTML(index,showIndex){
	var serialNum = $('#serialNum'+index).val();
	var titleHTML = '<tr><td>';
	showIndex = showIndex || '${JsParam.showIndex}';
	titleHTML += '<div class="pi_txtTitle pi_txtTitle_no">'+showIndex+'、</div>';
	var title = score_fdQuestionDef.subject;
	title=title.replace(/<p>/g,"").replace(/<\/p>/g,"<br>").replace(/\n/g,"").replace(/(<br>)+$/g,"");//格式化标题
	//title = title.replace(/<img/g, '<img  onMouseOver="showTooltip(event, this.src)" onMouseOut="hideTooltip();"');
	titleHTML += '<div class="pi_txtTitle pi_txtTitle_content" id="fdTitle'+index+'" name="fdTitle'+index+'" onclick="modifyTitleVal(this);">'+title+'</div>';
	if(score_fdQuestionDef.willAnswer)
		titleHTML += '<span class="pi_txtRequire">*</span>';
	titleHTML += '<span class="pi_txtStrong"> ['+$('#quesTypeName'+index).val()+']</span>';
	if(score_fdQuestionDef.willAnswer == true){
		titleHTML += '<span class="pi_txtStrong"> ';
		titleHTML += '[<bean:message bundle="km-pindagate" key="kmPindagateQuestion.flag.willAnswer"/>]</span>';
	}
	titleHTML += '</td></tr>';
	if(score_fdQuestionDef.attachmentIds !='null' && score_fdQuestionDef.attachmentIds != ''){
		var atturl = "<c:url value='/km/pindagate/km_pindagate_question/kmPindagateQuestion.do?method=viewAtt&attachmentIds="+score_fdQuestionDef.attachmentIds+"'  />";
		titleHTML += '<tr><td>';
		titleHTML += '<iframe id="attFrame" onload="autoResize(this)" src="';
		titleHTML += atturl;
		titleHTML +='" width=100% height=0 frameborder=0 scrolling=no>';
		titleHTML +='</iframe>';
		titleHTML += '</td></tr>';
	}
	if(score_fdQuestionDef.tip != ''){
		var tip=score_fdQuestionDef.tip;
		titleHTML += '<tr><td><div class="pi_subjectExplain">';
		titleHTML += '<bean:message bundle="km-pindagate" key="kmPindagateQuestion.preview.titleDescription"/>'+'<div class="pi_subjectExplain_content">'+tip+'</div>';
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
	if(score_fdQuestionDef.autoAddSelectReason){
		optionsHTML += '<tr><td>'; //<span class="txtstrong">*</span>';
		optionsHTML += score_fdQuestionDef.selectReasonText;
		optionsHTML += '</td></tr><tr><td><textarea style="width:840px;height:80px"></textarea></td></tr>';
	}
	return optionsHTML;
}
/**
* 编辑
*/
function score_edit(index){
	var obj = document.getElementById('fdQuestionDef'+index);
	var url = "/km/pindagate/question_type_ui/score/score_edit.jsp";
	if(obj == null) obj="";
	top._question=obj;
	_dialog.iframe(url," ",function(obj){
		if(obj!=null&&obj.value != null && obj.value != ""){
			score_fdQuestionDef = eval("("+(obj.value)+")");
			var tableHTML = '<tr class="options"><td><p class="pi_txtRed" name="tip" style="display:none;position:relative;"><a onclick="singleSelect_edit('+index+');" style="position:absolute;top: 0px;right: 50px;cursor: pointer;"><bean:message key="button.edit"/></a><a style="position:absolute;top: 0px;right: 0px;cursor: pointer;"><bean:message key="button.delete"/></a></p></td></tr>';
			tableHTML += score_getTitleHTML(index,index + 1);
			tableHTML += score_getOptionsHTML(index);
			tableHTML += '</td></tr>';
			$('#score_TB'+index).html(tableHTML);
			var title = score_fdQuestionDef.subject;
			title = title.replace("<p>", "");
			title = title.replace("</p>", "");
			//title = title.replace(/<img/g, '<img  onMouseOver="showTooltip(event, this.src)" onMouseOut="hideTooltip();"');		
			$('span[name=fdTitle'+index+']').html(title);
			setFdQuestionDef(score_fdQuestionDef,index);//更新题型定义的值
		}
	},{"width":800,"height":500});
}
score_init('${JsParam.index}');
</script>