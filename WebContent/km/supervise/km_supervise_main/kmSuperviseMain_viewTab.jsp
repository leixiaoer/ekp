<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:replace name="content">
   	<%-- 软删除 --%>
	<c:import url="/sys/recycle/import/redirect.jsp">
		<c:param name="formBeanName" value="kmSuperviseMainForm"></c:param>
	</c:import>
	<c:if test="${param.approveModel ne 'right'}">
    	<c:if test="${kmSuperviseMainForm.docUseXform == 'true' || empty kmSuperviseMainForm.docUseXform}">
			<form name="kmSuperviseMainForm" method="post" action="<c:url value='/km/supervise/km_supervise_main/kmSuperviseMain.do'/>">
		</c:if>
	</c:if>
		<xform:text property="fdId" showStatus="noShow"/>	
		<xform:text property="fdIsNew" showStatus="noShow"/>
		<xform:text property="fdIsPlan" showStatus="noShow"/>
		<xform:text property="docSubject" showStatus="noShow"/>
		<xform:text property="docStatus" showStatus="noShow"/>
		<xform:text property="method_GET" showStatus="noShow"/>

       <c:choose>
		<c:when test="${param.approveModel eq 'right'}">
			<ui:tabpanel suckTop="true" layout="sys.ui.tabpanel.sucktop" var-count="5" var-average='false' var-useMaxWidth='true'>
				<c:import url="/km/supervise/km_supervise_main/kmSuperviseMain_viewContent.jsp" charEncoding="UTF-8">
	 		 		<c:param name="approveModel" value="${param.approveModel}"></c:param>
	  			</c:import>
			</ui:tabpanel>
		</c:when>
		<c:otherwise>
			<ui:tabpage expand="false" var-navwidth="90%">
				<c:import url="/km/supervise/km_supervise_main/kmSuperviseMain_viewContent.jsp" charEncoding="UTF-8">
	 		 	</c:import>
			</ui:tabpage>
			<c:if test="${kmSuperviseMainForm.docUseXform == 'true' || empty kmSuperviseMainForm.docUseXform}">
				</form>
			</c:if>	
		</c:otherwise>
	</c:choose>	
</template:replace>
<c:choose>
	<c:when test="${param.approveModel eq 'right'}">
		<template:replace name="barRight">
			<c:choose>
				<c:when test="${kmSuperviseMainForm.docStatus>='30' || kmSuperviseMainForm.docStatus=='10' || kmSuperviseMainForm.docStatus=='00'}">
					<ui:accordionpanel>
						<!-- 关联配置 -->
						<c:import url="/sys/relation/import/sysRelationMain_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmSuperviseMainForm" />
							<c:param name="approveType" value="right" />
						</c:import>
						<!-- 基本信息-->
						<c:import url="/km/supervise/km_supervise_main/kmSuperviseMain_viewBaseInfoContent.jsp" charEncoding="UTF-8">
						</c:import>
					</ui:accordionpanel>
				</c:when>
				<c:otherwise>
					<ui:tabpanel layout="sys.ui.tabpanel.vertical.icon" id="barRightPanel" >
						<%-- 流程 --%>
						<c:choose>
							<c:when test="${kmSuperviseMainForm.docUseXform == 'true' || empty kmSuperviseMainForm.docUseXform}">
								<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
									<c:param name="formName" value="kmSuperviseMainForm" />
									<c:param name="fdKey" value="kmSuperviseMain" />
									<c:param name="showHistoryOpers" value="true" />
									<c:param name="onClickSubmitButton" value="Com_Submit(document.kmSuperviseMainForm, 'publishDraft');" />
									<c:param name="isExpand" value="true" />
									<c:param name="approveType" value="right" />
									<c:param name="approvePosition" value="right" />
								</c:import>
							</c:when>
							<c:otherwise>
								<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
									<c:param name="formName" value="kmSuperviseMainForm" />
									<c:param name="fdKey" value="kmSuperviseMain" />
									<c:param name="showHistoryOpers" value="true" />
									<c:param name="isExpand" value="true" />
									<c:param name="approveType" value="right" />
									<c:param name="approvePosition" value="right" />
								</c:import>
							</c:otherwise>
						</c:choose>
						<!-- 审批记录 -->
						<c:import url="/sys/lbpmservice/support/lbpm_audit_note/lbpmAuditNote_list_content.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmSuperviseMainForm" />
							<c:param name="fdModelId" value="${kmSuperviseMainForm.fdId}" />
							<c:param name="fdModelName" value="com.landray.kmss.km.supervise.model.KmSuperviseMain" />
						</c:import>
						<!-- 关联配置 -->
						<c:import url="/sys/relation/import/sysRelationMain_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmSuperviseMainForm" />
							<c:param name="approveType" value="right" />
							<c:param name="needTitle" value="true" />
						</c:import>
						<!-- 基本信息-->
						<c:import url="/km/supervise/km_supervise_main/kmSuperviseMain_viewBaseInfoContent.jsp" charEncoding="UTF-8">
						</c:import>
					</ui:tabpanel>
				</c:otherwise>
			</c:choose>
		</template:replace>
	</c:when>
	<c:otherwise>
		<template:replace name="nav">
			<c:import url="/sys/relation/import/sysRelationMain_view.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmSuperviseMainForm" />
			</c:import>
		</template:replace>
	</c:otherwise>
</c:choose>