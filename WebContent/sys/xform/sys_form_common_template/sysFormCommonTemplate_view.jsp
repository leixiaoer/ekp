<%@page import="com.landray.kmss.sys.xform.util.LangUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/view_top.jsp"%>
<% response.addHeader("X-UA-Compatible", "IE=edge"); %>
<c:set var="sysFormTemplateFormPrefix" value="" />
<c:set var="xFormTemplateForm" value="${sysFormCommonTemplateForm}" />
<script>
	Com_Parameter.IsAutoTransferPara = true;
	function confirmDelete(msg) {
		var del = confirm("<bean:message key="page.comfirmDelete"/>");
		return del;
	}
</script>
<kmss:windowTitle moduleKey="sys-xform:xform.title"
	subjectKey="sys-xform:tree.xform.def"
	subject="${sysFormCommonTemplateForm.fdName}" />

<%-- 表单映射按钮 --%>
<c:import url="/sys/xform/include/sysFormMappingBtn.jsp"
	charEncoding="UTF-8">
	<c:param name="fdTemplateId" value="${param.fdId}" />
	<c:param name="fdModelName" value="${param.fdMainModelName}" />
	<c:param name="fdTemplateModel" value="${param.fdModelName}" />
	<c:param name="fdKey" value="${param.fdKey}" />
	<c:param name="fdFormType" value="common" />
</c:import>

<div id="optBarDiv">
	<kmss:auth
		requestURL="/sys/xform/sys_form_common_template/sysFormCommonTemplate.do?method=edit&fdId=${param.fdId}"
		requestMethod="GET">
		<input type="button" value="<bean:message key="button.edit"/>"
			onclick="Com_OpenWindow('sysFormCommonTemplate.do?method=edit&fdId=${JsParam.fdId}&fdModelName=${param.fdModelName}&fdKey=${param.fdKey}&fdMainModelName=${param.fdMainModelName}','_self');">
	</kmss:auth>
	<kmss:auth
		requestURL="/sys/xform/sys_form_common_template/sysFormCommonTemplate.do?method=delete&fdId=${param.fdId}"
		requestMethod="GET">
		<input type="button" value="<bean:message key="button.delete"/>"
			onclick="if(!confirmDelete())return;Com_OpenWindow('sysFormCommonTemplate.do?method=delete&fdId=${JsParam.fdId}','_self');">
	</kmss:auth>
	<input type="button" value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>
<p class="txttitle">
	<bean:message bundle="sys-xform" key="table.sysFormCommonTemplate" />
</p>
<center>
	<html:hidden name="sysFormCommonTemplateForm" property="fdId" />
	<table id="Label_Tabel" width=95%>
		<tr
			LKS_LabelName="<bean:message bundle='sys-xform' key='sysFormCommonTemplate.templateInfo'/>">
			<td>
				<table class="tb_normal" width=100%>
					<tr>
						<td class="td_normal_title" width=15%><bean:message
								bundle="sys-xform" key="sysFormCommonTemplate.fdName" /></td>
						<td><bean:write name="sysFormCommonTemplateForm"
								property="fdName" /></td>
					</tr>
					<%@ include file="/sys/xform/base/sysFormTemplateDisplay_view.jsp"%>
					<%--通用模板变更记录 --%>
					<c:import url="/sys/xform/sys_form_common_template/sysFormCommonTemplateHistory_view.jsp"	charEncoding="UTF-8">
					</c:import>
				</table>
			</td>
		</tr>
		<c:import url="/sys/xform/sys_form_common_template/sysFormRefCommonTemplate_view.jsp" charEncoding="UTF-8">			
		</c:import>
		<%
			 if(LangUtil.isEnableMultiLang(request.getParameter("fdMainModelName"), "model") && LangUtil.isEnableAdminDoMultiLang()) {
		%>
		<%--多语言 --%>
		<c:import
			url="/sys/xform/lang/include/sysFormCommonMultiLang_view.jsp"
			charEncoding="UTF-8">
		</c:import>
		<%
			}
		%>
	</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>