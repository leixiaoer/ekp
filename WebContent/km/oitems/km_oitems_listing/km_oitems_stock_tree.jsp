<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/tree_top.jsp" %>
//Com_Parameter.XMLDebug = true;
function generateTree()
{
	LKSTree = new TreeView("LKSTree", "<bean:message key="table.kmOitemsManage" bundle="km-oitems"/>",
	 document.getElementById("treeDiv"));
	//LKSTree.isShowCheckBox=true;
	//LKSTree.isMultSel=true;
	LKSTree.isAutoSelectChildren = true;
	var n1, n2;
	n1 = LKSTree.treeRoot;	
	//var modelName = Com_GetUrlParameter(location.href,"modelName");
	n1.AppendBeanData(
		"kmOitemsManageServiceTree&categoryId=!{value}&nodeType=!{nodeType}",
		'<c:url value="/km/oitems/km_oitems_listing/kmOitemsListing.do?method=list&categoryId=!{value}&type=stock"/>'
	);
	
	LKSTree.Show();
}
<%@ include file="/resource/jsp/tree_down.jsp"%>
