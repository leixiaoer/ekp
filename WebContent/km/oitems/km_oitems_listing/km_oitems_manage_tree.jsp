<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/tree_top.jsp" %>
//Com_Parameter.XMLDebug = true;
function generateTree()
{
	LKSTree = new TreeView("LKSTree", "<bean:message key="table.kmOitemsManage" bundle="km-oitems"/>",
	 document.getElementById("treeDiv"));
	LKSTree.isAutoSelectChildren = true;
	var n1, n2;
	n1 = LKSTree.treeRoot;	
	n1.AppendSimpleCategoryData(
		"com.landray.kmss.km.oitems.model.KmOitemsManage",
		"<c:url value="/km/oitems/km_oitems_listing/kmOitemsListing.do?method=list&categoryId=!{value}"/>"
	);
	LKSTree.Show();
}
<%@ include file="/resource/jsp/tree_down.jsp"%>
