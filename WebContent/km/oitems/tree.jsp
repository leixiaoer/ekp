<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include file="/sys/profile/resource/template/tree.jsp">
    <template:replace name="content">
//Com_Parameter.XMLDebug = true;
function generateTree()
{
	LKSTree = new TreeView(
		"LKSTree",
		"<bean:message key="kmOitems.tree.modelName" bundle="km-oitems"/>",
		document.getElementById("treeDiv")
	);
	var n1, n2,n3,defaultNode;
	n1 = LKSTree.treeRoot;
	//========== 我的文档 ==========
		//类别设置
	defaultNode = n1.AppendURLChild(
		"<bean:message bundle="km-oitems" key="kmOitems.tree.baseset1"/>",
		"<c:url value="/sys/simplecategory/sys_simple_category/sysCategoryMain_tree.jsp?modelName=com.landray.kmss.km.oitems.model.KmOitemsManage&actionUrl=/km/oitems/km_oitems_manage/kmOitemsManage.do&formName=kmOitemsManageForm&mainModelName=com.landray.kmss.km.oitems.model.KmOitemsListing&docFkName=fdCategory" />"
	);
	
	//基础设置
	n2 = n1.AppendURLChild("<bean:message key="kmOitems.tree.baseset" bundle="km-oitems" />");
	
	n2.isExpanded = true;
	//n2.AppendURLChild("<bean:message key="kmOitems.tree.baseset1" bundle="km-oitems" />",
	//"<c:url value="/km/oitems/km_oitems_manage/kmOitemsManage.do?method=list" />"
	//);

	n2.AppendURLChild("<bean:message key="kmOitems.tree.baseset2" bundle="km-oitems" />",	
	"<c:url value="/km/oitems/km_oitems_templet/index.jsp?type=person" />"
	
	);
	
	n2.AppendURLChild("<bean:message key="kmOitems.tree.baseset3" bundle="km-oitems" />",
	"<c:url value="/km/oitems/km_oitems_templet/index.jsp?type=dept" />"
	);
	<kmss:authShow roles="ROLE_KM_KMOITEMS_BASE_ADMIN">
		n2.AppendURLChild(
			"<bean:message bundle="sys-number" key="table.sysNumberMain"/>",
			"<c:url value="/sys/number/sys_number_main/index.jsp?&modelName=com.landray.kmss.km.oitems.model.KmOitemsBudgerApplication" />"
		);
	</kmss:authShow>
	<kmss:authShow roles="ROLE_KM_KMOITEMS_BASE_ADMIN;ROLE_KMOITEMS_ADMIN">
	n2.AppendURLChild("<bean:message key="kmOitems.tree.baseset4" bundle="km-oitems" />",
	"<c:url value="/sys/lbpmservice/support/lbpm_template/index.jsp?fdModelName=com.landray.kmss.km.oitems.model.KmOitemsTemplet&fdKey=kmOitemsTemplet" />"
	);
	</kmss:authShow>
	n2.AppendURLChild(
		"<bean:message key="sys.profile.list.display.config" bundle="sys-profile"/>",
		"<c:url value="/sys/profile/listShow/sys_listshow_category/index.jsp?modelName=com.landray.kmss.km.oitems.model.KmOitemsBudgerApplication"/>"
	);
	n2 = n1.AppendURLChild("<bean:message key="tree.sysCategory.maintains" bundle="sys-category" />")
	n2.authType="01";
	n2.AppendSimpleCategoryDataWithAdmin ("com.landray.kmss.km.oitems.model.KmOitemsManage","<c:url value="/km/oitems/km_oitems_listing/kmOitemsListing.do?method=listChileren&categoryId=!{value}&docStatus=all"/>","<c:url value="/km/oitems/km_oitems_listing/kmOitemsListing.do?method=listChileren&categoryId=!{value}&orderby=docPublishTime&ordertype=down" />");
	LKSTree.EnableRightMenu();
	LKSTree.Show();
	LKSTree.ClickNode(defaultNode);
}
</template:replace>
</template:include>