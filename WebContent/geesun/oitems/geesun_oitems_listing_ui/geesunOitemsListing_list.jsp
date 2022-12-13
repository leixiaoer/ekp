<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="geesunOitemsListing" list="${queryPage.list }">
		<list:data-column property="fdId">
		</list:data-column>
		<list:data-column headerStyle="width:80px" property="fdNo" title="${ lfn:message('geesun-oitems:geesunOitemsListing.fdNo') }">
		</list:data-column> 
		<list:data-column property="fdName" title="${ lfn:message('geesun-oitems:geesunOitemsListing.fdName') }" style="text-align:left">
		</list:data-column>
		<list:data-column headerStyle="width:120px" property="fdCategory.fdName" title="${ lfn:message('geesun-oitems:geesunOitemsListing.fdCategoryId') }">
		</list:data-column>
		<list:data-column headerStyle="width:80px" property="fdSpecification" title="${ lfn:message('geesun-oitems:geesunOitemsListing.fdSpecification') }">
		</list:data-column>
		<list:data-column headerStyle="width:80px" property="fdBrand" title="${ lfn:message('geesun-oitems:geesunOitemsListing.fdBrand') }">
		</list:data-column>
		<list:data-column headerStyle="width:50px" property="fdUnit" title="${ lfn:message('geesun-oitems:geesunOitemsListing.fdUnit') }">
		</list:data-column>
		<list:data-column headerStyle="width:60px" col="fdReferencePrice" title="${ lfn:message('geesun-oitems:geesunOitemsListing.fdReferencePrice') }" escape="false">
		   <kmss:showNumber value="${geesunOitemsListing.fdReferencePrice}" pattern="#,##0.00"></kmss:showNumber>
		</list:data-column>
		<list:data-column headerStyle="width:60px" property="fdAmount" title="${ lfn:message('geesun-oitems:geesunOitemsListing.fdAmount') }">
		</list:data-column>
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>
