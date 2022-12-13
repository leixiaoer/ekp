<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@include file="/km/pindagate/question_type_ui/common/common_preview_script.jsp"%>
<script>
var _dialog;
seajs.use(['lui/dialog'], function(dialog){
	_dialog=dialog;
});
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
	var tableHTML = '<table class="options_tb" width=95% id="essayquestion_TB'+index+'">';
	tableHTML += '<tr class="options"><td><p name="tip" style="display:none;position:relative;color:red;">';
	tableHTML += '<a onclick="essayquestion_edit('+index+');" style="position:absolute;top: 0px;right: 50px;cursor: pointer;color:red;"><bean:message key="button.edit"/></a>';
	tableHTML += '<a onclick="deleteQuestion('+index+');" style="position:absolute;top: 0px;right: 0px;cursor: pointer;color:red;"><bean:message key="button.delete"/></a></p></td></tr>';
	tableHTML += essayquestion_getTitleHTML(index);
	var textHeight = essayquestion_fdQuestionDef.inputHeight*16;//一行为16像素
	tableHTML += '</td></tr><tr><td  align="left" id="essayquestion'+index+'"><textarea class="question_tb" style="width:100%;height:'+textHeight+'px"></textarea></td></tr>';
	tableHTML += '<table>';
	return tableHTML;
}
function essayquestion_getTitleHTML(index,showIndex){
	var serialNum = $('#serialNum'+index).val();
	var titleHTML = '<tr><td>';
	showIndex = showIndex ||'${JsParam.showIndex}';
	titleHTML += '<div class="pi_txtTitle pi_txtTitle_no">'+showIndex+'、</div>';
	var title = essayquestion_fdQuestionDef.subject;
	title=title.replace(/<p>/g,"").replace(/<\/p>/g,"<br>").replace(/\n/g,"").replace(/(<br>)+$/g,"");//格式化标题
	//title = title.replace(/<img/g, '<img  onMouseOver="showTooltip(event, this.src)" onMouseOut="hideTooltip();"');
	titleHTML += '<div class="pi_txtTitle pi_txtTitle_content" id="fdTitle'+index+'" name="fdTitle'+index+'" onclick="modifyTitleVal(this);">'+title+'</div>';
	if(essayquestion_fdQuestionDef.willAnswer)
		titleHTML += '<span class="pi_txtRequire">*</span>';
	titleHTML += '<span class="pi_txtStrong"> ['+$('#quesTypeName'+index).val()+']</span>';
	if(essayquestion_fdQuestionDef.willAnswer == true){
		titleHTML += '<span class="pi_txtStrong"> ';
		titleHTML += '[<bean:message bundle="km-pindagate" key="kmPindagateQuestion.flag.willAnswer"/>]</span>';
	}
	titleHTML += '</td></tr>';
	if(essayquestion_fdQuestionDef.attachmentIds != 'null' && essayquestion_fdQuestionDef.attachmentIds != ''){
		var atturl = "<c:url value='/km/pindagate/km_pindagate_question/kmPindagateQuestion.do?method=viewAtt&attachmentIds="+essayquestion_fdQuestionDef.attachmentIds+"'  />";
		titleHTML += '<tr><td>';
		titleHTML += '<iframe id="attFrame" onload="autoResize(this)" src="';
		titleHTML += atturl;
		titleHTML +='" width=100% height=0 frameborder=0 scrolling=no>';
		titleHTML +='</iframe>';
		titleHTML += '</td></tr>';
	}
	if(essayquestion_fdQuestionDef.tip != ''){
		var tip=essayquestion_fdQuestionDef.tip;
		titleHTML += '<tr><td><div class="pi_subjectExplain">';
		titleHTML += '<bean:message bundle="km-pindagate" key="kmPindagateQuestion.preview.titleDescription"/>'+'<div class="pi_subjectExplain_content">'+tip+'</div>';
		titleHTML += '</div></td></tr>';
	}
	return titleHTML;
}
/**
* 编辑
*/
function essayquestion_edit(index){
	var obj = document.getElementById('fdQuestionDef'+index);
	var url ="/km/pindagate/question_type_ui/essayquestion/essayquestion_edit.jsp";
	if(obj==null) obj="";
	top._question=obj;
	_dialog.iframe(url," ",function(obj){
		if(obj!=null&&obj.value != null && obj.value != ""){
			essayquestion_fdQuestionDef = eval("("+(obj.value)+")");
			var tableHTML = '<tr class="options"><td><p class="pi_txtRed" name="tip" style="display:none;position:relative;">';
			tableHTML += '<a onclick="essayquestion_edit('+index+');" style="position:absolute;right:50px;cursor: pointer;color:red;"><bean:message key="button.edit"/></a>';
			tableHTML += '<a onclick="deleteQuestion('+index+');" style="position:absolute;right: 0px;cursor: pointer;color:red;"><bean:message key="button.delete"/></a></p></td></tr>';
			tableHTML += essayquestion_getTitleHTML(index,index + 1);
			var textHeight = essayquestion_fdQuestionDef.inputHeight*16;//一行为16像素
			tableHTML += '</td></tr><tr><td  align="left" id="essayquestion'+index+'"><textarea style="width:500px;height:'+textHeight+'px"></textarea></td></tr>';
			$('#essayquestion_TB'+index).html(tableHTML);
			var title = essayquestion_fdQuestionDef.subject;
			title = title.replace("<p>", "");
			title = title.replace("</p>", "");
			//title = title.replace(/<img/g, '<img  onMouseOver="showTooltip(event, this.src)" onMouseOut="hideTooltip();"');		
			$('span[name=fdTitle'+index+']').html(title);
			setFdQuestionDef(essayquestion_fdQuestionDef,index);//更新题型定义的值
		}
	},{"width":800,"height":500});
}
essayquestion_init('${JsParam.index}');
</script>
