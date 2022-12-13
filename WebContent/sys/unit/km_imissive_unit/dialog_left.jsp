<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="com.landray.kmss.sys.unit.util.SysUnitUtil"%>
<style>
.navbar_page  > div {
	height: 420px !important;
}
.navbar_page {
	vertical-align: top;
    background-color: #fff !important;
}
</style>
<%@ include file="/resource/jsp/nav_top.jsp" %>
var unitTree = top.dialogObject.tree;
var dataUrlInfo = unitTree.treeRoot.parameter;
var narInfoArray = new Array(
	"<bean:message bundle="sys-unit" key="sysUnitDialog.cate"/>|dialog_cate_tree.jsp"
);
if (dataUrlInfo.indexOf("showCate=true") > 0) {
	narInfoArray.push("<bean:message bundle="sys-unit" key="sysUnitDialog.allcate"/>|dialog_unit_cate_tree.jsp");
}
if (dataUrlInfo.indexOf("kmImissiveUnitUseTreeService") < 0) {
	narInfoArray.push("<bean:message bundle="sys-unit" key="sysUnitDialog.group"/>|dialog_group_tree.jsp");
}

var navBarInfo = narInfoArray;
<%@ include file="/resource/jsp/nav_down.jsp" %>