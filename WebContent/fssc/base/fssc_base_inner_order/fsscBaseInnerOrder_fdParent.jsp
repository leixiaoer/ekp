<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="fsscBaseInnerOrder" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column property="fdName" title="${lfn:message('fssc-base:fsscBaseInnerOrder.fdName')}" escape="false" />
        <list:data-column property="fdCode" title="${lfn:message('fssc-base:fsscBaseInnerOrder.fdCode')}" escape="false" />
        <list:data-column col="fdCompany.name" title="${lfn:message('fssc-base:fsscBaseInnerOrder.fdCompany')}" escape="false">
            <c:out value="${fsscBaseInnerOrder.fdCompany.fdName}" />
        </list:data-column>
        <list:data-column col="fdCompany.id" escape="false">
            <c:out value="${fsscBaseInnerOrder.fdCompany.fdId}" />
        </list:data-column>
        <list:data-column col="fdIsAvailable.name" title="${lfn:message('fssc-base:fsscBaseInnerOrder.fdIsAvailable')}">
            <sunbor:enumsShow value="${fsscBaseInnerOrder.fdIsAvailable}" enumsType="common_yesno" />
        </list:data-column>
        <list:data-column col="fdIsAvailable">
            <c:out value="${fsscBaseInnerOrder.fdIsAvailable}" />
        </list:data-column>
        <list:data-column col="docCreator.name" title="${lfn:message('fssc-base:fsscBaseInnerOrder.docCreator')}" escape="false">
            <c:out value="${fsscBaseInnerOrder.docCreator.fdName}" />
        </list:data-column>
        <list:data-column col="docCreator.id" escape="false">
            <c:out value="${fsscBaseInnerOrder.docCreator.fdId}" />
        </list:data-column>
        <list:data-column col="docCreateTime" title="${lfn:message('fssc-base:fsscBaseInnerOrder.docCreateTime')}">
            <kmss:showDate value="${fsscBaseInnerOrder.docCreateTime}" type="datetime"></kmss:showDate>
        </list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
        <list:data-paging page="${queryPage}" />
</list:data>
