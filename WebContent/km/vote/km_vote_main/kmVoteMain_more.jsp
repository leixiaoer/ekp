<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
	
	<c:if test="${queryPage.totalrows>0}">
		<div class="p2">
	        <h3>
	            <bean:message  bundle="km-vote" key="kmVoteMain.moreVoting"/></h3>
	        <ul>
	           <c:forEach items="${queryPage.list}" var="kmVoteMain" varStatus="vstatus">
	           		<c:if test="${vstatus.index+1<5}">
						<li><a href="#" onclick="Com_OpenWindow('<c:url value="/km/vote/km_vote_main/kmVoteMain.do" />?method=view&fdId=${kmVoteMain.fdId}','_top');">
							${vstatus.index+1}.
							<c:out value="${kmVoteMain.docSubject}" />
						</a></li>
						<c:if test="${vstatus.index+1==4}">
							<li><a href="#" onclick="Com_OpenWindow('<c:url value="/km/vote" />','_top');" >
							${lfn:message('km-vote:kmVoteMain.commentMore')}</a></li>
						</c:if>
					</c:if>
					
					
				</c:forEach>
	        </ul>
	    </div>
		
	</c:if>
