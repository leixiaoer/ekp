<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>

<%@page import="com.landray.kmss.sys.authorization.constant.ISysAuthConstant"%><html:form action="/km/pindagate/km_pindagate_question_res/kmPindagateQuestionRes.do">
<div id="optBarDiv">
	<c:if test="${kmPindagateQuestionResForm.method_GET=='edit'}">
		<input type=button value="<bean:message key="button.update"/>"
			onclick="Com_Submit(document.kmPindagateQuestionResForm, 'update');">
	</c:if>
	<c:if test="${kmPindagateQuestionResForm.method_GET=='add'}">
		<input type=button value="<bean:message key="button.save"/>"
			onclick="Com_Submit(document.kmPindagateQuestionResForm, 'save');">
		<input type=button value="<bean:message key="button.saveadd"/>"
			onclick="Com_Submit(document.kmPindagateQuestionResForm, 'saveadd');">
	</c:if>
	<input type="button" value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
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
			<xform:select property="fdQuetionairResId">
				<xform:beanDataSource serviceBean="kmPindagateResponseService" selectBlock="fdId,fdName" orderBy="" />
			</xform:select>
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-pindagate" key="kmPindagateQuestionRes.fdQuetionairTitle"/>
		</td><td width="35%">
			<xform:select property="fdQuetionairTitleId">
				<xform:beanDataSource serviceBean="kmPindagateQuestionService" selectBlock="fdId,fdName" orderBy="fdOrder" />
			</xform:select>
		</td>
	</tr>
	<% if(ISysAuthConstant.IS_AREA_ENABLED) { %> 
	<input type="hidden" name="authAreaId" value="kmPindagateQuestionResForm.authAreaId"> 
	<xform:text property="kmPindagateQuestionResForm.authAreaName" showStatus="noShow" />	
	<% } %>
	
</table>
</center>
<html:hidden property="fdId" />
<html:hidden property="method_GET" />
<script>
	$KMSSValidation();
</script>
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp"%>