<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/lbpmservice/taglib/taglib.tld" prefix="lbpm"%>
<lbpm:lbpmApproveModel modelName="com.landray.kmss.km.supervise.model.KmSuperviseBack"></lbpm:lbpmApproveModel>
<c:choose>
	<c:when test="${lbpmApproveModel eq 'right'}">
		<template:include ref="lbpm.right" formName="kmSuperviseBackForm" formUrl="${KMSS_Parameter_ContextPath}km/supervise/km_supervise_back/kmSuperviseBack.do">
			<c:import url="/km/supervise/km_supervise_back/kmSuperviseBack_viewHead.jsp" charEncoding="UTF-8">
 		 	</c:import>
  			<c:choose>
  				<c:when test="${kmSuperviseBackForm.fdType eq '0'}">
  					<c:import url="/km/supervise/km_supervise_back/kmSuperviseBack_viewTab.jsp" charEncoding="UTF-8">
	 		 			<c:param name="approveModel" value="${lbpmApproveModel}"></c:param>
	  				</c:import>
  				</c:when>
  				<c:when test="${kmSuperviseBackForm.fdType eq '1'}">
  					<c:import url="/km/supervise/km_supervise_back/kmSuperviseBack_viewTab_stage.jsp" charEncoding="UTF-8">
	 		 			<c:param name="approveModel" value="${lbpmApproveModel}"></c:param>
	  				</c:import>
  				</c:when>
  			</c:choose>
		</template:include>
	</c:when>
	<c:otherwise>
		<template:include ref="default.view" sidebar="auto">
			<c:import url="/km/supervise/km_supervise_back/kmSuperviseBack_viewHead.jsp" charEncoding="UTF-8">
 		 	</c:import>
 		 	<c:choose>
 		 		<c:when test="${kmSuperviseBackForm.fdType eq '0'}">
 		 			<c:import url="/km/supervise/km_supervise_back/kmSuperviseBack_viewTab.jsp" charEncoding="UTF-8">
	  				</c:import>
 		 		</c:when>
 		 		<c:when test="${kmSuperviseBackForm.fdType eq '1'}">
 		 			<c:import url="/km/supervise/km_supervise_back/kmSuperviseBack_viewTab_stage.jsp" charEncoding="UTF-8">
	  				</c:import>
 		 		</c:when>
 		 	</c:choose>
		</template:include>
	</c:otherwise>
</c:choose>