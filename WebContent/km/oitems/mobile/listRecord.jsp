<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<list:data>
	<list:data-columns var="kmOitemsWarehousingRecordJoinList" list="${queryPage.list }" varIndex="status" mobile="true">
		<list:data-column property="fdId">
		</list:data-column>
		<%-- 物品Id --%>
		<list:data-column col="oitemId">
			<c:out value="${kmOitemsWarehousingRecordJoinList.kmOitemsListing.fdId}" />
		</list:data-column>
		<%-- 名称 --%>
        <list:data-column col="title">
        	<c:out value="${kmOitemsWarehousingRecordJoinList.kmOitemsListing.fdName}" />
        </list:data-column>
        <%-- 所属分类 --%>
        <list:data-column col="categoryName">
        	<c:out value="${kmOitemsWarehousingRecordJoinList.kmOitemsListing.fdCategory.fdName}" />
        </list:data-column>
        <%-- 规格 --%>
        <list:data-column col="fdSpecification" title="${lfn:message('km-oitems:kmOitemsListing.fdSpecification')}">
        	<c:out value="${kmOitemsWarehousingRecordJoinList.kmOitemsListing.fdSpecification}" />
        </list:data-column>
        <%-- 品牌 --%>
        <list:data-column col="fdBrand" title="${lfn:message('km-oitems:kmOitemsListing.fdBrand')}">
        	<c:out value="${kmOitemsWarehousingRecordJoinList.kmOitemsListing.fdBrand}" />
        </list:data-column>
        <%-- 单位 --%>
        <list:data-column col="fdUnit" title="${lfn:message('km-oitems:kmOitemsListing.fdUnit')}">
        	<c:out value="${kmOitemsWarehousingRecordJoinList.kmOitemsListing.fdUnit}" />
        </list:data-column>
        <%-- 入库数量 --%>
        <list:data-column col="fdNumber" title="${lfn:message('km-oitems:kmOitemsWarehousingRecord.fdNumber')}">
        	<c:out value="${kmOitemsWarehousingRecordJoinList.fdNumber}" />
        </list:data-column>
        <%-- 当前剩余量 --%>
        <list:data-column col="fdCurNumber" title="${lfn:message('km-oitems:kmOitemsWarehousingRecord.fdCurNumber')}">
        	<c:out value="${kmOitemsWarehousingRecordJoinList.fdCurNumber}" />
        </list:data-column>
        <%-- 入库单价 --%>
        <list:data-column col="fdPrice" title="${lfn:message('km-oitems:kmOitemsWarehousingRecord.fdPrice')}">
            <kmss:showNumber value='${kmOitemsWarehousingRecordJoinList.fdPrice}' pattern='0.00#'/>
        </list:data-column>
    </list:data-columns>
    <list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>