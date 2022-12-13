<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="fsscBaseBudgetItemCom" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column property="fdName" title="${lfn:message('fssc-base:fsscBaseBudgetItemCom.fdName')}" />
        <list:data-column property="fdCode" title="${lfn:message('fssc-base:fsscBaseBudgetItemCom.fdCode')}" />
        <list:data-column col="fdCompany.name" title="${lfn:message('fssc-base:fsscBaseBudgetItemCom.fdCompany')}" escape="false">
            <c:out value="${fsscBaseBudgetItemCom.fdCompany.fdName}" />
        </list:data-column>
        <list:data-column col="fdCompany.id" escape="false">
            <c:out value="${fsscBaseBudgetItemCom.fdCompany.fdId}" />
        </list:data-column>
        <list:data-column col="fdParent.name" title="${lfn:message('fssc-base:fsscBaseBudgetItemCom.fdParent')}" escape="false">
            <c:out value="${fsscBaseBudgetItemCom.fdParent.fdName}" />
        </list:data-column>
        <list:data-column col="fdParent.id" escape="false">
            <c:out value="${fsscBaseBudgetItemCom.fdParent.fdId}" />
        </list:data-column>
        <list:data-column col="fdStatus.name" title="${lfn:message('fssc-base:fsscBaseBudgetItemCom.fdStatus')}">
            <sunbor:enumsShow value="${fsscBaseBudgetItemCom.fdStatus}" enumsType="fssc_base_doc_status" />
        </list:data-column>
        <list:data-column col="fdStatus">
            <c:out value="${fsscBaseBudgetItemCom.fdStatus}" />
        </list:data-column>
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

    </list:data-columns>
    <%-- 分页信息生成 --%>
        <list:data-paging page="${queryPage}" />
</list:data>
