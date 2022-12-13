<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.landray.kmss.km.pindagate.questiontype.*" language="java"%>
<%@ page import="com.landray.kmss.km.pindagate.util.*" language="java"%>
<%@ page errorPage="/resource/jsp/jsperror.jsp" %>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ page import="javax.servlet.http.Cookie, com.landray.kmss.util.*" %>
<style>
 .questionTitle{
 	transform: scale(1,1);
 	max-width: 1000px;
}
</style>
<table id="TABLE_DocList" class="tb_normal" width=100%>
	<input type="hidden" id="questions">
	<input type="hidden" name="questionTypes">
	<tr>
		<td colspan="6">
			<%--预览--%>
			<ui:button text="${lfn:message('km-pindagate:kmPindagateQuestion.button.previewPage') }"  order="2" onclick="previewIndatate();">
			</ui:button>
		</td>
	</tr>
	<tr>
		<%--序号--%>
		<td class="tr_normal_title" width="5%">
			<bean:message key="page.serial" />
		</td>
		<%--题目--%>
		<td align="center" class="td_normal_title">
			<bean:message bundle="km-pindagate"  key="kmPindagateQuestion.question" />
		</td>
		<%--题型--%>
		<td width="20%" align="center" class="td_normal_title">
			<bean:message bundle="km-pindagate"  key="kmPindagateQuestion.fdType" />
		</td>
	</tr>
	<%--内容行--%>
	<%int index = 1;%>
	<c:forEach items="${kmPindagateMainForm.fdItems}" var="kmPindagateTitleForm" varStatus="vstatus">
		<c:choose>
			<c:when test="${kmPindagateTitleForm.fdSplit}">
				<tr KMSS_IsContentRow="1" style="background-color: #D5EADF;" class="questionTR">
					<td KMSS_IsRowIndex="1">
						<input type="hidden" name="fdItems[${vstatus.index}].fdSplit" value="true">
						<input type="hidden" name="fdItems[${vstatus.index}].version" value="${kmPindagateTitleForm.version}">
						<input type="hidden" name="fdItems[${vstatus.index}].fdType" value="${kmPindagateTitleForm.fdType}">
						<input type="hidden" name="fdItems[${vstatus.index}].fdOrder" value="${kmPindagateTitleForm.fdOrder}">
						<input type="hidden" name="fdItems[${vstatus.index}].fdQuestionDef" value="${kmPindagateTitleForm.fdQuestionDefView}">
						<input type="hidden" name="fdItems[${vstatus.index}].fdName" value="${kmPindagateTitleForm.fdName}">
						<input type="hidden" name="fdItems[${vstatus.index}].fdRelationDef" value="${kmPindagateTitleForm.fdRelationDefView}">
					</td>
					<td><c:out value="${kmPindagateTitleForm.fdName}"></c:out></td>
					<td style="text-align: center;"><c:out value="${kmPindagateTitleForm.fdName}"></c:out></td>
				</tr>
			</c:when>
			<c:otherwise>
				<tr KMSS_IsContentRow="1" class="questionTR">
					<td KMSS_IsRowIndex="1">
						<%=index%>
						<input type="hidden" name="fdItems[${vstatus.index}].fdSplit" value="${kmPindagateTitleForm.fdSplit}"> 
						<input type="hidden" name="fdItems[${vstatus.index}].version" value="${kmPindagateTitleForm.version}"> 
						<input type="hidden" name="fdItems[${vstatus.index}].fdType" value="${kmPindagateTitleForm.fdType}">
						<input type="hidden" name="fdItems[${vstatus.index}].fdOrder" value="${kmPindagateTitleForm.fdOrder}">
						<input type="hidden" name="fdItems[${vstatus.index}].fdQuestionDef" value="${kmPindagateTitleForm.fdQuestionDefView}">
						<input type="hidden" name="fdItems[${vstatus.index}].fdRelationDef" value="${kmPindagateTitleForm.fdRelationDefView}">
					</td>
					<td class="questionTitle">${kmPindagateTitleForm.fdName}</td>
					<td style="text-align: center;"><c:out value="${kmPindagateTitleForm.fdTypeName}"></c:out></td>
				</tr>
				<%index++;%>
			</c:otherwise>
		</c:choose>
	</c:forEach>
</table>

<script>
	Com_IncludeFile("data.js|doclist.js|docutil.js|optbar.js|jquery.js|json2.js");
	seajs.use(['theme!form']);
</script>
<script type="text/javascript">
	var _dialog;
	seajs.use(['lui/dialog'], function(dialog) {
		_dialog=dialog;
	});
	/**
	* 初始化
	*/
	LUI.ready(function loadQuestionType(){	
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
			}
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
		var lastIndex = $('#TABLE_DocList .questionTR').length;
		for(var index = 0; index<lastIndex; index++){
			question = {'fdQuestionDef':$('input[name="fdItems['+index+'].fdQuestionDef"]').val(),
					'fdType':$('input[name="fdItems['+index+'].fdType"]').val(),
					'fdSplit':$('input[name="fdItems['+index+'].fdSplit"]').val(),
					'fdOrder':$('input[name="fdItems['+index+'].fdOrder"]').val(),
					'fdTitle':$('input[name="fdItems['+index+'].fdName"]').val(),
					'fdRelationDef':$('input[name="fdItems['+index+'].fdRelationDef"]').val(),
					'questionTypes':questionTypes};
			questions[index] = question;
		}
		var docSubject=encodeURI($("input[name='docSubject']").val());
		var url = '/km/pindagate/km_pindagate_question_ui/kmPindagateQuestion_preview.jsp?param=view&docSubject='+docSubject;
		var obj = document.getElementById("questions");
		obj.value = JSON.stringify(questions);
		top._questions=obj;
		_dialog.iframe(url," ",null,{"width":'98%',"height":550});
	}
</script>