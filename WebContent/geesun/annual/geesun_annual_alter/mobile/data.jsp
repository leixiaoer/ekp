<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person" %>

<list:data>
    <list:data-columns var="geesunAnnualAlter" list="${queryPage.list }" varIndex="status" mobile="true">
        <list:data-column property="fdId">
        </list:data-column>
        <list:data-column col="href" escape="false">
            /geesun/annual/geesun_annual_alter/geesunAnnualAlter.do?method=view&fdId=${geesunAnnualAlter.fdId}
        </list:data-column>


        <c:if test="${geesunAnnualAlter.docCreator.fdName!=undefined}">
            <list:data-column col="creator" title="${lfn:message('geesun-annual:geesunAnnualAlter.docCreator')}" property="docCreator.fdName" />
        </c:if>

        <list:data-column col="created" title="${lfn:message('geesun-annual:geesunAnnualAlter.docCreateTime')}">
            <kmss:showDate value="${geesunAnnualAlter.docCreateTime}" type="date"></kmss:showDate>
        </list:data-column>

        <list:data-column col="icon" escape="false">
            <person:headimageUrl personId="${geesunAnnualAlter.docCreator.fdId}" size="m" />
        </list:data-column>
    </list:data-columns>

    <list:data-paging currentPage="${queryPage.pageno }" pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
    </list:data-paging>
</list:data>
