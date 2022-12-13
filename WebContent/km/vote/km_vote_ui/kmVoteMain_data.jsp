<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="item" list="${queryPage.list}" varIndex="status">
	
		<list:data-column col="fdId">
			 ${item.fdId}
		</list:data-column>
		<list:data-column col="docSubject">
			 ${item.docSubject}
		</list:data-column>
		<list:data-column col="fdVoteNum">
			${item.fdVoteNum}
		</list:data-column>
		<list:data-column col="docCreator">
			 ${item.docCreator["fdName"]}
		</list:data-column>
		<list:data-column col="docCreateTime">
			 ${fn:substring(item.docCreateTime, 0, 16)}
		</list:data-column>
		<list:data-column col="fdIsStart">
			 ${item.fdIsStart}
		</list:data-column>
		<list:data-column col="fdEffectTime">
			 ${item.fdEffectTime}
		</list:data-column>
		<list:data-column col="fdExpireTime">
			 ${item.fdExpireTime}
		</list:data-column>
		<list:data-column col="fdIsVoted">
			 ${item.fdIsVoted}
		</list:data-column>
		<list:data-column col="fdAuthVoteFlag">
			 ${item.fdAuthVoteFlag}
		</list:data-column>
		
	</list:data-columns>
	
	<list:data-paging page="${queryPage}" />
</list:data>