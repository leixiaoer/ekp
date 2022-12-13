<%@ page language="java" contentType="text/plain; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.kms.knowledge.borrow.util.KmsKnowledgeBorrowUtil"%>
<%
    boolean isBorrowOpen = KmsKnowledgeBorrowUtil.checkBorrowOpen(request);
    request.setAttribute("isBorrowOpen", isBorrowOpen);
%>
[ 
	{ text:"${ lfn:message('list.approval') }", "router" : true,  href:'/approval', icon:'lui_iconfont_navleft_com_my_beapproval' }, 
	{ text:"${ lfn:message('list.approved') }", "router" : true,  href:'/approved', icon:'lui_iconfont_navleft_com_my_approvaled' }, 
	{ text:"${ lfn:message('kms-knowledge:kmsKnowledgeBaseDoc.my.draftBox')}", "router" : true,  href:'/draftBox',icon:'lui_iconfont_navleft_com_my_drafted' }, 
	{ text:"${ lfn:message('list.alldoc') }", "router" : true,  href:'/all',  icon:'lui_iconfont_navleft_com_all' },
    <c:if test="${isBorrowOpen}">
	  { text:"${lfn:message('kms-knowledge:kmsKnowledge.my.borrow') }", router:true, href:'/myBorrow', icon:'lui_iconfont_navleft_archives_borrow' }
	</c:if>
]
