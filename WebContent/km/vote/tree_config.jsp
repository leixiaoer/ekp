<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include file="/sys/profile/resource/template/tree.jsp">
    <template:replace name="content">
//Com_Parameter.XMLDebug = true;
function generateTree()
{
	//==========投票管理==========
	LKSTree = new TreeView( 
		"LKSTree",
		"<bean:message key="tree.voteManagement" bundle="km-vote"/>",
		document.getElementById("treeDiv")
	);
	var n1, n2, n3,defaultNode;
	n1 = LKSTree.treeRoot;
	
	//基础配置
	<kmss:authShow roles="ROLE_KMVOTEMAIN_BACKSTAGE_MANAGER">
		n1.AppendURLChild(
		"<bean:message bundle="km-vote" key="kmVoteMain.param.config"/>",
		"<c:url value="/sys/appconfig/sys_appconfig/sysAppConfig.do?method=edit&modelName=com.landray.kmss.km.vote.model.KmVoteConfig" />"
	    );
	</kmss:authShow>
      
	//==========模块设置==========
	//类别设置
	defaultNode = n1.AppendURLChild(
		"<bean:message key="tree.votecategorySetting" bundle="km-vote" />",
		"<c:url value="/sys/simplecategory/sys_simple_category/sysCategoryMain_tree.jsp?modelName=com.landray.kmss.km.vote.model.KmVoteCategory&actionUrl=/km/vote/km_vote_category/kmVoteCategory.do&formName=kmVoteCategoryForm&mainModelName=com.landray.kmss.km.vote.model.KmVoteMain&docFkName=fdVoteCategory" />"
	);
	
	n2 = n1.AppendURLChild("<bean:message key="tree.sysCategory.maintains" bundle="sys-category" />")
	n2.authType="01";
	n2.AppendSimpleCategoryDataWithAdmin ("com.landray.kmss.km.vote.model.KmVoteCategory","<c:url value="/km/vote/km_vote_main/kmVoteMain.do?method=manageList&categoryId=!{value}&docStatus=all"/>","<c:url value="/km/vote/km_vote_main/kmVoteMain.do?method=listChildren&categoryId=!{value}&orderby=docPublishTime&ordertype=down" />");

	
	LKSTree.EnableRightMenu();
	LKSTree.Show();
	LKSTree.ClickNode(defaultNode);
	
}
 </template:replace>
</template:include>