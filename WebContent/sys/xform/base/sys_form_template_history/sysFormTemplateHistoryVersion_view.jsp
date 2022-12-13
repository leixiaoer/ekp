<%@page import="com.landray.kmss.sys.xform.util.LangUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/view_top.jsp"%>
<c:set var="sysFormTemplateFormPrefix" value="" />
<c:set var="xFormTemplateForm" value="${sysFormTemplateHistoryForm}" />
<c:set var="authUrl" value="${actionUrl}?method=edit" />
<kmss:windowTitle moduleKey="sys-xform:xform.title"
	subjectKey="sys-xform:tree.xform.def"
	subject="历史模板" />
	
<div id="optBarDiv">
	<c:if test="${versionType eq null || versionType ne 'new'}">
		<kmss:auth
			requestURL="${actionUrl}?method=edit&fdId=${param.fdModelTemplateId}"
			requestMethod="GET">
			<input type="button" value="<bean:message key="button.edit"/>"
				onclick="Com_OpenWindow('${KMSS_Parameter_ContextPath}sys/xform/base/sys_form_template_history/sysFormTemplateHistory.do?method=edit&fdId=${param.fdId }&fdMainModelName=${fdMainModelName}&authUrl=${authUrl}&fdModelTemplateId=${param.fdModelTemplateId}','_self');" />
		</kmss:auth>
	</c:if>
	
	<input type="button" value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();" />
</div>
<p class="txttitle"><bean:message bundle="sys-xform" key="sysFormTemplate.history.formHistoryTemplate"/>_V${xFormTemplateForm.fdTemplateEdition }</p>
<center>
<table id="Label_Tabel" width=95%>
	<tr LKS_LabelName="<bean:message bundle="sys-xform" key="sysFormTemplate.history.templateInformation"/>">
		<td>
			<table class="tb_normal" width="100%">
				<%@ include file="/sys/xform/base/sysFormTemplateDisplay_view.jsp"%>
			</table>
		</td>
	</tr>
	<%--多语言 --%>
	<%  if(LangUtil.isEnableMultiLang(request.getParameter("fdMainModelName"), "model") && LangUtil.isEnableAdminDoMultiLang()) {%>
	<c:import url="/sys/xform/lang/include/sysFormHistoryMultiLang_view.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="sysFormTemplateHistoryForm" />
		<c:param name="sysFormTemplateFormPrefix" value="${sysFormTemplateFormPrefix }" />
	</c:import>
	<% } %>	
	<%--被引用的主文档 --%>
	<c:import url="/sys/xform/base/sys_form_template_history/sysFormTemplateHistoryRefMain_view.jsp"	charEncoding="UTF-8">
			<c:param name="formName" value="sysFormTemplateHistoryForm" />
			<c:param name="fdMainModelName" value="${fdMainModelName}" />
	</c:import>
</table>
	
</center>

<%@ include file="/resource/jsp/view_down.jsp"%>