<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<script type="text/javascript" >
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
	var tableHTML = '<table class="options_tb" width=90% id="scoreMatris_TB'+index+'">';
	tableHTML += '<tr class="options"><td><p name="tip" style="display:none;position:relative;color:red;"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.preview.editTip"/>';
	tableHTML += '<span onclick="scoreMatrix_edit('+index+');" style="position:absolute;top: 0px;right: 30px;cursor: pointer;color:red;"><bean:message key="button.edit"/></span>';
	tableHTML += '<span onclick="deleteQuestion('+index+');" style="position:absolute;top: 0px;right: 0px;cursor: pointer;color:red;"><bean:message key="button.delete"/></span></p></td></tr>';
	tableHTML += scoreMatrix_getTitleHTML(index);
	tableHTML += '</td></tr><tr><td id="scorematrixquestion'+index+'"></td></tr>';//
	tableHTML += '</table>';
	return tableHTML;
}
//得到展现题目所需的html代码
function scoreMatrix_getTitleHTML(index){
	var serialNum = $('#serialNum'+index).val();
	var titleHTML = '<tr><td>';
	titleHTML += '<div class="pi_txtTitle pi_txtTitle_no">'+serialNum+'、</div>';
	var title = scoreMatrix_fdQuestionDef.subject;
	title = title.replace("<p>", "");
	title = title.replace("</p>", "");
	title = title.replace(/<img/g, '<img  onMouseOver="showTooltip(event, this.src)" onMouseOut="hideTooltip();"');
	titleHTML += '<span class="pi_txtTitle" id="fdTitle'+index+'" name="fdTitle'+index+'" onclick="modifyTitleVal(this);">'+title+'</span>';
	if(scoreMatrix_fdQuestionDef.willAnswer)
		titleHTML += '<span class="pi_txtStrong">*</span>';
	titleHTML += '<span class="pi_txtStrong"> ['+$('#quesTypeName'+index).val()+']</span>';
	titleHTML += '</td></tr>';
	if(scoreMatrix_fdQuestionDef.attachmentIds != ''){
		var atturl = "<c:url value='/km/pindagate/km_pindagate_question/kmPindagateQuestion.do?method=viewAtt&attachmentIds="+scoreMatrix_fdQuestionDef.attachmentIds+"'  />";
		titleHTML += '<tr><td>';
		titleHTML += '<iframe id="attFrame" onload="autoResize(this)" src="';
		titleHTML += atturl;
		titleHTML +='" width=100% height=100% frameborder=0 scrolling=no>';
		titleHTML +='</iframe>';
		titleHTML += '</td></tr>';
	}
	if(scoreMatrix_fdQuestionDef.tip != ''){
		titleHTML += '<tr><td><div class="pi_subjectExplain">';
		titleHTML += '<bean:message bundle="km-pindagate" key="kmPindagateQuestion.preview.titleDescription"/>'+$("<div></div>").append(scoreMatrix_fdQuestionDef.tip).text();
		titleHTML += '</div></td></tr>';
	}
	return titleHTML;
}
//得到问题和选项的主要内容-矩阵问题按行排序
function scoreMatrix_getContent_row(index){
	var optionsHTML = '<table class="question_tb">';
	optionsHTML += '<tr>';
	optionsHTML += '<td align="center"></td>';
	for(var key in scoreMatrix_fdQuestionDef.options){

		var option = scoreMatrix_fdQuestionDef.options[key];
		var imgHTML = "";
		//if(option[1] != null && option[1] != "")
		//	imgHTML = '<img src="'+option[1]+'" border="0" />';
		
		optionsHTML += '<td align="center">'+scoreMatrix_fdQuestionDef.options[key][0]+"("+scoreMatrix_fdQuestionDef.options[key][1]+"${ lfn:message('km-pindagate:kmPindagateResponse.points') }"+")"+'</td>';
	}
	optionsHTML += '</tr>';
	for(var itemskey in scoreMatrix_fdQuestionDef.items){

		var option = scoreMatrix_fdQuestionDef.items[itemskey];
		var imgHTML = "";
		if(option[1] != null && option[1] != ""){
			var imgArr = option[1].split(";");
			for(var x=0; x<imgArr.length; x++){
				if(imgArr[x]!=0)
			imgHTML += '<img src="'+imgArr[x]+'"  border="1" onMouseOver="showTooltip(event, this.src)" onMouseOut="hideTooltip();" border="0"  width="14px" height="14px"/>&nbsp;&nbsp;';
			}
		}
		optionsHTML += '<tr>';
		optionsHTML += '<td align="center">'+scoreMatrix_fdQuestionDef.items[itemskey][0]+imgHTML+'</td>';
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
		optionsHTML += '<td align="center"></td>';
		for(var key in scoreMatrix_fdQuestionDef.items){
			var option = scoreMatrix_fdQuestionDef.items[key];
			var imgHTML = "";
			if(option[1] != null && option[1] != ""){
				var imgArr = option[1].split(";");
				for(var x=0; x<imgArr.length; x++){
					if(imgArr[x]!=0)
				imgHTML += '<img src="'+imgArr[x]+'"  border="1" onMouseOver="showTooltip(event, this.src)" onMouseOut="hideTooltip();" border="0"  width="14px" height="14px"/>&nbsp;&nbsp;';
				}
			}
			optionsHTML += '<td align="center">'+scoreMatrix_fdQuestionDef.items[key][0]+imgHTML+'</td>';
		}
		optionsHTML += '</tr>';
		for(var optionskey in scoreMatrix_fdQuestionDef.options){
			var option = scoreMatrix_fdQuestionDef.options[optionskey];
			var imgHTML = "";
			optionsHTML += '<tr>';
			optionsHTML += '<td align="center">'+scoreMatrix_fdQuestionDef.options[optionskey][0]+"("+scoreMatrix_fdQuestionDef.options[optionskey][1]+"${ lfn:message('km-pindagate:kmPindagateResponse.points') }"+")"+'</td>';
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
	var url = getContextPath()+"km/pindagate/question_type/scorematrix/scorematrix_edit.jsp";
	if(obj == null)
	  window.showModalDialog(url, "","dialogWidth=600px;dialogHeight=500px;");
	else
		window.showModalDialog(url, obj,"dialogWidth=600px;dialogHeight=500px;");
	if(obj.value != null && obj.value != ""){
		scoreMatrix_fdQuestionDef = eval("("+(obj.value)+")");
		var tableHTML = '<tr class="options"><td><p class="pi_txtRed" name="tip" style="display:none;position:relative;"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.preview.editTip"/>';
		tableHTML += '<span onclick="scoreMatrix_edit('+index+');" style="position:absolute;top: 0px;right: 30px;cursor: pointer;"><bean:message key="button.edit"/></span>';
		tableHTML += '<span onclick="deleteQuestion('+index+');" style="position:absolute;top: 0px;right: 0px;cursor: pointer;"><bean:message key="button.delete"/></span></p></td></tr>';
		tableHTML += scoreMatrix_getTitleHTML(index);
		tableHTML += '</td></tr><tr><td id="scorematrixquestion'+index+'"></td></tr>';
		$('#scoreMatris_TB'+index).html(tableHTML);
		if(	scoreMatrix_fdQuestionDef.hlist) //判断问题是按行显示还是按列显示
			scoreMatrix_getContent_col(index);
		else 
			scoreMatrix_getContent_row(index);	
		var title = scoreMatrix_fdQuestionDef.subject;
		title = title.replace("<p>", "");
		title = title.replace("</p>", "");
		title = title.replace(/<img/g, '<img  onMouseOver="showTooltip(event, this.src)" onMouseOut="hideTooltip();"');		
		$('span[name=fdTitle'+index+']').html(title);
		setFdQuestionDef(scoreMatrix_fdQuestionDef,index);//更新题型定义的值
	}
}
//改变图片的大小
function resizeToSmail(_this){
  _this.style.width="300px"; 
  _this.style.height ="300px"; 
}
function resizeToLarge(_this){
  _this.style.width="14px"; 
  _this.style.height ="14px"; 
}
scoreMatrix_init('${JsParam.index}');
</script>