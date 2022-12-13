<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmVoteMain" list="${queryPage.list }">
		<list:data-column property="fdId">
		</list:data-column>
		<!--投票主题-->
		<list:data-column  col="docSubject"  title="${ lfn:message('km-vote:kmVoteMain.docSubject') }" escape="false" style="text-align:left;">
			<a data-href="${LUI_ContextPath}/km/vote/km_vote_main/kmVoteMain.do?method=view&fdId=${kmVoteMain.fdId}" target="_blank" onclick="Com_OpenNewWindow(this)">
			   <c:out value="${kmVoteMain.docSubject}"/>
			</a>  
		</list:data-column>
		<!-- 所属分类 -->
		<list:data-column headerStyle="100px" col="fdVoteCategory" title="${ lfn:message('km-vote:kmVoteMain.fdCategoryId')}" style="width:10%"  escape="false">
			<c:out value="${kmVoteMain.fdVoteCategory.fdName}"/>
		</list:data-column>
		<!-- 目前投票数 -->
		<list:data-column headerStyle="100px" col="fdVoteNum" title="${ lfn:message('km-vote:kmVoteMain.fdVoteNum')}" style="width:10%"  escape="false">
			<kmss:showNumber value="${kmVoteMain.fdVoteNum}"/>
		</list:data-column>
		<!-- 发起者 -->
		<list:data-column headerStyle="100px" col="docCreator" title="${ lfn:message('km-vote:kmVoteMain.docCreatorId')}" style="width:10%"  escape="false">
			<c:out value="${kmVoteMain.docCreator.fdName}"/>
		</list:data-column>
		<!-- 投票开始时间 -->
		<list:data-column headerStyle="100px" col="fdEffectTime" title="${ lfn:message('km-vote:kmVoteMain.fdEffectTime')}" style="width:10%"  escape="false">
			<kmss:showDate value="${kmVoteMain.fdEffectTime}" type="date"/>
		</list:data-column>
		<!-- 投票结束时间 -->
		<list:data-column headerStyle="100px" col="fdExpireTime" title="${ lfn:message('km-vote:kmVoteMain.fdExpireTime')}" style="width:10%"  escape="false">
			<c:if test="${not empty kmVoteMain.fdExpireTime}">
				<kmss:showDate value="${kmVoteMain.fdExpireTime}" type="date"/>
			</c:if>
			<c:if test="${empty kmVoteMain.fdExpireTime}">
				<bean:message bundle="km-vote" key="kmVoteMain.null.not.limit.time" />
			</c:if>
		</list:data-column>
		<!--状态-->
		<list:data-column headerStyle="100px" col="fdVoteStatus" title="${ lfn:message('km-vote:tree.voteStatus') }" style="width:10%" escape="false">
			<sunbor:enumsShow
				value="${kmVoteMain.fdVoteStatus}"
				enumsType="kmVote_status" />
		</list:data-column>
	</list:data-columns>
	
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>