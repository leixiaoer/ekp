<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="fsscBaseInputTax" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column col="fdCompany.name" title="${lfn:message('fssc-base:fsscBaseInputTax.fdCompany')}" escape="false">
            <c:out value="${fsscBaseInputTax.fdCompany.fdName}" />
        </list:data-column> 
         <list:data-column col="fdTaxRate" title="${lfn:message('fssc-base:fsscBaseInputTax.fdTaxRate')}" >
        	${fsscBaseInputTax.fdTaxRate}%
        </list:data-column> 
        <list:data-column col="fdAccount.name" title="${lfn:message('fssc-base:fsscBaseInputTax.fdAccount')}" escape="false">
            <c:out value="${fsscBaseInputTax.fdAccount.fdName}" />
        </list:data-column>
       
        <list:data-column col="fdAccount.id" escape="false">
            <c:out value="${fsscBaseInputTax.fdAccount.fdId}" />
        </list:data-column>
        <list:data-column col="fdCompany.id" escape="false">
            <c:out value="${fsscBaseInputTax.fdCompany.fdId}" />
        </list:data-column>
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

    </list:data-columns>
    <%-- 分页信息生成 --%>
        <list:data-paging page="${queryPage}" />
</list:data>
