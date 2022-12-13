<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="fsscBaseExpenseItem" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column property="fdName" title="${lfn:message('fssc-base:fsscBaseExpenseItem.fdName')}" escape="false" />
        <list:data-column property="fdCode" title="${lfn:message('fssc-base:fsscBaseExpenseItem.fdCode')}" escape="false" />
        <list:data-column col="fdCompany.name" title="${lfn:message('fssc-base:fsscBaseExpenseItem.fdCompany')}" escape="false">
            <c:out value="${fsscBaseExpenseItem.fdCompany.fdName}" />
        </list:data-column>
        <list:data-column col="fdCompany.id" escape="false">
            <c:out value="${fsscBaseExpenseItem.fdCompany.fdId}" />
        </list:data-column>
        <list:data-column col="fdParent.name" title="${lfn:message('fssc-base:fsscBaseExpenseItem.fdParent')}" escape="false">
            <c:out value="${fsscBaseExpenseItem.fdParent.fdName}" />
        </list:data-column>
        <list:data-column col="fdParent.id" escape="false">
            <c:out value="${fsscBaseExpenseItem.fdParent.fdId}" />
        </list:data-column>
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

    </list:data-columns>
    <%-- 分页信息生成 --%>
        <list:data-paging page="${queryPage}" />
</list:data>
