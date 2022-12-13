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
	<kmss:auth requestURL="/km/asset/km_asset_apply_base/kmAssetApplyBase.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.edit"/>"
			onclick="Com_OpenWindow('kmAssetApplyBase.do?method=edit&fdId=${JsParam.fdId}','_self');">
	</kmss:auth>
	<kmss:auth requestURL="/km/asset/km_asset_apply_base/kmAssetApplyBase.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.delete"/>"
			onclick="if(!confirmDelete())return;Com_OpenWindow('kmAssetApplyBase.do?method=delete&fdId=${JsParam.fdId}','_self');">
	</kmss:auth>
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>

<p class="txttitle"><bean:message bundle="km-asset" key="table.kmAssetApplyBase"/></p>

<center>
<table class="tb_normal" width=95%>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyBase.docSubject"/>
		</td><td width="35%">
			<xform:text property="docSubject" style="width:85%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyBase.docStatus"/>
		</td><td width="35%">
			<xform:text property="docStatus" style="width:85%" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyBase.fdNo"/>
		</td><td width="35%">
			<xform:text property="fdNo" style="width:85%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyBase.fdCreateDate"/>
		</td><td width="35%">
			<xform:datetime property="fdCreateDate" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyBase.fdExplain"/>
		</td><td width="35%">
			<xform:rtf property="fdExplain" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyBase.fdReason"/>
		</td><td width="35%">
			<xform:rtf property="fdReason" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyBase.fdSubclassModelname"/>
		</td><td width="35%">
			<xform:text property="fdSubclassModelname" style="width:85%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyBase.docCreateTime"/>
		</td><td width="35%">
			<xform:datetime property="docCreateTime" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyBase.docAlterTime"/>
		</td><td width="35%">
			<xform:datetime property="docAlterTime" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyBase.docPublishTime"/>
		</td><td width="35%">
			<xform:datetime property="docPublishTime" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyBase.docCreator"/>
		</td><td width="35%">
			<c:out value="${kmAssetApplyBaseForm.docCreatorName}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyBase.fdCreator"/>
		</td><td width="35%">
			<c:out value="${kmAssetApplyBaseForm.fdCreatorName}" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyBase.fdDept"/>
		</td><td width="35%">
			<c:out value="${kmAssetApplyBaseForm.fdDeptName}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyBase.docAlteror"/>
		</td><td width="35%">
			<c:out value="${kmAssetApplyBaseForm.docAlterorName}" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyBase.fdApplyCategory"/>
		</td><td width="35%">
			<c:out value="${kmAssetApplyBaseForm.fdApplyCategoryName}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyBase.fdApplyTemplate"/>
		</td><td width="35%">
			<c:out value="${kmAssetApplyBaseForm.fdApplyTemplateName}" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyBase.authReaders"/>
		</td><td width="35%">
			<c:out value="${kmAssetApplyBaseForm.authReaderNames}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyBase.authEditors"/>
		</td><td width="35%">
			<c:out value="${kmAssetApplyBaseForm.authEditorNames}" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyBase.authOtherReaders"/>
		</td><td width="35%">
			<c:out value="${kmAssetApplyBaseForm.authOtherReaderNames}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyBase.authOtherEditors"/>
		</td><td width="35%">
			<c:out value="${kmAssetApplyBaseForm.authOtherEditorNames}" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyBase.authAllReaders"/>
		</td><td width="35%">
			<c:out value="${kmAssetApplyBaseForm.authAllReaderNames}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyBase.authAllEditors"/>
		</td><td width="35%">
			<c:out value="${kmAssetApplyBaseForm.authAllEditorNames}" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyBase.authAttCopys"/>
		</td><td width="35%">
			<c:out value="${kmAssetApplyBaseForm.authAttCopyNames}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyBase.authAttDownloads"/>
		</td><td width="35%">
			<c:out value="${kmAssetApplyBaseForm.authAttDownloadNames}" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyBase.authAttPrints"/>
		</td><td width="35%">
			<c:out value="${kmAssetApplyBaseForm.authAttPrintNames}" />
		</td>
		<td class="td_normal_title" width=15%>&nbsp;</td><td width=35%>&nbsp;</td>
	</tr>
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>