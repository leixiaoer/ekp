<%@page import="com.landray.kmss.sys.lbpmservice.support.model.LbpmSetting"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
	<template:replace name="title">
        <c:out value="${ lfn:message('km-supervise:table.kmSuperviseBack') }" />
    </template:replace>
	
	<%--操作按钮--%>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="5">
			<c:if test="${kmSuperviseBackForm.docStatus=='10' || kmSuperviseBackForm.docStatus=='11' }">
                <kmss:auth requestURL="/km/supervise/km_supervise_back/kmSuperviseBack.do?method=edit&fdId=${param.fdId}&fdType=${kmSuperviseBackForm.fdType }" requestMethod="GET">
                    <ui:button text="${lfn:message('button.edit')}" onclick="Com_OpenWindow('kmSuperviseBack.do?method=edit&fdId=${param.fdId}&fdType=${kmSuperviseBackForm.fdType}&fdIsNew=true','_self');" order="2" />
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