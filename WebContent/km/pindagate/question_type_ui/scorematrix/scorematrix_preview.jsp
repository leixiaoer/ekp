<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@include file="/km/pindagate/question_type_ui/common/common_preview_script.jsp"%>
<script type="text/javascript" >
var _dialog;
seajs.use(['lui/dialog'], function(dialog){
	_dialog=dialog;
});
var scoreMatrix_fdQuestionDef = null;
function autoResize(obj){
	obj.height = obj.contentWindow.document.body.scrollHeight + 20;	
}
function scoreMatrix_init(index){
	var divId = "${JsParam.divId}";
	if($('#fdQuestionDef'+index).val() == null || $('#fdQuestionDef'+index).val() == "" || $('#fdQuestionDef'+index).val() == "delete")
		return;
	scoreMatrix_fdQuestionDef = eval("("+($('#fdQuestionDef'+index).val())+")");
	$('#'+divId).append(scoreMatrix_getTableHTML(index)); 
	if(scoreMatrix_fdQuestionDef.hlist){ //判断问题是按行显示还是按列显示
		scoreMatrix_getContent_col(index);
	}
	else{
		scoreMatrix_getContent_row(index);
	}
}
/**
* 根据题目序号返回一个矩阵单选的表格
*/
function scoreMatrix_getTableHTML(index){
	var tableHTML = '<table class="options_tb" width=95% id="scoreMatris_TB'+index+'">';
	tableHTML += '<tr class="options"><td><p name="tip" style="display:none;position:relative;color:red;">';
	tableHTML += '<a onclick="scoreMatrix_edit('+index+');" style="position:absolute;top: 0px;right: 50px;cursor: pointer;color:red;"><bean:message key="button.edit"/></a>';
	tableHTML += '<a onclick="deleteQuestion('+index+');" style="position:absolute;top: 0px;right: 0px;cursor: pointer;color:red;"><bean:message key="button.delete"/></a></p></td></tr>';
	tableHTML += scoreMatrix_getTitleHTML(index);
	tableHTML += '</td></tr><tr><td id="scorematrixquestion'+index+'"></td></tr>';//
	//选择原因
	if(scoreMatrix_fdQuestionDef.autoAddSelectReason){
		tableHTML += '<tr><td style="padding-bottom:10px;">';
		tableHTML += scoreMatrix_fdQuestionDef.selectReasonText;
		tableHTML += '</td></tr><tr><td><textarea name="fdItems['+index+'].fdSelectReason"'+
						' style="width:840px;height:80px"></textarea></td></tr>';
	}
	tableHTML += '</table>';
	return tableHTML;
}
//得到展现题目所需的html代码
function scoreMatrix_getTitleHTML(index,showIndex){
	var serialNum = $('#serialNum'+index).val();
	var titleHTML = '<tr><td>';
	showIndex = showIndex || '${JsParam.showIndex}';
	titleHTML += '<div class="pi_txtTitle pi_txtTitle_no">'+showIndex+'、</div>';
	var title = scoreMatrix_fdQuestionDef.subject;
	title=title.replace(/<p>/g,"").replace(/<\/p>/g,"<br>").replace(/\n/g,"").replace(/(<br>)+$/g,"");//格式化标题
	//title = title.replace(/<img/g, '<img  onMouseOver="showTooltip(event, this.src)" onMouseOut="hideTooltip();"');
	titleHTML += '<div class="pi_txtTitle pi_txtTitle_content" id="fdTitle'+index+'" name="fdTitle'+index+'" onclick="modifyTitleVal(this);">'+title+'</div>';
	if(scoreMatrix_fdQuestionDef.willAnswer)
		titleHTML += '<span class="pi_txtStrong">*</span>';
	titleHTML += '<span class="pi_txtStrong"> ['+$('#quesTypeName'+index).val()+']</span>';
	titleHTML += '</td></tr>';
	if(scoreMatrix_fdQuestionDef.attachmentIds !='null' && scoreMatrix_fdQuestionDef.attachmentIds != ''){
		var atturl = "<c:url value='/km/pindagate/km_pindagate_question/kmPindagateQuestion.do?method=viewAtt&attachmentIds="+scoreMatrix_fdQuestionDef.attachmentIds+"'  />";
		titleHTML += '<tr><td>';
		titleHTML += '<iframe id="attFrame" onload="autoResize(this)" src="';
		titleHTML += atturl;
		titleHTML +='" width=100% height=0 frameborder=0 scrolling=no>';
		titleHTML +='</iframe>';
		titleHTML += '</td></tr>';
	}
	if(scoreMatrix_fdQuestionDef.tip != ''){
		var tip=scoreMatrix_fdQuestionDef.tip;
		titleHTML += '<tr><td><div class="pi_subjectExplain">';
		titleHTML += '<bean:message bundle="km-pindagate" key="kmPindagateQuestion.preview.titleDescription"/>'+'<div class="pi_subjectExplain_content">'+tip+'</div>';
		titleHTML += '</div></td></tr>';
	}
	return titleHTML;
}
//得到问题和选项的主要内容-矩阵问题按行排序
function scoreMatrix_getContent_row(index){
	var optionsHTML = '<table class="question_tb">';
	optionsHTML += '<tr>';
	optionsHTML += '<td></td>';
	for(var key in scoreMatrix_fdQuestionDef.options){

		var option = scoreMatrix_fdQuestionDef.options[key];
		var imgHTML = "";
		optionsHTML += '<td>'+scoreMatrix_fdQuestionDef.options[key][0]+"("+scoreMatrix_fdQuestionDef.options[key][1]+"${ lfn:message('km-pindagate:kmPindagateResponse.points') }"+")"+'</td>';
	}
	optionsHTML += '</tr>';
	for(var itemskey in scoreMatrix_fdQuestionDef.items){

		var option = scoreMatrix_fdQuestionDef.items[itemskey];
		var imgHTML = "";
		if(option[1] != null && option[1] != ""){
			var imgArr = option[1].split(";");
			for(var x=0; x<imgArr.length; x++){
				if(imgArr[x]!=0)
			imgHTML += '<img src="'+imgArr[x]+'"  border="1" onclick="previewTooltip(event, this.src)" border="0"  width="14px" height="14px"/>&nbsp;&nbsp;';
			}
		}
		optionsHTML += '<tr>';
		optionsHTML += '<td>'+scoreMatrix_fdQuestionDef.items[itemskey][0]+imgHTML+'</td>';
		for(var optionskey in scoreMatrix_fdQuestionDef.options){
			optionsHTML += '<td align="center"><input type="radio" name="option'+index+itemskey+'"/></td>';
		}
		optionsHTML += '</tr>';
	}
	optionsHTML += '</table>';
	$('#scorematrixquestion'+index).html(optionsHTML);
}
//得到问题和选项的主要内容-矩阵问题按列排序
function scoreMatrix_getContent_col(index){
	 var optionsHTML = '<table class="question_tb">';
		optionsHTML += '<tr>';
		optionsHTML += '<td></td>';
		for(var key in scoreMatrix_fdQuestionDef.items){
			var option = scoreMatrix_fdQuestionDef.items[key];
			var imgHTML = "";
			if(option[1] != null && option[1] != ""){
				var imgArr = option[1].split(";");
				for(var x=0; x<imgArr.length; x++){
					if(imgArr[x]!=0)
				imgHTML += '<img src="'+imgArr[x]+'"  border="1" onclick="previewTooltip(event, this.src)" border="0"  width="14px" height="14px"/>&nbsp;&nbsp;';
				}
			}
			optionsHTML += '<td>'+scoreMatrix_fdQuestionDef.items[key][0]+imgHTML+'</td>';
		}
		optionsHTML += '</tr>';
		for(var optionskey in scoreMatrix_fdQuestionDef.options){
			var option = scoreMatrix_fdQuestionDef.options[optionskey];
			var imgHTML = "";
			optionsHTML += '<tr>';
			optionsHTML += '<td>'+scoreMatrix_fdQuestionDef.options[optionskey][0]+"("+scoreMatrix_fdQuestionDef.options[optionskey][1]+"${ lfn:message('km-pindagate:kmPindagateResponse.points') }"+")"+'</td>';
			for(var itemskey in scoreMatrix_fdQuestionDef.items){
				optionsHTML += '<td align="center"><input type="radio" name="option'+index+itemskey+'"/></td>';
			}
			optionsHTML += '</tr>';
		}
		optionsHTML += '</table>';
		$('#scorematrixquestion'+index).html(optionsHTML);
}
/**
 * 编辑
 */
