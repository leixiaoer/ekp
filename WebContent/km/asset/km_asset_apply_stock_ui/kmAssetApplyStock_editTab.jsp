<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:replace name="content">
	<%@include file="/km/asset/resource/chinaValue.jsp"%>
	<script>
		Com_IncludeFile("doclist.js|calendar.js");
		Com_IncludeFile("providerDialog.js",Com_Parameter.ContextPath+"km/provider/resource/js/","js",true); 
	</script>
	<script>
		//防止通过URL直接进入页面而没有选择类别
		var fdModelId='${JsParam.fdModelId}';
		var fdModelName='${JsParam.fdModelName}';
		var url='<c:url value="/km/asset/km_asset_apply_stock/kmAssetApplyStock.do" />?method=add&fdTemplateId=!{id}&fdTemplateName=!{name}';
		if(fdModelId!=null&&fdModelName!=''){
				url+="&fdModelId="+fdModelId+"&fdModelName="+fdModelName;
			}   
		Com_NewFile('com.landray.kmss.km.asset.model.KmAssetApplyTemplate',url);
	
	
		// 提交表单
		function commitMethod(method, saveDraft){
			var TABLE_DocList=document.getElementById("TABLE_DocList");
			if(TABLE_DocList.getElementsByTagName("input").length==0){
				alert("<bean:message bundle='km-asset' key='kmAssetApplyStockList.noList' />");
				return;
			}
			var docStatus = document.getElementsByName("docStatus")[0];
			if (saveDraft != null && saveDraft == 'true'){
				docStatus.value = "10";
			} else {
				docStatus.value = "20";
			}
			Com_Submit(document.kmAssetApplyStockForm, method);
		}
	</script>
	<c:if test="${param.approveModel ne 'right'}">
		<form name="kmAssetApplyStockForm" method="post" action ="${KMSS_Parameter_ContextPath}km/asset/km_asset_apply_stock/kmAssetApplyStock.do" enctype="multipart/form-data">
	</c:if>
        <html:hidden property="fdId" />
		<html:hidden property="docStatus" />
		<html:hidden property="method_GET" />
		<html:hidden property="fdCreatorId" />
		<html:hidden property="fdDeptId" />
		<html:hidden property="fdCreateDate" />
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
					<c:import url="/km/asset/km_asset_apply_stock_ui/kmAssetApplyStock_editContent.jsp" charEncoding="UTF-8">
		 		 		<c:param name="contentType" value="baseInfo"></c:param>
		  			</c:import>
				</ui:tabpage>
				<ui:tabpanel suckTop="true" layout="sys.ui.tabpanel.sucktop" var-supportExpand="true" var-extend="true" var-average='false' var-useMaxWidth='true'>
					<%--流程--%>
					<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmAssetApplyStockForm" />
						<c:param name="fdKey" value="KmAssetApplyStockDoc" />
						<c:param name="showHistoryOpers" value="true" />
						<c:param name="isExpand" value="true" />
						<c:param name="approveType" value="right" />
					</c:import>
					<c:import url="/km/asset/km_asset_apply_stock_ui/kmAssetApplyStock_editContent.jsp" charEncoding="UTF-8">
		 		 		<c:param name="contentType" value="other"></c:param>
		 		 		<c:param name="approveModel" value="${param.approveModel}"></c:param>
		  			</c:import>
				</ui:tabpanel>
			</c:when>
			<c:otherwise>
				<ui:tabpage expand="false" var-navwidth="90%" >
					<c:import url="/km/asset/km_asset_apply_stock_ui/kmAssetApplyStock_editContent.jsp" charEncoding="UTF-8">
		 		 		<c:param name="contentType" value="baseInfo"></c:param>
		  			</c:import>
					<c:import url="/km/asset/km_asset_apply_stock_ui/kmAssetApplyStock_editContent.jsp" charEncoding="UTF-8">
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
					<c:param name="formName" value="kmAssetApplyStockForm" />
					<c:param name="fdKey" value="KmAssetApplyStockDoc" />
					<c:param name="showHistoryOpers" value="true" />
					<c:param name="isExpand" value="true" />
					<c:param name="approveType" value="right" />
					<c:param name="approvePosition" value="right" />
				</c:import>
				<!-- 关联机制(与原有机制有差异) -->
				<c:import url="/sys/relation/import/sysRelationMain_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyStockForm" />
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
				<c:param name="formName" value="kmAssetApplyStockForm" />
			</c:import>
		</template:replace>
	</c:otherwise>
</c:choose>