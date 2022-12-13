<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/tree_top.jsp" %>
//Com_Parameter.XMLDebug = true;
function generateTree()
{
	LKSTree = new TreeView("LKSTree", "<bean:message key="table.geesunOitemsManage" bundle="geesun-oitems"/>",
	 document.getElementById("treeDiv"));
	LKSTree.isAutoSelectChildren = true;
	var n1, n2;
	n1 = LKSTree.treeRoot;	
	n1.AppendSimpleCategoryData(
		"com.landray.kmss.geesun.oitems.model.GeesunOitemsManage",
		"<c:url value="/geesun/oitems/geesun_oitems_listing/geesunOitemsListing.do?method=list&categoryId=!{value}"/>"
	);
	LKSTree.Show();
}
<%@ include file="/resource/jsp/tree_down.jsp"%>
