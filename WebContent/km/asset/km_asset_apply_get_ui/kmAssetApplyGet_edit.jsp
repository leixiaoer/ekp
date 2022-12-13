<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/lbpmservice/taglib/taglib.tld" prefix="lbpm"%>
<lbpm:lbpmApproveModel modelName="com.landray.kmss.km.asset.model.KmAssetApplyGet"></lbpm:lbpmApproveModel>
<c:choose>
	<c:when test="${lbpmApproveModel eq 'right'}">
		<template:include ref="lbpm.right" isShowQrcode="false" isEdit="true" fdUseForm="false" formName="kmAssetApplyGetForm" formUrl="${KMSS_Parameter_ContextPath}km/asset/km_asset_apply_get/kmAssetApplyGet.do">
			<c:import url="/km/asset/km_asset_apply_get_ui/kmAssetApplyGet_editHead.jsp" charEncoding="UTF-8">
				<c:param name="approveModel" value="${lbpmApproveModel}"></c:param>
 		 	</c:import>
 		 	<c:import url="/km/asset/km_asset_apply_get_ui/kmAssetApplyGet_editTab.jsp" charEncoding="UTF-8">
 		 		<c:param name="approveModel" value="${lbpmApproveModel}"></c:param>
  			</c:import>
		</template:include>
	</c:when>
	<c:otherwise>
		<template:include ref="default.edit" sidebar="auto" showQrcode="false">
			<c:import url="/km/asset/km_asset_apply_get_ui/kmAssetApplyGet_editHead.jsp" charEncoding="UTF-8">
 		 	</c:import>
 		 	<c:import url="/km/asset/km_asset_apply_get_ui/kmAssetApplyGet_editTab.jsp" charEncoding="UTF-8">
  			</c:import>
		</template:include>
	</c:otherwise>
</c:choose>
<%@ include file="/km/asset/km_asset_apply_base/kmAssetApplyBase_common.jsp"%>