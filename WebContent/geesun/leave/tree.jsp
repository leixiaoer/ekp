<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="config.tree">
<template:replace name="content">
function generateTree()
{
    window.LKSTree = new TreeView( 
        'LKSTree',
        
        '${ lfn:message("geesun-leave:module.geesun.leave") }',//根节点的名称
        document.getElementById('treeDiv')
    );
    var n1, n2, n3, n4, n5;
	n1 = LKSTree.treeRoot;
	
	n2 = n1.AppendURLChild(
		"<bean:message key="geesunLeaveConfig.config" bundle="geesun-leave" />",
		"<c:url value="/sys/appconfig/sys_appconfig/sysAppConfig.do?method=edit&modelName=com.landray.kmss.geesun.leave.model.GeesunLeaveConfig" />"
	);
    
    LKSTree.Show();
}
</template:replace>
</template:include>