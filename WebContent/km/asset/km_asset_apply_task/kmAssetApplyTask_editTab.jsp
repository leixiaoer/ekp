<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:replace name="content">
	<script type="text/javascript">
		Com_IncludeFile("common.js|jquery.js|dialog.js|xform.js|doclist.js");
		Com_IncludeFile("calendar.js");
		
		// 重新渲染DIV
		function reRenderDir(obj){
			var assignUser = $("select[name='fdAssignUser']").val();
			var purchaseTime = $("select[name='fdPurchaseTime']").val();
			
			if(assignUser == "2" || assignUser == "3"){
				 $("div .assignUserCtl").show();
			}else{
				$("div .assignUserCtl").hide();
			}
			if(purchaseTime == "2"){
				$("div .purchaseTimeCtl").show();
			}else{
				$("div .purchaseTimeCtl").hide();
			}
		}
		
		seajs.use(['lui/dialog'],function(dialog) {
			
			window.validateForm = function(){
				// 分配用户
				var selectAssignUserValue = $("[name='fdAssignUser']").val();
				
				if('2' == selectAssignUserValue || '3' == selectAssignUserValue){
					var userIds = $("input[name='kmAssignPersonnelIds']").val();
					if(userIds == ""){
						dialog.alert("${ lfn:message('km-asset:kmAssetApplyTask.submit.personIds.notnull') }");
						return false;
					}
				}
				
				// 时间校验
				var purchaseTime = $("select[name='fdPurchaseTime']").val();
				var fdStartDate=$("input[name='fdStartDate']").val();
				var fdEndDate=$("input[name='fdEndDate']").val();
				
				if(purchaseTime == "2"){
					if(fdStartDate==""&&fdEndDate==""){
						dialog.alert("${ lfn:message('km-asset:kmAssetApplyTask.submit.start_endDate.notnull') }");
						return false;
					}
					if(fdStartDate!=null&&fdStartDate!=""&&fdEndDate!=null&&fdEndDate!=""){
						 if(Date.parse(Com_GetDate(fdEndDate))<Date.parse(Com_GetDate(fdStartDate))){
							dialog.alert("${ lfn:message('km-asset:kmAssetApplyTask.submit.endDate.not.lt.startDate') }");
					    	return false;
						}
					}
				}
				
				var cardLength = $("#detailTB >tbody> tr").length;
				if(cardLength <= 1){
					dialog.alert("${ lfn:message('km-asset:kmAssetApplyTask.submit.alert') }");
					return false;
				}
				
				if('1' == selectAssignUserValue){
					// 获取责任人为空的元素
					var inputs = $("#detailTB >tbody> tr input.hiddenPerson").filter(function(index) {
						var inputValue = this.value;
						if (inputValue == ""  || typeof(inputValue) == "undefined"){
							return true;
						}
						return false;
					});
					if(inputs.length > 0 ){
						dialog.alert("${ lfn:message('km-asset:kmAssetApplyTask.submit.person.notnull') }");
						return false;
					}
				}
				return true;
			}
		});
		
		function commitMethod(method, saveDraft){
			var docStatus = document.getElementsByName("docStatus")[0];
			if (saveDraft != null && saveDraft == 'true'){
				docStatus.value = "10";
			} else {
				docStatus.value = "20";
			}
			Com_Submit(document.kmAssetApplyTaskForm, method);
		}
		
		$(function(){
			reRenderDir(null);
			
			$("select[name='fdAssignUser']").unbind("change");
			$("select[name='fdAssignUser']").bind("change",function(){
				reRenderDir(this);
			});
			
			$("select[name='fdPurchaseTime']").unbind("change");
			$("select[name='fdPurchaseTime']").bind("change",function(){
				reRenderDir(this);
			});
		});
		
	</script>
	<c:if test="${param.approveModel ne 'right'}">
		<form name="kmAssetApplyTaskForm" method="post" action ="${KMSS_Parameter_ContextPath}km/asset/km_asset_apply_task/kmAssetApplyTask.do">
	</c:if>
	<html:hidden property="fdId" />
	<html:hidden property="method_GET" />
	<html:hidden property="docStatus" />
	<html:hidden property="fdStatus" />
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
				<c:import url="/km/asset/km_asset_apply_task/kmAssetApplyTask_editContent.jsp" charEncoding="UTF-8">
	 		 		<c:param name="contentType" value="baseInfo"></c:param>
	  			</c:import>
			</ui:tabpage>
			<ui:tabpanel suckTop="true" layout="sys.ui.tabpanel.sucktop" var-supportExpand="true" var-extend="true" var-average='false' var-useMaxWidth='true'>
				<%--流程--%>
				<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyTaskForm" />
					<c:param name="fdKey" value="KmAssetApplyTaskDoc" />
					<c:param name="showHistoryOpers" value="true" />
					<c:param name="isExpand" value="true" />
					<c:param name="approveType" value="right" />
				</c:import>
				<c:import url="/km/asset/km_asset_apply_task/kmAssetApplyTask_editContent.jsp" charEncoding="UTF-8">
	 		 		<c:param name="contentType" value="other"></c:param>
	 		 		<c:param name="approveModel" value="${param.approveModel}"></c:param>
	  			</c:import>
			</ui:tabpanel>
		</c:when>
		<c:otherwise>
			<ui:tabpage expand="false" var-navwidth="90%" >
				<c:import url="/km/asset/km_asset_apply_task/kmAssetApplyTask_editContent.jsp" charEncoding="UTF-8">
	 		 		<c:param name="contentType" value="baseInfo"></c:param>
	  			</c:import>
				<c:import url="/km/asset/km_asset_apply_task/kmAssetApplyTask_editContent.jsp" charEncoding="UTF-8">
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
					<c:param name="formName" value="kmAssetApplyTaskForm" />
					<c:param name="fdKey" value="KmAssetApplyTaskDoc" />
					<c:param name="showHistoryOpers" value="true" />
					<c:param name="isExpand" value="true" />
					<c:param name="approveType" value="right" />
					<c:param name="approvePosition" value="right" />
				</c:import>
				<!-- 关联机制(与原有机制有差异) -->
				<c:import url="/sys/relation/import/sysRelationMain_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyTaskForm" />
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
				<c:param name="formName" value="kmAssetApplyTaskForm" />
			</c:import>
		</template:replace>
	</c:otherwise>
</c:choose>