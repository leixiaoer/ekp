<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/tree_top.jsp" %>
//Com_Parameter.XMLDebug = true;
function generateTree()
{
	LKSTree = new TreeView("LKSTree", '<bean:message key="geesunOitems.tree.modelName" bundle="geesun-oitems"/>',
	 document.getElementById("treeDiv"));
	//LKSTree.isShowCheckBox=true;
	//LKSTree.isMultSel=true;
	LKSTree.isAutoSelectChildren = true;
	var n1, n2;
	n1 = LKSTree.treeRoot;	
	n2=n1.AppendURLChild(
		"<bean:message key="table.geesunOitemsManage" bundle="geesun-oitems"/>",
		"<c:url value="/geesun/oitems/geesun_oitems_listing/geesunOitemsListing.do?method=checkOitemsList&deptBudger=true&fdApplicationId=${JsParam.fdApplicationId}" />",
		"chacked"
	);
	n2.isExpanded = true;
	n2.AppendBeanData(
		"geesunOitemsManageServiceCheckTree&categoryId=!{value}&deptBudger=true&fdApplicationId=${JsParam.fdApplicationId }"
	);
	LKSTree.Show();
}
<%@ include file="/resource/jsp/tree_down.jsp"%>
