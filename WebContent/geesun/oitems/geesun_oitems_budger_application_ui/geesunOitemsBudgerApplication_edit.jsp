<%@ page
	language="java"
	contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/lbpmservice/taglib/taglib.tld" prefix="lbpm"%>
<lbpm:lbpmApproveModel modelName="com.landray.kmss.geesun.oitems.model.GeesunOitemsBudgerApplication"></lbpm:lbpmApproveModel>
<c:choose> 
	<c:when test="${lbpmApproveModel eq 'right'}">
		<template:include ref="lbpm.right" isShowQrcode="${param.method eq 'change'?false:true }" isEdit="true" fdUseForm="false" formName="geesunOitemsBudgerApplicationForm" formUrl="${KMSS_Parameter_ContextPath}geesun/oitems/geesun_oitems_budger_application/geesunOitemsBudgerApplication.do">
			<c:import url="/geesun/oitems/geesun_oitems_budger_application_ui/geesunOitemsBudgerApplication_editHead.jsp" charEncoding="UTF-8">
				<c:param name="approveModel" value="${lbpmApproveModel}"></c:param>
 		 	</c:import>
 		 	<c:import url="/geesun/oitems/geesun_oitems_budger_application_ui/geesunOitemsBudgerApplication_editTab_right.jsp" charEncoding="UTF-8">
 		 		<c:param name="approveModel" value="${lbpmApproveModel}"></c:param>
  			</c:import>
		</template:include>
	</c:when>
	<c:otherwise>
		<template:include ref="default.edit" sidebar="auto" showQrcode="${param.method eq 'change'?false:true }">
			<c:import url="/geesun/oitems/geesun_oitems_budger_application_ui/geesunOitemsBudgerApplication_editHead.jsp" charEncoding="UTF-8">
 		 	</c:import>
 		 	<c:import url="/geesun/oitems/geesun_oitems_budger_application_ui/geesunOitemsBudgerApplication_editTab.jsp" charEncoding="UTF-8">
  			</c:import>
		</template:include>
	</c:otherwise>
</c:choose>
