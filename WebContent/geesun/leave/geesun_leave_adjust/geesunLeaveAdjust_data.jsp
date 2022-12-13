<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="geesunLeaveAdjust" list="${queryPage.list}" varIndex="status" custom="false">
        <list:data-column property="fdId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column property="docSubject" title="${lfn:message('geesun-leave:geesunLeaveAdjust.docSubject')}" />
        <list:data-column col="docCreator.name" title="${lfn:message('geesun-leave:geesunLeaveAdjust.docCreator')}" escape="false">
            <c:out value="${geesunLeaveAdjust.docCreator.fdName}" />
        </list:data-column>
        <list:data-column col="docCreator.id" escape="false">
            <c:out value="${geesunLeaveAdjust.docCreator.fdId}" />
        </list:data-column>
        <list:data-column col="docDept.name" title="${lfn:message('geesun-leave:geesunLeaveAdjust.docDept')}" escape="false">
            <c:out value="${geesunLeaveAdjust.docDept.fdName}" />
        </list:data-column>
        <list:data-column col="docDept.id" escape="false">
            <c:out value="${geesunLeaveAdjust.docDept.fdId}" />
        </list:data-column>
        <list:data-column property="fdStartTime" title="${lfn:message('geesun-leave:geesunLeaveAdjust.fdStartTime')}" />
        <list:data-column property="fdEndTime" title="${lfn:message('geesun-leave:geesunLeaveAdjust.fdEndTime')}" />
        <list:data-column property="fdLeaveHour" title="${lfn:message('geesun-leave:geesunLeaveAdjust.fdLeaveHour')}" />
        <list:data-column col="docCreateTime" title="${lfn:message('geesun-leave:geesunLeaveAdjust.docCreateTime')}">
            <kmss:showDate value="${geesunLeaveAdjust.docCreateTime}" type="datetime"></kmss:showDate>
        </list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
    <list:data-paging page="${queryPage}" />
</list:data>
