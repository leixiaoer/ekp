<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="fsscBaseTaxRate" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column col="fdCompany.name" title="${lfn:message('fssc-base:fsscBaseTaxRate.fdCompany')}" escape="false">
            <c:out value="${fsscBaseTaxRate.fdCompany.fdName}" />
        </list:data-column>
        
        <list:data-column col="fdAccount.name" title="${lfn:message('fssc-base:fsscBaseTaxRate.fdAccount')}" escape="false">
            <c:out value="${fsscBaseTaxRate.fdAccount.fdName}" />
        </list:data-column>
        <list:data-column col="fdRate" title="${lfn:message('fssc-base:fsscBaseTaxRate.fdRate')}" >
        	${fsscBaseTaxRate.fdRate}%
        </list:data-column>
        <list:data-column col="fdAccount.id" escape="false">
            <c:out value="${fsscBaseTaxRate.fdAccount.fdId}" />
        </list:data-column>
        <list:data-column col="fdCompany.id" escape="false">
            <c:out value="${fsscBaseTaxRate.fdCompany.fdId}" />
        </list:data-column>
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

    </list:data-columns>
    <%-- 分页信息生成 --%>
        <list:data-paging page="${queryPage}" />
</list:data>
