<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="geesunBaseProject" list="${queryPage.list}" varIndex="status" custom="false">
        <list:data-column property="fdId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column property="fdName" title="${lfn:message('geesun-base:geesunBaseProject.fdName')}" />
        <list:data-column property="fdProjectNo" title="${lfn:message('geesun-base:geesunBaseProject.fdProjectNo')}" />
        <list:data-column property="fdOrder" title="${lfn:message('geesun-base:geesunBaseProject.fdOrder')}" />
        <list:data-column col="fdIsAvailable.name" title="${lfn:message('geesun-base:geesunBaseProject.fdIsAvailable')}">
            <sunbor:enumsShow value="${geesunBaseProject.fdIsAvailable}" enumsType="common_yesno" />
        </list:data-column>
        <list:data-column col="fdIsAvailable">
            <c:out value="${geesunBaseProject.fdIsAvailable}" />
        </list:data-column>
        <list:data-column col="docCreator.name" title="${lfn:message('geesun-base:geesunBaseProject.docCreator')}" escape="false">
            <c:out value="${geesunBaseProject.docCreator.fdName}" />
        </list:data-column>
        <list:data-column col="docCreator.id" escape="false">
            <c:out value="${geesunBaseProject.docCreator.fdId}" />
        </list:data-column>
        <list:data-column col="docCreateTime" title="${lfn:message('geesun-base:geesunBaseProject.docCreateTime')}">
            <kmss:showDate value="${geesunBaseProject.docCreateTime}" type="datetime"></kmss:showDate>
        </list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
    <list:data-paging page="${queryPage}" />
</list:data>
