<%@page import="com.landray.kmss.km.vote.model.KmVoteMain"%>
<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<list:data>
	<list:data-columns var="kmVoteMain" list="${queryPage.list }" varIndex="status" mobile="true">
		<list:data-column property="fdId">
		</list:data-column >
		
	    <%-- 主题--%>	
		<list:data-column col="docSubject" title="${ lfn:message('km-vote:kmVoteMain.docSubject') }" escape="false">
			<c:out value="${kmVoteMain.docSubject}"/>
		</list:data-column>
		 <%-- 创建者--%>
		<list:data-column col="creator" title="${ lfn:message('km-vote:kmVoteMain.docCreatorId') }" >
		    <c:out value="${kmVoteMain.docCreator.fdName}"/>
		</list:data-column>
		 <%-- 创建者头像--%>
		<list:data-column col="icon" escape="false">
			    <person:headimageUrl contextPath="true" personId="${kmVoteMain.docCreator.fdId}" size="m" />
		</list:data-column>
		
		 <%-- 分类--%>
	 	<list:data-column col="category" title="${ lfn:message('km-vote:table.kmVoteCategory') }">
	        <c:out value="${kmVoteMain.fdVoteCategory.fdName}"/>
      	</list:data-column>
      	<%-- 投票数--%>
	 	<list:data-column col="voteNum" title="${ lfn:message('km-vote:kmVoteMain.fdVoteNum') }" escape="false" >
	        <span class='vote_num muiFontSizeXXXXL'><c:out value="${kmVoteMain.fdVoteNum}"/></span><span class='vote_num_unit muiFontSizeS'>${ lfn:message('km-vote:kmVoteMain.votes') }</span>
      	</list:data-column>
      	<%-- 截止时间--%>
	 	<list:data-column col="expireTime" title="${ lfn:message('km-vote:kmVoteMain.fdExpireTime') }">
	 		<c:choose>
	 			<c:when test="${kmVoteMain.fdExpireTime != null}">
			        <kmss:showDate value="${kmVoteMain.fdExpireTime}" type="datetime"></kmss:showDate>	 			
	 			</c:when>
	 			<c:otherwise>
	 				${ lfn:message('km-vote:mui.kmVoteMain.unlimited')}
	 			</c:otherwise>
	        </c:choose>
      	</list:data-column>
		<%--链接--%>
		<list:data-column col="href" escape="false">
			/km/vote/km_vote_main/kmVoteMain.do?method=view&fdId=${kmVoteMain.fdId}
		</list:data-column>
		<%--是否已投票--%>
		<list:data-column col="isVoted" escape="false">
			<c:out value="${kmVoteMain.fdIsVoted}"/>
		</list:data-column>
		<%--投票状态--%>
		<list:data-column property="fdVoteStatus"></list:data-column>
		<%--文档状态--%>
		<list:data-column property="docStatus"></list:data-column>
		<%--是否可查看投票结果 --%>
		<list:data-column col="canVoteResult" escape="false">
			<%
				boolean canVoteResult = false;
				if(pageContext.getAttribute("kmVoteMain")!=null){
					KmVoteMain kmVoteMain = (KmVoteMain)pageContext.getAttribute("kmVoteMain");
					if(kmVoteMain.getFdViewer().size() > 0 
							&& kmVoteMain.getFdViewer().contains(UserUtil.getUser())){
						//存在例外人员列表中
						canVoteResult = true;
					}else if(kmVoteMain.getFdVoterViewFlag() == true 
							&& kmVoteMain.getFdVoters().contains(UserUtil.getUser()) ){
						//可投票者查看
						canVoteResult = true;
					}else if(kmVoteMain.getFdVoterViewFlag() == false 
							&& UserUtil.getUser().getFdId().equals(kmVoteMain.getDocCreator().getFdId())){
						//作者本人
						canVoteResult = true;
					}
				}
				request.setAttribute("canVoteResult", canVoteResult);
			%>
			${canVoteResult}
		</list:data-column>
		
	</list:data-columns>
	
	
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>