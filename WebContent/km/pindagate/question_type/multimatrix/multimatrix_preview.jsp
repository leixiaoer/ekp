<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<script type="text/javascript" >
function autoResize(obj){
	obj.height = obj.contentWindow.document.body.scrollHeight + 20;	
}
var multiMatrix_fdQuestionDef = null;
function multiMatrix_init(index){
	var divId = "${JsParam.divId}";
	if($('#fdQuestionDef'+index).val() == null || $('#fdQuestionDef'+index).val() == "" || $('#fdQuestionDef'+index).val() == "delete")
		return;
	multiMatrix_fdQuestionDef = eval("("+($('#fdQuestionDef'+index).val())+")");
	$('#'+divId).append(multiMatrix_getTableHTML(index)); 
	if(	multiMatrix_fdQuestionDef.hlist){ //判断问题是按行显示还是按列显示
	multiMatrix_getContent_col(index);}
	else {
	multiMatrix_getContent_row(index);	
	}
}
/**
* 根据题目序号返回一个矩阵多选的表格
*/
function multiMatrix_getTableHTML(index){
	var tableHTML = '<table class="options_tb" width=90% id="multiMatrix_TB'+index+'">';
	tableHTML += '<tr class="options"><td><p name="tip" style="display:none;position:relative;color:red;"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.preview.editTip"/>';
	tableHTML += '<span onclick="multiMatrix_edit('+index+');" style="position:absolute;top: 0px;right: 30px;cursor: pointer;color:red;"><bean:message key="button.edit"/></span>';
	tableHTML += '<span onclick="deleteQuestion('+index+');" style="position:absolute;top: 0px;right: 0px;cursor: pointer;color:red;"><bean:message key="button.delete"/></span></p></td></tr>';
	tableHTML += multiMatrix_getTitleHTML(index);
	tableHTML += '</td></tr><tr><td id="multimatrixquestion'+index+'"></td></tr>';//
	tableHTML += '<table>';
	return tableHTML;
}
//得到展现题目所需的html代码
function multiMatrix_getTitleHTML(index){
	var serialNum = $('#serialNum'+index).val();
	var titleHTML = '<tr><td>';
	titleHTML += '<div class="pi_txtTitle pi_txtTitle_no">'+serialNum+'、</div>';
	var title = multiMatrix_fdQuestionDef.subject;
	title = title.replace("<p>", "");
	title = title.replace("</p>", "");
	title = title.replace(/<img/g, '<img  onMouseOver="showTooltip(event, this.src)" onMouseOut="hideTooltip();"');
	titleHTML += '<span class="pi_txtTitle" id="fdTitle'+index+'" name="fdTitle'+index+'" onclick="modifyTitleVal(this);">'+title+'</span>';
	if(multiMatrix_fdQuestionDef.willAnswer)
		titleHTML += '<span class="pi_txtRequire">*</span>';
	titleHTML += '<span class="pi_txtStrong"> ['+$('#quesTypeName'+index).val()+']</span>';
	if(multiMatrix_fdQuestionDef.willAnswer == true){
		titleHTML += '<span class="pi_txtStrong"> ';
		titleHTML += '[<bean:message bundle="km-pindagate" key="kmPindagateQuestion.flag.willAnswer"/>]</span>';
	}
	if(multiMatrix_fdQuestionDef.eachMinSelectNumber != ""){
		titleHTML += '<span class="pi_txtStrong"> [';
		titleHTML += '<bean:message bundle="km-pindagate" key="kmPindagateResponse.matrix.single"/>';
		titleHTML += '<bean:message bundle="km-pindagate" key="kmPindagateResponse.matrix.questionItems"/>';
		titleHTML += '<bean:message bundle="km-pindagate" key="kmPindagateResponse.selectAtLeast"/>';
		titleHTML += multiMatrix_fdQuestionDef.eachMinSelectNumber;
		titleHTML += '<bean:message bundle="km-pindagate" key="kmPindagateResponse.matrix.items"/>';
		titleHTML += ']</span>';
	}
	titleHTML += '</td></tr>';
	if(multiMatrix_fdQuestionDef.attachmentIds != ''){
		var atturl = "<c:url value='/km/pindagate/km_pindagate_question/kmPindagateQuestion.do?method=viewAtt&attachmentIds="+multiMatrix_fdQuestionDef.attachmentIds+"'  />";
		titleHTML += '<tr><td>';
		titleHTML += '<iframe id="attFrame" onload="autoResize(this)" src="';
		titleHTML += atturl;
		titleHTML +='" width=100% height=100% frameborder=0 scrolling=no>';
		titleHTML +='</iframe>';
		titleHTML += '</td></tr>';
	}
	if(multiMatrix_fdQuestionDef.tip != ''){
		titleHTML += '<tr><td><div class="pi_subjectExplain">';
		titleHTML += '<bean:message bundle="km-pindagate" key="kmPindagateQuestion.preview.titleDescription"/>'+$("<div></div>").append(multiMatrix_fdQuestionDef.tip).text();
		titleHTML += '</div></td></tr>';
	}
	return titleHTML;
}
//得到问题和选项的主要内容-矩阵问题按行排序
function multiMatrix_getContent_row(index){
	$('#multimatrixquestion'+index).append("<table class='question_tb' id='multimatrixquestionTable"+index+"' ></table>");
	for(var itemskey in multiMatrix_fdQuestionDef.items){
		$('#multimatrixquestionTable'+index).append('<tr id="multimatrixquestion'+index+itemskey+'"></tr>');
		for(var optionskey in multiMatrix_fdQuestionDef.options){
			$('#multimatrixquestion'+index+itemskey).append('<td align="center"><input type="checkbox" name="item'+index+itemskey+'"/></td>');
		}
	}
    $('#multimatrixquestionTable'+index).prepend('<tr id="multimatrixfirstTr'+index+'"></tr>');
    for(var key in multiMatrix_fdQuestionDef.options){
    	var option = multiMatrix_fdQuestionDef.options[key];
    	var imgHTML = "";
		if(option[1] != null && option[1] != ""){
			var imgArr = option[1].split(";");
			for(var x=0; x<imgArr.length; x++){
				if(imgArr[x]!=0)
			imgHTML += '<img src="'+imgArr[x]+'"  border="1" onMouseOver="showTooltip(event, this.src)" onMouseOut="hideTooltip();" border="0"  width="14px" height="14px"/>&nbsp;&nbsp;';
			}
		}
		$("#multimatrixfirstTr"+index).append("<td align='center'>"+multiMatrix_fdQuestionDef.options[key][0]+imgHTML+"</td>");
	}
	for(var key in multiMatrix_fdQuestionDef.items){
		var option =  multiMatrix_fdQuestionDef.items[key];
		var imgHTML = "";
		if(option[1] != null && option[1] != ""){
			var imgArr = option[1].split(";");
			for(var x=0; x<imgArr.length; x++){
				if(imgArr[x]!=0)
			imgHTML += '<img src="'+imgArr[x]+'"  border="1" onMouseOver="showTooltip(event, this.src)" onMouseOut="hideTooltip();" border="0"  width="14px" height="14px"/>&nbsp;&nbsp;';
			}
		}
		$('#multimatrixquestion'+index+key).prepend("<td align='center'>"+ multiMatrix_fdQuestionDef.items[key][0]+imgHTML+"</td>");
	}
	 $('#multimatrixfirstTr'+index).prepend('<td align="center"></td>');
	}
