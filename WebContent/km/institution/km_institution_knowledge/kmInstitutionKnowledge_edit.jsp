<%@ page
	language="java"
	contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<script>
	Com_IncludeFile("doclist.js|dialog.js|calendar.js|optbar.js");
</script>
<script language="JavaScript">
	Com_NewFileFromSimpleCateory('com.landray.kmss.km.institution.model.KmInstitutionTemplate','<c:url value="/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do" />?method=add&fdTemplateId=!{id}&fdTemplateName=!{name}');
</script>
<c:if test="${kmInstitutionKnowledgeForm.method_GET=='add' }">
	<%@page import="com.landray.kmss.km.institution.model.KmInstitutionTemplate"%>
	<%@page import="com.landray.kmss.km.institution.service.IKmInstitutionTemplateService"%>
	<%@page import="org.springframework.context.ApplicationContext"%>
	<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
	<%@page import="com.landray.kmss.km.institution.forms.KmInstitutionTemplateForm"%>
	<%@page import="com.landray.kmss.common.actions.RequestContext"%>
	<%
		String templateId = request.getParameter("fdTemplateId");
		ApplicationContext ctx = WebApplicationContextUtils
				.getRequiredWebApplicationContext(request.getSession()
				.getServletContext());
		IKmInstitutionTemplateService templateService = (IKmInstitutionTemplateService) ctx
				.getBean("kmInstitutionTemplateService");
		if (templateId != null&&StringUtil.isNotNull(templateId)) {
			KmInstitutionTemplate template = (KmInstitutionTemplate) templateService
			.findByPrimaryKey(templateId);
			KmInstitutionTemplateForm form = new KmInstitutionTemplateForm();
			templateService.convertModelToForm(form, template,
			new RequestContext(request));
			request.setAttribute("kmInstitutionTemplateForm", form);
		}
	%>
</c:if>
<c:set
	var="sysDocBaseInfoForm"
	value="${kmInstitutionKnowledgeForm}"
	scope="request" />
<html:form
	action="/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do"
	onsubmit="return validateKmInstitutionKnowledgeForm(this);">
	<html:hidden property="fdImportInfo" />
	<%@ include file="kmInstitutionKnowledge_script.jsp"%>
	<div id="optBarDiv"><logic:equal
		name="kmInstitutionKnowledgeForm"
		property="method_GET"
		value="add">
		<kmss:windowTitle
			subjectKey="km-institution:kmInstitution.create.title"
			moduleKey="km-institution:table.kmdoc" />
		<input
			type=button
			value="<bean:message key="kmInstitution.button.savedraft" bundle="km-institution"/>"
			onclick="commitMethod('save','true');">
		<input
			type=button
			value="<bean:message key="button.submit"/>"
			onclick="commitMethod('save','false');">
	</logic:equal> <logic:equal
		name="kmInstitutionKnowledgeForm"
		property="method_GET"
		value="edit">
		<kmss:windowTitle
			subject="${kmInstitutionKnowledgeForm.docSubject}"
			moduleKey="km-institution:table.kmdoc" />
		<c:if test="${kmInstitutionKnowledgeForm.docStatusFirstDigit=='1'}">
			<input
				type=button
				value="<bean:message key="kmInstitution.button.savedraft" bundle="km-institution"/>"
				onclick="commitMethod('update','true');">
		</c:if>
		<c:if test="${kmInstitutionKnowledgeForm.docStatusFirstDigit<'3'}">
			<input
				type=button
				value="<bean:message key="button.submit"/>"
				onclick="commitMethod('update','false');">
		</c:if>
		<c:if test="${kmInstitutionKnowledgeForm.docStatusFirstDigit>='3'}">
			<input
				type=button
				value="<bean:message key="button.submit"/>"
				onclick="Com_Submit(document.kmInstitutionKnowledgeForm, 'update');">
		</c:if>
	</logic:equal> <input
		type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();"></div>
	<p class="txttitle">
	<c:if test="${kmInstitutionKnowledgeForm.docSubject==null}" >
	<bean:message
		bundle="km-institution"
		key="kmInstitution.form.title" />
		</c:if>
		<c:if test="${kmInstitutionKnowledgeForm.docSubject!=null}" >
	<bean:write
					name="kmInstitutionKnowledgeForm"
					property="docSubject" />
		</c:if>
		</p>
	<center>
	<table
		id="Label_Tabel"
		width=95%>
		<html:hidden property="fdId" />
		<tr LKS_LabelName="<bean:message bundle="km-institution" key="kmInstitution.form.tab.main.label" />">
			<td>
			<table
				class="tb_normal"
				width=100%>
				<html:hidden property="docStatus" />
			<tr>
				<td
					width="15%"
					class="td_normal_title"><bean:message
					bundle="km-institution"
					key="kmInstitution.docSubject" /></td>
				<td colspan="3"><html:text
					property="docSubject"
					styleClass="inputsgl"
					style="width:90%;"
					/> <span class="txtstrong">*</span></td>
			</tr>
