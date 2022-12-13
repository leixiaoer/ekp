<%@page import="com.landray.kmss.sys.lbpmservice.support.model.LbpmSetting"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:replace name="title">
	<c:out value="${kmAssetApplyStockForm.docSubject} - ${ lfn:message('km-asset:module.km.asset')}"></c:out>
</template:replace>
<template:replace name="toolbar">
	<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" var-navwidth="90%">
	<c:if test="${kmAssetApplyStockForm.docStatus=='10' || kmAssetApplyStockForm.docStatus=='11'|| kmAssetApplyStockForm.docStatus=='20'}">
		<kmss:auth requestURL="/km/asset/km_asset_apply_stock/kmAssetApplyStock.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
		    <ui:button text="${ lfn:message('button.edit') }" order="2" 
						onclick="Com_OpenWindow('kmAssetApplyStock.do?method=edit&fdId=${JsParam.fdId}','_self');">
		    </ui:button>
		</kmss:auth>
	</c:if>
	<kmss:auth requestURL="/km/asset/km_asset_apply_stock/kmAssetApplyStock.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
	    <ui:button text="${ lfn:message('button.delete') }" order="2" 
						onclick="if(!confirmDelete())return;Com_OpenWindow('kmAssetApplyStock.do?method=delete&fdId=${JsParam.fdId}','_self');">
		</ui:button>
	</kmss:auth>
	<c:if test="${kmAssetApplyStockForm.docStatus!='10'}">
		<kmss:auth
			requestURL="/km/asset/km_asset_apply_stock/kmAssetApplyStock.do?method=print&fdId=${param.fdId}"
			requestMethod="GET">
			<ui:button text="${lfn:message('button.print') }" order="4" 
			    onclick="Com_OpenWindow('kmAssetApplyStock.do?method=print&fdId=${JsParam.fdId}','_blank');">
		    </ui:button>
		</kmss:auth>
   </c:if>
	  <ui:button text="${ lfn:message('button.close') }" order="5"  onclick="Com_CloseWindow()">
	  </ui:button>
	</ui:toolbar>
</template:replace>
<template:replace name="path">
	<ui:combin ref="menu.path.category">
		<ui:varParams  moduleTitle="${ lfn:message('km-asset:module.km.asset') }" 
		    modulePath="/km/asset/" 
			modelName="com.landray.kmss.km.asset.model.KmAssetApplyTemplate" 
		    autoFetch="false" 
		    href="/km/asset/#j_path=/kmAsset_stock" 
			categoryId="${kmAssetApplyStockForm.fdApplyTemplateId}" />
	</ui:combin>
</template:replace>