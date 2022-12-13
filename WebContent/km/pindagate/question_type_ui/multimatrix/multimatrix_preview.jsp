<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@include file="/km/pindagate/question_type_ui/common/common_preview_script.jsp"%>
<script type="text/javascript" >
var _dialog;
seajs.use(['lui/dialog'], function(dialog){
	_dialog=dialog;
});
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
	var tableHTML = '<table class="options_tb" width=95% id="multiMatrix_TB'+index+'">';
	tableHTML += '<tr class="options"><td><p name="tip" style="display:none;position:relative;color:red;">';
	tableHTML += '<a onclick="multiMatrix_edit('+index+');" style="position:absolute;top: 0px;right: 50px;cursor: pointer;color:red;"><bean:message key="button.edit"/></a>';
	tableHTML += '<a onclick="deleteQuestion('+index+');" style="position:absolute;top: 0px;right: 0px;cursor: pointer;color:red;"><bean:message key="button.delete"/></a></p></td></tr>';
	tableHTML += multiMatrix_getTitleHTML(index);
	tableHTML += '</td></tr><tr><td id="multimatrixquestion'+index+'"></td></tr>';//
	//选择原因
	if(multiMatrix_fdQuestionDef.autoAddSelectReason){
		tableHTML += '<tr><td style="padding-bottom:10px;">';
		tableHTML += multiMatrix_fdQuestionDef.selectReasonText;
		tableHTML += '</td></tr><tr><td><textarea name="fdItems['+index+'].fdSelectReason"'+
						' style="width:840px;height:80px"></textarea></td></tr>';
	}
	tableHTML += '<table>';
	return tableHTML;
}
//得到展现题目所需的html代码
function multiMatrix_getTitleHTML(index,showIndex){
	var serialNum = $('#serialNum'+index).val();
	var titleHTML = '<tr><td>';
	showIndex = showIndex || '${JsParam.showIndex}';
	titleHTML += '<div class="pi_txtTitle pi_txtTitle_no">'+showIndex+'、</div>';
	var title = multiMatrix_fdQuestionDef.subject;
	title=title.replace(/<p>/g,"").replace(/<\/p>/g,"<br>").replace(/\n/g,"").replace(/(<br>)+$/g,"");//格式化标题
	//title = title.replace(/<img/g, '<img  onMouseOver="showTooltip(event, this.src)" onMouseOut="hideTooltip();"');
	titleHTML += '<div class="pi_txtTitle pi_txtTitle_content" id="fdTitle'+index+'" name="fdTitle'+index+'" onclick="modifyTitleVal(this);">'+title+'</div>';
	if(multiMatrix_fdQuestionDef.willAnswer)
		titleHTML += '<span class="pi_txtRequire">*</span>';
	titleHTML += '<span class="pi_txtStrong"> ['+$('#quesTypeName'+index).val()+']</span>';
	if(multiMatrix_fdQuestionDef.willAnswer == true){
		titleHTML += '<span class="pi_txtStrong"> ';
		titleHTML += '[<bean:message bundle="km-pindagate" key="kmPindagateQuestion.flag.willAnswer"/>]</span>';
		//如果为必选题，最少选项才生效
		if(multiMatrix_fdQuestionDef.eachMinSelectNumber != ""){
			titleHTML += '<span class="pi_txtStrong"> [';
			titleHTML += '<bean:message bundle="km-pindagate" key="kmPindagateResponse.matrix.single"/>';
			titleHTML += '<bean:message bundle="km-pindagate" key="kmPindagateResponse.matrix.questionItems"/>';
			titleHTML += '<bean:message bundle="km-pindagate" key="kmPindagateResponse.selectAtLeast"/>';
			titleHTML += multiMatrix_fdQuestionDef.eachMinSelectNumber;
			titleHTML += '<bean:message bundle="km-pindagate" key="kmPindagateResponse.matrix.items"/>';
			titleHTML += ']</span>';
		}
	}
	
	titleHTML += '</td></tr>';
	if(multiMatrix_fdQuestionDef.attachmentIds !='null' && multiMatrix_fdQuestionDef.attachmentIds != ''){
		var atturl = "<c:url value='/km/pindagate/km_pindagate_question/kmPindagateQuestion.do?method=viewAtt&attachmentIds="+multiMatrix_fdQuestionDef.attachmentIds+"'  />";
		titleHTML += '<tr><td>';
		titleHTML += '<iframe id="attFrame" onload="autoResize(this)" src="';
		titleHTML += atturl;
		titleHTML +='" width=100% height=0 frameborder=0 scrolling=no>';
		titleHTML +='</iframe>';
		titleHTML += '</td></tr>';
	}
	if(multiMatrix_fdQuestionDef.tip != ''){
		var tip=multiMatrix_fdQuestionDef.tip;
		titleHTML += '<tr><td><div class="pi_subjectExplain">';
		titleHTML += '<bean:message bundle="km-pindagate" key="kmPindagateQuestion.preview.titleDescription"/>'+'<div class="pi_subjectExplain_content">'+tip+'</div>';
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
			imgHTML += '<img src="'+imgArr[x]+'"  border="1" onclick="previewTooltip(event, this.src)" border="0"  width="14px" height="14px"/>&nbsp;&nbsp;';
			}
		}
		$("#multimatrixfirstTr"+index).append("<td>"+multiMatrix_fdQuestionDef.options[key][0]+imgHTML+"</td>");
	}
	for(var key in multiMatrix_fdQuestionDef.items){
		var option =  multiMatrix_fdQuestionDef.items[key];
		var imgHTML = "";
		if(option[1] != null && option[1] != ""){
			var imgArr = option[1].split(";");
			for(var x=0; x<imgArr.length; x++){
				if(imgArr[x]!=0)
			imgHTML += '<img src="'+imgArr[x]+'"  border="1" onclick="previewTooltip(event, this.src)" border="0"  width="14px" height="14px"/>&nbsp;&nbsp;';
			}
		}
		$('#multimatrixquestion'+index+key).prepend("<td>"+ multiMatrix_fdQuestionDef.items[key][0]+imgHTML+"</td>");
	}
	 $('#multimatrixfirstTr'+index).prepend('<td></td>');
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
				imgHTML += '<img src="'+imgArr[x]+'"  border="1" onclick="previewTooltip(event, this.src)" border="0"  width="14px" height="14px"/>&nbsp;&nbsp;';
				}
			}
			$("#multimatrixfirstTr"+index).append("<td>"+multiMatrix_fdQuestionDef.items[key][0]+imgHTML+"</td>");
		}
	 for(var key in multiMatrix_fdQuestionDef.options){
		 var option = multiMatrix_fdQuestionDef.options[key];
		 var imgHTML = "";
			if(option[1] != null && option[1] != ""){
				var imgArr = option[1].split(";");
				for(var x=0; x<imgArr.length; x++){
					if(imgArr[x]!=0)
				imgHTML += '<img src="'+imgArr[x]+'"  border="1" onclick="previewTooltip(event, this.src)" border="0"  width="14px" height="14px"/>&nbsp;&nbsp;';
				}
			}
			$('#multimatrixquestion'+index+key).prepend("<td>"+ multiMatrix_fdQuestionDef.options[key][0]+imgHTML+"</td>");
		}
	 $('#multimatrixfirstTr'+index).prepend('<td></td>');
}
/**
* 编辑
*/
function multiMatrix_edit(index){
	var obj = document.getElementById('fdQuestionDef'+index);
	var url = "/km/pindagate/question_type_ui/multimatrix/multimatrix_edit.jsp";
	if(obj == null) obj="";
	top._question=obj;
	_dialog.iframe(url," ",function(obj){
		if(obj!=null&&obj.value != null && obj.value != ""){
			multiMatrix_fdQuestionDef = eval("("+(obj.value)+")");
			var tableHTML = '<tr class="options"><td><p name="tip" style="display:none;position:relative;color:red;">';
			tableHTML += '<a onclick="multiMatrix_edit('+index+');" style="position:absolute;top: 0px;right: 50px;cursor: pointer;color:red;"><bean:message key="button.edit"/></a>';
			tableHTML += '<a onclick="deleteQuestion('+index+');" style="position:absolute;top: 0px;right: 0px;cursor: pointer;color:red;"><bean:message key="button.delete"/></a></p></td></tr>';
			tableHTML += multiMatrix_getTitleHTML(index,index + 1);
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
			//title = title.replace(/<img/g, '<img  onMouseOver="showTooltip(event, this.src)" onMouseOut="hideTooltip();"');		
			$('span[name=fdTitle'+index+']').html(title);
			setFdQuestionDef(multiMatrix_fdQuestionDef,index);//更新题型定义的值
		}
	},{"width":800,"height":500});
}
multiMatrix_init('${JsParam.index}');
</script>