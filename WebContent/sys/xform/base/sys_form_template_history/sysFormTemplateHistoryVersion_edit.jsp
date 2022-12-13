<%@page import="com.landray.kmss.sys.xform.util.LangUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% response.addHeader("X-UA-Compatible", "IE=edge"); %>
<%@page import="com.landray.kmss.sys.xform.util.LangUtil"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<c:set var="xFormTemplateForm" value="${sysFormTemplateHistoryForm}" />
<%@ include file="/sys/xform/base/template_script.jsp" %>
<c:set var="sysFormTemplateFormPrefix" value="" />
<link rel="stylesheet" type="text/css" href="<c:url value="/component/locker/resource/jNotify.jquery.css"/>" media="screen" />
<script type="text/javascript" src="<c:url value="/component/locker/resource/jNotify.jquery.js"/>"></script>
<script type="text/javascript">Com_IncludeFile("docutil.js|security.js|dialog.js|formula.js");</script>
<script>
Com_IncludeFile("dialog.js");

Com_Parameter.event["confirm"][Com_Parameter.event["confirm"].length] = XForm_ConfirmFormChangedEvent;

function XForm_ConfirmFormChangedEvent() {
	return XForm_ConfirmFormChangedFun();
}

Com_AddEventListener(window, "load", function() {
	LoadXForm(document.getElementById('TD_FormTemplate_${xFormTemplateForm.fdKey}'));
});

var _xform_MainModelName = '${param.fdMainModelName}';


function _XForm_GetTempExtDictObj(tempId) {
	return new KMSSData().AddBeanData("sysFormDictVarTree&tempType=template&tempId="+tempId).GetHashMapArray();
}
function _XForm_GetCommonExtDictObj(tempId) {
	return new KMSSData().AddBeanData("sysFormDictVarTree&tempType=common&tempId="+tempId).GetHashMapArray();
}
function _XForm_GetExitFileDictObj(fileName) {
	return new KMSSData().AddBeanData("sysFormDictVarTree&tempType=file&fileName="+fileName).GetHashMapArray();
}
function _XForm_GetSysDictObj(modelName){
	return Formula_GetVarInfoByModelName(modelName);
}
function _XForm_GetSysDictObj_${xFormTemplateForm.fdKey}() {
	return _XForm_GetSysDictObj(_xform_MainModelName);
}

function updateWarning(){
	var updateWarning = document.getElementById("templateHistoryRefMain").contentWindow.updateWarning;
	if(updateWarning && updateWarning != ""){
		if(!confirm(updateWarning)){
			return false;
		}
	}
	Com_Submit(document.sysFormTemplateHistoryForm, 'update');
}

</script>

<kmss:windowTitle moduleKey="sys-xform:xform.title"
	subjectKey="sys-xform:tree.xform.def"
	subject="历史模板" />
	
<div id="optBarDiv">
	<input type="button" value="<bean:message key="button.save"/>"
		onclick="updateWarning();" />
	<input type="button" value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();" />
</div>
<html:form action="/sys/xform/base/sys_form_template_history/sysFormTemplateHistory.do" method="post">
<html:hidden property="fdDesignerHtml"></html:hidden>
<html:hidden property="fdMetadataXml"></html:hidden>
<html:hidden property="fdCss"/>
<html:hidden property="fdCssDesigner"/>
<input type="hidden" name = "_sysFormTemplateHistory" value="true"/>

<p class="txttitle">表单历史模板_V${xFormTemplateForm.fdTemplateEdition }</p>
<center>
	<table id="Label_Tabel" width=95%>
		<tr LKS_LabelName="模板信息">
			<td>
				<table class="tb_normal" width=100%>
					<c:import url="/sys/xform/base/sysFormTemplateHistoryDisplay_edit.jsp"	charEncoding="UTF-8">
						<c:param name="sysFormTemplateFormPrefix" value="${sysFormTemplateFormPrefix }" />
						<c:param name="formName" value="sysFormTemplateHistoryForm" />
						<c:param name="noProcessFlow" value="true"></c:param>
					</c:import>
				</table>
			</td>			
		</tr>
		<%--多语言 --%>
		<%  if(LangUtil.isEnableMultiLang(request.getParameter("fdMainModelName"), "model") && LangUtil.isEnableAdminDoMultiLang()) {%>
		<c:import url="/sys/xform/lang/include/sysFormHistoryMultiLang_edit.jsp"	charEncoding="UTF-8">
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
</html:form>

<%@ include file="/resource/jsp/edit_down.jsp"%>