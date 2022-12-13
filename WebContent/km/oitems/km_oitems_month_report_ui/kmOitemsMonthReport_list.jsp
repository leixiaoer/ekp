<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmOitemsListing" list="${queryPage.list }">
		<list:data-column property="fdId">
		</list:data-column>
		<list:data-column  property="docSubject" title="${ lfn:message('km-oitems:kmOitemsMonthReport.docSubject') }" style="text-align:left">
		</list:data-column> 
		<list:data-column property="docCreateTime" title="${ lfn:message('km-oitems:kmOitemsMonthReport.docCreateTime') }" >
		</list:data-column>
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>
