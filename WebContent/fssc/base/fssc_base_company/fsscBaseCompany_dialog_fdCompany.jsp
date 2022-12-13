<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="fsscBaseCompany" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column property="fdName" title="${lfn:message('fssc-base:fsscBaseCompany.fdName')}" escape="false" />
        <list:data-column property="fdCode" title="${lfn:message('fssc-base:fsscBaseCompany.fdCode')}" escape="false" />
        <list:data-column col="fdBudgetCurrency.name" title="${lfn:message('fssc-base:fsscBaseCompany.fdBudgetCurrency')}" escape="false">
            <c:out value="${fsscBaseCompany.fdBudgetCurrency.fdName}" />
        </list:data-column>
        <list:data-column col="fdBudgetCurrency.id" escape="false">
            <c:out value="${fsscBaseCompany.fdBudgetCurrency.fdId}" />
        </list:data-column>
        <list:data-column col="fdAccountCurrency.name" title="${lfn:message('fssc-base:fsscBaseCompany.fdAccountCurrency')}" escape="false">
            <c:out value="${fsscBaseCompany.fdAccountCurrency.fdName}" />
        </list:data-column>
        <list:data-column col="fdAccountCurrency.id" escape="false">
            <c:out value="${fsscBaseCompany.fdAccountCurrency.fdId}" />
        </list:data-column>
        <list:data-column col="fdIsAvailable.name" title="${lfn:message('fssc-base:fsscBaseCompany.fdIsAvailable')}">
            <sunbor:enumsShow value="${fsscBaseCompany.fdIsAvailable}" enumsType="common_yesno" />
        </list:data-column>
        <list:data-column col="fdIsAvailable">
            <c:out value="${fsscBaseCompany.fdIsAvailable}" />
        </list:data-column>
        <list:data-column property="fdJoinSystem" title="${lfn:message('fssc-base:fsscBaseCompany.fdJoinSystem')}" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

    </list:data-columns>
    <%-- 分页信息生成 --%>
        <list:data-paging page="${queryPage}" />
</list:data>
