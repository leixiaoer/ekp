<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="config.tree">
	<template:replace name="content">
//Com_Parameter.XMLDebug = true;
function generateTree()
{
	LKSTree = new TreeView(
		"LKSTree",
		"<bean:message key="module.geesun.org" bundle="geesun-org"/>",
		document.getElementById("treeDiv")
	);
	var n1, n2, n3, n4, n5;
	n1 = LKSTree.treeRoot;
	
	n2 = n1.AppendURLChild(
		"<bean:message key="geesunOrgSynchroConfig.config" bundle="geesun-org" />",
		"<c:url value="/sys/appconfig/sys_appconfig/sysAppConfig.do?method=edit&modelName=com.landray.kmss.geesun.org.model.GeesunOrgSynchroConfig" />"
	);
	
	n2 = n1.AppendURLChild(
		"<bean:message key="geesunOrgConfig.setting" bundle="geesun-org" />",
		"<c:url value="/sys/appconfig/sys_appconfig/sysAppConfig.do?method=edit&modelName=com.landray.kmss.geesun.org.model.GeesunOrgConfig" />"
	);
	
	LKSTree.EnableRightMenu();
	LKSTree.Show();
}
	</template:replace>
</template:include>
