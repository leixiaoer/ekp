<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="geesunLeaveMain" list="${queryPage.list}" varIndex="status" custom="false">
        <list:data-column property="fdId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column property="fdTime" title="${lfn:message('geesun-leave:geesunLeaveMain.fdTime')}" />
        <list:data-column col="docCreator.name" title="${lfn:message('geesun-leave:geesunLeaveMain.docCreator')}" escape="false">
            <c:out value="${geesunLeaveMain.docCreator.fdName}" />
        </list:data-column>
        <list:data-column col="docCreator.id" escape="false">
            <c:out value="${geesunLeaveMain.docCreator.fdId}" />
        </list:data-column>
        <list:data-column property="fdOwnerNo" title="${lfn:message('geesun-leave:geesunLeaveMain.fdOwnerNo')}" />
        <list:data-column col="docDept.name" title="${lfn:message('geesun-leave:geesunLeaveMain.docDept')}" escape="false">
            <c:out value="${geesunLeaveMain.docDept.fdName}" />
        </list:data-column>
        <list:data-column col="docDept.id" escape="false">
            <c:out value="${geesunLeaveMain.docDept.fdId}" />
        </list:data-column>
        <list:data-column property="fdSurplusLeave" title="${lfn:message('geesun-leave:geesunLeaveMain.fdSurplusLeave')}" />
        <list:data-column property="fdUseLeave" title="${lfn:message('geesun-leave:geesunLeaveMain.fdUseLeave')}" />
        <list:data-column property="fdSunLeave" title="${lfn:message('geesun-leave:geesunLeaveMain.fdSunLeave')}" />
        <list:data-column col="docCreateTime" title="${lfn:message('geesun-leave:geesunLeaveMain.docCreateTime')}">
            <kmss:showDate value="${geesunLeaveMain.docCreateTime}" type="datetime"></kmss:showDate>
        </list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
    <list:data-paging page="${queryPage}" />
</list:data>
