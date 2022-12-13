<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
	<template:replace name="head">
        <style type="text/css">
            .imageSlider { margin:0;padding:0; height:20px; width:265px; background-image:url("${KMSS_Parameter_ContextPath}km/supervise/resource/images/horizBg.png"); }
			.imageBar    { margin:0;padding:0; height:15px; width:14px; background-image:url("${KMSS_Parameter_ContextPath}km/supervise/resource/images/horizSlider.png"); }
        </style>
        <link type="text/css" rel="stylesheet" href="${LUI_ContextPath}/km/supervise/resource/css/supervise.css?s_cache=${LUI_Cache}"/>
        <script type="text/javascript">
            Com_IncludeFile("domain.js");
            Com_IncludeFile("form.js");
            Com_IncludeFile("data.js");
            $KMSSValidation();
	        function commitMethod(commitType, saveDraft){
				var formObj = document.kmSuperviseBackForm;
				console.log(formObj);
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
        </script>
    </template:replace>
    
	<template:replace name="title">
		<c:out value="${lfn:message('km-supervise:table.kmSuperviseBack')} - ${ lfn:message('km-supervise:module.km.supervise') }"></c:out>	
	</template:replace>
	
	<%--操作按钮--%>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float">
			<c:if test="${kmSuperviseBackForm.method_GET=='edit'&&(kmSuperviseBackForm.docStatus=='10'
						||kmSuperviseBackForm.docStatus=='11'||kmSuperviseBackForm.docStatus=='20')}">
				<c:choose>
					<c:when test="${param.approveModel eq 'right'}">
						<ui:button text="${ lfn:message('button.submit') }" order="2" styleClass="lui_widget_btn_primary" isForcedAddClass="true" 
								onclick="commitMethod('update','false');">
						</ui:button>
					</c:when>
					<c:otherwise>
						<ui:button text="${ lfn:message('button.submit') }" order="2"  
								onclick="commitMethod('update','false');">
						</ui:button>
					</c:otherwise>
				</c:choose>
			</c:if> 
			<c:if test="${kmSuperviseBackForm.method_GET=='add'}">
				<c:choose>
					<c:when test="${param.approveModel eq 'right'}">
						<ui:button text="${ lfn:message('button.submit') }" order="2" styleClass="lui_widget_btn_primary" isForcedAddClass="true"
								onclick="commitMethod('save','false');">
						</ui:button>
					</c:when>
					<c:otherwise>
						<ui:button text="${ lfn:message('button.submit') }" order="2"  
								onclick="commitMethod('save','false');">
						</ui:button>
					</c:otherwise>
				</c:choose>
			</c:if>
			<%--关闭--%>
			<ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();">
			</ui:button>
		</ui:toolbar>
	</template:replace>
	
	<template:replace name="path">
		<ui:combin ref="menu.path.category">
			<ui:varParams 
					moduleTitle="${ lfn:message('km-supervise:module.km.supervise') }" 
					modulePath="/km/supervise/" 
					modelName="com.landray.kmss.km.supervise.model.KmSuperviseTemplet" 
					autoFetch="false"
					categoryId="${kmSuperviseMainForm.docTemplateId}" />
		</ui:combin>
	</template:replace>	