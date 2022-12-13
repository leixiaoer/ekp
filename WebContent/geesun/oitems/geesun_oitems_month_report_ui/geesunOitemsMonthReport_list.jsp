<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="geesunOitemsListing" list="${queryPage.list }">
		<list:data-column property="fdId">
		</list:data-column>
		<list:data-column  property="docSubject" title="${ lfn:message('geesun-oitems:geesunOitemsMonthReport.docSubject') }" style="text-align:left">
		</list:data-column> 
		<list:data-column property="docCreateTime" title="${ lfn:message('geesun-oitems:geesunOitemsMonthReport.docCreateTime') }" >
		</list:data-column>
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>
