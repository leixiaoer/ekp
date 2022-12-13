<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="java.net.URLEncoder" %>
<%
	String orgName = request.getParameter("orgName");
	request.setAttribute("encodeOrgName", URLEncoder.encode(orgName, "UTF-8"));
%>
<template:include ref="default.simple">
	<%-- 标签页标题--%>
	<template:replace name="title">
		<c:out value="${ lfn:message('sys-task:module.sys.task') }"></c:out>
	</template:replace>
	<template:replace name="body">
		<script language="JavaScript">
		seajs.use(['theme!form']);
		</script>
		<center>
			<div style="text-align: right;">
				<kmss:auth requestURL="/sys/task/sys_task_main/sysTaskMain.do?method=exportDetailExcel&fdAnalyzeId=${param.fdId}" requestMethod="GET">
					<ui:button text="${lfn:message('sys-task:button.exportExcel')}"
						onclick="Com_OpenWindow('${LUI_ContextPath}/sys/task/sys_task_main/sysTaskMain.do?method=exportDetailExcel&fdAnalyzeId=${JsParam.fdId}&orgName=${encodeOrgName}&statusType=${JsParam.statusType}&extParam=${JsParam.extParam}','_blank');">
					</ui:button>
				</kmss:auth>
			</div>
			<p class="lui_form_subject">
				<c:out value="${param.orgName}"></c:out>-<bean:message key="sysTaskAnalyze.detail"  bundle="sys-task"/>
			</p>
		</center>
		<div style="text-align: center;padding: 10px;">
			<%--list视图--%>
			<list:listview id="listview">
				<ui:source type="AjaxJson">
					{url:'/sys/task/sys_task_main/sysTaskMain.do?method=${JsParam.method}&fdId=${JsParam.fdId}&statusType=${JsParam.statusType}&extParam=${JsParam.extParam}'}
				</ui:source>
				<%--列表形式--%>
				<list:colTable isDefault="false" layout="sys.ui.listview.listtable" 
					rowHref="/sys/task/sys_task_main/sysTaskMain.do?method=view&fdId=!{fdId}"  name="columntable">
					<list:col-serial></list:col-serial>
					<list:col-auto props=""></list:col-auto>
				</list:colTable>
		 		<ui:event topic="list.loaded">
					pageResize();
				</ui:event> 
			</list:listview> 
			<br>
		 	<list:paging></list:paging>	 
	 	</div>
	</template:replace>
</template:include>
<script type="text/javascript">
window.pageResize = function(){
	domain.call(parent,'pageResize', []);
};
</script>
