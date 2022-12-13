<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<list:data>
	<list:data-columns var="kmOitemsListing" list="${queryPage.list }" varIndex="status" mobile="true">
		<list:data-column property="fdId">
		</list:data-column>
		<%-- 名称 --%>
        <list:data-column col="title">
        	<c:out value="${kmOitemsListing.fdName}" />
        </list:data-column>
        <%-- 所属分类 --%>
        <list:data-column col="categoryName">
        	<c:out value="${kmOitemsListing.fdCategory.fdName}" />
        </list:data-column>
        <%-- 单价 --%>
        <list:data-column col="fdReferencePrice" title="${lfn:message('km-oitems:kmOitemsListing.fdReferencePrice')}">
            <kmss:showNumber value='${kmOitemsListing.fdReferencePrice}' pattern='0.00#'/>
        </list:data-column>
        <%-- 库存量 --%>
        <list:data-column col="fdAmount" title="${lfn:message('km-oitems:kmOitemsListing.fdAmount') }">
        	<c:out value="${kmOitemsListing.fdAmount}" />
        </list:data-column>
    </list:data-columns>
    <list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>