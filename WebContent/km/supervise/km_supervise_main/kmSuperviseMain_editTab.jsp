<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:replace name="content">
	<%-- 软删除 --%>
	<c:import url="/sys/recycle/import/redirect.jsp">
		<c:param name="formBeanName" value="kmSuperviseMainForm"></c:param>
	</c:import>     
	<c:if test="${param.approveModel ne 'right'}">
		<form name="kmSuperviseMainForm" method="post" action ="${KMSS_Parameter_ContextPath}km/supervise/km_supervise_main/kmSuperviseMain.do">
	</c:if>	  
     	<html:hidden property="fdId" value="${kmSuperviseMainForm.fdId}"/>
        <html:hidden property="docStatus" />
        <html:hidden property="fdIsNew" value="true"/>
        <html:hidden property="fdIsPlan"/>
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
					<c:import url="/km/supervise/km_supervise_main/kmSuperviseMain_editContent.jsp" charEncoding="UTF-8">
		 		 		<c:param name="contentType" value="baseInfo"></c:param>
		  			</c:import>
				</ui:tabpage>
				<ui:tabpanel suckTop="true" layout="sys.ui.tabpanel.sucktop" var-count="7" var-average='false' var-useMaxWidth='true' 
						var-supportExpand="true" var-expand="true">
					<c:import url="/km/supervise/km_supervise_main/kmSuperviseMain_editContent.jsp" charEncoding="UTF-8">
		 		 		<c:param name="contentType" value="other"></c:param>
		 		 		<c:param name="approveModel" value="${param.approveModel}"></c:param>
		  			</c:import>
		  			
		  			<%--流程--%>
					<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmSuperviseMainForm" />
						<c:param name="fdKey" value="kmSuperviseMain" />
						<c:param name="showHistoryOpers" value="true" />
						<c:param name="approveType" value="right" />
					</c:import>
				</ui:tabpanel>
			</c:when>
			<c:otherwise>
				<ui:tabpage expand="false" var-navwidth="90%" >
					<c:import url="/km/supervise/km_supervise_main/kmSuperviseMain_editContent.jsp" charEncoding="UTF-8">
		 		 		<c:param name="contentType" value="baseInfo"></c:param>
		  			</c:import>
					<c:import url="/km/supervise/km_supervise_main/kmSuperviseMain_editContent.jsp" charEncoding="UTF-8">
		 		 		<c:param name="contentType" value="other"></c:param>
		  			</c:import>
				</ui:tabpage>
				</form>
			</c:otherwise>
		</c:choose>
    
    <script type="text/javascript">
	  	Com_IncludeFile("calendar.js");
		Com_IncludeFile("doclist.js");
		Com_IncludeFile("dialog.js");
	  	Com_IncludeFile("domain.js");
	  	Com_IncludeFile("form.js");
	  	Com_IncludeFile("jquery.js");
	  	Com_IncludeFile("sysUnitDialog.js", Com_Parameter.ContextPath+ "sys/unit/resource/js/", "js", true);
	  	function selectDept(){
				var url = "${KMSS_Parameter_ContextPath}km/supervise/km_supervise_main/kmSuperviseMain.do?method=getApplicantDept";
				var fdSponsorId = document.getElementsByName("fdSponsorId")[0];
			$.ajax({     
	  	    	type:"post",   
	  	     	url:url,     
	  	     	data:{fdSponsorId:fdSponsorId.value},    
	  	     	async:false,    //用同步方式 
	  	     	success:function(data){
	  	 	    var results =  eval("("+data+")");
	      	 	    if(results['deptId']!=""&&results['deptName']!=""){
	      	 	    	var kmssData = new KMSSData();
	 	          		kmssData.AddHashMap({deptId:results['deptId'],deptName:results['deptName']});
	 	          		kmssData.PutToField("deptId:deptName", "fdUnitId:fdUnitName", "", false);
	      	   	 	}else{
	      	   	 		//emptyNewAddress('fdUnitName',null,0);
	       	   	 		var address = Address_GetAddressObj("fdUnitName");
						address.emptyAddress(true);
	      	   	 	}
	  		 	}    
			});
		}
	  	
	  	function _updateDraft(){
	  		var docStatus = document.getElementsByName("docStatus")[0];
        	docStatus.value="10";
        	validation.removeElements($('#kmSuperviseDiv')[0],'required');
			validation.removeValidators('validateTime');
			validation.removeValidators('validateSuperviseTime');
			Com_Submit(document.kmSuperviseMainForm, 'update');
		}
	  	
		function _saveDraft(){
			var docStatus = document.getElementsByName("docStatus")[0];
        	docStatus.value="10";
			validation.removeElements($('#kmSuperviseDiv')[0],'required');
			validation.removeValidators('validateTime');
			validation.removeValidators('validateSuperviseTime');
			Com_Submit(document.kmSuperviseMainForm, 'save');
		}
		
		function _submitDoc(){
			var docStatus = document.getElementsByName("docStatus")[0];
        	docStatus.value="20";
			Com_Submit(document.kmSuperviseMainForm, 'save');
		}
		
		function _updateDoc(){
			var docStatus = document.getElementsByName("docStatus")[0];
        	docStatus.value="20";
			Com_Submit(document.kmSuperviseMainForm, 'update');
		}
	</script>
</template:replace>
<c:choose>
	<c:when test="${param.approveModel eq 'right'}">
		<template:replace name="barRight">
			<ui:tabpanel layout="sys.ui.tabpanel.vertical.icon" id="barRightPanel">
				<%--流程--%>
				<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmSuperviseMainForm" />
					<c:param name="fdKey" value="kmSuperviseMain" />
					<c:param name="showHistoryOpers" value="true" />
					<c:param name="isExpand" value="true" />
					<c:param name="approveType" value="right" />
					<c:param name="approvePosition" value="right" />
				</c:import>
				<!-- 关联机制(与原有机制有差异) -->
				<c:import url="/sys/relation/import/sysRelationMain_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmSuperviseMainForm" />
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
				<c:param name="formName" value="kmSuperviseMainForm" />
			</c:import>
		</template:replace>
	</c:otherwise>
</c:choose>