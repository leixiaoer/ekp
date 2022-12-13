<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/resource/jsp/error_import.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/lbpmservice/taglib/taglib.tld" prefix="lbpm"%>
<lbpm:lbpmApproveModel modelName="com.landray.kmss.km.asset.model.KmAssetApplyReturn"></lbpm:lbpmApproveModel>
<c:choose>
	<c:when test="${lbpmApproveModel eq 'right'}">
		<template:include ref="lbpm.right" showQrcode="true" fdUseForm="false" formName="kmAssetApplyReturnForm" formUrl="${KMSS_Parameter_ContextPath}km/asset/km_asset_apply_return/kmAssetApplyReturn.do">
			<c:import url="/km/asset/km_asset_apply_return_ui/kmAssetApplyReturn_viewHead.jsp" charEncoding="UTF-8">
 		 	</c:import>
 		 	<c:import url="/km/asset/km_asset_apply_return_ui/kmAssetApplyReturn_viewTab.jsp" charEncoding="UTF-8">
 		 		<c:param name="approveModel" value="${lbpmApproveModel}"></c:param>
  			</c:import>
		</template:include>
	</c:when>
	<c:otherwise>
		<template:include ref="default.view" sidebar="auto">
			<c:import url="/km/asset/km_asset_apply_return_ui/kmAssetApplyReturn_viewHead.jsp" charEncoding="UTF-8">
 		 	</c:import>
 		 	<c:import url="/km/asset/km_asset_apply_return_ui/kmAssetApplyReturn_viewTab.jsp" charEncoding="UTF-8">
  			</c:import>
		</template:include>
	</c:otherwise>
</c:choose>