<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="config.tree">
<template:replace name="content">
function generateTree()
{
    window.LKSTree = new TreeView( 
        'LKSTree',
        '',//根节点的名称
        document.getElementById('treeDiv')
    );
    var node = LKSTree.treeRoot; 
    
    var node_all_templet = node.AppendURLChild(
        '所有督办类型');
    node_all_templet.isExpanded = true;
    var parameter= new Array;
    parameter[0] =  '<c:url value="/km/supervise/km_supervise_main/supervise_item_view.jsp?categoryId=!{value}"/>';
	parameter[1] = 'viewFrame';
	parameter[2] = Com_Parameter.Style;
	node_all_templet.authType="01";
	node_all_templet.AppendCategoryDataWithAdmin (
		"com.landray.kmss.km.supervise.model.KmSuperviseTemplet",
		parameter,
		'<c:url value="/km/supervise/km_supervise_main/supervise_item_view.jsp?categoryId=!{value}" />'
		,null,null,null,null,null,"10");    	
    
	var node_my_concern = node.AppendChild(
        '我关注的督办');
    //node_my_concern.isExpanded = true;
    
    var parameter= new Array;
    parameter[0] =  '<c:url value="/km/supervise/km_supervise_main/supervise_item_view.jsp?categoryId=!{value}&isMyConcern=true"/>';
	parameter[1] = 'viewFrame';
	parameter[2] = Com_Parameter.Style;
    node_my_concern.AppendBeanData(
    	"kmSuperviseMyConcernTempletService&fdValue=!{value}",parameter);
    
	LKSTree.EnableRightMenu();
    
    LKSTree.Show();
}
</template:replace>
</template:include>