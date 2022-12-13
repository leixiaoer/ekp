<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:replace name="content">
    <c:choose>
		<c:when test="${param.approveModel eq 'right'}">
			<ui:tabpage collapsed="true" id="stopTabPage">
				<script>
					LUI.ready(function(){
						setTimeout(function(){
							var reviewTabPage = LUI("stopTabPage");
							if(reviewTabPage!=null){
								reviewTabPage.element.find(".lui_tabpage_float_collapse").hide();
								reviewTabPage.element.find(".lui_tabpage_float_navs_mark").hide();
							}
						},100)
					})
				</script>
	  			<c:import url="/km/supervise/km_supervise_main_stop/kmSuperviseMainStop_viewContent.jsp" charEncoding="UTF-8">
	 		 		<c:param name="contentType" value="xform"></c:param>
	  			</c:import>
			</ui:tabpage>
			
			<ui:tabpanel suckTop="true" layout="sys.ui.tabpanel.sucktop" var-count="5" var-average='false' var-useMaxWidth='true'
				var-supportExpand="true" var-expand="true">
				<c:import url="/km/supervise/km_supervise_main_stop/kmSuperviseMainStop_viewContent.jsp" charEncoding="UTF-8">
	 		 		<c:param name="contentType" value="other"></c:param>
	 		 		<c:param name="approveModel" value="${param.approveModel}"></c:param>
	  			</c:import>
			</ui:tabpanel>
		</c:when>
		<c:otherwise>
			<ui:tabpage expand="false" var-navwidth="90%">
				<c:import url="/km/supervise/km_supervise_main_stop/kmSuperviseMainStop_viewContent.jsp" charEncoding="UTF-8">
	 		 		<c:param name="contentType" value="xform"></c:param>
	 		 	</c:import>
	 		 	<c:import url="/km/supervise/km_supervise_main_stop/kmSuperviseMainStop_viewContent.jsp" charEncoding="UTF-8">
	 		 		<c:param name="contentType" value="other"></c:param>
	 		 		<c:param name="approveModel" value="${param.approveModel}"></c:param>
	  			</c:import>
			</ui:tabpage>
		</c:otherwise>
	</c:choose>
	<script>
	function deleteDoc(delUrl) {
        seajs.use(['lui/dialog'], function(dialog) {
        	Com_Delete_Get(delUrl, 'com.landray.kmss.km.supervise.model.KmSuperviseMainStop');
        });
    }
	</script>
</template:replace>
<c:choose>
	<c:when test="${param.approveModel eq 'right'}">
		<template:replace name="barRight">
			<c:choose>
				<c:when test="${kmSuperviseMainStopForm.docStatus>='30' || kmSuperviseMainStopForm.docStatus=='00'}">
					<ui:accordionpanel>
					<!-- 基本信息-->
					<c:import url="/km/supervise/km_supervise_main_stop/kmSuperviseMainStop_viewBaseInfoContent.jsp" charEncoding="UTF-8"></c:import>
					</ui:accordionpanel>
				</c:when>
				<c:otherwise>
					<ui:tabpanel layout="sys.ui.tabpanel.vertical.icon" id="barRightPanel" >
						<%-- 流程 --%>
						<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmSuperviseMainStopForm" />
							<c:param name="fdKey" value="kmSuperviseTermination" />
							<c:param name="showHistoryOpers" value="true" />
							<c:param name="isExpand" value="true" />
							<c:param name="approveType" value="right" />
							<c:param name="approvePosition" value="right" />
						</c:import>
						<!-- 审批记录 -->
						<c:import url="/sys/lbpmservice/support/lbpm_audit_note/lbpmAuditNote_list_content.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmSuperviseMainStopForm" />
							<c:param name="fdModelId" value="${kmSuperviseMainStopForm.fdId}" />
							<c:param name="fdModelName" value="com.landray.kmss.km.supervise.model.KmSuperviseMainStop" />
						</c:import>
						<!-- 基本信息-->
						<c:import url="/km/supervise/km_supervise_main_stop/kmSuperviseMainStop_viewBaseInfoContent.jsp" charEncoding="UTF-8">
						</c:import>
					</ui:tabpanel>
				</c:otherwise>
			</c:choose>
		</template:replace>
	</c:when>
	<c:otherwise>
		<template:replace name="nav">
			<ui:accordionpanel>
				<!-- 基本信息-->
				<c:import url="/km/supervise/km_supervise_main_stop/kmSuperviseMainStop_viewBaseInfoContent.jsp" charEncoding="UTF-8">
				</c:import>
			</ui:accordionpanel>
		</template:replace>
	</c:otherwise>
</c:choose>

