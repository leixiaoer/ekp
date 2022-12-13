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
	<kmss:auth requestURL="/km/asset/km_asset_apply_category/kmAssetApplyCategory.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.edit"/>"
			onclick="Com_OpenWindow('kmAssetApplyCategory.do?method=edit&fdId=${JsParam.fdId}','_self');">
	</kmss:auth>
	<kmss:auth requestURL="/km/asset/km_asset_apply_category/kmAssetApplyCategory.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.delete"/>"
			onclick="if(!confirmDelete())return;Com_OpenWindow('kmAssetApplyCategory.do?method=delete&fdId=${JsParam.fdId}','_self');">
	</kmss:auth>
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>

<p class="txttitle"><bean:message bundle="km-asset" key="table.kmAssetApplyCategory"/></p>

<center>
<table class="tb_normal" width=95%>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyCategory.fdName"/>
		</td><td width="35%">
			<xform:text property="fdName" style="width:85%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyCategory.fdOrder"/>
		</td><td width="35%">
			<xform:text property="fdOrder" style="width:85%" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyCategory.fdHierarchyId"/>
		</td><td width="35%">
			<xform:textarea property="fdHierarchyId" style="width:85%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyCategory.docCreateTime"/>
		</td><td width="35%">
			<xform:datetime property="docCreateTime" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyCategory.docAlterTime"/>
		</td><td width="35%">
			<xform:datetime property="docAlterTime" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyCategory.docStatus"/>
		</td><td width="35%">
			<xform:text property="docStatus" style="width:85%" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyCategory.docPublishTime"/>
		</td><td width="35%">
			<xform:datetime property="docPublishTime" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyCategory.docCreator"/>
		</td><td width="35%">
			<c:out value="${kmAssetApplyCategoryForm.docCreatorName}" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyCategory.docAlteror"/>
		</td><td width="35%">
			<c:out value="${kmAssetApplyCategoryForm.docAlterorName}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyCategory.fdParent"/>
		</td><td width="35%">
			<c:out value="${kmAssetApplyCategoryForm.fdParentName}" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyCategory.authReaders"/>
		</td><td width="35%">
			<c:out value="${kmAssetApplyCategoryForm.authReaderNames}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyCategory.authEditors"/>
		</td><td width="35%">
			<c:out value="${kmAssetApplyCategoryForm.authEditorNames}" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyCategory.authOtherReaders"/>
		</td><td width="35%">
			<c:out value="${kmAssetApplyCategoryForm.authOtherReaderNames}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyCategory.authOtherEditors"/>
		</td><td width="35%">
			<c:out value="${kmAssetApplyCategoryForm.authOtherEditorNames}" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyCategory.authAllReaders"/>
		</td><td width="35%">
			<c:out value="${kmAssetApplyCategoryForm.authAllReaderNames}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyCategory.authAllEditors"/>
		</td><td width="35%">
			<c:out value="${kmAssetApplyCategoryForm.authAllEditorNames}" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyCategory.authAttCopys"/>
		</td><td width="35%">
			<c:out value="${kmAssetApplyCategoryForm.authAttCopyNames}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyCategory.authAttDownloads"/>
		</td><td width="35%">
			<c:out value="${kmAssetApplyCategoryForm.authAttDownloadNames}" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyCategory.authAttPrints"/>
		</td><td width="35%">
			<c:out value="${kmAssetApplyCategoryForm.authAttPrintNames}" />
		</td>
		<td class="td_normal_title" width=15%>&nbsp;</td><td width=35%>&nbsp;</td>
	</tr>
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>