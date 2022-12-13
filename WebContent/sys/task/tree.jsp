<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include file="/sys/profile/resource/template/tree.jsp">
    <template:replace name="content">
//Com_Parameter.XMLDebug = true;
function generateTree()
{
	LKSTree = new TreeView(
		"LKSTree",
		"<bean:message key="sysTask.moduleName" bundle="sys-task"/>",
		document.getElementById("treeDiv")
	);
	var n1, n2, n3, n4, n5,n6,n7,n8,n9;
	n1 = LKSTree.treeRoot;
	 
<kmss:authShow roles="ROLE_SYSTASK_CONFIG">		
	<!-- 参数设置 -->
	n8 = n1.AppendURLChild(
		"<bean:message key="tree.task.config" bundle="sys-task"/>",
		"<c:url value="/sys/appconfig/sys_appconfig/sysAppConfig.do?method=edit&modelName=com.landray.kmss.sys.task.model.SysTaskConfig" />"
	);
	<!-- 模块配置 -->
	n9 = n1.AppendURLChild(
		"<bean:message key="tree.module.set" bundle="sys-task"/>"
	);
	n9.isExpanded = true;
    n4 = n9.AppendURLChild(
		"<bean:message key="tree.task.category.set" bundle="sys-task"/>",
		"<c:url value="/sys/task/sys_task_category/index.jsp"/>"
	);
	 n5 = n9.AppendURLChild(
		"<bean:message key="tree.task.degree.set" bundle="sys-task"/>",
		"<c:url value="/sys/task/sys_task_approve/index.jsp"/>"
	);
	n6 = n9.AppendURLChild(
		"<bean:message key="tree.task.level.set" bundle="sys-task"/>",
		"<c:url value="/sys/appconfig/sys_appconfig/sysAppConfig.do?method=edit&modelName=com.landray.kmss.sys.task.model.SysTaskMainLevel" />"
	);
</kmss:authShow>
LKSTree.EnableRightMenu();	
 LKSTree.Show();
 LKSTree.ClickNode(n4);
 }
</template:replace>
</template:include>