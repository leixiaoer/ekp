<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="fsscBaseBudgetItem" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column property="fdName" title="${lfn:message('fssc-base:fsscBaseBudgetItem.fdName')}" />
        <list:data-column property="fdCode" title="${lfn:message('fssc-base:fsscBaseBudgetItem.fdCode')}" />
        <list:data-column property="fdParent.fdName" title="${lfn:message('fssc-base:fsscBaseBudgetItem.fdParent')}" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

    </list:data-columns>
    <%-- 分页信息生成 --%>
        <list:data-paging page="${queryPage}" />
</list:data>
