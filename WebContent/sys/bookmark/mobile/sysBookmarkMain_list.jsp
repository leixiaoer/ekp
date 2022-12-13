<%@ page language="java" contentType="text/json; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="item" list="${queryPage.list}"
		varIndex="status">

		<list:data-column property="fdId">
		</list:data-column>

		<list:data-column property="docSubject" >
		</list:data-column>
		<list:data-column property="docCreateTime" >
		</list:data-column>

		<list:data-column col="href" escape="false">
		${item.fdUrl }
		</list:data-column>
	</list:data-columns>

	<list:data-paging page="${queryPage}" />
</list:data>