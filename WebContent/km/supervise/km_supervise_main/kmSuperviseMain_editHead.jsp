<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:replace name="head">
	<script>
		 Com_IncludeFile("security.js");
	     Com_IncludeFile("domain.js");
	     Com_IncludeFile("form.js");
	     Com_IncludeFile("main_edit.js", "${LUI_ContextPath}/km/supervise/resource/js/", 'js', true);
	     Com_IncludeFile("form_option.js", "${LUI_ContextPath}/km/supervise/km_supervise_main/", 'js', true);
     </script>
     <link type="text/css" rel="stylesheet" href="${LUI_ContextPath}/km/supervise/resource/css/supervise.css?s_cache=${LUI_Cache}"/>
</template:replace>
<template:replace name="title">
    <c:choose>
        <c:when test="${kmSuperviseMainForm.method_GET == 'add' }">
            <c:out value="${ lfn:message('operation.create') } - ${ lfn:message('km-supervise:module.km.supervise') }" />
        </c:when>
        <c:otherwise>
            <c:out value="${kmSuperviseMainForm.docSubject} - " />
            <c:out value="${ lfn:message('km-supervise:module.km.supervise') }" />
        </c:otherwise>
    </c:choose>
</template:replace>
<template:replace name="toolbar">
	<c:if test="${kmSuperviseMainForm.docDeleteFlag ==1}">
		<ui:toolbar id="toolbar" style="display:none;"></ui:toolbar>
	</c:if>
	<c:if test="${kmSuperviseMainForm.docDeleteFlag !=1}">
    	<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="3">
        	<c:choose>
	            <c:when test="${ kmSuperviseMainForm.method_GET == 'edit' }">
	                <c:if test="${ kmSuperviseMainForm.docStatus=='10' || kmSuperviseMainForm.docStatus=='11' }">
	                    <ui:button text="${ lfn:message('button.savedraft') }" onclick="_updateDraft()" />
	                </c:if>
	                <c:if test="${ kmSuperviseMainForm.docStatus=='10' || kmSuperviseMainForm.docStatus=='11' || kmSuperviseMainForm.docStatus=='20' }">
	                    <c:choose>
							<c:when test="${param.approveModel eq 'right'}">
								<ui:button text="${ lfn:message('button.submit') }" order="2" styleClass="lui_widget_btn_primary" isForcedAddClass="true" 
										onclick="_updateDoc();">
								</ui:button>
							</c:when>
							<c:otherwise>
								<ui:button text="${ lfn:message('button.submit') }" order="2"  
										onclick="_updateDoc();">
								</ui:button>
							</c:otherwise>
						</c:choose>
	                </c:if>
	            </c:when>
	            <c:when test="${ kmSuperviseMainForm.method_GET == 'add' }">
	                <ui:button text="${ lfn:message('button.savedraft') }" order="2" onclick="_saveDraft();" />
	                <c:choose>
						<c:when test="${param.approveModel eq 'right'}">
							<ui:button text="${ lfn:message('button.submit') }" order="2" styleClass="lui_widget_btn_primary" isForcedAddClass="true"
									onclick="_submitDoc();">
							</ui:button>
						</c:when>
						<c:otherwise>
							<ui:button text="${ lfn:message('button.submit') }" order="2"  
									onclick="_submitDoc();">
							</ui:button>
						</c:otherwise>
					</c:choose>
	            </c:when>
	        </c:choose>

        	<ui:button text="${ lfn:message('button.close') }" order="5" onclick="Com_CloseWindow();" />
   		</ui:toolbar>
	</c:if>
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