<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/fssc/common/fssc.tld" prefix="fssc"%>
<template:include ref="config.tree">
<template:replace name="content">
function generateTree()
{
    window.LKSTree = new TreeView( 
        'LKSTree',
        
        '${ lfn:message("fssc-ledger:module.fssc.ledger") }',//根节点的名称
        document.getElementById('treeDiv')
    );
    var node = LKSTree.treeRoot; 
    
    
    node.isExpanded = true;
    /*数据导入*/
    <kmss:auth requestURL="/sys/transport/sys_transport_import/index.jsp?fdModelName=com.landray.kmss.fssc.ledger.model.FsscLedgerInvoice" requestMethod="GET">
    var node_1_1_node = node.AppendURLChild(
        '${ lfn:message("fssc-ledger:py.FaPiaoShuJuDaoRu") }',
        '<c:url value="/sys/transport/sys_transport_import/index.jsp?fdModelName=com.landray.kmss.fssc.ledger.model.FsscLedgerInvoice"/>');
    </kmss:auth>

    /*数据导入*/
   <%--  <kmss:auth requestURL="/sys/transport/sys_transport_import/index.jsp?fdModelName=com.landray.kmss.fssc.ledger.model.FsscLedgerCredit" requestMethod="GET">
    var node_1_2_node = node.AppendURLChild(
        '${ lfn:message("fssc-ledger:py.XinYongShuJuDaoRu") }',
        '<c:url value="/sys/transport/sys_transport_import/index.jsp?fdModelName=com.landray.kmss.fssc.ledger.model.FsscLedgerCredit"/>');
    </kmss:auth> --%>
	/*发票信息_列表自定义*/
    var node_1_0_node = node.AppendURLChild(
        '${ lfn:message("fssc-ledger:py.FaPiaoXinXiLie") }',
        '<c:url value="/sys/profile/listShow/sys_listshow_category/index.jsp?modelName=com.landray.kmss.fssc.ledger.model.FsscLedgerInvoice"/>'); 
    /*信用台账_列表自定义*/
  <%--   var node_1_3_node = node.AppendURLChild(
        '${ lfn:message("fssc-ledger:py.XinYongTaiZhangLie") }',
        '<c:url value="/sys/profile/listShow/sys_listshow_category/index.jsp?modelName=com.landray.kmss.fssc.ledger.model.FsscLedgerCredit"/>');  --%>
    <fssc:checkVersion version="true">
    <kmss:ifModuleExist path="/fssc/purch/">
    /*物资台账_列表自定义*/
    var node_1_3_node = node.AppendURLChild(
        '${ lfn:message("fssc-ledger:py.WuZiTaiZhangLie") }',
        '<c:url value="/sys/profile/listShow/sys_listshow_category/index.jsp?modelName=com.landray.kmss.fssc.ledger.model.FsscLedgerMaterial"/>'); 
    </kmss:ifModuleExist>
    /*合同台账_列表自定义*/
    var node_1_3_node = node.AppendURLChild(
        '${ lfn:message("fssc-ledger:py.HeTongTaiZhangLie") }',
        '<c:url value="/sys/profile/listShow/sys_listshow_category/index.jsp?modelName=com.landray.kmss.fssc.ledger.model.FsscLedgerContract"/>'); 
    </fssc:checkVersion>
    LKSTree.Show();
}
</template:replace>
</template:include>