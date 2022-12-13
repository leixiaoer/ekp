<%@ page
	language="java"
	contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/lbpmservice/taglib/taglib.tld" prefix="lbpm"%>
<lbpm:lbpmApproveModel modelName="com.landray.kmss.km.oitems.model.KmOitemsBudgerApplication"></lbpm:lbpmApproveModel>
<c:choose> 
	<c:when test="${lbpmApproveModel eq 'right'}">
		<template:include ref="lbpm.right" isShowQrcode="${param.method eq 'change'?false:true }" isEdit="true" fdUseForm="false" formName="kmOitemsBudgerApplicationForm" formUrl="${KMSS_Parameter_ContextPath}km/oitems/km_oitems_budger_application/kmOitemsBudgerApplication.do">
			<c:import url="/km/oitems/km_oitems_budger_application_ui/kmOitemsBudgerApplication_editHead.jsp" charEncoding="UTF-8">
				<c:param name="approveModel" value="${lbpmApproveModel}"></c:param>
 		 	</c:import>
 		 	<c:import url="/km/oitems/km_oitems_budger_application_ui/kmOitemsBudgerApplication_editTab_right.jsp" charEncoding="UTF-8">
 		 		<c:param name="approveModel" value="${lbpmApproveModel}"></c:param>
  			</c:import>
		</template:include>
	</c:when>
	<c:otherwise>
		<template:include ref="default.edit" sidebar="auto" showQrcode="${param.method eq 'change'?false:true }">
			<c:import url="/km/oitems/km_oitems_budger_application_ui/kmOitemsBudgerApplication_editHead.jsp" charEncoding="UTF-8">
 		 	</c:import>
 		 	<c:import url="/km/oitems/km_oitems_budger_application_ui/kmOitemsBudgerApplication_editTab.jsp" charEncoding="UTF-8">
  			</c:import>
		</template:include>
	</c:otherwise>
</c:choose>
