<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:replace name="content"> 
	<c:if test="${param.approveModel ne 'right'}">
		<form name="kmSuperviseMainPlanForm" method="post" action ="${KMSS_Parameter_ContextPath}km/supervise/km_supervise_main_plan/kmSuperviseMainPlan.do">
	</c:if>
	<html:hidden property="fdId" value="${kmSuperviseMainPlanForm.fdId }"/>
	<html:hidden property="docStatus"/>
	<html:hidden property="docSubject"/>
	<html:hidden property="fdMainId"/>
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
				<c:import url="/km/supervise/km_supervise_main_plan/task_update_editContent.jsp" charEncoding="UTF-8">
	 		 		<c:param name="contentType" value="xform"></c:param>
	  			</c:import>
			</ui:tabpage>
			<ui:tabpanel suckTop="true" layout="sys.ui.tabpanel.sucktop" var-count="5" var-average='false' var-useMaxWidth='true'>
				<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmSuperviseMainPlanForm" />
					<c:param name="fdKey" value="kmSuperviseMakePlan" />
					<c:param name="showHistoryOpers" value="true" />
					<c:param name="isExpand" value="true" />
					<c:param name="approveType" value="right" />
				</c:import>
				<c:import url="/km/supervise/km_supervise_main_plan/task_update_editContent.jsp" charEncoding="UTF-8">
	 		 		<c:param name="contentType" value="other"></c:param>
	 		 		<c:param name="approveModel" value="${param.approveModel}"></c:param>
	  			</c:import>
			</ui:tabpanel>
		</c:when>
		<c:otherwise>
			<ui:tabpage expand="false" var-navwidth="90%" >
				<c:import url="/km/supervise/km_supervise_main_plan/task_update_editContent.jsp" charEncoding="UTF-8">
	 		 		<c:param name="contentType" value="xform"></c:param>
	  			</c:import>
				<c:import url="/km/supervise/km_supervise_main_plan/task_update_editContent.jsp" charEncoding="UTF-8">
	 		 		<c:param name="contentType" value="other"></c:param>
	  			</c:import>
			</ui:tabpage>
			</form>
		</c:otherwise>
	</c:choose>
	<script type="text/javascript">
		$KMSSValidation();
		function commitMethod(commitType, saveDraft){
			var formObj = document.kmSuperviseMainPlanForm;
			var docStatus = document.getElementsByName("docStatus")[0];
			if(saveDraft=="true"){
				docStatus.value="10";
			}else{
				docStatus.value="20";
			}
			if('save'==commitType){
				Com_Submit(formObj, commitType,'fdId');
		    }else{
		    	Com_Submit(formObj, commitType); 
		    }
		}
		
		
		seajs.use(['lui/dialog','lui/jquery'],function(dialog,$){
			
			window.previewBackDay = function(){
				var fdBackType = document.getElementsByName("fdBackType")[0];
				var backType = fdBackType.value;
				var allTR = document.getElementById("TABLE_DocList").getElementsByTagName("TR");
				var stages = []; 
				for(var i = 1 ;i < allTR.length;i++){
					var vals = {};
					var optTR = allTR[i];
					$(optTR).find(":input").each(function(idx, elem){
						var domNode = $(elem); 
						if(elem && elem.name){
							if(elem.name.indexOf("fdPlanStartTime") > -1 ){
								vals["fdPlanStartTime"] = DocList_getFiledValue(optTR,elem.name);
							}else if(elem.name.indexOf("fdPlanEndTime") > -1){
								vals["fdPlanEndTime"] = DocList_getFiledValue(optTR,elem.name);
							}else if(elem.name.indexOf("docSubject") > -1){
								vals["docSubject"] = DocList_getFiledValue(optTR,elem.name);
							}
						}
					});
					stages.push(vals);
				}
				var stageStr = JSON.stringify(stages);
				stageStr = encodeURI(stageStr);
				dialog.iframe("/km/supervise/km_supervise_main/import/back_day_preview_frame.jsp?&fdBackType="+backType+"&stages="+stageStr,
	           			'反馈日预览',null,{width:600,height:360});
			}
		});
	</script>
</template:replace>
<c:if test="${param.approveModel eq 'right'}">
	<template:replace name="barRight">
		<ui:tabpanel layout="sys.ui.tabpanel.vertical.icon" id="barRightPanel">
			<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmSuperviseMainPlanForm" />
				<c:param name="fdKey" value="kmSuperviseMakePlan" />
				<c:param name="showHistoryOpers" value="true" />
				<c:param name="isExpand" value="true" />
				<c:param name="approveType" value="right" />
				<c:param name="approvePosition" value="right" />
			</c:import>
		</ui:tabpanel>
	</template:replace>
</c:if>