//得到问题和选项的主要内容-矩阵问题按列排序
function multiMatrix_getContent_col(index){
	$('#multimatrixquestion'+index).append("<table  class='question_tb'  id='multimatrixquestionTable"+index+"' ></table>");
	for(var optionskey in multiMatrix_fdQuestionDef.options){
		$('#multimatrixquestionTable'+index).append('<tr id="multimatrixquestion'+index+optionskey+'"></tr>');
	}
	for(var itemskey in multiMatrix_fdQuestionDef.items){
		for(var optionskey in multiMatrix_fdQuestionDef.options){
		$('#multimatrixquestion'+index+optionskey).append('<td align="center"><input type="checkbox" name="option'+index+itemskey+'"/></td>');
	}}
	$('#multimatrixquestionTable'+index).prepend('<tr id="multimatrixfirstTr'+index+'"></tr>');
	 for(var key in multiMatrix_fdQuestionDef.items){
		 var option =  multiMatrix_fdQuestionDef.items[key];
		 var imgHTML = "";
			if(option[1] != null && option[1] != ""){
				var imgArr = option[1].split(";");
				for(var x=0; x<imgArr.length; x++){
					if(imgArr[x]!=0)
				imgHTML += '<img src="'+imgArr[x]+'"  border="1" onMouseOver="showTooltip(event, this.src)" onMouseOut="hideTooltip();" border="0"  width="14px" height="14px"/>&nbsp;&nbsp;';
				}
			}
			$("#multimatrixfirstTr"+index).append("<td align='center'>"+multiMatrix_fdQuestionDef.items[key][0]+imgHTML+"</td>");
		}
	 for(var key in multiMatrix_fdQuestionDef.options){
		 var option = multiMatrix_fdQuestionDef.options[key];
		 var imgHTML = "";
			if(option[1] != null && option[1] != ""){
				var imgArr = option[1].split(";");
				for(var x=0; x<imgArr.length; x++){
					if(imgArr[x]!=0)
				imgHTML += '<img src="'+imgArr[x]+'"  border="1" onMouseOver="showTooltip(event, this.src)" onMouseOut="hideTooltip();" border="0"  width="14px" height="14px"/>&nbsp;&nbsp;';
				}
			}
			$('#multimatrixquestion'+index+key).prepend("<td align='center'>"+ multiMatrix_fdQuestionDef.options[key][0]+imgHTML+"</td>");
		}
	 $('#multimatrixfirstTr'+index).prepend('<td align="center"></td>');
}
/**
* 编辑
*/
function multiMatrix_edit(index){
	var obj = document.getElementById('fdQuestionDef'+index);
	var url = getContextPath()+"km/pindagate/question_type/multimatrix/multimatrix_edit.jsp";
	if(obj == null)
	  window.showModalDialog(url, "","dialogWidth=600px;dialogHeight=500px;");
	else
		window.showModalDialog(url, obj,"dialogWidth=600px;dialogHeight=500px;");
	if(obj.value != null && obj.value != ""){
		multiMatrix_fdQuestionDef = eval("("+(obj.value)+")");
		var tableHTML = '<tr class="options"><td><p name="tip" style="display:none;position:relative;color:red;"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.preview.editTip"/>';
		tableHTML += '<span onclick="multiMatrix_edit('+index+');" style="position:absolute;top: 0px;right: 30px;cursor: pointer;color:red;"><bean:message key="button.edit"/></span>';
		tableHTML += '<span onclick="deleteQuestion('+index+');" style="position:absolute;top: 0px;right: 0px;cursor: pointer;color:red;"><bean:message key="button.delete"/></span></p></td></tr>';
		tableHTML += multiMatrix_getTitleHTML(index);
		tableHTML += '</td></tr><tr><td id="multimatrixquestion'+index+'"></td></tr>';
		$('#singleMatris_TB'+index).html(tableHTML);
		$('#multimatrixquestion'+index).html("");
		if(multiMatrix_fdQuestionDef.hlist) //判断问题是按行显示还是按列显示
			multiMatrix_getContent_col(index);
		else 
			multiMatrix_getContent_row(index);	
		var title = multiMatrix_fdQuestionDef.subject;
		title = title.replace("<p>", "");
		title = title.replace("</p>", "");
		title = title.replace(/<img/g, '<img  onMouseOver="showTooltip(event, this.src)" onMouseOut="hideTooltip();"');		
		$('span[name=fdTitle'+index+']').html(title);
		setFdQuestionDef(multiMatrix_fdQuestionDef,index);//更新题型定义的值
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
multiMatrix_init('${JsParam.index}');
</script>