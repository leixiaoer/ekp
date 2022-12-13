<%@ page
	language="java"
	contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/view_top.jsp"%>
<%--bookmark--%>
<c:import url="/sys/bookmark/include/bookmark_bar.jsp"
	charEncoding="UTF-8">
	<c:param name="fdSubject" value="${kmInstitutionKnowledgeForm.docSubject}" />
	<c:param name="fdModelId" value="${kmInstitutionKnowledgeForm.fdId}" />
	<c:param name="fdModelName"
		value="com.landray.kmss.km.institution.model.KmInstitutionKnowledge"/>
</c:import>
<script>
function confirmDelete(msg){
	var del = confirm("<bean:message key="page.comfirmDelete"/>");
	return del;
}
Com_IncludeFile("dialog.js");
</script>
<script language="javascript">
function confirmAbolish(){
	var dayField = document.getElementsByName("fdAbolishTime")[0];
	var days = Dialog_PopupWindow("kmInstitutionKnowledge_setTime.jsp", 400, 200);
		if(days==null)
			return;
		dayField.value = days;
		Com_OpenWindow("kmInstitutionKnowledge.do?method=abolish&fdAbolishTime="+days+"&fdId=${param.fdId}",'_self');
}
</script>
<kmss:windowTitle
	subject="${kmInstitutionKnowledgeForm.docSubject}"
	moduleKey="km-institution:table.kmdoc" />
<c:set
	var="kmInstitutionKnowledgeForm"
	value="${kmInstitutionKnowledgeForm}"
	scope="request" />
<%@ include file="kmInstitutionKnowledge_script.jsp"%>
	<input type="hidden" name="fdAbolishTime" />
<div id="optBarDiv">
	<c:if test="${kmInstitutionKnowledgeForm.docStatusFirstDigit >= '3' }">
		<input type="button"
			value="<bean:message key="button.back" bundle="km-institution"/>"
			onclick="Com_OpenWindow('kmInstitutionKnowledge.do?method=view&fdId=${param.fdId}','_self');" />
	</c:if>

<c:if test="${kmInstitutionKnowledgeForm.docStatus == '30' && kmInstitutionKnowledgeForm.docIsNewVersion==true}">
	 <kmss:auth
		requestURL="/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=abolish&fdId=${param.fdId}"
		requestMethod="GET">
		<input
			type="button"
			value="<bean:message key="kmInstitution.button.abolishSingle" bundle="km-institution"/>"
			onclick="confirmAbolish();">
	</kmss:auth>
</c:if> 
<c:if test="${kmInstitutionKnowledgeForm.docStatusFirstDigit > '0' }">
	<kmss:auth
		requestURL="/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=edit&fdId=${param.fdId}"
		requestMethod="GET">
		<input
			type="button"
			value="<bean:message key="button.edit"/>"
			onclick="Com_OpenWindow('kmInstitutionKnowledge.do?method=edit&fdId=${param.fdId}','_self');">
	</kmss:auth> 
</c:if>
<kmss:auth
	requestURL="/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=delete&fdId=${param.fdId}"
	requestMethod="GET">
	<input
		type="button"
		value="<bean:message key="button.delete"/>"
		onclick="if(!confirmDelete())return;Com_OpenWindow('kmInstitutionKnowledge.do?method=delete&fdId=${param.fdId}','_self');">
</kmss:auth><input
	type="button"
	value="<bean:message key="button.close"/>"
	onclick="Com_CloseWindow();"></div>
<p class="txttitle"><bean:write
					name="kmInstitutionKnowledgeForm"
					property="docSubject" />
	<c:if test="${kmInstitutionKnowledgeForm.docStatus=='50'}">
	<font color="red">
	<bean:message
	bundle="km-institution"
	key="kmInstitution.fileAbolished" />
	</font>
	</c:if>
	</p>
<center>
<table
	id="Label_Tabel"
	width=95%>
	<tr LKS_LabelName="<bean:message bundle="km-institution" key="kmInstitution.form.tab.main.label" />">
		<td>
		<table
			class="tb_normal"
			width=100%>
	<tr>
	<td
		width="11%"
		class="td_normal_title"><bean:message
		bundle="km-institution"
		key="kmInstitution.docSubject" /></td>
	<td
		width="89%"
		colspan="3"><bean:write
		name="kmInstitutionKnowledgeForm"
		property="docSubject" /></td>
		</tr>
		<tr>
			<td
					width="11%"
					class="td_normal_title"><bean:message
					bundle="km-institution"
					key="kmInstitution.fdNumber" /></td>
				<td
					width="89%"
					colspan="3"><bean:write
					name="kmInstitutionKnowledgeForm"
					property="fdNumber" /></td>
			</tr>
