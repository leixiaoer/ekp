<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="geesunOrgEkp" list="${queryPage.list}" varIndex="status">
		<list:data-column property="fdId">
		</list:data-column>
		<list:data-column col="index">
		  ${status+1}
		</list:data-column>
		
		<list:data-column col="fdResult" title="${ lfn:message('geesun-org:geesunOrgEkp.fdResult') }">
			<sunbor:enumsShow
				value="${geesunOrgEkp.fdResult}"
				enumsType="geesunOrgEkp_fdResult" />
		</list:data-column>
		<list:data-column col="fdType" title="${ lfn:message('geesun-org:geesunOrgEkp.fdType') }">
			<sunbor:enumsShow
				value="${geesunOrgEkp.fdType}"
				enumsType="geesunOrgEkp_fdType" />
		</list:data-column>
		<list:data-column col="docCreateTime" title="${ lfn:message('geesun-org:geesunOrgEkp.docCreateTime') }">
			<kmss:showDate value="${geesunOrgEkp.docCreateTime}" type="datetime"></kmss:showDate>
		</list:data-column>
	</list:data-columns>
	
	<list:data-paging page="${queryPage}" />
</list:data>
