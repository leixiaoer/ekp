<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="sysPostMiddle" list="${queryPage.list}" varIndex="status">
		<list:data-column property="fdId">
		</list:data-column>
		<list:data-column col="index">
		  ${status+1}
		</list:data-column>
		
		<list:data-column property="objid" title="${ lfn:message('geesun-org:sysPostMiddle.objid') }">
		</list:data-column>
		<list:data-column property="stext" title="${ lfn:message('geesun-org:sysPostMiddle.stext') }">
		</list:data-column>
		<list:data-column property="objidUp" title="${ lfn:message('geesun-org:sysPostMiddle.objidUp') }">
		</list:data-column>
		<list:data-column property="objidSUp" title="${ lfn:message('geesun-org:sysPostMiddle.objidSUp') }">
		</list:data-column>
		<list:data-column property="priox" title="${ lfn:message('geesun-org:sysPostMiddle.priox') }">
		</list:data-column>
		<list:data-column col="zsfyx" title="${ lfn:message('geesun-org:sysPostMiddle.zsfyx') }">
			<sunbor:enumsShow
				value="${sysPostMiddle.zsfyx}"
				enumsType="common_yesno" />
		</list:data-column>
	</list:data-columns>
	
	<list:data-paging page="${queryPage}" />
</list:data>
