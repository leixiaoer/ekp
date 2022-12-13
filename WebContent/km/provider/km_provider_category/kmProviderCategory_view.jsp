<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/view_top.jsp"%>
<script>
	function confirmDelete(msg){
	var del = confirm("<bean:message key="page.comfirmDelete"/>");
	return del;
}
</script>
<div id="optBarDiv">
	<kmss:auth requestURL="/km/provider/km_provider_category/kmProviderCategory.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.edit"/>"
			onclick="Com_OpenWindow('kmProviderCategory.do?method=edit&fdId=${param.fdId}','_self');">
	</kmss:auth>
	<kmss:auth requestURL="/km/provider/km_provider_category/kmProviderCategory.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.delete"/>"
			onclick="if(!confirmDelete())return;Com_OpenWindow('kmProviderCategory.do?method=delete&fdId=${param.fdId}','_self');">
	</kmss:auth>
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>

<p class="txttitle"><bean:message bundle="km-provider" key="table.kmProviderCategory"/></p>

<center>
<table class="tb_normal" width=95%>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-provider" key="kmProviderCategory.fdName"/>
		</td><td width="35%">
			<xform:text property="fdName" style="width:85%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-provider" key="kmProviderCategory.fdOrder"/>
		</td><td width="35%">
			<xform:text property="fdOrder" style="width:85%" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-provider" key="kmProviderCategory.fdHierarchyId"/>
		</td><td width="35%">
			<xform:textarea property="fdHierarchyId" style="width:85%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-provider" key="kmProviderCategory.docCreateTime"/>
		</td><td width="35%">
			<xform:datetime property="docCreateTime" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-provider" key="kmProviderCategory.docAlterTime"/>
		</td><td width="35%">
			<xform:datetime property="docAlterTime" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-provider" key="kmProviderCategory.docStatus"/>
		</td><td width="35%">
			<xform:text property="docStatus" style="width:85%" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-provider" key="kmProviderCategory.authReaderFlag"/>
		</td><td width="35%">
			<xform:radio property="authReaderFlag">
				<xform:enumsDataSource enumsType="common_yesno" />
			</xform:radio>
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-provider" key="kmProviderCategory.authAttNocopy"/>
		</td><td width="35%">
			<xform:radio property="authAttNocopy">
				<xform:enumsDataSource enumsType="common_yesno" />
			</xform:radio>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-provider" key="kmProviderCategory.authAttNodownload"/>
		</td><td width="35%">
			<xform:radio property="authAttNodownload">
				<xform:enumsDataSource enumsType="common_yesno" />
			</xform:radio>
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-provider" key="kmProviderCategory.authAttNoprint"/>
		</td><td width="35%">
			<xform:radio property="authAttNoprint">
				<xform:enumsDataSource enumsType="common_yesno" />
			</xform:radio>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-provider" key="kmProviderCategory.fdParent"/>
		</td><td width="35%">
			<c:out value="${kmProviderCategoryForm.fdParentName}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-provider" key="kmProviderCategory.docCreator"/>
		</td><td width="35%">
			<c:out value="${kmProviderCategoryForm.docCreatorName}" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-provider" key="kmProviderCategory.docAlteror"/>
		</td><td width="35%">
			<c:out value="${kmProviderCategoryForm.docAlterorName}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-provider" key="kmProviderCategory.authEditors"/>
		</td><td width="35%">
			<c:out value="${kmProviderCategoryForm.authEditorNames}" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-provider" key="kmProviderCategory.authReaders"/>
		</td><td width="35%">
			<c:out value="${kmProviderCategoryForm.authReaderNames}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-provider" key="kmProviderCategory.authAttCopys"/>
		</td><td width="35%">
			<c:out value="${kmProviderCategoryForm.authAttCopyNames}" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-provider" key="kmProviderCategory.authAttDownloads"/>
		</td><td width="35%">
			<c:out value="${kmProviderCategoryForm.authAttDownloadNames}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-provider" key="kmProviderCategory.authAttPrints"/>
		</td><td width="35%">
			<c:out value="${kmProviderCategoryForm.authAttPrintNames}" />
		</td>
	</tr>
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>