<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/lbpmservice/taglib/taglib.tld" prefix="lbpm"%>
<lbpm:lbpmApproveModel modelName="com.landray.kmss.km.smissive.model.KmSmissiveMain"></lbpm:lbpmApproveModel>
<c:choose>
	<c:when test="${lbpmApproveModel eq 'right'}">
		<template:include ref="lbpm.right" isShowQrcode="false" isEdit="true" formName="kmSmissiveMainForm" formUrl="${KMSS_Parameter_ContextPath}km/smissive/km_smissive_main/kmSmissiveMain.do">
			<c:import url="/km/smissive/km_smissive_main_ui/kmSmissiveMain_editHead.jsp" charEncoding="UTF-8">
				<c:param name="approveModel" value="${lbpmApproveModel}"></c:param>
 		 	</c:import>
 		 	<c:import url="/km/smissive/km_smissive_main_ui/kmSmissiveMain_editTab.jsp" charEncoding="UTF-8">
 		 		<c:param name="approveModel" value="${lbpmApproveModel}"></c:param>
  			</c:import>
		</template:include>
	</c:when>
	<c:otherwise>
		<template:include ref="default.edit" sidebar="auto" showQrcode="false">
			<c:import url="/km/smissive/km_smissive_main_ui/kmSmissiveMain_editHead.jsp" charEncoding="UTF-8">
 		 	</c:import>
 		 	<c:import url="/km/smissive/km_smissive_main_ui/kmSmissiveMain_editTab.jsp" charEncoding="UTF-8">
  			</c:import>
		</template:include>
	</c:otherwise>
</c:choose>
