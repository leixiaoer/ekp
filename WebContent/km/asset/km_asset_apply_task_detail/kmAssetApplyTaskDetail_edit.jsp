<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<% response.addHeader("X-UA-Compatible", "IE=edge"); %>	
<template:include ref="config.edit">
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" var-navwidth="95%">
			<c:choose>
				<c:when test="${ kmAssetApplyTaskDetailForm.method_GET == 'edit' }">
					<ui:button text="${ lfn:message('button.update') }" onclick="Com_Submit(document.kmAssetApplyTaskDetailForm, 'update');"></ui:button>
				</c:when>
				<c:when test="${ kmAssetApplyTaskDetailForm.method_GET == 'add' }">	
					<ui:button text="${ lfn:message('button.save') }" onclick="Com_Submit(document.kmAssetApplyTaskDetailForm, 'save');"></ui:button>
					<ui:button text="${ lfn:message('button.saveadd') }" onclick="Com_Submit(document.kmAssetApplyTaskDetailForm, 'saveadd');"></ui:button>
				</c:when>
			</c:choose>
			<ui:button text="${ lfn:message('button.close') }" onclick="Com_CloseWindow();"></ui:button>
		</ui:toolbar>
	</template:replace>
	<template:replace name="content">
	
<html:form action="/km/asset/km_asset_apply_task_detail/kmAssetApplyTaskDetail.do">
<p class="txttitle">${txttitle}</p>
<center>
<table class="tb_normal" id="Label_Tabel" width=95%>
	<tr LKS_LabelName='${ lfn:message('config.baseinfo') }'>
		<td>
			<table class="tb_normal" width=100%> 
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyTaskDetail.fdAssetCard"/>
		</td><td width="35%">
			<xform:text property="fdAssetCard" style="width:85%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyTaskDetail.fdStatus"/>
		</td><td width="35%">
			<xform:select property="fdStatus">
				<xform:enumsDataSource enumsType="km_asset_apply_task_detail_fd_status" />
			</xform:select>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyTaskDetail.fdName"/>
		</td><td width="35%">
			<xform:select property="fdNameId">
				<xform:beanDataSource serviceBean="kmAssetCardService" selectBlock="fdId,docSubject" orderBy="" />
			</xform:select>
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyTaskDetail.fdTask"/>
		</td><td width="35%">
			<xform:select property="fdTaskId">
				<xform:beanDataSource serviceBean="kmAssetApplyTaskService" selectBlock="fdId,docSubject" orderBy="" />
			</xform:select>
		</td>
	</tr>
			</table>
		</td>
	</tr>
</table> 
</center>
<html:hidden property="fdId" />
<html:hidden property="method_GET" />
<script>
	$KMSSValidation();
</script>
</html:form>

	</template:replace>
</template:include>