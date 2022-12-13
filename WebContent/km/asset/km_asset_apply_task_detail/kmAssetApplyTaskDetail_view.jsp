<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<% response.addHeader("X-UA-Compatible", "IE=edge"); %>	
<template:include ref="config.view">
	<template:replace name="toolbar">
		<script>
			function confirmDelete(msg){
			var del = confirm("<bean:message key="page.comfirmDelete"/>");
			return del;
		}
		</script>
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" var-navwidth="95%">
			<kmss:auth requestURL="/km/asset/km_asset_apply_task_detail/kmAssetApplyTaskDetail.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
				<ui:button text="${ lfn:message('button.edit') }" onclick="Com_OpenWindow('kmAssetApplyTaskDetail.do?method=edit&fdId=${param.fdId}','_self');">
				</ui:button>
			</kmss:auth>
			<kmss:auth requestURL="/km/asset/km_asset_apply_task_detail/kmAssetApplyTaskDetail.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
				<ui:button text="${ lfn:message('button.delete') }" onclick="if(!confirmDelete())return;Com_OpenWindow('kmAssetApplyTaskDetail.do?method=delete&fdId=${param.fdId}','_self');">
				</ui:button>
			</kmss:auth>
			<ui:button text="${ lfn:message('button.close') }" onclick="Com_CloseWindow();"></ui:button>
		</ui:toolbar>
	</template:replace>
	<template:replace name="content">
	
<p class="txttitle"><bean:message bundle="km-asset" key="table.kmAssetApplyTaskDetail"/></p>

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
			<c:out value="${kmAssetApplyTaskDetailForm.fdNameName}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyTaskDetail.fdTask"/>
		</td><td width="35%">
			<c:out value="${kmAssetApplyTaskDetailForm.fdTaskName}" />
		</td>
	</tr>
			</table>
		</td>
	</tr>
</table>
</center>

	</template:replace>
</template:include>