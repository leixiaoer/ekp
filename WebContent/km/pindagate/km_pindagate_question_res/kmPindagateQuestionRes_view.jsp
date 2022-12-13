<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/view_top.jsp"%>

<%@page import="com.landray.kmss.sys.authorization.constant.ISysAuthConstant"%><script>
	function confirmDelete(msg){
	var del = confirm("<bean:message key="page.comfirmDelete"/>");
	return del;
}
</script>
<div id="optBarDiv">
	<kmss:auth requestURL="/km/pindagate/km_pindagate_question_res/kmPindagateQuestionRes.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.edit"/>"
			onclick="Com_OpenWindow('kmPindagateQuestionRes.do?method=edit&fdId=${JsParam.fdId}','_self');">
	</kmss:auth>
	<kmss:auth requestURL="/km/pindagate/km_pindagate_question_res/kmPindagateQuestionRes.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.delete"/>"
			onclick="if(!confirmDelete())return;Com_OpenWindow('kmPindagateQuestionRes.do?method=delete&fdId=${JsParam.fdId}','_self');">
	</kmss:auth>
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>

<p class="txttitle"><bean:message bundle="km-pindagate" key="table.kmPindagateQuestionRes"/></p>

<center>
<table class="tb_normal" width=95%>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-pindagate" key="kmPindagateQuestionRes.fdAnswer"/>
		</td><td width="35%">
			<xform:rtf property="fdAnswer" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-pindagate" key="kmPindagateQuestionRes.fdOther"/>
		</td><td width="35%">
			<xform:text property="fdOther" style="width:85%" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-pindagate" key="kmPindagateQuestionRes.fdQuetionairRes"/>
		</td><td width="35%">
			<c:out value="${kmPindagateQuestionResForm.fdQuetionairResName}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-pindagate" key="kmPindagateQuestionRes.fdQuetionairTitle"/>
		</td><td width="35%">
			<c:out value="${kmPindagateQuestionResForm.fdQuetionairTitleName}" />
		</td>
	</tr>
	<% if(ISysAuthConstant.IS_AREA_ENABLED) { %> 
	<input type="hidden" name="authAreaId" value="kmPindagateQuestionResForm.authAreaId"/> 
	<xform:text property="kmPindagateQuestionResForm.authAreaName" showStatus="noShow" />	
	<% } %>
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>