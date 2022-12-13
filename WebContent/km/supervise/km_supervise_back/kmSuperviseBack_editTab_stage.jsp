<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<template:replace name="content"> 
	<c:if test="${param.approveModel ne 'right'}">
		<form name="kmSuperviseBackForm" method="post" action ="${KMSS_Parameter_ContextPath}km/supervise/km_supervise_back/kmSuperviseBack.do">
	</c:if>
	<html:hidden property="fdId" />
	<html:hidden property="docSubject" />
   	<html:hidden property="docStatus" />
   	<html:hidden property="method_GET" />
   	<html:hidden property="fdSuperviseId" />
    <c:choose>
		<c:when test="${param.approveModel eq 'right'}">
			<ui:tabpanel suckTop="true" layout="sys.ui.tabpanel.sucktop" var-count="5" var-average='false' var-useMaxWidth='true'>
				<c:import url="/km/supervise/km_supervise_back/kmSuperviseBack_editContent_stage.jsp" charEncoding="UTF-8">
	 		 		<c:param name="contentType" value="xform"></c:param>
	  			</c:import>
				<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmSuperviseBackForm" />
					<c:param name="fdKey" value="kmSuperviseStage" />
					<c:param name="showHistoryOpers" value="true" />
					<c:param name="isExpand" value="true" />
					<c:param name="approveType" value="right" />
				</c:import>
			</ui:tabpanel>
		</c:when>
		<c:otherwise>
			<ui:tabpage expand="false" var-navwidth="90%" >
				<c:import url="/km/supervise/km_supervise_back/kmSuperviseBack_editContent_stage.jsp" charEncoding="UTF-8">
	 		 		<c:param name="contentType" value="xform"></c:param>
	  			</c:import>
				<c:import url="/km/supervise/km_supervise_back/kmSuperviseBack_editContent_stage.jsp" charEncoding="UTF-8">
	 		 		<c:param name="contentType" value="other"></c:param>
	  			</c:import>
			</ui:tabpage>
			</form>
		</c:otherwise>
	</c:choose>
	<script type="text/javascript" src="${KMSS_Parameter_ContextPath}km/supervise/resource/js/slider_extras.js"></script>
    <script>
    	$(document).ready(function() {
    		var method ='${kmSuperviseBackForm.method_GET}';
    		if(method != 'edit'){
			    var taskData = new KMSSData();
			    taskData.AddBeanData("kmSuperviseBackTaskService&fdMainId=${kmSuperviseBackForm.fdSuperviseId}&type=0&fdType=${kmSuperviseBackForm.fdType}");
			    taskData.PutToSelect("fdTaskId","id","name");
    		}
		});
        
        function getBackPeriod(val){
        	var data = new KMSSData();
        	
        	data.AddBeanData("kmSuperviseBackTaskService&fdTaskId="+val+"&type=2");
	    	data.PutToField("fdStageTarget:fdProgress","fdStageTarget:fdProgress","",false);
	    	
	    	var progress = document.getElementsByName("fdProgress")[0].value;
	    	document.getElementById("lui_supervise_inner_bar").setAttribute("style","width:"+progress+"%")
	    	document.getElementById("lui_supervise_rate").innerHTML=progress+"%";
		    document.getElementById("fdStageTargetSpan").innerHTML=document.getElementsByName("fdStageTarget")[0].value;
        }
        
    </script>
</template:replace>

<c:choose>
	<c:when test="${param.approveModel eq 'right'}">
		<template:replace name="barRight">
		<ui:tabpanel layout="sys.ui.tabpanel.vertical.icon" id="barRightPanel">
			<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmSuperviseBackForm" />
				<c:param name="fdKey" value="kmSuperviseStage" />
				<c:param name="showHistoryOpers" value="true" />
				<c:param name="isExpand" value="true" />
				<c:param name="approveType" value="right" />
				<c:param name="approvePosition" value="right" />
			</c:import>
				<!-- 关联机制(与原有机制有差异) -->
				<c:import url="/sys/relation/import/sysRelationMain_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmSuperviseBackForm" />
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
				<c:param name="formName" value="kmSuperviseBackForm" />
			</c:import>
		</template:replace>
	</c:otherwise>
</c:choose>



