<%@ page
	language="java"
	contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/view_top.jsp"%>
<kmss:windowTitle
	subject="${kmInstitutionTemplateForm.fdName}"
	moduleKey="km-institution:table.kmdoc" />
<%--参数--%>
<c:set var="formName" value="kmInstitutionTemplateForm" />
<c:set var="requestURL" value="/km/institution/kmInstitutionTemplate.do" />
<c:set var="fdId" value="${kmInstitutionTemplateForm.fdId}" />
<c:set var="fdModelName" value="com.landray.kmss.km.institution.model.KmInstitutionKnowledge" />
<%---按钮--%>
<c:import
	url="/sys/right/right_batch_change_button.jsp"
	charEncoding="UTF-8">
	<c:param
		name="modelName"
		value="com.landray.kmss.km.institution.model.KmInstitutionKnowledge" />
	<c:param
		name="type"
		value="tmpdoc" />
</c:import> 
<c:import url="/sys/simplecategory/sys_simple_category/sysCategoryMain_view_button.jsp"
				charEncoding="UTF-8">
		<c:param name="formName" value="${formName}" />
		<c:param name="requestURL" value="${requestURL}" />
		<c:param name="fdId" value="${fdId}" />
		<c:param name="fdModelName" value="${fdModelName}" />
</c:import> 
<%--标题--%>
<p class="txttitle"><bean:message
	bundle="km-institution"
	key="table.kmInstitutionTemplate" /></p>
<center>
<%--内容--%>
<table
	id="Label_Tabel"
	width="95%">
	<%--模板信息---%>		
		<c:import url="/sys/simplecategory/include/sysCategoryMain_view.jsp"
			charEncoding="UTF-8">
			<c:param name="formName" value="${formName}" />
			<c:param name="fdModelName" value="${fdModelName}" />
			<c:param name="fdKey" value="mainDoc" />
		</c:import>
	<%--基本信息--%>
	<tr LKS_LabelName="<bean:message bundle="km-institution" key="kmInstitutionTemplate.lbl.baseinfo" />">
		<td>
		<table
			class="tb_normal"
			width=100%>
			<tr>
				<td
					class="td_normal_title"
					width=15%><bean:message
					bundle="km-institution"
					key="kmInstitutionTemplate.docContent" /></td>
				<td width=85%>${kmInstitutionTemplateForm.docContent }</td>
			</tr> 
			<!-- 关键字去掉
			<tr>
				<td
					class="td_normal_title"
					width=15%><bean:message
					bundle="km-institution"
					key="kmInstitutionTemplateKeyword.docKeyword" /></td>
				<td colspan="3"><bean:write
					name="kmInstitutionTemplateForm"
					property="docKeywordNames" /></td>
			</tr>- -->
			<!-- 标签机制 -->
				<c:import url="/sys/tag/include/sysTagTemplate_view.jsp"
					charEncoding="UTF-8">
					<c:param name="formName" value="kmInstitutionTemplateForm" />
					<c:param name="fdKey" value="mainDoc" /> 
				</c:import>
				<!-- 标签机制 -->
		</table>
		</td>
	</tr>
	<%--流程--%>
	<c:import url="/sys/workflow/include/sysWfTemplate_view.jsp"
		charEncoding="UTF-8">
		<c:param name="formName" value="kmInstitutionTemplateForm" />
		<c:param name="fdKey" value="mainDoc" />
	</c:import> 
	 <!--发布机制开始-->
       <c:import url="/sys/news/include/sysNewsPublishCategory_view.jsp" charEncoding="UTF-8">
                <c:param name="formName" value="kmInstitutionTemplateForm" />
                 <c:param name="fdKey" value="mainDoc" />
         </c:import>

	
	<%--权限--%>
	<tr LKS_LabelName="<bean:message bundle="sys-right" key="right.moduleName" />">
		<td>
		<table
			class="tb_normal"
			width=100%>
			<c:import
				url="/sys/right/tmp_right_view.jsp"
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
	<c:import url="/sys/number/include/sysNumberMappTemplate_view.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="kmInstitutionTemplateForm" />
		<c:param name="modelName" value="com.landray.kmss.km.institution.model.KmInstitutionKnowledge"/>
	</c:import>
	
	<!-- 失效流程 -->
	<c:import url="/sys/workflow/include/sysWfTemplate_view.jsp"
		charEncoding="UTF-8">
		<c:param name="formName" value="kmInstitutionTemplateForm" />
		<c:param name="fdKey" value="abolishDoc" />
		<c:param name="messageKey" value="km-institution:kmInstitutionTemplate.abolishTemplate" />
	</c:import> 
	<!-- 规则机制 -->
	<c:import url="/sys/rule/sys_ruleset_temp/sysRuleTemplate_view.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="kmInstitutionTemplateForm" />
		<c:param name="fdKey" value="mainDoc;abolishDoc" />
		<c:param name="messageKey" value="制度规则设置;失效流程规则设置" />
		<c:param name="templateModelName" value="com.landray.kmss.km.institution.model.KmInstitutionTemplate"></c:param>
	</c:import>
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>