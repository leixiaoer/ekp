<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="fsscBasePayBank" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column property="fdBankName" title="${lfn:message('fssc-base:fsscBasePayBank.fdBankName')}" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column property="fdBankAccount" title="${lfn:message('fssc-base:fsscBasePayBank.fdBankAccount')}" />
        <list:data-column col="fdAccountName" title="${lfn:message('fssc-base:fsscBasePayBank.fdAccountName')}">
            <c:out value="${fsscBasePayBank.fdAccountName}" />
        </list:data-column>
        <list:data-column property="fdBankNo" title="${lfn:message('fssc-base:fsscBasePayBank.fdBankNo')}" />
    </list:data-columns>
    <%-- 分页信息生成 --%>
        <list:data-paging page="${queryPage}" />
</list:data>
