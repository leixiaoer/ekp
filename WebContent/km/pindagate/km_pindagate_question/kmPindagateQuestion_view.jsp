<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.landray.kmss.km.pindagate.questiontype.*"
	language="java"%>
<%@ page import="com.landray.kmss.km.pindagate.util.*" language="java"%>
<%@ page errorPage="/resource/jsp/jsperror.jsp" %>
<%@ include file="/resource/jsp/common.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page import="javax.servlet.http.Cookie, com.landray.kmss.util.*" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Pragma" content="No-Cache">
<link rel="shortcut icon" href="${KMSS_Parameter_ContextPath}favicon.ico"> 
<script type="text/javascript" src="${KMSS_Parameter_ResPath}js/common.js"></script>
</head>
<body>
<br>
<script>
Com_IncludeFile("document.js", "style/"+Com_Parameter.Style+"/doc/");
Com_IncludeFile("calendar.js|dialog.js|doclist.js|docutil.js|optbar.js|jquery.js|json2.js");
</script>
<script type="text/javascript">
var tbInfo = null;
$(document).ready(function loadQuestionType(){	
	  var data = new KMSSData();
	  var url="kmPindagateQuestionTypeService";
	  data.SendToBean(url,initQuesTypeVal);
});
/**
 * 初始化题型类别信息
 */
function initQuesTypeVal(rtnData){
	var questionTypes = {};
	var str = "";
	if(rtnData){
		for(var i=0; i<rtnData.GetHashMapArray().length; i++){
			var obj = rtnData.GetHashMapArray()[i];
			var quesTypeId = obj['quesTypeId'];
			var quesTypeName = obj['quesTypeName'];
			var editUrl = obj['editUrl'];
			var previewUrl = obj['previewUrl'];
			var jsUrl = obj['jsUrl'];
			questionTypes[i] = {'quesTypeId':quesTypeId,
								'quesTypeName':quesTypeName,
								'editUrl':editUrl,
								'previewUrl':previewUrl,
								'jsUrl':jsUrl};
			$('select[name="questionTypeselect"]').append('<option value="'+quesTypeId+'">'+quesTypeName+'</option>');
			if(i == 0)
				str += "<tr>";
			str +='<td><input type="button" class="btnopt" value="'+quesTypeName+'" onclick="addQuestion(\'add\',\''+quesTypeId+'\',\''+editUrl+'\');"></td>';
			if((i+1)%3==0)
				str += "</tr>"+"<tr>";
		}
		str += '<td><input type="button" class="btnopt" value="插入分页符" onclick="addQuestion(\'add\',\'pagination\');"></td>';
		str += "</tr>";
		$('#Add_question_TB').append(str);
	}
	var encoded = JSON.stringify(questionTypes); 
	$('input[name="questionTypes"]').val(encoded);
}

/**
* 预览
*/
function previewIndatate(){
	var questions = new Array();
	var question = null;
	var questionTypes = $('input[name="questionTypes"]').val();
	//注意在编辑页面lastIndex为-2和编辑页面不同
	var lastIndex = $('#TABLE_DocList tr').length - 2;
	for(var index = 0; index<lastIndex; index++){
		question = {'fdQuestionDef':$('input[name="fdItems['+index+'].fdQuestionDef"]').val(),
				'fdType':$('input[name="fdItems['+index+'].fdType"]').val(),
				'fdSplit':$('input[name="fdItems['+index+'].fdSplit"]').val(),
				'fdOrder':$('input[name="fdItems['+index+'].fdOrder"]').val(),
				'fdTitle':$('input[name="fdItems['+index+'].fdName"]').val(),
				'questionTypes':questionTypes};
		questions[index] = question;
	}
	var url = '<c:url value = "/km/pindagate/km_pindagate_question/kmPindagateQuestion_preview.jsp?param=view" />';
	var obj = $('#questions');
	var obj = document.getElementById("questions");
	obj.value = JSON.stringify(questions);
	window.showModalDialog(url , obj,"dialogWidth=1024px;dialogHeight=768px");
}
function confirmDelete(msg){
	var del = confirm("<bean:message key="page.comfirmDelete"/>");
	return del;
}
</script>
<center>
<table id="TABLE_DocList" class="tb_normal" width=95%>
	<input type="hidden" id="questions">
	<input type="hidden" name="questionTypes">
	<tr><td colspan="6">
		<input type="button" class="btnopt" value="<bean:message bundle="km-pindagate" key="kmPindagateQuestion.button.previewPage"/>" onclick="previewIndatate();">
		</td>
	</tr>
	<tr>
		<td class="tr_normal_title" width="2%"><bean:message
			key="page.serial" /></td>
		<td align="center" class="td_normal_title">题目</td>
		<td width="20%" align="center" class="td_normal_title">题型</td>
	</tr>
	<!--内容行-->
	<%
		int index = 1;
	%>
	<c:forEach items="${kmPindagateMainForm.fdItems}"
		var="kmPindagateTitleForm" varStatus="vstatus">
		<c:choose>
			<c:when test="${kmPindagateTitleForm.fdSplit}">
				<tr KMSS_IsContentRow="1" style="background-color: #D5EADF;">
					<td KMSS_IsRowIndex="1"><input type="hidden"
						name="fdItems[${vstatus.index}].fdSplit" value="true"> <input
						type="hidden" name="fdItems[${vstatus.index}].version"
						value="${kmPindagateTitleForm.version}"> <input
						type="hidden" name="fdItems[${vstatus.index}].fdType"
						value="${kmPindagateTitleForm.fdType}"> <input
						type="hidden" name="fdItems[${vstatus.index}].fdOrder"
						value="${kmPindagateTitleForm.fdOrder}"> <input
						type="hidden" name="fdItems[${vstatus.index}].fdQuestionDef"
						value="${kmPindagateTitleForm.fdQuestionDefView}"><input
						type="hidden" name="fdItems[${vstatus.index}].fdName"
						value="${kmPindagateTitleForm.fdName}"></td>
					<td>${kmPindagateTitleForm.fdName}</td>
					<td>${kmPindagateTitleForm.fdName}</td>
				</tr>
			</c:when>
			<c:otherwise>
				<tr KMSS_IsContentRow="1">
					<td KMSS_IsRowIndex="1"><%=index%><input type="hidden"
						name="fdItems[${vstatus.index}].fdSplit"
						value="${kmPindagateTitleForm.fdSplit}"> <input
						type="hidden" name="fdItems[${vstatus.index}].version"
						value="${kmPindagateTitleForm.version}"> <input
						type="hidden" name="fdItems[${vstatus.index}].fdType"
						value="${kmPindagateTitleForm.fdType}"> <input
						type="hidden" name="fdItems[${vstatus.index}].fdOrder"
						value="${kmPindagateTitleForm.fdOrder}"> <input
						type="hidden" name="fdItems[${vstatus.index}].fdQuestionDef"
						value="${kmPindagateTitleForm.fdQuestionDefView}"></td>
					<td><input
						style="width: 90%; border: 0px; background: transparent;"
						readonly="readonly" name="fdItems[${vstatus.index}].fdName"
						value="${kmPindagateTitleForm.fdName}"></td>
					<td>${kmPindagateTitleForm.fdTypeName}</td>
				</tr>
				<%
					index++;
				%>
			</c:otherwise>
		</c:choose>
	</c:forEach>
</table>
</center>
<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>说明：</b>
*表示该问题为必答题。
<%@ include file="/resource/jsp/view_down.jsp"%>