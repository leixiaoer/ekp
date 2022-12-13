<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="geesunLeaveBarter" list="${queryPage.list}" varIndex="status" custom="false">
        <list:data-column property="fdId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column property="docSubject" title="${lfn:message('geesun-leave:geesunLeaveBarter.docSubject')}" />
        <list:data-column col="docCreator.name" title="${lfn:message('geesun-leave:geesunLeaveBarter.docCreator')}" escape="false">
            <c:out value="${geesunLeaveBarter.docCreator.fdName}" />
        </list:data-column>
        <list:data-column col="docCreator.id" escape="false">
            <c:out value="${geesunLeaveBarter.docCreator.fdId}" />
        </list:data-column>
        <list:data-column col="docDept.name" title="${lfn:message('geesun-leave:geesunLeaveBarter.docDept')}" escape="false">
            <c:out value="${geesunLeaveBarter.docDept.fdName}" />
        </list:data-column>
        <list:data-column col="docDept.id" escape="false">
            <c:out value="${geesunLeaveBarter.docDept.fdId}" />
        </list:data-column>
        <list:data-column col="fdStartTime" title="${lfn:message('geesun-leave:geesunLeaveBarter.fdStartTime')}">
            <kmss:showDate value="${geesunLeaveBarter.fdStartTime}" type="datetime"></kmss:showDate>
        </list:data-column>
        <list:data-column col="fdEndTime" title="${lfn:message('geesun-leave:geesunLeaveBarter.fdEndTime')}">
            <kmss:showDate value="${geesunLeaveBarter.fdEndTime}" type="datetime"></kmss:showDate>
        </list:data-column>
        <list:data-column property="fdLeaveHour" title="${lfn:message('geesun-leave:geesunLeaveBarter.fdLeaveHour')}" />
        <list:data-column col="docCreateTime" title="${lfn:message('geesun-leave:geesunLeaveBarter.docCreateTime')}">
            <kmss:showDate value="${geesunLeaveBarter.docCreateTime}" type="datetime"></kmss:showDate>
        </list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
    <list:data-paging page="${queryPage}" />
</list:data>
