<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<html:form action="/km/asset/km_asset_apply_category/kmAssetApplyCategory.do">
<div id="optBarDiv">
	<c:if test="${kmAssetApplyCategoryForm.method_GET=='edit'}">
		<input type=button value="<bean:message key="button.update"/>"
			onclick="Com_Submit(document.kmAssetApplyCategoryForm, 'update');">
	</c:if>
	<c:if test="${kmAssetApplyCategoryForm.method_GET=='add'}">
		<input type=button value="<bean:message key="button.save"/>"
			onclick="Com_Submit(document.kmAssetApplyCategoryForm, 'save');">
		<input type=button value="<bean:message key="button.saveadd"/>"
			onclick="Com_Submit(document.kmAssetApplyCategoryForm, 'saveadd');">
	</c:if>
	<input type="button" value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
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
			<xform:datetime property="docCreateTime" showStatus="readOnly" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyCategory.docAlterTime"/>
		</td><td width="35%">
			<xform:datetime property="docAlterTime" showStatus="readOnly" />
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
			<xform:address propertyId="docCreatorId" propertyName="docCreatorName" orgType="ORG_TYPE_PERSON" showStatus="readOnly" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyCategory.docAlteror"/>
		</td><td width="35%">
			<xform:address propertyId="docAlterorId" propertyName="docAlterorName" orgType="ORG_TYPE_PERSON" showStatus="readOnly" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyCategory.fdParent"/>
		</td><td width="35%">
			<xform:select property="fdParentId">
				<xform:beanDataSource serviceBean="kmAssetApplyCategoryService" selectBlock="fdId,fdName" orderBy="fdOrder" />
			</xform:select>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyCategory.authReaders"/>
		</td><td width="35%">
			<xform:address propertyId="authReaderIds" propertyName="authReaderNames" mulSelect="true" orgType="ORG_TYPE_ALL" textarea="true" style="width:85%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyCategory.authEditors"/>
		</td><td width="35%">
			<xform:address propertyId="authEditorIds" propertyName="authEditorNames" mulSelect="true" orgType="ORG_TYPE_ALL" textarea="true" style="width:85%" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyCategory.authOtherReaders"/>
		</td><td width="35%">
			<xform:address propertyId="authOtherReaderIds" propertyName="authOtherReaderNames" mulSelect="true" orgType="ORG_TYPE_ALL" textarea="true" style="width:85%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyCategory.authOtherEditors"/>
		</td><td width="35%">
			<xform:address propertyId="authOtherEditorIds" propertyName="authOtherEditorNames" mulSelect="true" orgType="ORG_TYPE_ALL" textarea="true" style="width:85%" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyCategory.authAllReaders"/>
		</td><td width="35%">
			<xform:address propertyId="authAllReaderIds" propertyName="authAllReaderNames" mulSelect="true" orgType="ORG_TYPE_ALL" textarea="true" style="width:85%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyCategory.authAllEditors"/>
		</td><td width="35%">
			<xform:address propertyId="authAllEditorIds" propertyName="authAllEditorNames" mulSelect="true" orgType="ORG_TYPE_ALL" textarea="true" style="width:85%" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyCategory.authAttCopys"/>
		</td><td width="35%">
			<xform:address propertyId="authAttCopyIds" propertyName="authAttCopyNames" mulSelect="true" orgType="ORG_TYPE_ALL" textarea="true" style="width:85%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyCategory.authAttDownloads"/>
		</td><td width="35%">
			<xform:address propertyId="authAttDownloadIds" propertyName="authAttDownloadNames" mulSelect="true" orgType="ORG_TYPE_ALL" textarea="true" style="width:85%" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyCategory.authAttPrints"/>
		</td><td width="35%">
			<xform:address propertyId="authAttPrintIds" propertyName="authAttPrintNames" mulSelect="true" orgType="ORG_TYPE_ALL" textarea="true" style="width:85%" />
		</td>
		<td class="td_normal_title" width=15%>&nbsp;</td><td width=35%>&nbsp;</td>
	</tr>
</table>
</center>
<html:hidden property="fdId" />
<html:hidden property="method_GET" />
<script>
	Com_IncludeFile("calendar.js");
	Com_IncludeFile("dialog.js");
	$KMSSValidation();
</script>
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp"%>