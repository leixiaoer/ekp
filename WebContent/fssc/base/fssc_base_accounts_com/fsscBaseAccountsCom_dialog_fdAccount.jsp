<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="fsscBaseAccountsCom" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column property="fdCostItem" />
        <list:data-column property="fdName" title="${lfn:message('fssc-base:fsscBaseAccountsCom.fdName')}" />
        <list:data-column property="fdCode" title="${lfn:message('fssc-base:fsscBaseAccountsCom.fdCode')}" />
        <list:data-column col="fdCompany.name" title="${lfn:message('fssc-base:fsscBaseAccountsCom.fdCompany')}" escape="false">
            <c:out value="${fsscBaseAccountsCom.fdCompany.fdName}" />
        </list:data-column>
        <list:data-column col="fdCompany.id" escape="false">
            <c:out value="${fsscBaseAccountsCom.fdCompany.fdId}" />
        </list:data-column>
        <list:data-column col="fdParent.name" title="${lfn:message('fssc-base:fsscBaseAccountsCom.fdParent')}" escape="false">
            <c:out value="${fsscBaseAccountsCom.fdParent.fdName}" />
        </list:data-column>
        <list:data-column col="fdParent.id" escape="false">
            <c:out value="${fsscBaseAccountsCom.fdParent.fdId}" />
        </list:data-column>
        <list:data-column col="fdStatus.name" title="${lfn:message('fssc-base:fsscBaseAccountsCom.fdStatus')}">
            <sunbor:enumsShow value="${fsscBaseAccountsCom.fdStatus}" enumsType="fssc_base_doc_status" />
        </list:data-column>
        <list:data-column col="fdStatus">
            <c:out value="${fsscBaseAccountsCom.fdStatus}" />
        </list:data-column>
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

    </list:data-columns>
    <%-- 分页信息生成 --%>
        <list:data-paging page="${queryPage}" />
</list:data>
