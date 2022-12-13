<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/tree_top.jsp" %>
//Com_Parameter.XMLDebug = true;
function generateTree()
{
	LKSTree = new TreeView(
		"LKSTree",
		"<bean:message key="module.km.provider" bundle="km-provider"/>",
		document.getElementById("treeDiv")
	);
	var n1, n2, n3, n4, n5;
	n1 = LKSTree.treeRoot;
	

	<%-- 供应商:按类别分类 --%>
	n2 = n1.AppendURLChild(
		"<bean:message key="table.kmProviderMain" bundle="km-provider" />",
    	"<c:url value="/km/provider/km_provider_main/index.jsp" />"
	);
	n2.AppendSimpleCategoryData(
    	"com.landray.kmss.km.provider.model.KmProviderCategory",
    	"<c:url value="/km/provider/km_provider_main/index.jsp?categoryId=!{value}&authReaderNoteFlag=2" />"
    );
	n2.isExpanded = true; 	
	
	<%-- 无效供应商 --%>
	n2 = n1.AppendURLChild(
			"<bean:message key="table.kmProviderMain.abandon" bundle="km-provider"/>",
			"<c:url value="/km/provider/km_provider_main/index.jsp?fdIsvalidate=false" />"
	);
	<%-- 供应商类别 --%>
	n2 = n1.AppendURLChild(
			"<bean:message key="table.kmProviderCategory" bundle="km-provider"/>",
			"<c:url value="/sys/simplecategory/sys_simple_category/sysCategoryMain_tree.jsp?modelName=com.landray.kmss.km.provider.model.KmProviderCategory&actionUrl=/km/provider/km_provider_category/kmProviderCategory.do&formName=kmProviderCategoryForm&mainModelName=com.landray.kmss.km.provider.model.KmProviderMain&docFkName=docCategory" />"
	);
	LKSTree.EnableRightMenu();
	LKSTree.Show();
}
<%@ include file="/resource/jsp/tree_down.jsp" %>