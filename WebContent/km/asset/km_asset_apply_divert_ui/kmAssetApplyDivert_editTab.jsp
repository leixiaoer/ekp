<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:replace name="content">
	<script>
		Com_IncludeFile("xform.js|doclist.js");
		Com_IncludeFile("calendar.js");
		
		// 提交表单
		function commitMethod(method, saveDraft){
			var docStatus = document.getElementsByName("docStatus")[0];
			if (saveDraft != null && saveDraft == 'true'){
				docStatus.value = "10";
			} else {
				docStatus.value = "20";
			}
			setTextRequired();
			Com_Submit(document.kmAssetApplyDivertForm, method);
		}
	</script>
	<c:if test="${param.approveModel ne 'right'}">
		<form name="kmAssetApplyDivertForm" method="post" action ="${KMSS_Parameter_ContextPath}km/asset/km_asset_apply_divert/kmAssetApplyDivert.do">
	</c:if>
		<html:hidden property="fdId" />
		<html:hidden property="docStatus" value="20"/>
		<html:hidden property="titleRegulation" />
		<html:hidden property="method_GET" />
		<c:choose>
			<c:when test="${param.approveModel eq 'right'}">
				<ui:tabpage collapsed="true" id="reviewTabPage">
					<script>
						LUI.ready(function(){
							setTimeout(function(){
								var reviewTabPage = LUI("reviewTabPage");
								if(reviewTabPage!=null){
									reviewTabPage.element.find(".lui_tabpage_float_collapse").hide();
									reviewTabPage.element.find(".lui_tabpage_float_navs_mark").hide();
								}
							},100)
						})
					</script>
					<c:import url="/km/asset/km_asset_apply_divert_ui/kmAssetApplyDivert_editContent.jsp" charEncoding="UTF-8">
		 		 		<c:param name="contentType" value="baseInfo"></c:param>
		  			</c:import>
				</ui:tabpage>
				<ui:tabpanel suckTop="true" layout="sys.ui.tabpanel.sucktop" var-supportExpand="true" var-extend="true" var-average='false' var-useMaxWidth='true'>
					<%--流程--%>
					<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmAssetApplyDivertForm" />
						<c:param name="fdKey" value="KmAssetApplyDivertDoc" />
						<c:param name="showHistoryOpers" value="true" />
						<c:param name="isExpand" value="true" />
						<c:param name="approveType" value="right" />
					</c:import>
					<c:import url="/km/asset/km_asset_apply_divert_ui/kmAssetApplyDivert_editContent.jsp" charEncoding="UTF-8">
		 		 		<c:param name="contentType" value="other"></c:param>
		 		 		<c:param name="approveModel" value="${param.approveModel}"></c:param>
		  			</c:import>
				</ui:tabpanel>
			</c:when>
			<c:otherwise>
				<ui:tabpage expand="false" var-navwidth="90%" >
					<c:import url="/km/asset/km_asset_apply_divert_ui/kmAssetApplyDivert_editContent.jsp" charEncoding="UTF-8">
		 		 		<c:param name="contentType" value="baseInfo"></c:param>
		  			</c:import>
					<c:import url="/km/asset/km_asset_apply_divert_ui/kmAssetApplyDivert_editContent.jsp" charEncoding="UTF-8">
		 		 		<c:param name="contentType" value="other"></c:param>
		  			</c:import>
				</ui:tabpage>
				</form>
			</c:otherwise>
		</c:choose>
</template:replace>
<c:choose>
	<c:when test="${param.approveModel eq 'right'}">
		<template:replace name="barRight">
			<ui:tabpanel layout="sys.ui.tabpanel.vertical.icon" id="barRightPanel">
				<%--流程--%>
				<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyDivertForm" />
					<c:param name="fdKey" value="KmAssetApplyDivertDoc" />
					<c:param name="showHistoryOpers" value="true" />
					<c:param name="isExpand" value="true" />
					<c:param name="approveType" value="right" />
					<c:param name="approvePosition" value="right" />
				</c:import>
				<!-- 关联机制(与原有机制有差异) -->
				<c:import url="/sys/relation/import/sysRelationMain_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyDivertForm" />
					<c:param name="approveType" value="right" />
					<c:param name="needTitle" value="true" />
				</c:import>
			</ui:tabpanel>
		</template:replace>
	</c:when>
	<c:otherwise>
		<template:replace name="nav">
			<%--关联机制(与原有机制有差异)--%>
			<c:import url="/sys/relation/import/sysRelationMain_edit.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmAssetApplyDivertForm" />
			</c:import>
		</template:replace>
	</c:otherwise>
</c:choose>