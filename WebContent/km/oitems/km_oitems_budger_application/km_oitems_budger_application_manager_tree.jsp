<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/tree_top.jsp" %>
//Com_Parameter.XMLDebug = true;
function generateTree()
{
	LKSTree = new TreeView("LKSTree", '<bean:message key="kmOitems.tree.modelName" bundle="km-oitems"/>',
	 document.getElementById("treeDiv"));
	//LKSTree.isShowCheckBox=true;
	//LKSTree.isMultSel=true;
	LKSTree.isAutoSelectChildren = true;
	var n1, n2;
	n1 = LKSTree.treeRoot;	
	n2=n1.AppendURLChild(
		"<bean:message key="table.kmOitemsManage" bundle="km-oitems"/>",
		"<c:url value="/km/oitems/km_oitems_listing/kmOitemsListing.do?method=checkOitemsList&deptBudger=true&fdApplicationId=${JsParam.fdApplicationId}" />",
		"chacked"
	);
	n2.isExpanded = true;
	n2.AppendBeanData(
		"kmOitemsManageServiceCheckTree&categoryId=!{value}&deptBudger=true&fdApplicationId=${JsParam.fdApplicationId }"
	);
	LKSTree.Show();
}
<%@ include file="/resource/jsp/tree_down.jsp"%>
