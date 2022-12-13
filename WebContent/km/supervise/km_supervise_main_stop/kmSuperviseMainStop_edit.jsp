<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/lbpmservice/taglib/taglib.tld" prefix="lbpm"%>
<lbpm:lbpmApproveModel modelName="com.landray.kmss.km.supervise.model.KmSuperviseMainStop"></lbpm:lbpmApproveModel>
 
<c:choose>
	<c:when test="${lbpmApproveModel eq 'right'}">
		<template:include ref="lbpm.right" isEdit="true" formName="kmSuperviseMainStopForm" formUrl="${KMSS_Parameter_ContextPath}km/supervise/km_supervise_main_stop/kmSuperviseMainStop.do">
			<c:import url="/km/supervise/km_supervise_main_stop/kmSuperviseMainStop_editHead.jsp" charEncoding="UTF-8">
				<c:param name="approveModel" value="${lbpmApproveModel}"></c:param>
 		 	</c:import>
 		 	<c:import url="/km/supervise/km_supervise_main_stop/kmSuperviseMainStop_editTab.jsp" charEncoding="UTF-8">
 		 		<c:param name="approveModel" value="${lbpmApproveModel}"></c:param>
  			</c:import>
		</template:include>
	</c:when>
	<c:otherwise>
		<template:include ref="default.edit" sidebar="auto">
			<c:import url="/km/supervise/km_supervise_main_stop/kmSuperviseMainStop_editHead.jsp" charEncoding="UTF-8">
 		 	</c:import>
 		 	<c:import url="/km/supervise/km_supervise_main_stop/kmSuperviseMainStop_editTab.jsp" charEncoding="UTF-8">
  			</c:import>
		</template:include>
	</c:otherwise>
</c:choose>