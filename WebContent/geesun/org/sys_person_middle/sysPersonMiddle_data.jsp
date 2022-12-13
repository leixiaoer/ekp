<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="sysPersonMiddle" list="${queryPage.list}" varIndex="status">
		<list:data-column property="fdId">
		</list:data-column>
		<list:data-column col="index">
		  ${status+1}
		</list:data-column>
		
		<list:data-column property="pernr" title="${ lfn:message('geesun-org:sysPersonMiddle.pernr') }">
		</list:data-column>
		<list:data-column property="nachn" title="${ lfn:message('geesun-org:sysPersonMiddle.nachn') }">
		</list:data-column>
		<list:data-column property="vnamc" title="${ lfn:message('geesun-org:sysPersonMiddle.vnamc') }">
		</list:data-column>
		<list:data-column property="orger" title="${ lfn:message('geesun-org:sysPersonMiddle.orger') }">
		</list:data-column>
		<list:data-column property="plans01" title="${ lfn:message('geesun-org:sysPersonMiddle.plans01') }">
		</list:data-column>
		<list:data-column property="plans02" title="${ lfn:message('geesun-org:sysPersonMiddle.plans02') }">
		</list:data-column>
		<list:data-column property="phone" title="${ lfn:message('geesun-org:sysPersonMiddle.phone') }">
		</list:data-column>
		<list:data-column property="email" title="${ lfn:message('geesun-org:sysPersonMiddle.email') }">
		</list:data-column>
		<list:data-column property="ccall" title="${ lfn:message('geesun-org:sysPersonMiddle.ccall') }">
		</list:data-column>
		<list:data-column property="wxid" title="${ lfn:message('geesun-org:sysPersonMiddle.wxid') }">
		</list:data-column>
		<list:data-column property="gender" title="${ lfn:message('geesun-org:sysPersonMiddle.gender') }">
		</list:data-column>
		<list:data-column col="zsfyx" title="${ lfn:message('geesun-org:sysPersonMiddle.zsfyx') }">
			<sunbor:enumsShow
				value="${sysPersonMiddle.zsfyx}"
				enumsType="common_yesno" />
		</list:data-column>
	</list:data-columns>
	
	<list:data-paging page="${queryPage}" />
</list:data>
