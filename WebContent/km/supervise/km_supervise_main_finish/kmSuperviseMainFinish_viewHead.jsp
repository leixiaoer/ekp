<%@page import="com.landray.kmss.sys.lbpmservice.support.model.LbpmSetting"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
	<template:replace name="head">
		<link type="text/css" rel="stylesheet" href="${LUI_ContextPath}/km/supervise/resource/css/supervise.css?s_cache=${LUI_Cache}"/>
	</template:replace>
	<template:replace name="title">
    	<%-- <c:out value="${kmSuperviseMainForm.docSubject} - " /> --%>
        <c:out value="${ lfn:message('km-supervise:module.km.supervise') }" />
    </template:replace>
	
	<%--操作按钮--%>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="6">
			<c:if test="${ kmSuperviseMainFinishForm.docStatus=='10' || kmSuperviseMainFinishForm.docStatus=='11' }">
                <kmss:auth requestURL="/km/supervise/km_supervise_main_finish/kmSuperviseMainFinish.do?method=edit&fdId=${param.fdId}&fdMainId=${kmSuperviseMainFinishForm.fdMainId }">
                    <ui:button text="${lfn:message('button.edit')}" onclick="Com_OpenWindow('kmSuperviseMainFinish.do?method=edit&fdId=${param.fdId}&fdMainId=${kmSuperviseMainFinishForm.fdMainId }','_self');" order="2" />
                </kmss:auth>
            </c:if>
            <c:if test="${ kmSuperviseMainFinishForm.docStatus=='10' }">
            	<kmss:auth requestURL="/km/supervise/km_supervise_main_finish/kmSuperviseMainFinish.do?method=delete&fdId=${param.fdId}&fdMainId=${kmSuperviseMainFinishForm.fdMainId }">
                	<ui:button text="${lfn:message('button.delete')}" onclick="deleteDoc('kmSuperviseMainFinish.do?method=delete&fdId=${param.fdId}&fdMainId=${kmSuperviseMainFinishForm.fdMainId }');" order="5" />
            	</kmss:auth>
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