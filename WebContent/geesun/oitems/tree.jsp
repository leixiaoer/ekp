<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include file="/sys/profile/resource/template/tree.jsp">
    <template:replace name="content">
//Com_Parameter.XMLDebug = true;
function generateTree()
{
	LKSTree = new TreeView(
		"LKSTree",
		"<bean:message key="geesunOitems.tree.modelName" bundle="geesun-oitems"/>",
		document.getElementById("treeDiv")
	);
	var n1, n2,n3,defaultNode;
	n1 = LKSTree.treeRoot;
	//========== 我的文档 ==========
		//类别设置
	defaultNode = n1.AppendURLChild(
		"<bean:message bundle="geesun-oitems" key="geesunOitems.tree.baseset1"/>",
		"<c:url value="/sys/simplecategory/sys_simple_category/sysCategoryMain_tree.jsp?modelName=com.landray.kmss.geesun.oitems.model.GeesunOitemsManage&actionUrl=/geesun/oitems/geesun_oitems_manage/geesunOitemsManage.do&formName=geesunOitemsManageForm&mainModelName=com.landray.kmss.geesun.oitems.model.GeesunOitemsListing&docFkName=fdCategory" />"
	);
	
	//基础设置
	n2 = n1.AppendURLChild("<bean:message key="geesunOitems.tree.baseset" bundle="geesun-oitems" />");
	
	n2.isExpanded = true;
	//n2.AppendURLChild("<bean:message key="geesunOitems.tree.baseset1" bundle="geesun-oitems" />",
	//"<c:url value="/geesun/oitems/geesun_oitems_manage/geesunOitemsManage.do?method=list" />"
	//);

	n2.AppendURLChild("<bean:message key="geesunOitems.tree.baseset2" bundle="geesun-oitems" />",	
	"<c:url value="/geesun/oitems/geesun_oitems_templet/index.jsp?type=person" />"
	
	);
	
	n2.AppendURLChild("<bean:message key="geesunOitems.tree.baseset3" bundle="geesun-oitems" />",
	"<c:url value="/geesun/oitems/geesun_oitems_templet/index.jsp?type=dept" />"
	);
	<kmss:authShow roles="ROLE_KM_GEESUNOITEMS_BASE_ADMIN">
		n2.AppendURLChild(
			"<bean:message bundle="sys-number" key="table.sysNumberMain"/>",
			"<c:url value="/sys/number/sys_number_main/index.jsp?&modelName=com.landray.kmss.geesun.oitems.model.GeesunOitemsBudgerApplication" />"
		);
	</kmss:authShow>
	<kmss:authShow roles="ROLE_KM_GEESUNOITEMS_BASE_ADMIN;ROLE_GEESUNOITEMS_ADMIN">
	n2.AppendURLChild("<bean:message key="geesunOitems.tree.baseset4" bundle="geesun-oitems" />",
	"<c:url value="/sys/lbpmservice/support/lbpm_template/index.jsp?fdModelName=com.landray.kmss.geesun.oitems.model.GeesunOitemsTemplet&fdKey=geesunOitemsTemplet" />"
	);
	</kmss:authShow>
	n2.AppendURLChild(
		"<bean:message key="sys.profile.list.display.config" bundle="sys-profile"/>",
		"<c:url value="/sys/profile/listShow/sys_listshow_category/index.jsp?modelName=com.landray.kmss.geesun.oitems.model.GeesunOitemsBudgerApplication"/>"
	);
	n2 = n1.AppendURLChild("<bean:message key="tree.sysCategory.maintains" bundle="sys-category" />")
	n2.authType="01";
	n2.AppendSimpleCategoryDataWithAdmin ("com.landray.kmss.geesun.oitems.model.GeesunOitemsManage","<c:url value="/geesun/oitems/geesun_oitems_listing/geesunOitemsListing.do?method=listChileren&categoryId=!{value}&docStatus=all"/>","<c:url value="/geesun/oitems/geesun_oitems_listing/geesunOitemsListing.do?method=listChileren&categoryId=!{value}&orderby=docPublishTime&ordertype=down" />");
	LKSTree.EnableRightMenu();
	LKSTree.Show();
	LKSTree.ClickNode(defaultNode);
}
</template:replace>
</template:include>
