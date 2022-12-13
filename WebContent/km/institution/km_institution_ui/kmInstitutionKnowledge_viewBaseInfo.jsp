<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<!-- 草稿状态的文档默认选中基本信息页签 -->
<c:if test="${kmInstitutionKnowledgeForm.docStatus=='10'}">
	<ui:event event="layoutDone">
		$("i.lui-fm-icon-2").closest(".lui_tabpanel_vertical_icon_navs_item_l").click();
    </ui:event>
</c:if>

<ui:content title="${lfn:message('km-institution:kmInstitutionKnowledge.baseInfo') }" titleicon="lui-fm-icon-2">
	<table class="tb_normal lui-fm-noneBorderTable" width=100%>
		<!-- 录入者 -->
		<tr>
			<td class="tr_normal_title" width=30%>
				<bean:message bundle="km-institution" key="kmInstitution.kmInstitutionKnowledgeForm.docAuthor" />
			</td>
			<td>
				<ui:person personId="${kmInstitutionKnowledgeForm.docCreatorId}" personName="${kmInstitutionKnowledgeForm.docCreatorName}" layer="true"></ui:person>
			</td>
		</tr>
		<!-- 所属部门 -->
		<tr>
			<td class="tr_normal_title" width=30%>
				<bean:message bundle="km-institution" key="kmInstitution.form.main.docDeptId" />
			</td>
			<td>
				<c:out value="${ kmInstitutionKnowledgeForm.docDeptName }"></c:out>
			</td>
		</tr>
		<!-- 录入时间 -->
		<tr>
			<td class="tr_normal_title" width=30%>
				<bean:message bundle="km-institution" key="kmInstitutionKnowledge.docCreateTime" />
			</td>
			<td>
				<c:out value="${ kmInstitutionKnowledgeForm.docCreateTime }"></c:out>
			</td>
		</tr>
		<!-- 文档状态 -->
		<tr>
			<td class="tr_normal_title" width=30%>
				<bean:message bundle="km-institution" key="kmInstitution.KmInstitutionKnowledge.docStatus" />
			</td>
			<td>
				<sunbor:enumsShow value="${kmInstitutionKnowledgeForm.docStatus}"	enumsType="kmInstitutionKnowledge_docStaus" />
			</td>
		</tr>
		<!-- 版本 -->
		<tr>
			<td class="tr_normal_title" width=30%>
				<bean:message bundle="km-institution" key="kmInstitution.version" />
			</td>
			<td>
				<c:out value="${ kmInstitutionKnowledgeForm.editionForm.currentVersion }"></c:out>
			</td>
		</tr>
		<!-- 文档编号 -->
		<tr>
			<td class="tr_normal_title" width=30%>
				<bean:message bundle="km-institution" key="kmInstitution.fdNumber" />
			</td>
			<td>
				<c:out value="${ kmInstitutionKnowledgeForm.fdNumber }"></c:out>
			</td>
		</tr>
		<!-- 所属分类 -->
		<tr>
			<td class="tr_normal_title" width=30%>
				<bean:message bundle="km-institution" key="kmInstitutionKnowledge.fdTemplateName" />
			</td>
			<td>
				<c:out value="${kmInstitutionKnowledgeForm.fdDocTemplateName}"></c:out>
			</td>
		</tr>
	</table>
</ui:content>