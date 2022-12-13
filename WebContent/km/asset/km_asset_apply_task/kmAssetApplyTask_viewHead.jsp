<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:replace name="head">
	<style type="text/css">
		   .assignUserCtl,.purchaseTimeCtl {
		    display: none;
		}
	</style>
</template:replace>
<template:replace name="title">
	<c:out value="${kmAssetApplyTaskForm.docSubject} - ${ lfn:message('km-asset:module.km.asset')}"></c:out>
</template:replace>
<template:replace name="toolbar">
	<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="3">
		<% 
		 request.setAttribute("fdUserId",UserUtil.getUser().getFdId());
		%>
		<c:if test="${kmAssetApplyTaskForm.docStatus eq '30' and kmAssetApplyTaskForm.fdStatus ne '3' and kmAssetApplyTaskForm.docCreatorId ==fdUserId}">
			<ui:button text="${lfn:message('km-asset:kmAssetApplyTask.inventoryComplete')}" 
						onclick="complateTask('${param.fdId}');" order="1">
			</ui:button>
		</c:if>
		<c:if test="${kmAssetApplyTaskForm.docStatus=='10' || kmAssetApplyTaskForm.docStatus=='11'|| kmAssetApplyTaskForm.docStatus=='20'}">
			<kmss:auth requestURL="/km/asset/km_asset_apply_task/kmAssetApplyTask.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
				<ui:button text="${lfn:message('button.edit')}" 
							onclick="Com_OpenWindow('kmAssetApplyTask.do?method=edit&fdId=${param.fdId}','_self');" order="2">
				</ui:button>
			</kmss:auth>
		</c:if>
		<kmss:auth requestURL="/km/asset/km_asset_apply_task/kmAssetApplyTask.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
			<ui:button text="${lfn:message('button.delete')}" order="4"
						onclick="deleteDoc('kmAssetApplyTask.do?method=delete&fdId=${param.fdId}');">
			</ui:button> 
		</kmss:auth>
		<c:if test="${kmAssetApplyTaskForm.docStatus=='30'}">
			<ui:button text="${lfn:message('km-asset:kmAssetApplyTask.button.export')}" 
						onclick="Com_OpenWindow('kmAssetApplyTask.do?method=exportAssetTask&taskId=${param.fdId}','_self');" order="3">
			</ui:button>
		</c:if>
		<ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();">
		</ui:button>
	</ui:toolbar>
</template:replace>
<template:replace name="path">
	<ui:combin ref="menu.path.category">
		<ui:varParams  moduleTitle="${ lfn:message('km-asset:module.km.asset') }" 
		    modulePath="/km/asset/" 
			modelName="com.landray.kmss.km.asset.model.KmAssetApplyTemplate" 
		    autoFetch="false" 
		    href="/km/asset/#j_path=/kmAssetApplyTask_my/create" 
			categoryId="${kmAssetApplyTaskForm.fdApplyTemplateId}" />
	</ui:combin>
</template:replace>