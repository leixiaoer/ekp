<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmVoteItem" list="${list}" varIndex="status" mobile="true">
		<list:data-column property="fdId">
		</list:data-column >
	    <%-- 主题--%>	
		<list:data-column property="fdName" title="${ lfn:message('km-vote:kmVoteMainItem.fdName') }" >
		</list:data-column>
		<%-- 投票数--%>	
		<list:data-column property="fdVoteItemNum" title="${ lfn:message('km-vote:kmVoteMainItem.fdVoteItemNum') }" >
		</list:data-column>
		<c:if test="${not empty kmVoteItem.fdAttId }">
			<%-- 附件 --%>	
			<list:data-column col="fdAtt" title="${ lfn:message('km-vote:kmVoteMainItem.fdVoteItemNum') }" escape="false">
				/sys/attachment/sys_att_main/sysAttMain.do?method=view&picthumb=small&fdId=${kmVoteItem.fdAttId}
			</list:data-column>
		</c:if>
	</list:data-columns>
</list:data>