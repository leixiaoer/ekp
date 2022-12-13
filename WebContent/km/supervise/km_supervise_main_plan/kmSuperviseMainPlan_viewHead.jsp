<%@page import="com.landray.kmss.sys.lbpmservice.support.model.LbpmSetting"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
	<style type="text/css">
		.lui-lbpm-opinion-outerBox  i {

		    top: 40%;
		}
	</style>
	<template:replace name="head">
	    <link type="text/css" rel="stylesheet" href="${LUI_ContextPath}/km/supervise/resource/css/supervise.css?s_cache=${LUI_Cache}"/>
	</template:replace>
    <template:replace name="title">
        <c:out value="${ lfn:message('km-supervise:table.kmSuperviseMainPlan')} - " />
        <c:out value="${ lfn:message('km-supervise:module.km.supervise') }" />
    </template:replace>
    <template:replace name="toolbar">
    	<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float">
	        <%--关闭--%>
			<ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();"></ui:button>
			<c:if test="${kmSuperviseMainPlanForm.docStatus eq '10' || kmSuperviseMainPlanForm.docStatus eq '11'}">
				<%-- 起草与驳回增加删除与编辑按钮 -#159378 --%>
				<ui:button text="删除" order="6" onclick="if(!confirmDelete())return;Com_OpenWindow('kmSuperviseMainPlan.do?method=delete&fdId=${param.fdId}','_self');"/>
   				<ui:button text="编辑 " order="7" onclick="Com_OpenWindow('kmSuperviseMainPlan.do?method=edit&fdId=${param.fdId}&fdKey=${param.fdKey}&isAdd=false','_self');"/>
			</c:if>
		</ui:toolbar>
    </template:replace>
    <template:replace name="path">
        <ui:combin ref="menu.path.category">
				<ui:varParams 
					moduleTitle="${ lfn:message('km-supervise:module.km.supervise') }" 
					modulePath="/km/supervise/" 
					modelName="com.landray.kmss.km.supervise.model.KmSuperviseTemplet" 
					autoFetch="false"
					href="/km/supervise/" 
					categoryId="${kmSuperviseMainForm.docTemplateId}" />
		</ui:combin>
    </template:replace>	
    <script>
    function confirmDelete(msg) {
        return confirm('${ lfn:message("page.comfirmDelete") }');
    }
    </script>