<tr>
	<td
				width="15%"
				class="td_normal_title">
				<bean:message
				bundle="km-institution"
				key="kmInstitution.fdNumber" /></td>
	<td
				width="85%"
				colspan="3">
				<html:text
				property="fdNumber"
				styleClass="inputsgl"
				style="width:90%;" 
				/> 
				<span class="txtstrong">*</span></td>
</tr>
			<tr>
				<td
					width="15%"
					class="td_normal_title"><bean:message
					bundle="sys-doc"
					key="sysDocBaseInfo.docDept" /></td>
				<td>
				<html:hidden property="docDeptId" /> <html:text
					property="docDeptName"
					styleClass="inputsgl"
					readonly="true" /> <span class="txtstrong">*</span> <a
					href="#"
					onclick="Dialog_Address(false, 'docDeptId','docDeptName', ';', ORG_TYPE_ORGORDEPT);"> <bean:message key="dialog.selectOrg" /> 
					</a>
					
				</td>
				<!-- ------------发布时间------------- -->
		<td	class="td_normal_title"width="15%">
					<bean:message
						bundle="km-institution"
						key="kmInstitution.docPublishTime" />
					</td>
					<td>
					<html:text
						property="docPublishTime"
						
						styleClass="inputsgl"						
						/>
			<a href="#" onclick="selectDate('docPublishTime');">
			<bean:message key="dialog.selectOther"/>
			</a><bean:message bundle="km-institution" key="kmInstitution.docpublishTime.tips" />
				</td>
					<!-- ------------------------- -->
				</tr>
				<tr>
					<td
						class="td_normal_title"
						width="15%"><bean:message
						key="kmInstitutionKnowledge.fdTemplateName"
						bundle="km-institution" /></td>
					<td><html:hidden property="fdDocTemplateId" /> <bean:write
						name="kmInstitutionKnowledgeForm"
						property="fdDocTemplateName" />
					</td>
					<td	class="td_normal_title"width="15%">
					<bean:message
						bundle="km-institution"
						key="table.kmInstitutionMainProperty" />
					</td>
					<td width="39%">
					<html:hidden property="docPropertiesIds" /> 
					<html:text
						property="docPropertiesNames"
						readonly="true"
						styleClass="inputsgl"
						 />
					 <a
				href="#"
				onclick="Dialog_property(true, 'docPropertiesIds','docPropertiesNames', ';', ORG_TYPE_PERSON);">
				<bean:message key="dialog.selectOrg" /> 
				</a>
					</td>
				</tr>
				<!-- 标签机制 -->
				<c:import url="/sys/tag/include/sysTagMain_edit.jsp"
					charEncoding="UTF-8">
					<c:param name="formName" value="kmInstitutionKnowledgeForm" />
					<c:param name="fdKey" value="mainDoc" /> 
					<c:param name="modelName" value="com.landray.kmss.km.institution.model.KmInstitutionKnowledge" />
					<c:param name="fdQueryCondition" value="fdDocTemplateId;docDeptId" /> 			
				</c:import>
				<!-- 标签机制 -->
				<!-- 关键字去掉
				<tr>
					<td
						class="td_normal_title"
						width=15%><bean:message
						bundle="km-institution"
						key="kmInstitutionMainKeyword.docKeyword" /></td>
					<td colspan="3"><html:text
						property="docKeywordNames"
						style="width:80%" /><br>
					<bean:message
						key="kmInstitution.keyword.description"
						bundle="km-institution" /></td>
				</tr> -->
				
				<tr>
					<td
						width="15%"
						class="td_normal_title"
						valign="top"><bean:message
						bundle="km-institution"
						key="kmInstitution.docContent" /></td>
					<td
						width="85%"
						colspan="3"><kmss:editor
						property="docContent"
						toolbarSet="Default"
						height="300" /></td>
				</tr>
				
				<tr>
					<td
						width="15%"
						class="td_normal_title"
						valign="top"><bean:message
						bundle="sys-doc"
						key="sysDocBaseInfo.docAttachments" /></td>
					<td
						width="85%"
						colspan="3"><c:import
						url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp"
						charEncoding="UTF-8">
						<c:param
							name="fdKey"
							value="attachment" />
					</c:import></td>
				</tr>
				
				<%-----新建时，录入者，录入时间不要显示 modify by zhouchao---%>
				<c:if test="${kmInstitutionKnowledgeForm.method_GET=='edit' }">
					<tr>
					<td
						width="15%"
						class="td_normal_title"><bean:message
						bundle="sys-doc"
						key="sysDocBaseInfo.docCreator" /></td>
					<td width="39%"><html:text
						property="docCreatorName"
						readonly="true"
						 /></td>
					<td
						width="15%"
						class="td_normal_title"><bean:message
						bundle="sys-doc"
						key="sysDocBaseInfo.docCreateTime" /></td>
					<td width="39%"><html:text
						property="docCreateTime"
						readonly="true" /></td>
				</tr>
				</c:if>
			</table>
			</td>
		</tr>
		
		<c:import
			url="/sys/readlog/include/sysReadLog_edit.jsp"
			charEncoding="UTF-8">
			<c:param
				name="formName"
				value="kmInstitutionKnowledgeForm" />
		</c:import>
		<!-- 流程 -->
		<c:import url="/sys/workflow/include/sysWfProcess_edit.jsp"
			charEncoding="UTF-8">
			<c:param name="formName" value="kmInstitutionKnowledgeForm" />
			<c:param name="fdKey" value="mainDoc" />
		</c:import>
		<c:import
			url="/sys/edition/include/sysEditionMain_edit.jsp"
			charEncoding="UTF-8">
			<c:param
				name="formName"
				value="kmInstitutionKnowledgeForm" />
		</c:import>
		
		    <!--发布机制开始-->
            <c:import url="/sys/news/include/sysNewsPublishMain_edit.jsp"  charEncoding="UTF-8">
                <c:param  name="formName" value="kmInstitutionKnowledgeForm" />
                <c:param name="fdKey" value="mainDoc" />
                <c:param name="isShow" value="true" />
                   </c:import>

         <!--发布机制结束-->

		
		
		<tr LKS_LabelName="<bean:message bundle="sys-relation" key="sysRelationMain.tab.label" />">
			<c:set
				var="mainModelForm"
				value="${kmInstitutionKnowledgeForm}"
				scope="request" />
			<c:set
				var="currModelName"
				value="com.landray.kmss.km.institution.model.KmInstitutionKnowledge"
				scope="request" />
			<td><%@ include file="/sys/relation/include/sysRelationMain_edit.jsp"%></td>
		</tr>
		<tr LKS_LabelName="<bean:message bundle="sys-right" key="right.moduleName" />">
			<td>
			<table
				class="tb_normal"
				width=100%>
				<c:import
					url="/sys/right/right_edit.jsp"
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
	<html:hidden property="method_GET" />
</html:form>
<!-- 校验代码生成语句-->
<html:javascript
	formName="kmInstitutionKnowledgeForm"
	cdata="false"
	dynamicJavascript="true"
	staticJavascript="false" />
<%@ include file="/resource/jsp/edit_down.jsp"%>
