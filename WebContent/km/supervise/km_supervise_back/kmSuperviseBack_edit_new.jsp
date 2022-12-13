<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/lbpmservice/taglib/taglib.tld" prefix="lbpm"%>
<lbpm:lbpmApproveModel modelName="com.landray.kmss.km.supervise.model.KmSuperviseBack"></lbpm:lbpmApproveModel>
 
<c:choose>
	<c:when test="${lbpmApproveModel eq 'right'}">
		<template:include ref="lbpm.right" isEdit="true" formName="kmSuperviseBackForm" formUrl="${KMSS_Parameter_ContextPath}km/supervise/km_supervise_back/kmSuperviseBack.do">
			<c:import url="/km/supervise/km_supervise_back/kmSuperviseBack_editHead.jsp" charEncoding="UTF-8">
				<c:param name="approveModel" value="${lbpmApproveModel}"></c:param>
 		 	</c:import>
 		 	<c:if test="${kmSuperviseBackForm.fdType eq '0'}">
	 		 	<c:import url="/km/supervise/km_supervise_back/kmSuperviseBack_editTab.jsp" charEncoding="UTF-8">
	 		 		<c:param name="approveModel" value="${lbpmApproveModel}"></c:param>
	  			</c:import>
  			</c:if>
  			<c:if test="${kmSuperviseBackForm.fdType eq '1'}">
	 		 	<c:import url="/km/supervise/km_supervise_back/kmSuperviseBack_editTab_stage.jsp" charEncoding="UTF-8">
	 		 		<c:param name="approveModel" value="${lbpmApproveModel}"></c:param>
	  			</c:import>
  			</c:if>
		</template:include>
	</c:when>
	<c:otherwise>
		<template:include ref="default.edit" sidebar="auto">
			<c:import url="/km/supervise/km_supervise_back/kmSuperviseBack_editHead.jsp" charEncoding="UTF-8">
 		 	</c:import>
 		 	<c:if test="${kmSuperviseBackForm.fdType eq '0'}">
	 		 	<c:import url="/km/supervise/km_supervise_back/kmSuperviseBack_editTab.jsp" charEncoding="UTF-8">
	  			</c:import>
  			</c:if>
  			<c:if test="${kmSuperviseBackForm.fdType eq '1'}">
	 		 	<c:import url="/km/supervise/km_supervise_back/kmSuperviseBack_editTab_stage.jsp" charEncoding="UTF-8">
	  			</c:import>
  			</c:if>
		</template:include>
	</c:otherwise>
</c:choose>