<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="config.tree">
<template:replace name="content">
function generateTree()
{
    window.LKSTree = new TreeView( 
        'LKSTree',
        
        '${ lfn:message("geesun-base:module.geesun.base") }',//根节点的名称
        document.getElementById('treeDiv')
    );
    var node = LKSTree.treeRoot; 
    
    var n1, n2, n3, n4, n5;
	n1 = LKSTree.treeRoot;
	
	n2 = n1.AppendURLChild(
		"<bean:message key="geesunBaseConfig.config" bundle="geesun-base" />",
		"<c:url value="/sys/appconfig/sys_appconfig/sysAppConfig.do?method=edit&modelName=com.landray.kmss.geesun.base.model.GeesunBaseConfig" />"
	);
	//导入机制
	<kmss:auth requestURL="/sys/transport/sys_transport_import/SysTransportImport.do?method=list&fdModelName=com.landray.kmss.geesun.base.model.GeesunBaseBxsj">
	n2 = n1.AppendURLChild(
		"<bean:message bundle="geesun-base" key="geesunBaseBxsj.import"/>",
		"<c:url value="/sys/transport/sys_transport_import/index.jsp?fdModelName=com.landray.kmss.geesun.base.model.GeesunBaseBxsj"/>"
	);
	</kmss:auth>
	
	/*数据导入*/
    <kmss:auth requestURL="/sys/transport/sys_transport_import/index.jsp?fdModelName=com.landray.kmss.geesun.base.model.GeesunBaseAudit" requestMethod="GET">
    var node_1_1_node = n1.AppendURLChild(
        '${ lfn:message("geesun-base:py.ShuJuDaoRu") }',
        '<c:url value="/sys/transport/sys_transport_import/index.jsp?fdModelName=com.landray.kmss.geesun.base.model.GeesunBaseAudit"/>');
    </kmss:auth>

    /*数据导入*/
    <kmss:auth requestURL="/sys/transport/sys_transport_import/index.jsp?fdModelName=com.landray.kmss.geesun.base.model.GeesunBaseProject" requestMethod="GET">
    var node_1_2_node = n1.AppendURLChild(
        '${ lfn:message("geesun-base:py.ShuJuDaoRu") }',
        '<c:url value="/sys/transport/sys_transport_import/index.jsp?fdModelName=com.landray.kmss.geesun.base.model.GeesunBaseProject"/>');
    </kmss:auth>
	
    
    LKSTree.Show();
}
</template:replace>
</template:include>