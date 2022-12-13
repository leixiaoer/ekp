<%@ page
	language="java"
	contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<%@ include file="/sys/ui/jsp/jshead.jsp"%>
<kmss:windowTitle
	subjectKey="km-institution:table.kmInstitutionTemplate"
	moduleKey="km-institution:table.kmdoc" />
<script language="JavaScript">
Com_IncludeFile("dialog.js");
</script>
<html:form
	action="/km/institution/km_institution_template/kmInstitutionTemplate.do"
	onsubmit="return validateKmInstitutionTemplateForm(this);">
	
	<c:import url="/sys/simplecategory/sys_simple_category/sysCategoryMain_edit_button.jsp"
			charEncoding="UTF-8">
			<c:param name="formName" value="kmInstitutionTemplateForm" />
	</c:import>
	
	<p class="txttitle"><bean:message
		bundle="km-institution"
		key="table.kmInstitutionTemplate" /></p>
	<center>
	<table
		id="Label_Tabel"
		width="95%">
		<!-- 模板信息 -->
		<c:import url="/sys/simplecategory/include/sysCategoryMain_edit.jsp"
			charEncoding="UTF-8">
			<c:param name="formName" value="kmInstitutionTemplateForm" />
			<c:param name="requestURL" value="/km/institution/km_institution_template/kmInstitutionTemplate.do?method=add" />
			<c:param name="fdModelName" value="${param.fdModelName}" />
			<c:param name="fdKey" value="mainDoc" />
		</c:import>		
		<tr LKS_LabelName="<bean:message bundle="km-institution" key="kmInstitutionTemplate.lbl.baseinfo" />">
			<td>
			<table
				class="tb_normal"
				width=100%>
				<kmss:ifModuleExist path="/elec/yqqs">
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-institution" key="kmInstitutionKnowledge.fdSignEnable"/>
						</td>
						<td colspan="3">
							<ui:switch property="fdSignEnable" showType="edit" checked="${kmInstitutionTemplateForm.fdSignEnable}"  checkVal="true" unCheckVal="false"/>
							<bean:message bundle="km-institution" key="kmInstitutionKnowledge.fdSignEnable.tip"/>
						</td>
					</tr>
				</kmss:ifModuleExist>
				<tr>
					<td
						class="td_normal_title"
						width=15%><bean:message
						bundle="km-institution"
						key="kmInstitutionTemplate.docContent" /></td>
					<td width=85%><kmss:editor
						property="docContent"
						height="400" /></td>
				</tr>
				
				<!--  <tr>
					<td
						class="td_normal_title"
						width=15%><bean:message
						bundle="km-institution"
						key="kmInstitutionTemplateKeyword.docKeyword" /></td>
					<td colspan="3"><html:text
						property="docKeywordNames"
						style="width:80%" /><br>
					<bean:message
						key="kmInstitution.keyword.description"
						bundle="km-institution" /></td>
				</tr>-->
				<!-- 标签机制 -->
				<c:import url="/sys/tag/include/sysTagTemplate_edit.jsp"
					charEncoding="UTF-8">
					<c:param name="formName" value="kmInstitutionTemplateForm" />
					<c:param name="fdKey" value="mainDoc" /> 
				</c:import>
				<!-- 标签机制 -->
				
			</table>
			</td>
		</tr>
		<!-- 流程 -->
		<c:import url="/sys/workflow/include/sysWfTemplate_edit.jsp"
			charEncoding="UTF-8">
			<c:param name="formName" value="kmInstitutionTemplateForm" />
			<c:param name="fdKey" value="mainDoc" />
		</c:import>
		<%--<tr LKS_LabelName="<bean:message bundle="km-institution" key="kmInstitutionTemplate.lbl.publish"/>">
			<td>
			<table
				class="tb_normal"
				width="100%">
			</table>
			</td>
		</tr>
		--%>
		<%--关联机制--%>
		<tr LKS_LabelName="<bean:message bundle="sys-relation" key="sysRelationMain.tab.label" />">
			<c:set
				var="mainModelForm"
				value="${kmInstitutionTemplateForm}"
				scope="request" />
			<c:set
				var="currModelName"
				value="com.landray.kmss.km.institution.model.KmInstitutionTemplate"
				scope="request" />
			<td><%@ include file="/sys/relation/include/sysRelationMain_edit.jsp"%></td>
		</tr>
		
		    <!--发布机制开始 -->
               <c:import url="/sys/news/include/sysNewsPublishCategory_edit.jsp" charEncoding="UTF-8">
                            <c:param name="formName" value="kmInstitutionTemplateForm" />
                            <c:param name="fdKey" value="mainDoc" />
                            <c:param name="messageKey" value="km-institution:kmInstitutionTemplate.lbl.publish" />
                </c:import>
             <!--发布机制结束-->

		
		
		<tr LKS_LabelName="<bean:message bundle="sys-right" key="right.moduleName" />">
			<td>
			<table
				class="tb_normal"
				width=100%>
				<c:import
					url="/sys/right/tmp_right_edit.jsp"
					charEncoding="UTF-8">
					<c:param
						name="formName"
						value="kmInstitutionTemplateForm" />
					<c:param
						name="moduleModelName"
						value="com.landray.kmss.km.institution.model.KmInstitutionTemplate" />
				</c:import>
			</table>
			</td>
		</tr>
		
		<!-- 编号机制 -->
		<c:import url="/sys/number/include/sysNumberMappTemplate_edit.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmInstitutionTemplateForm" />
			<c:param name="modelName" value="com.landray.kmss.km.institution.model.KmInstitutionKnowledge"/>
			<c:param name="isUnlimit" value="true"/>
		</c:import>
		<!-- 失效流程 -->
		<c:import url="/sys/workflow/include/sysWfTemplate_edit.jsp"
			charEncoding="UTF-8">
			<c:param name="formName" value="kmInstitutionTemplateForm" />
			<c:param name="fdKey" value="abolishDoc" />
			<c:param name="messageKey" value="km-institution:kmInstitutionTemplate.abolishTemplate" />
		</c:import>
		<!-- 规则机制 -->
		<c:import url="/sys/rule/sys_ruleset_temp/sysRuleTemplate_edit.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmInstitutionTemplateForm" />
			<c:param name="fdKey" value="mainDoc;abolishDoc" />
			<c:param name="messageKey" value="km-institution:kmInstitutionTemplate.mainDocSetting;km-institution:kmInstitutionTemplate.abolishDocSetting" />
			<c:param name="templateModelName" value="com.landray.kmss.km.institution.model.KmInstitutionTemplate"></c:param>
		</c:import>
	</table>
	</center>
	<html:hidden property="method_GET" />
	<html:hidden property="fdId" />
</html:form>
<html:javascript
	formName="kmInstitutionTemplateForm"
	cdata="false"
	dynamicJavascript="true"
	staticJavascript="false" />
<%@ include file="/resource/jsp/edit_down.jsp"%>
