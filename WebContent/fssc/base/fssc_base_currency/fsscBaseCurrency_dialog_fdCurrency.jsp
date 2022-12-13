<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="fsscBaseCurrency" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column property="fdName" title="${lfn:message('fssc-base:fsscBaseCurrency.fdName')}" escape="false" />
        <list:data-column property="fdNameEn" title="${lfn:message('fssc-base:fsscBaseCurrency.fdNameEn')}" escape="false" />
        <list:data-column property="fdSymbol" title="${lfn:message('fssc-base:fsscBaseCurrency.fdSymbol')}" escape="false" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

    </list:data-columns>
    <%-- 分页信息生成 --%>
        <list:data-paging page="${queryPage}" />
</list:data>
