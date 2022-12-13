<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:replace name="content">
	<script type="text/javascript">
Com_IncludeFile("calendar.js");
</script>
<script language="JavaScript">
// 提交表单
function commitMethod(method, saveDraft){
	var docStatus = document.getElementsByName("docStatus")[0];
	if (saveDraft != null && saveDraft == 'true'){
		docStatus.value = "10";
	} else {
		docStatus.value = "20";
	}
	Com_Submit(document.kmAssetApplyChangeForm, method);
}
</script>
	<c:if test="${param.approveModel ne 'right'}">
		<form name="kmAssetApplyChangeForm" method="post" action ="${KMSS_Parameter_ContextPath}km/asset/km_asset_apply_change/kmAssetApplyChange.do">
	</c:if>
		 <html:hidden property="fdId" />
		 <html:hidden property="fdCreatorId" />
		 <html:hidden property="fdDeptId" />
		 <html:hidden property="fdCreateDate" />
		 <html:hidden property="method_GET" />
		 <html:hidden property="docStatus"/>
		 <html:hidden property="titleRegulation" />
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
					<c:import url="/km/asset/km_asset_apply_change_ui/kmAssetApplyChange_editContent.jsp" charEncoding="UTF-8">
		 		 		<c:param name="contentType" value="baseInfo"></c:param>
		  			</c:import>
				</ui:tabpage>
				<ui:tabpanel suckTop="true" layout="sys.ui.tabpanel.sucktop" var-supportExpand="true" var-extend="true" var-average='false' var-useMaxWidth='true'>
					<%--流程--%>
					<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmAssetApplyChangeForm" />
						<c:param name="fdKey" value="KmAssetApplyChangeDoc" />
						<c:param name="showHistoryOpers" value="true" />
						<c:param name="isExpand" value="true" />
						<c:param name="approveType" value="right" />
					</c:import>
					<c:import url="/km/asset/km_asset_apply_change_ui/kmAssetApplyChange_editContent.jsp" charEncoding="UTF-8">
		 		 		<c:param name="contentType" value="other"></c:param>
		 		 		<c:param name="approveModel" value="${param.approveModel}"></c:param>
		  			</c:import>
				</ui:tabpanel>
			</c:when>
			<c:otherwise>
				<ui:tabpage expand="false" var-navwidth="90%" >
					<c:import url="/km/asset/km_asset_apply_change_ui/kmAssetApplyChange_editContent.jsp" charEncoding="UTF-8">
		 		 		<c:param name="contentType" value="baseInfo"></c:param>
		  			</c:import>
					<c:import url="/km/asset/km_asset_apply_change_ui/kmAssetApplyChange_editContent.jsp" charEncoding="UTF-8">
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
					<c:param name="formName" value="kmAssetApplyChangeForm" />
					<c:param name="fdKey" value="KmAssetApplyChangeDoc" />
					<c:param name="showHistoryOpers" value="true" />
					<c:param name="isExpand" value="true" />
					<c:param name="approveType" value="right" />
					<c:param name="approvePosition" value="right" />
				</c:import>
				<!-- 关联机制(与原有机制有差异) -->
				<c:import url="/sys/relation/import/sysRelationMain_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyChangeForm" />
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
				<c:param name="formName" value="kmAssetApplyChangeForm" />
			</c:import>
		</template:replace>
	</c:otherwise>
</c:choose>