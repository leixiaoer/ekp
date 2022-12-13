<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/tree_top.jsp" %>
//Com_Parameter.XMLDebug = true;
function generateTree()
{
	LKSTree = new TreeView(
		"LKSTree",
		"<bean:message key="module.km.asset" bundle="km-asset"/>",
		document.getElementById("treeDiv")
	);
	var n1, n2, n3, n4, n5;
	n1 = LKSTree.treeRoot;
	//=====================按类别=====================
	

	var parameter= new Array;
		parameter[0] = '<c:url value="/km/asset/km_asset_card/kmAssetCard.do?method=listChildren&categoryId=!{value}&categoryName=!{text}&isDialog=0&isParentCard=${JsParam.isParentCard}&status=${JsParam.status}"/>';
		parameter[1] = 'optFrame';
		parameter[2] = Com_Parameter.Style;
	
	n1.AppendSimpleCategoryData(
    	"com.landray.kmss.km.asset.model.KmAssetCategory",
    	 parameter
    );
	
	n1.isExpanded = true; 	
	
	LKSTree.EnableRightMenu();
	LKSTree.Show();
}
<%@ include file="/resource/jsp/tree_down.jsp" %>