function scoreMatrix_edit(index){
	var obj = document.getElementById('fdQuestionDef'+index);
	var url = "/km/pindagate/question_type_ui/scorematrix/scorematrix_edit.jsp";
	if(obj == null) obj="";
	top._question=obj;
	_dialog.iframe(url," ",function(obj){
		if(obj!=null&&obj.value != null && obj.value != ""){
			scoreMatrix_fdQuestionDef = eval("("+(obj.value)+")");
			var tableHTML = '<tr class="options"><td><p class="pi_txtRed" name="tip" style="display:none;position:relative;">';
			tableHTML += '<a onclick="scoreMatrix_edit('+index+');" style="position:absolute;top: 0px;right: 50px;cursor: pointer;"><bean:message key="button.edit"/></a>';
			tableHTML += '<a onclick="deleteQuestion('+index+');" style="position:absolute;top: 0px;right: 0px;cursor: pointer;"><bean:message key="button.delete"/></a></p></td></tr>';
			tableHTML += scoreMatrix_getTitleHTML(index,index + 1);
			tableHTML += '</td></tr><tr><td id="scorematrixquestion'+index+'"></td></tr>';
			$('#scoreMatris_TB'+index).html(tableHTML);
			if(	scoreMatrix_fdQuestionDef.hlist) //判断问题是按行显示还是按列显示
				scoreMatrix_getContent_col(index);
			else 
				scoreMatrix_getContent_row(index);	
			var title = scoreMatrix_fdQuestionDef.subject;
			title = title.replace("<p>", "");
			title = title.replace("</p>", "");
			//title = title.replace(/<img/g, '<img  onMouseOver="showTooltip(event, this.src)" onMouseOut="hideTooltip();"');		
			$('span[name=fdTitle'+index+']').html(title);
			setFdQuestionDef(scoreMatrix_fdQuestionDef,index);//更新题型定义的值
		}
	},{"width":800,"height":500});
}
scoreMatrix_init('${JsParam.index}');
</script>