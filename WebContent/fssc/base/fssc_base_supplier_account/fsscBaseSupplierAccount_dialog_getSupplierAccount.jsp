<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="fsscBaseSupplierAccount" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column property="fdBankNo" />
        <list:data-column property="fdAccountName" title="${lfn:message('fssc-base:fsscBaseSupplierAccount.fdAccountName')}" escape="false" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column property="fdBankName" title="${lfn:message('fssc-base:fsscBaseSupplierAccount.fdBankName')}"  escape="false"/>
        <list:data-column property="fdBankAccount" title="${lfn:message('fssc-base:fsscBaseSupplierAccount.fdBankAccount')}" />
    </list:data-columns>
    <%-- 分页信息生成 --%>
    <list:data-paging page="${queryPage}" />
</list:data>
