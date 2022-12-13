<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include file="/sys/profile/resource/template/tree.jsp">
	<template:replace name="content">
	function generateTree() {
		LKSTree = new TreeView(
			"LKSTree",
			"<bean:message key="sysSearchCate.title" bundle="sys-search" />",
			document.getElementById("treeDiv")
		);
		var n1, n2, defaultNode;
		<!-- 搜索分类 -->
		n1 = LKSTree.treeRoot;
		n1.AppendBeanData(
			"sysSearchCateService&parentId=!{value}&item=fdName:fdId&addNode=true",
			"<c:url value="/sys/search/ui/nav_search_new_showTree.jsp?category=!{value}&modelName=${JsParam.fdModelName }&searchTitle=${JsParam.searchTitle }"/>"
		);
		
		LKSTree.EnableRightMenu();
		LKSTree.Show();
		setTimeout(function(){
			LKSTree.ClickNode(LKSTree.treeRoot.firstChild);
		},500);
	}
	</template:replace>
</template:include>