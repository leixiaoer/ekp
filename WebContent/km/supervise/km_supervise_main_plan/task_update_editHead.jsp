<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
	<template:replace name="head">
		<link type="text/css" rel="stylesheet" href="${LUI_ContextPath}/km/supervise/resource/css/supervise.css?s_cache=${LUI_Cache}"/>
		<script type="text/javascript">
		Com_IncludeFile("calendar.js");
		Com_IncludeFile("doclist.js");
		Com_IncludeFile("dialog.js");
		Com_IncludeFile("sysUnitDialog.js", Com_Parameter.ContextPath+ "sys/unit/resource/js/", "js", true);
		</script>
	</template:replace>
    <template:replace name="title">
    	<%-- <c:out value="${kmSuperviseMainForm.docSubject} - " /> --%>
        <c:out value="${ lfn:message('km-supervise:module.km.supervise') } - " />
        <c:out value="${ lfn:message('km-supervise:py.RenWuZhiPai') }" />
    </template:replace>
	
	<%--操作按钮--%>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float">
			<c:if test="${kmSuperviseMainPlanForm.method_GET=='edit'&&(kmSuperviseMainPlanForm.docStatus=='10'
						||kmSuperviseMainPlanForm.docStatus=='11'||kmSuperviseMainPlanForm.docStatus=='20')}">
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
			<c:if test="${kmSuperviseMainPlanForm.method_GET=='add'}">
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