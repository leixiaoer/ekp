<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<list:data>
	
	
	<list:data-columns var="kmVoteComment" list="${queryPage.list }" varIndex="status">
		<list:data-column   col="fdId" escape="false"  style="text-align:left">
		    <c:out value="${kmVoteComment.fdId}"></c:out> 
		</list:data-column>
		<!--评论内容 -->
		<list:data-column   col="docContent" escape="false"  style="text-align:left">
		    <c:out value="${kmVoteComment.docContent}" escapeXml="false"></c:out> 
		</list:data-column>

		<!--创建者-->
		<list:data-column headerStyle="width:60px" col="docCreator.fdName"  escape="false"> 
		      <ui:person personId="${kmVoteComment.docCreator.fdId}" personName="${kmVoteComment.docCreator.fdName}"></ui:person> 
		</list:data-column>
		<list:data-column headerStyle="width:60px" col="docCreator.fdId"  escape="false"> 
		      ${kmVoteComment.docCreator.fdId}
		</list:data-column>
		<!--评论时间-->
		<list:data-column headerStyle="width:80px" col="docCreateTime" escape="false">
		    <kmss:showDate value="${kmVoteComment.docCreateTime}"  /> 
		</list:data-column>
		<list:data-column col="creatorIcon" escape="false">
			    <person:headimageUrl personId="${kmVoteComment.docCreator.fdId}" size="m"/>
		</list:data-column>

	</list:data-columns>



	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
	
</list:data>