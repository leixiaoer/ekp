<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/tree_top.jsp" %>
//Com_Parameter.XMLDebug = true;
function generateTree()
{
	//==========投票管理==========
	LKSTree = new TreeView( 
		"LKSTree",
		"<bean:message key="tree.voteManagement" bundle="km-vote"/>",
		document.getElementById("treeDiv")
	);
	var n1, n2, n3, n4;
	n1 = LKSTree.treeRoot;
	
	//==========我的投票==========
	n2 = n1.AppendURLChild(
		"<bean:message key="tree.myVote" bundle="km-vote" />",
		"<c:url value="/km/vote/km_vote_main/kmVoteMain.do?method=list&myVote=0" />"
	);
		//发起的投票
		n3 = n2.AppendURLChild(
			"<bean:message key="tree.myLaunchedVote" bundle="km-vote" />",
			"<c:url value="/km/vote/km_vote_main/kmVoteMain.do?method=list&myVote=1" />"
		);
		//参与的投票
		n3 = n2.AppendURLChild(
			"<bean:message key="tree.myParticipatedVote" bundle="km-vote" />",
			"<c:url value="/km/vote/km_vote_main/kmVoteMain.do?method=list&myVote=2" />"
		);
		//草稿
		n3 = n2.AppendURLChild(
			"<bean:message key="tree.doc.draft" bundle="km-vote" />",
			"<c:url value="/km/vote/km_vote_main/kmVoteMain.do?method=list&myVote=1&docStatus=10" />"
		);
		
	//==========随便看看==========
	n2 = n1.AppendURLChild(
		"<bean:message key="tree.lookLook" bundle="km-vote" />",
		"<c:url value="/km/vote/km_vote_main/kmVoteMain.do?method=list" />"
	);
		//按状态
		n3 = n2.AppendURLChild(
			"<bean:message key="tree.voteStatus" bundle="km-vote" />"
		);
			//投票中
			n4 = n3.AppendURLChild(
				"<bean:message key="tree.voteStatus.voting" bundle="km-vote" />",
				"<c:url value="/km/vote/km_vote_main/kmVoteMain.do?method=list&voteStatus=0" />"
			);
			//未开始
			n4 = n3.AppendURLChild(
				"<bean:message key="tree.voteStatus.notStarted" bundle="km-vote" />",
				"<c:url value="/km/vote/km_vote_main/kmVoteMain.do?method=list&voteStatus=1" />"
			);
			//已结束
			n4 = n3.AppendURLChild(
				"<bean:message key="tree.voteStatus.end" bundle="km-vote" />",
				"<c:url value="/km/vote/km_vote_main/kmVoteMain.do?method=list&voteStatus=2" />"
			);
		//按分类
		n3 = n2.AppendURLChild(
			"<bean:message key="tree.voteCategory" bundle="km-vote" />"
		);
		n3.AppendBeanData(
			"kmVoteCategoryTreeService",
			"<c:url value="/km/vote/km_vote_main/kmVoteMain.do?method=list&fdCategoryId=!{value}" />"
		);
		
	//==========投票搜索==========
	n2 = n1.AppendURLChild(
		"<bean:message key="tree.voteSearch" bundle="km-vote" />",
		"<c:url value="/sys/search/search.do?method=condition&fdModelName=com.landray.kmss.km.vote.model.KmVoteMain" />"
	);
	
	<kmss:authShow roles="ROLE_KMVOTECATEGORY_ADMIN">
	//==========模块设置==========
	n2 = n1.AppendURLChild(
		"<bean:message key="tree.moduleSetting" bundle="km-vote" />"
	);
		//类别设置
		n3 = n2.AppendURLChild(
			"<bean:message key="tree.votecategorySetting" bundle="km-vote" />",
			"<c:url value="/sys/simplecategory/sys_simple_category/sysCategoryMain_tree.jsp?modelName=com.landray.kmss.km.vote.model.KmVoteCategory&actionUrl=/km/vote/km_vote_category/kmVoteCategory.do&formName=kmVoteCategoryForm&mainModelName=com.landray.kmss.km.vote.model.KmVoteMain&docFkName=kmVoteCategory" />"
		);
	</kmss:authShow>
	
	LKSTree.EnableRightMenu();
	LKSTree.Show();
}
<%@ include file="/resource/jsp/tree_down.jsp" %>