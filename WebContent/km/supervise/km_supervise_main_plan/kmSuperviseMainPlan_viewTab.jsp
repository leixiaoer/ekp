<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:replace name="content">
    <c:choose>
		<c:when test="${param.approveModel eq 'right'}">
			<ui:tabpanel suckTop="true" layout="sys.ui.tabpanel.sucktop" var-count="5" var-average='false' var-useMaxWidth='true'>
				<c:import url="/km/supervise/km_supervise_main_plan/kmSuperviseMainPlan_viewContent.jsp" charEncoding="UTF-8">
	 		 		<c:param name="approveModel" value="${param.approveModel}"></c:param>
	  			</c:import>
			</ui:tabpanel>
		</c:when>
		<c:otherwise>
			<ui:tabpage expand="false" var-navwidth="90%">
				<c:import url="/km/supervise/km_supervise_main_plan/kmSuperviseMainPlan_viewContent.jsp" charEncoding="UTF-8">
	 		 	</c:import>
			</ui:tabpage>
		</c:otherwise>
	</c:choose>	
</template:replace>
<c:choose>
	<c:when test="${param.approveModel eq 'right'}">
		<template:replace name="barRight">
			<ui:tabpanel layout="sys.ui.tabpanel.vertical.icon" id="barRightPanel" >
				<%-- 流程 --%>
				<c:if test="${kmSuperviseMainPlanForm.docStatus !='10'}">
				<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmSuperviseMainPlanForm" />
					<c:param name="fdKey" value="kmSuperviseMakePlan" />
					<c:param name="showHistoryOpers" value="true" />
					<c:param name="isExpand" value="true" />
					<c:param name="approveType" value="right" />
					<c:param name="approvePosition" value="right" />
				</c:import>
				</c:if>
				<!-- 审批记录 -->
				<c:import url="/sys/lbpmservice/support/lbpm_audit_note/lbpmAuditNote_list_content.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmSuperviseMainPlanForm" />
					<c:param name="fdModelId" value="${kmSuperviseMainPlanForm.fdId}" />
					<c:param name="fdModelName" value="com.landray.kmss.km.supervise.model.KmSuperviseMain" />
				</c:import>
			</ui:tabpanel>
		</template:replace>
	</c:when>
</c:choose>
