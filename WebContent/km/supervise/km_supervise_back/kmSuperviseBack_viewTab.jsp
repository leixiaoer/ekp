<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:replace name="content">
    <c:choose>
		<c:when test="${param.approveModel eq 'right'}">
			<ui:tabpanel suckTop="true" layout="sys.ui.tabpanel.sucktop" var-count="5" var-average='false' var-useMaxWidth='true'>
				<c:import url="/km/supervise/km_supervise_back/kmSuperviseBack_viewContent.jsp" charEncoding="UTF-8">
	 		 		<c:param name="approveModel" value="${param.approveModel}"></c:param>
	  			</c:import>
			</ui:tabpanel>
		</c:when>
		<c:otherwise>
			<ui:tabpage expand="false" var-navwidth="90%">
				<c:import url="/km/supervise/km_supervise_back/kmSuperviseBack_viewContent.jsp" charEncoding="UTF-8">
	 		 	</c:import>
			</ui:tabpage>
		</c:otherwise>
	</c:choose>
</template:replace>
<c:choose>
	<c:when test="${param.approveModel eq 'right'}">
		<template:replace name="barRight">
			<c:choose>
				<c:when test="${kmSuperviseBackForm.docStatus>='30' || kmSuperviseBackForm.docStatus=='00'}">
					<ui:accordionpanel>
						<!-- 关联配置 -->
						<c:import url="/sys/relation/import/sysRelationMain_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmSuperviseBackForm" />
							<c:param name="approveType" value="right" />
							<c:param name="needTitle" value="true" />
						</c:import>
						<!-- 基本信息-->
						<c:import url="/km/supervise/km_supervise_back/kmSuperviseBack_viewBaseInfoContent.jsp" charEncoding="UTF-8"></c:import>
					</ui:accordionpanel>
				</c:when>
				<c:otherwise>
					<ui:tabpanel layout="sys.ui.tabpanel.vertical.icon" id="barRightPanel" >
						<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmSuperviseBackForm" />
							<c:param name="fdKey" value="kmSuperviseFeedback" />
							<c:param name="showHistoryOpers" value="true" />
							<c:param name="isExpand" value="true" />
							<c:param name="approveType" value="right" />
							<c:param name="approvePosition" value="right" />
						</c:import>
						<!-- 审批记录 -->
						<c:import url="/sys/lbpmservice/support/lbpm_audit_note/lbpmAuditNote_list_content.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmSuperviseBackForm" />
							<c:param name="fdModelId" value="${kmSuperviseBackForm.fdId}" />
							<c:param name="fdModelName" value="com.landray.kmss.km.supervise.model.KmSuperviseBack" />
						</c:import>
						<!-- 关联配置 -->
						<c:import url="/sys/relation/import/sysRelationMain_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmSuperviseBackForm" />
							<c:param name="approveType" value="right" />
							<c:param name="needTitle" value="true" />
						</c:import>
						<!-- 基本信息-->
						<c:import url="/km/supervise/km_supervise_back/kmSuperviseBack_viewBaseInfoContent.jsp" charEncoding="UTF-8"></c:import>
					</ui:tabpanel>
				</c:otherwise>
			</c:choose>
		</template:replace>
	</c:when>
	<c:otherwise>
		<template:replace name="nav">
			<ui:accordionpanel>
				<!-- 基本信息-->
				<c:import url="/km/supervise/km_supervise_back/kmSuperviseBack_viewBaseInfoContent.jsp" charEncoding="UTF-8">
				</c:import>
				<c:import url="/sys/relation/import/sysRelationMain_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmSuperviseBackForm" />
				</c:import>
			</ui:accordionpanel>
		</template:replace>
	</c:otherwise>
</c:choose>
