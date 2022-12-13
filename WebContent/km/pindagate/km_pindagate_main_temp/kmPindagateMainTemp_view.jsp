<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.landray.kmss.km.pindagate.questiontype.*"
	language="java"%>
<%@ page import="com.landray.kmss.km.pindagate.util.*" language="java"%>
<%@ include file="/resource/jsp/view_top.jsp"%>
<script type="text/javascript"
	src="${KMSS_Parameter_ResPath}js/jquery.js"></script>
<script type="text/javascript"
	src="${KMSS_Parameter_ResPath}js/json2.js"></script>
<script>
Com_IncludeFile("document.js", "style/"+Com_Parameter.Style+"/doc/");
Com_IncludeFile("calendar.js|dialog.js|doclist.js|docutil.js|optbar.js");
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
		str += '<td><input type="button" class="btnopt" value="<bean:message key="kmPindagateQuestion.button.addPageBreak" bundle="km-pindagate"/>" onclick="addQuestion(\'add\',\'pagination\');"></td>';
		str += "</tr>";
		$('#Add_question_TB').append(str);
	}
	var encoded = JSON.stringify(questionTypes); 
	$('input[name="questionTypes"]').val(encoded);
}

/**	
* 预览
*/
function preview(){
	var questions = new Array();
	var question = null;
	var questionTypes = $('input[name="questionTypes"]').val();
	var lastIndex = $('#TABLE_DocList .questionTR').length;
	for(var index = 0; index<lastIndex; index++){
		question = {'fdQuestionDef':$('[name="fdItems['+index+'].fdQuestionDef"]').val(),
				'fdType':$('[name="fdItems['+index+'].fdType"]').val(),
				'fdSplit':$('[name="fdItems['+index+'].fdSplit"]').val(),
				'fdOrder':$('[name="fdItems['+index+'].fdOrder"]').val(),
				'fdTitle':$('[name="fdItems['+index+'].fdName"]').val(),
				'questionTypes':questionTypes};
		questions[index] = question;
	}
	var url = '<c:url value = "/km/pindagate/km_pindagate_question_ui/kmPindagateQuestion_preview.jsp?param=view" />';
	var obj = $('#questions');
	obj.value = JSON.stringify(questions);
	var width=1024;var height=768;
	var left = (screen.width-width)/2;
	var top = (screen.height-height)/2;
	var winStyle = "width="+width+",height="+height+",dependent=yes,alwaysRaised=1,resizable=1,scrollbars=1"+",left="+left+",top="+top;
	window._questions=obj;
	window.open(url,"_blank",winStyle);
	//window.showModalDialog(url , obj,"dialogWidth=1024px;dialogHeight=768px");
}
function confirmDelete(msg){
	var del = confirm("<bean:message key="page.comfirmDelete"/>");
	return del;
}
</script>
<div id="optBarDiv">
	<kmss:auth requestURL="/km/pindagate/km_pindagate_main_temp/kmPindagateMainTemp.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.edit"/>"
			onclick="Com_OpenWindow('kmPindagateMainTemp.do?method=edit&fdId=${JsParam.fdId}','_self');">
	</kmss:auth>
	<kmss:auth requestURL="/km/pindagate/km_pindagate_main_temp/kmPindagateMainTemp.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.delete"/>"
			onclick="if(!confirmDelete())return;Com_OpenWindow('kmPindagateMainTemp.do?method=delete&fdId=${JsParam.fdId}','_self');">
	</kmss:auth>
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>
<p class="txttitle"><bean:message bundle="km-pindagate" key="table.kmPindagateMainTemp" /></p>
<center>
<table id="TABLE_DocList" class="tb_normal" width=95%>
	<input type="hidden" id="questions">
	<input type="hidden" name="questionTypes">
	<tr>
		<td class="td_normal_title"><bean:message bundle="km-pindagate" key="kmPindagateMainTemp.docSubject" /></td>
		<td colspan="3"><c:out value="${kmPindagateMainTempForm.docSubject}"></c:out></td>
	</tr>
	<tr>
		<td class="td_normal_title"><bean:message bundle="km-pindagate" key="kmPindagateTemplate.fdCatoryName" /></td>
		<td colspan="3">${kmPindagateMainTempForm.fdCategoryName}</td>
	</tr>
	<tr>
			<!-- 排序号 -->
			<td class="td_normal_title"><bean:message
					bundle="km-pindagate" key="kmPindagateTemplate.fdOrder" /></td>
			<td colspan="3">${kmPindagateMainTempForm.fdOrder}</td>
	</tr>
	<%-- 所属场所 --%>
	<c:import url="/sys/authorization/sys_auth_area/sysAuthArea_field.jsp" charEncoding="UTF-8">
           <c:param name="id" value="${kmPindagateMainTempForm.authAreaId}"/>
    </c:import> 
	<tr>
			<!-- 创建人 -->
			<td class="td_normal_title" width=15% ><bean:message
				bundle="km-pindagate" key="kmPindagateTemplate.docCreatorId" /></td>
					
			<td width=35%>${kmPindagateMainTempForm.docCreatorName}</td>
			<!-- 创建时间 -->
			<td class="td_normal_title" width=15% ><bean:message
						bundle="km-pindagate" key="kmPindagateTemplate.docCreateTime" /></td>
			<td width=35% >${kmPindagateMainTempForm.docCreateTime}</td>

	</tr>
	<tr><td colspan="4">
		<input type="button" class="btnopt" value="<bean:message
						bundle="km-pindagate" key="kmPindagateQuestion.button.previewPage" />" onclick="preview();">
		</td>
	</tr>
	<tr>
		<td class="tr_normal_title" width="2%"><bean:message
			key="page.serial" /></td>
		<td align="center" class="td_normal_title"><bean:message
						bundle="km-pindagate" key="kmPindagateQuestion.question" /></td>
		<td width="20%" align="center" class="td_normal_title" colspan="2"><bean:message
						bundle="km-pindagate" key="kmPindagateQuestion.fdType" /></td>
	</tr>
	<!--内容行-->
	<%
		int index = 1;
	%>
	<c:forEach items="${kmPindagateMainTempForm.fdItems}"
		var="kmPindagateTitleForm" varStatus="vstatus">
		<c:choose>
			<c:when test="${kmPindagateTitleForm.fdSplit}">
				<tr KMSS_IsContentRow="1" style="background-color: #D5EADF;" class="questionTR">
					<td KMSS_IsRowIndex="1"><input type="hidden"
						name="fdItems[${vstatus.index}].fdSplit" value="true"> <input
						type="hidden" name="fdItems[${vstatus.index}].version"
						value="${kmPindagateTitleForm.version}"> <input
						type="hidden" name="fdItems[${vstatus.index}].fdType"
						value="${kmPindagateTitleForm.fdType}"> <input
						type="hidden" name="fdItems[${vstatus.index}].fdOrder"
						value="${kmPindagateTitleForm.fdOrder}"> <input
						type="hidden" name="fdItems[${vstatus.index}].fdQuestionDef"
						value="${kmPindagateTitleForm.fdQuestionDefView}"> <input
						type="hidden" name="fdItems[${vstatus.index}].fdStatistic"
						value="${kmPindagateTitleForm.fdStatisticView}"> <input
						type="hidden" name="fdItems[${vstatus.index}].fdName"
						value="${kmPindagateTitleForm.fdName}"></td>
					<td>${kmPindagateTitleForm.fdName}</td>
					<td colspan="2"><c:out value="${kmPindagateTitleForm.fdName}"></c:out></td>
				</tr>
			</c:when>
			<c:otherwise>
				<tr KMSS_IsContentRow="1" class="questionTR">
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
						value="${kmPindagateTitleForm.fdQuestionDefView}"> <input
						type="hidden" name="fdItems[${vstatus.index}].fdStatistic"
						value="${kmPindagateTitleForm.fdStatisticView}"> </td>
					<td><input  type="hidden" name="fdItems[${vstatus.index}].fdName"
						value="${kmPindagateTitleForm.fdName}">${kmPindagateTitleForm.fdName}</td>
					<td colspan="2"><c:out value="${kmPindagateTitleForm.fdTypeName}"></c:out> </td>
				</tr>
				<%
					index++;
				%>
			</c:otherwise>
		</c:choose>
	</c:forEach>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-pindagate" key="kmPindagateMainTemp.fdSelectAll" />
		</td>
		<td colspan="3">
			<c:choose>
				<c:when test="${kmPindagateMainTempForm.fdSelectAll eq 'true' }">
					<bean:message bundle="km-pindagate" key="kmPindagateTemplate.fdIsAvailable.true" />
				</c:when>
				<c:otherwise>
					<bean:message bundle="km-pindagate" key="kmPindagateTemplate.fdIsAvailable.false" />
				</c:otherwise>
			</c:choose>
		</td>
	</tr>
	
		<!-- 可使用者 -->
			<tr>
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-pindagate" key="table.kmPindagateTemplateUser" /></td>
				<td width=85% colspan="3"><bean:write name="kmPindagateMainTempForm"
					property="authReaderNames" /></td>
			</tr>
			<!-- 可维护者 -->
			<tr>
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-pindagate" key="table.kmPindagateTemplateEditor" /></td>
				<td width=85% colspan="3"><bean:write name="kmPindagateMainTempForm"
					property="authEditorNames" /></td>
			</tr>
</table>
</center>
<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b><bean:message key="kmPindagateQuestion.description" bundle="km-pindagate"/></b>
<bean:message key="kmPindagateQuestion.asWillAnswer" bundle="km-pindagate"/>
<%@ include file="/resource/jsp/view_down.jsp"%>