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
	<c:choose>
		<c:when test="${kmAssetApplyTaskForm.method_GET == 'add' }">
			<c:out value="${ lfn:message('operation.create') } - ${ lfn:message('km-asset:module.km.asset') }"></c:out>	
		</c:when>
		<c:otherwise>
				<c:out value="${kmAssetApplyTaskForm.docSubject} - "/>
			<c:out value="${ lfn:message('km-asset:module.km.asset') }"></c:out>
		</c:otherwise>
	</c:choose>
</template:replace>
<template:replace name="toolbar">
	<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="3"> 
		<c:if test="${kmAssetApplyTaskForm.method_GET=='edit'}">
			<%-- 暂存 --%>
			<c:if test="${ kmAssetApplyTaskForm.docStatus == '10'}">
				<ui:button text="${ lfn:message('button.savedraft') }" onclick="commitMethod('update', 'true');"></ui:button>
			</c:if>
			<%-- 提交 --%>
			<c:if test="${kmAssetApplyTaskForm.docStatus=='10'||kmAssetApplyTaskForm.docStatus=='11'||kmAssetApplyTaskForm.docStatus=='20' }">
				<ui:button text="${ lfn:message('button.submit') }" onclick="commitMethod('update');" styleClass="lui_widget_btn_primary" isForcedAddClass="true"></ui:button>	
			</c:if>
		</c:if>
		<c:if test="${kmAssetApplyTaskForm.method_GET=='add'}">
			<%-- 暂存--%>
			<ui:button text="${ lfn:message('button.savedraft') }" onclick="commitMethod('save', 'true');"></ui:button>
			<%--提交--%>
			<ui:button text="${ lfn:message('button.submit') }" onclick="commitMethod('save');"></ui:button>
		</c:if>
		<ui:button text="${ lfn:message('button.close') }" onclick="Com_CloseWindow();"></ui:button>	
	</ui:toolbar>
</template:replace>
<template:replace name="path">			
	<ui:menu layout="sys.ui.menu.nav"> 
		<ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home">
		</ui:menu-item>	
		<ui:menu-item text="${ lfn:message('km-asset:module.km.asset') }">
		</ui:menu-item>
	</ui:menu>
</template:replace>