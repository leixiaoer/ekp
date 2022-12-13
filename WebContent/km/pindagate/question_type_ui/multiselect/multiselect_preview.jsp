<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@include file="/km/pindagate/question_type_ui/common/common_preview_script.jsp"%>
<script type="text/javascript">
var _dialog;
seajs.use(['lui/dialog'], function(dialog) {
	_dialog=dialog;
});
var multiSelect_fdQuestionDef = null;
function autoResize(obj){
	obj.height = obj.contentWindow.document.body.scrollHeight + 20;	
}
function multiSelect_init(index){
	var divId = "${JsParam.divId}";
	if($('#fdQuestionDef'+index).val() == null || $('#fdQuestionDef'+index).val() == "" || $('#fdQuestionDef'+index).val() == "delete")
		return;
	multiSelect_fdQuestionDef = eval("("+($('#fdQuestionDef'+index).val())+")");
	$('#'+divId).append(multiSelect_getTableHTML(index));
}
/**
 * 根据题目序号返回一个多选题表单
 */
function multiSelect_getTableHTML(index){
	var tableHTML = '<table class="options_tb" width=95% id="multiSelect_TB'+index+'">';
	tableHTML += '<tr class="options"><td><p name="tip" style="display:none;position:relative;color:red;">';
	tableHTML += '<a onclick="multiSelect_edit('+index+');" style="position:absolute;top: 0px;right: 50px;cursor: pointer;color:red;"><bean:message key="button.edit"/></a>';
	tableHTML += '<a onclick="deleteQuestion('+index+');" style="position:absolute;top: 0px;right: 0px;cursor: pointer;color:red;"><bean:message key="button.delete"/></a></p>';
	tableHTML += multiSelect_getTitleHTML(index);
	tableHTML += multiSelect_getOptionsHTML(index);
	tableHTML += '</td></tr></table>';
	return tableHTML;
}
function multiSelect_getTitleHTML(index,showIndex){
	var serialNum = $('#serialNum'+index).val();
	var titleHTML = '<tr><td>';
	showIndex = showIndex || '${JsParam.showIndex}';
	titleHTML += '<div class="pi_txtTitle pi_txtTitle_no">'+showIndex+'、</div>';
	var title = multiSelect_fdQuestionDef.subject;
	title=title.replace(/<p>/g,"").replace(/<\/p>/g,"<br>").replace(/\n/g,"").replace(/(<br>)+$/g,"");//格式化标题
	//title = title.replace(/<img/g, '<img  onMouseOver="showTooltip(event, this.src)" onMouseOut="hideTooltip();"');
	titleHTML += '<div class="pi_txtTitle pi_txtTitle_content" id="fdTitle'+index+'" name="fdTitle'+index+'" onclick="modifyTitleVal(this);">'+title+'</div>';
	if(multiSelect_fdQuestionDef.willAnswer)
		titleHTML += '<span class="pi_txtRequire">*</span>';
	titleHTML += '<span class="pi_txtStrong"> ['+$('#quesTypeName'+index).val()+']</span>';
	if(multiSelect_fdQuestionDef.willAnswer == true){
		titleHTML += '<span class="pi_txtStrong"> ';
		titleHTML += '[<bean:message bundle="km-pindagate" key="kmPindagateQuestion.flag.willAnswer"/>]</span>';
		//如果是必选题,最多选择、最少选择个数生效
		if(multiSelect_fdQuestionDef.minSelectNumber != ""){
			titleHTML += '<span class="pi_txtStrong"> ';
			titleHTML += '[<bean:message bundle="km-pindagate" key="kmPindagateResponse.selectAtLeast"/>';
			titleHTML += multiSelect_fdQuestionDef.minSelectNumber;
			titleHTML += '<bean:message bundle="km-pindagate" key="kmPindagateResponse.matrix.items"/>';
			if(multiSelect_fdQuestionDef.maxSelectNumber!=null&&multiSelect_fdQuestionDef.maxSelectNumber!=""){
				titleHTML+=',<bean:message bundle="km-pindagate" key="kmPindagateResponse.selectAtMost"/>';
				titleHTML += multiSelect_fdQuestionDef.maxSelectNumber;
				titleHTML += '<bean:message bundle="km-pindagate" key="kmPindagateResponse.matrix.items"/>';
			}
			titleHTML +=']</span>';
		}
	}
	
	titleHTML += '</td></tr>';
	if(multiSelect_fdQuestionDef.attachmentIds !='null' && multiSelect_fdQuestionDef.attachmentIds != ''){
		var atturl = "<c:url value='/km/pindagate/km_pindagate_question/kmPindagateQuestion.do?method=viewAtt&attachmentIds="+multiSelect_fdQuestionDef.attachmentIds+"'  />";
		titleHTML += '<tr><td>';
		titleHTML += '<iframe id="attFrame" onload="autoResize(this)" src="';
		titleHTML += atturl;
		titleHTML +='" width=100% height=0 frameborder=0 scrolling=no>';
		titleHTML +='</iframe>';
		titleHTML += '</td></tr>';
	}
	if(multiSelect_fdQuestionDef.tip != ''){
		var tip=multiSelect_fdQuestionDef.tip;
		titleHTML += '<tr><td><div class="pi_subjectExplain">';
		titleHTML += '<bean:message bundle="km-pindagate" key="kmPindagateQuestion.preview.titleDescription"/>'+'<div class="pi_subjectExplain_content">'+tip+'</div>';
		titleHTML += '</div></td></tr>';
	}
	return titleHTML;
}
function multiSelect_getOptionsHTML(index){
	var vlistColumnCount = 0;
	var optionsHTML = '<tr><td><table class="options_tb question_tb" width=100%"><tr><td>';
	if(multiSelect_fdQuestionDef.hlist){
		vlistColumnCount = multiSelect_fdQuestionDef.vlistColumnCount;
	}
	var optionIndex = 0;
	for(var key in multiSelect_fdQuestionDef.items){
		optionIndex++;
		var option = multiSelect_fdQuestionDef.items[key];
		var imgHTML = "";
		if(option[1] != null && option[1] != ""){
			var imgArr = option[1].split(";");
			for(var x=0; x<imgArr.length; x++){
				if(imgArr[x]!=0)
			imgHTML += '<img src="'+imgArr[x]+'"  border="1" onclick="previewTooltip(event, this.src)" border="0"  width="14px" height="14px"/>&nbsp;&nbsp;';
			}
		}
		optionsHTML += '<input type="checkbox" name="option'+index+'" onchange="select_change('+index+')" value="'+key+'"/>'+option[0]+'  '+imgHTML+''; 
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
	if(multiSelect_fdQuestionDef.autoAddOther){
		optionsHTML += '<tr><td colspan="'+ vlistColumnCount +'"><input type="checkbox" name="option'+index+'" onchange="select_change('+index+')" value="'+optionIndex+'"/>';
		optionsHTML += multiSelect_fdQuestionDef.otherText;
		optionsHTML += '</td></tr><tr><td colspan="'+ vlistColumnCount +'"><textarea style="width:840px;height:80px" ></textarea></td></tr>';
	}
	if(multiSelect_fdQuestionDef.autoAddSelectReason){
		optionsHTML += '<tr><td colspan="'+ vlistColumnCount +'">'; //<span class="txtstrong">*</span>';
		optionsHTML += multiSelect_fdQuestionDef.selectReasonText;
		optionsHTML += '</td></tr><tr><td colspan="'+ vlistColumnCount +'"><textarea style="width:840px;height:80px"></textarea></td></tr>';
	}
	optionsHTML += '</table></td></tr>';
	return optionsHTML;
}
/**
* 编辑
*/
function multiSelect_edit(index){
	var obj = document.getElementById('fdQuestionDef'+index);
	var url ="/km/pindagate/question_type_ui/multiselect/multiselect_edit.jsp";
	if(obj == null) obj="";
	top._question=obj;
	_dialog.iframe(url," ",function(obj){
		if(obj!=null&&obj.value != null && obj.value != ""){
			multiSelect_fdQuestionDef = eval("("+(obj.value)+")");
			var tableHTML = '<tr class="options"><td><p name="tip" style="display:none;position:relative;color:red;">';
			tableHTML += '<a onclick="multiSelect_edit('+index+');" style="position:absolute;top: 0px;right: 50px;cursor: pointer;color:red;"><bean:message key="button.edit"/></a>';
			tableHTML += '<a onclick="deleteQuestion('+index+');" style="position:absolute;top: 0px;right: 0px;cursor: pointer;color:red;"><bean:message key="button.delete"/></a></p>';
			tableHTML += multiSelect_getTitleHTML(index,index + 1);
			tableHTML += multiSelect_getOptionsHTML(index);
			tableHTML += '</td></tr>';
			$('#multiSelect_TB'+index).html(tableHTML);
			var title = multiSelect_fdQuestionDef.subject;
			title = title.replace("<p>", "");
			title = title.replace("</p>", "");
			//title = title.replace(/<img/g, '<img  onMouseOver="showTooltip(event, this.src)" onMouseOut="hideTooltip();"');		
			$('span[name=fdTitle'+index+']').html(title);
			setFdQuestionDef(multiSelect_fdQuestionDef,index);//更新题型定义的值
		}
	},{"width":800,"height":500});
}
multiSelect_init('${JsParam.index}');
</script>