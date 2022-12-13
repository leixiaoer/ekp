<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/lbpmservice/taglib/taglib.tld" prefix="lbpm"%>
<lbpm:lbpmApproveModel modelName="com.landray.kmss.km.carmng.model.KmCarmngApplication"></lbpm:lbpmApproveModel>
<c:choose>
	<c:when test="${lbpmApproveModel eq 'right'}">
		<template:include ref="lbpm.right" showQrcode="true"  formName="kmCarmngApplicationForm" formUrl="${KMSS_Parameter_ContextPath}km/carmng/km_carmng_application/kmCarmngApplication.do">
			<c:import url="/km/carmng/km_carmng_ui/kmCarmngApplication_viewHead.jsp" charEncoding="UTF-8">
 		 	</c:import>
 		 	<c:import url="/km/carmng/km_carmng_ui/kmCarmngApplication_viewTab.jsp" charEncoding="UTF-8">
 		 		<c:param name="approveModel" value="${lbpmApproveModel}"></c:param>
  			</c:import>
		</template:include>
	</c:when>
	<c:otherwise>
		<template:include ref="default.view" sidebar="auto">
			<c:import url="/km/carmng/km_carmng_ui/kmCarmngApplication_viewHead.jsp" charEncoding="UTF-8">
 		 	</c:import>
 		 	<c:import url="/km/carmng/km_carmng_ui/kmCarmngApplication_viewTab.jsp" charEncoding="UTF-8">
  			</c:import>
		</template:include>
	</c:otherwise>
</c:choose>