<tr>
	<td
		width="11%"
		class="td_normal_title"><bean:message
		bundle="sys-doc"
		key="sysDocBaseInfo.docDept" /></td>
	<td width="39%"><bean:write
		name="kmInstitutionKnowledgeForm"
		property="docDeptName" /></td>
	<td
		width="11%"
		class="td_normal_title"><bean:message
		bundle="km-institution"
		key="kmInstitution.docPublishTime" /></td>
	<td width="39%">	
		<c:out value="${kmInstitutionKnowledgeForm.docPublishTime}" />
		</td>
		</tr>
		<tr>
				<td
					class="td_normal_title"
					width="15%"><bean:message
					key="kmInstitutionKnowledge.fdTemplateName"
					bundle="km-institution" /></td>
				<td ><bean:write
					name="kmInstitutionKnowledgeForm"
					property="fdDocTemplateName" /></td>
					<td
					class="td_normal_title"
					width="15%"><bean:message
					bundle="km-institution"
					key="table.kmInstitutionMainProperty" /></td>
				<td ><bean:write
					name="kmInstitutionKnowledgeForm"
					property="docPropertiesNames" /></td>
			</tr>
			<!-- 标签机制 -->
			<c:import url="/sys/tag/include/sysTagMain_view.jsp"
				charEncoding="UTF-8">
				<c:param name="formName" value="kmInstitutionKnowledgeForm" />
				<c:param name="fdKey" value="mainDoc" /> 
			</c:import>
			<!-- 标签机制 -->
			<!-- 关键字去掉 
			<tr>
				<td
					class="td_normal_title"
					width=15%><bean:message
					bundle="km-institution"
					key="kmInstitutionMainKeyword.docKeyword" />
				</td>
				<td colspan="3"><bean:write
					name="kmInstitutionKnowledgeForm"
					property="docKeywordNames" />
				</td>
			</tr>-->

	<tr>
		<td
		width="11%"
		class="td_normal_title"
		valign="top"><bean:message
		bundle="km-institution"
		key="kmInstitution.docContent" /></td>
		<td
		width="89%"
		colspan="3">${kmInstitutionKnowledgeForm.docContent }</td>
	</tr>
<tr>
	<td
		width="11%"
		class="td_normal_title"
		valign="top"><bean:message
		bundle="sys-doc"
		key="sysDocBaseInfo.docAttachments" /></td>
	<td
		width="89%"
		colspan="3"><c:import
		url="/sys/attachment/sys_att_main/sysAttMain_view.jsp"
		charEncoding="UTF-8">
		<c:param
			name="formBeanName"
			value="kmInstitutionKnowledgeForm" />
		<c:param
			name="fdKey"
			value="attachment" />
	</c:import>
	</td>
</tr>

<tr>
	<td
		width="11%"
		class="td_normal_title"><bean:message
		bundle="sys-doc"
		key="sysDocBaseInfo.docCreator" /></td>
	<td width="39%"><bean:write
		name="kmInstitutionKnowledgeForm"
		property="docCreatorName" /></td>
	<td
		width="11%"
		class="td_normal_title"><bean:message
		bundle="sys-doc"
		key="sysDocBaseInfo.docCreateTime" /></td>
	<td width="39%"><bean:write
		name="kmInstitutionKnowledgeForm"
		property="docCreateTime" /></td>
</tr>
<c:if test="${kmInstitutionKnowledgeForm.docStatus=='50' && kmInstitutionKnowledgeForm.fdAbolisherName!=null}">
	<tr>
	<td
		width="11%"
		class="td_normal_title">
		<FONT color="red"><bean:message
		bundle="km-institution"
		key="kmInstitution.abolishRecord" /></FONT></td>
	<td colspan="3">
	<font color="red"><bean:write
		name="kmInstitutionKnowledgeForm"
		property="fdAbolishTime" />
		<bean:write
		name="kmInstitutionKnowledgeForm"
		property="fdAbolisherName" />
		<bean:message
		bundle="km-institution"
		key="kmInstitution.abolishDeal" />
		</font>
		</td>	
	</tr>
	</c:if>


		</table>
		</td>
	</tr>
	<!--  
	<c:import
		url="/sys/introduce/include/sysIntroduceMain_view.jsp"
		charEncoding="UTF-8">
		<c:param
			name="formName"
			value="kmInstitutionKnowledgeForm" />
	</c:import>
	-->
	  <!-- 发布机制开始 -->
         <c:import url="/sys/news/include/sysNewsPublishMain_view.jsp" charEncoding="UTF-8">
             <c:param  name="formName" value="kmInstitutionKnowledgeForm" />
             <c:param name="fdKey" value="mainDoc" />
         </c:import>
         <!-- 发布机制结束 -->

	<c:import
		url="/sys/readlog/include/sysReadLog_view.jsp"
		charEncoding="UTF-8">
		<c:param
			name="formName"
			value="kmInstitutionKnowledgeForm" />
	</c:import>

		<c:import url="/sys/workflow/include/sysWfProcess_view.jsp"
			charEncoding="UTF-8">
			<c:param name="formName" value="kmInstitutionKnowledgeForm" />
			<c:param name="fdKey" value="mainDoc" />
			<c:param name="showHistoryOpers" value="true" />
			<c:param name="isSimpleWorkflow" value="true" />
		</c:import>

	<c:import
		url="/sys/edition/include/sysEditionMain_view.jsp"
		charEncoding="UTF-8">
		<c:param
			name="formName"
			value="kmInstitutionKnowledgeForm" />
	</c:import>

	<tr LKS_LabelName="<bean:message bundle="sys-relation" key="sysRelationMain.tab.label" />">
		<c:set
			var="mainModelForm"
			value="${kmInstitutionKnowledgeForm}"
			scope="request" />
		<c:set
			var="currModelName"
			value="com.landray.kmss.km.institution.model.KmInstitutionKnowledge"
			scope="request" />
		<td><%@ include file="/sys/relation/include/sysRelationMain_view.jsp"%></td>
	</tr>
	<tr LKS_LabelName="<bean:message bundle="sys-right" key="right.moduleName" />">
		<td>
		<table
			class="tb_normal"
			width=100%>
			<c:import
				url="/sys/right/right_view.jsp"
				charEncoding="UTF-8">
				<c:param
					name="formName"
					value="kmInstitutionKnowledgeForm" />
				<c:param
					name="moduleModelName"
					value="com.landray.kmss.km.institution.model.KmInstitutionKnowledge" />
			</c:import>
		</table>
		</td>
	</tr>
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>
