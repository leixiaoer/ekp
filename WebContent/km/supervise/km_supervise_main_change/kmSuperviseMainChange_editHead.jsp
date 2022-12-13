<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
	<template:replace name="head">
		<link type="text/css" rel="stylesheet" href="${LUI_ContextPath}/km/supervise/resource/css/supervise.css?s_cache=${LUI_Cache}"/>
        <script type="text/javascript">
            Com_IncludeFile("calendar.js");
            Com_IncludeFile("security.js");
            Com_IncludeFile("domain.js");
            Com_IncludeFile("form.js");
            Com_IncludeFile("doclist.js");
            Com_IncludeFile("form_option.js", "${LUI_ContextPath}/km/supervise/km_supervise_main/", 'js', true);
            Com_IncludeFile("sysUnitDialog.js", Com_Parameter.ContextPath+ "sys/unit/resource/js/", "js", true);
            
            $KMSSValidation();
	        function commitMethod(commitType, saveDraft){
				var formObj = document.kmSuperviseMainForm;
				var docStatus = document.getElementsByName("docStatus")[0];
				if(saveDraft=="true"){
					docStatus.value="10";
				}else{
					docStatus.value="20";
				}
				if('save'==commitType){
					Com_Submit(formObj, commitType);
			    }else{
			    	Com_Submit(formObj, commitType); 
			    }
			}
        </script>
    </template:replace>
    <template:replace name="title">
    	<c:out value="${kmSuperviseMainForm.docSubject} - " />
        <c:out value="${ lfn:message('km-supervise:module.km.supervise') }" />
    </template:replace>
	
	<%--操作按钮--%>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float">
			<c:choose>
	            <c:when test="${ kmSuperviseMainForm.method_GET == 'edit' }">
	                <c:if test="${ kmSuperviseMainForm.docStatus=='10' || kmSuperviseMainForm.docStatus=='11' || kmSuperviseMainForm.docStatus=='20' }">
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
	            </c:when>
	            <c:when test="${ kmSuperviseMainForm.method_GET == 'add' }">
					<c:if test="${kmSuperviseMainForm.docStatus=='10'
								||kmSuperviseMainForm.docStatus=='11'||kmSuperviseMainForm.docStatus=='20'}">
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
	            </c:when>
	        </c:choose>
			
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