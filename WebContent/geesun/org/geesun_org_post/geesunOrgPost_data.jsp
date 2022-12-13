<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="geesunOrgPost" list="${queryPage.list}" varIndex="status" custom="false">
        <list:data-column property="fdId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column property="fdPostId" title="${lfn:message('geesun-org:geesunOrgPost.fdPostId')}" />
        <list:data-column property="fdPostName" title="${lfn:message('geesun-org:geesunOrgPost.fdPostName')}" />
        <list:data-column property="fdParentId" title="${lfn:message('geesun-org:geesunOrgPost.fdParentId')}" />
        <list:data-column property="fdPostNo" title="${lfn:message('geesun-org:geesunOrgPost.fdPostNo')}" />
        <list:data-column col="fdQidongDate" title="${lfn:message('geesun-org:geesunOrgPost.fdQidongDate')}">
            <kmss:showDate value="${geesunOrgPost.fdQidongDate}" type="date"></kmss:showDate>
        </list:data-column>
        <list:data-column col="fdNewDate" title="${lfn:message('geesun-org:geesunOrgPost.fdNewDate')}">
            <kmss:showDate value="${geesunOrgPost.fdNewDate}" type="datetime"></kmss:showDate>
        </list:data-column>
        <list:data-column col="docCreateTime" title="${lfn:message('geesun-org:geesunOrgPost.docCreateTime')}">
            <kmss:showDate value="${geesunOrgPost.docCreateTime}" type="datetime"></kmss:showDate>
        </list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
    <list:data-paging page="${queryPage}" />
</list:data>
