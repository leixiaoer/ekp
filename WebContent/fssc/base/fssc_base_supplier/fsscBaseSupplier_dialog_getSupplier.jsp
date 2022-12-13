<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="fsscBaseSupplier" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column property="fdName" title="${lfn:message('fssc-base:fsscBaseSupplier.fdName')}" escape="false" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column property="fdCode" title="${lfn:message('fssc-base:fsscBaseSupplier.fdCode')}"  escape="false"/>
        <list:data-column col="fdCompany.name" title="${lfn:message('fssc-base:fsscBaseSupplier.fdCompany')}" escape="false">
            <c:out value="${fsscBaseSupplier.fdCompany.fdName}" />
        </list:data-column>
        <list:data-column col="fdCompany.id" escape="false">
            <c:out value="${fsscBaseSupplier.fdCompany.fdId}" />
        </list:data-column>
        <list:data-column col="docCreateTime" title="${lfn:message('fssc-base:fsscBaseSupplier.docCreateTime')}">
            <kmss:showDate value="${fsscBaseSupplier.docCreateTime}" type="date"></kmss:showDate>
        </list:data-column>
        <list:data-column col="docCreator.name" title="${lfn:message('fssc-base:fsscBaseSupplier.docCreator')}" escape="false">
            <c:out value="${fsscBaseSupplier.docCreator.fdName}" />
        </list:data-column>
        <list:data-column col="docCreator.id" escape="false">
            <c:out value="${fsscBaseSupplier.docCreator.fdId}" />
        </list:data-column>
        <list:data-column property="fdTaxNo" title="${lfn:message('fssc-base:fsscBaseSupplier.fdTaxNo')}" />
        <list:data-column property="fdAddress" title="${lfn:message('fssc-base:fsscBaseSupplier.fdAddress')}"  escape="false"/>
        <list:data-column property="fdPhoneNo" title="${lfn:message('fssc-base:fsscBaseSupplier.fdPhoneNo')}" />
    </list:data-columns>
    <%-- 分页信息生成 --%>
    <list:data-paging page="${queryPage}" />
</list:data>
