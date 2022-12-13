<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@include file="/km/pindagate/question_type_ui/common/common_preview_script.jsp"%>
<script type="text/javascript">
	var _dialog;
	seajs.use(['lui/dialog'], function(dialog) {
		_dialog=dialog;
	});
</script>
<script type="text/javascript">
function autoResize(obj){
	obj.height = obj.contentWindow.document.body.scrollHeight + 20;	
}
var matrixfilled_fdQuestionDef = null;
function matrixfilled_init(index){
	var divId = "${JsParam.divId}";
	if($('#fdQuestionDef'+index).val() == null || $('#fdQuestionDef'+index).val() == "" || $('#fdQuestionDef'+index).val() == "delete")
		return;
	matrixfilled_fdQuestionDef = eval("("+($('#fdQuestionDef'+index).val())+")");
	$('#'+divId).append(matrixfilled_getTableHTML(index));
}
/**
 * 根据题目序号返回一个单选题表单
 */
function matrixfilled_getTableHTML(index){
	var tableHTML = '<table class="options_tb" width=95% id="matrixfilled_TB'+index+'">';
	tableHTML += '<tr class="options"><td><p name="tip" style="display:none;position:relative;color:red;">';
	tableHTML += '<a onclick="matrixfilled_edit('+index+');" style="position:absolute;top: 0px;right: 50px;cursor: pointer;color:red;"><bean:message key="button.edit"/></a>';
	tableHTML += '<a onclick="deleteQuestion('+index+');" style="position:absolute;top: 0px;right: 0px;cursor: pointer;color:red;"><bean:message key="button.delete"/></a></p></td></tr>';
	tableHTML += matrixfilled_getTitleHTML(index);
	tableHTML += matrixfilled_getOptionsHTML(index);
	tableHTML += '</table>';
	return tableHTML;
}
function matrixfilled_getTitleHTML(index,showIndex){
	var serialNum = $('#serialNum'+index).val();
	var titleHTML = '<tr><td>';
	showIndex = showIndex || '${JsParam.showIndex}';
	titleHTML += '<div class="pi_txtTitle pi_txtTitle_no">'+showIndex+'、</div>';
	var title = matrixfilled_fdQuestionDef.subject;
	title=title.replace(/<p>/g,"").replace(/<\/p>/g,"<br>").replace(/\n/g,"").replace(/(<br>)+$/g,"");//格式化标题
	//title = title.replace(/<img/g, '<img  onMouseOver="showTooltip(event, this.src)" onMouseOut="hideTooltip();"');
	titleHTML += '<div class="pi_txtTitle pi_txtTitle_content" id="fdTitle'+index+'" name="fdTitle'+index+'" onclick="modifyTitleVal(this);">'+title+'</div>';
	if(matrixfilled_fdQuestionDef.willAnswer)
		titleHTML += '<span class="pi_txtRequire">*</span>';
	titleHTML += '<span class="pi_txtStrong"> ['+$('#quesTypeName'+index).val()+']</span>';
	if(matrixfilled_fdQuestionDef.willAnswer == true){
		titleHTML += '<span class="pi_txtStrong"> ';
		titleHTML += '[<bean:message bundle="km-pindagate" key="kmPindagateQuestion.flag.willAnswer"/>]</span>';
	}
	titleHTML += '</td></tr>';
	if(matrixfilled_fdQuestionDef.attachmentIds !='null' && matrixfilled_fdQuestionDef.attachmentIds != ''){
		var atturl = "<c:url value='/km/pindagate/km_pindagate_question/kmPindagateQuestion.do?method=viewAtt&attachmentIds="+matrixfilled_fdQuestionDef.attachmentIds+"'  />";
		titleHTML += '<tr><td>';
		titleHTML += '<iframe id="attFrame" onload="autoResize(this)" src="';
		titleHTML += atturl;
		titleHTML +='" width=100% height=0 frameborder=0 scrolling=no>';
		titleHTML +='</iframe>';
		titleHTML += '</td></tr>';
	}
	
	if(matrixfilled_fdQuestionDef.tip != ''){
		var tip=matrixfilled_fdQuestionDef.tip;
		titleHTML += '<tr><td><div class="pi_subjectExplain">';
		titleHTML += '<bean:message bundle="km-pindagate" key="kmPindagateQuestion.preview.titleDescription"/>'+'<div  class="pi_subjectExplain_content">'+tip+'</div>';
		titleHTML += '</div></td></tr>';
	}
	return titleHTML;
}
function matrixfilled_getOptionsHTML(index){
	var vlistColumnCount = 0;
	var optionsHTML = '<tr><td><table class="options_tb question_tb" width=100%"><tr><td>';
	if(matrixfilled_fdQuestionDef.hlist){
		vlistColumnCount = matrixfilled_fdQuestionDef.vlistColumnCount;
	}
	var optionIndex = 0;
	for(var key in matrixfilled_fdQuestionDef.items){
		optionIndex++;
		var option = matrixfilled_fdQuestionDef.items[key];
		var imgHTML = "";
		if(option[1] != null && option[1] != ""){
			var imgArr = option[1].split(";");
			for(var x=0; x<imgArr.length; x++){
				if(imgArr[x]!=0)
			imgHTML += '<img src="'+imgArr[x]+'"  border="1" onclick="previewTooltip(event, this.src)" border="0"  width="14px" height="14px"/>&nbsp;&nbsp;';
			}
		}
		optionsHTML += option[0]+'&nbsp;&nbsp;&nbsp;&nbsp;'+imgHTML+''+'<input type="input" name="option'+index+'"/>'; 
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
	if(matrixfilled_fdQuestionDef.autoAddOther){
		optionsHTML += '<tr><td colspan="'+ vlistColumnCount +'"><input type="radio" name="option'+index+'" value="'+optionIndex+'"/>';
		optionsHTML += matrixfilled_fdQuestionDef.otherText;
		optionsHTML += '</td></tr><tr><td colspan="'+ vlistColumnCount +'"><textarea style="width:840px;height:80px" ></textarea></td></tr>';
						
		}
	if(matrixfilled_fdQuestionDef.autoAddSelectReason){
		optionsHTML += '<tr><td colspan="'+ vlistColumnCount +'">'; //<span class="txtstrong">*</span>';
		optionsHTML += matrixfilled_fdQuestionDef.selectReasonText;
		optionsHTML += '</td></tr><tr><td colspan="'+ vlistColumnCount +'"><textarea style="width:840px;height:80px"></textarea></td></tr>';
	}
	optionsHTML += '</table></td></tr>';
	return optionsHTML;
}
/**
 * 编辑
 */
function matrixfilled_edit(index){
	var obj = document.getElementById('fdQuestionDef'+index);
	var url = "/km/pindagate/question_type_ui/matrixfilled/matrixfilled_edit.jsp";
	if(obj==null) obj="";
	top._question=obj;
	_dialog.iframe(url," ",function(obj){
		if(obj!=null&&obj.value != null && obj.value != ""){
			matrixfilled_fdQuestionDef = eval("("+(obj.value)+")");
			var tableHTML = '<tr class="options"><td><p name="tip" style="display:none;position:relative;color:red;"><a onclick="matrixfilled_edit('+index+');" style="position:absolute;top: 0px;right: 50px;cursor: pointer;color:red;"><bean:message key="button.edit"/></a><a style="position:absolute;top: 0px;right: 0px;cursor: pointer;color:red;"><bean:message key="button.delete"/></a></p></td></tr>';
			tableHTML += matrixfilled_getTitleHTML(index,index + 1);
			tableHTML += matrixfilled_getOptionsHTML(index);
			$('#matrixfilled_TB'+index).html(tableHTML);
			var title = matrixfilled_fdQuestionDef.subject;
			title = title.replace("<p>", "");
			title = title.replace("</p>", "");
			//title = title.replace(/<img/g, '<img  onMouseOver="showTooltip(event, this.src)" onMouseOut="hideTooltip();"');		
			$('span[name=fdTitle'+index+']').html(title);
			setFdQuestionDef(matrixfilled_fdQuestionDef,index);//更新题型定义的值
		}
	},{"width":800,"height":500});
}
matrixfilled_init('${JsParam.index}');
</script>