<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="fsscBaseMaterialType" list="${queryPage.list}" varIndex="status" custom="false">
        <list:data-column property="fdId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column property="fdName" title="${lfn:message('fssc-base:fsscBaseMaterialType.fdName')}" />
        <list:data-column property="fdCode" title="${lfn:message('fssc-base:fsscBaseMaterialType.fdCode')}" />
        <list:data-column col="fdIsAvailable.name" title="${lfn:message('fssc-base:fsscBaseMaterialType.fdIsAvailable')}">
            <sunbor:enumsShow value="${fsscBaseMaterialType.fdIsAvailable}" enumsType="common_yesno" />
        </list:data-column>
        <list:data-column col="fdIsAvailable">
            <c:out value="${fsscBaseMaterialType.fdIsAvailable}" />
        </list:data-column>
        <list:data-column col="docCreator.name" title="${lfn:message('fssc-base:fsscBaseMaterialType.docCreator')}" escape="false">
            <c:out value="${fsscBaseMaterialType.docCreator.fdName}" />
        </list:data-column>
        <list:data-column col="docCreator.id" escape="false">
            <c:out value="${fsscBaseMaterialType.docCreator.fdId}" />
        </list:data-column>
        <list:data-column col="docCreateTime" title="${lfn:message('fssc-base:fsscBaseMaterialType.docCreateTime')}">
            <kmss:showDate value="${fsscBaseMaterialType.docCreateTime}" type="datetime"></kmss:showDate>
        </list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
    <list:data-paging page="${queryPage}" />
</list:data>
