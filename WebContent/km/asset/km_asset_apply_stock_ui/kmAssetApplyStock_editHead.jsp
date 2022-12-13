<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:replace name="title">
	<c:choose>
		<c:when test="${ kmAssetApplyStockForm.method_GET == 'add' }">
			<c:out value="${lfn:message('km-asset:table.kmAssetApplyStock.create') } - ${ lfn:message('km-asset:module.km.asset') }"></c:out>	
		</c:when>
		<c:otherwise>
			<c:out value="${kmAssetApplyStockForm.docSubject} - ${ lfn:message('km-asset:module.km.asset') }"></c:out>
		</c:otherwise>
	</c:choose>
</template:replace>
<template:replace name="toolbar">
       <ui:toolbar var-navwidth="90%" id="toolbar" layout="sys.ui.toolbar.float"> 
       	<c:if test="${kmAssetApplyStockForm.method_GET=='edit'}">
			<%-- 暂存 --%>
			<c:if test="${ kmAssetApplyStockForm.docStatus == '10'}">
			    <ui:button text="${ lfn:message('button.savedraft') }" order="2" 
										onclick="commitMethod('update', 'true');">
				</ui:button>
			</c:if>
			<%-- 提交 --%>
			<c:if test="${kmAssetApplyStockForm.docStatus=='10'||kmAssetApplyStockForm.docStatus=='11'||kmAssetApplyStockForm.docStatus=='20' }">
			    <ui:button text="${ lfn:message('button.submit') }" order="2" 
										onclick="commitMethod('update');" styleClass="lui_widget_btn_primary" isForcedAddClass="true">
				</ui:button>
			</c:if>
		</c:if>
		<c:if test="${kmAssetApplyStockForm.method_GET=='add'}">
			<%-- 暂存--%>
			<ui:button text="${ lfn:message('button.savedraft') }" order="2" 
										onclick="commitMethod('save', 'true');">
			</ui:button>
			<%--提交--%>
			<ui:button text="${ lfn:message('button.submit') }" order="2" 
										onclick="commitMethod('save');" styleClass="lui_widget_btn_primary" isForcedAddClass="true">
			</ui:button>
		</c:if>
	    <ui:button text="${ lfn:message('button.close') }" order="5"  onclick="Com_CloseWindow()">
		</ui:button>
	</ui:toolbar>
</template:replace>
<template:replace name="path">
	<ui:combin ref="menu.path.category">
		<ui:varParams 
		    moduleTitle="${ lfn:message('km-asset:module.km.asset') }" 
		    modulePath="/km/asset/" 
			modelName="com.landray.kmss.km.asset.model.KmAssetApplyTemplate" 
			autoFetch="false"	
			target="_blank"
			href="/km/asset/#j_path=/kmAsset_stock" 
			categoryId="${kmAssetApplyStockForm.fdApplyTemplateId}" />
	</ui:combin>
</template:replace>