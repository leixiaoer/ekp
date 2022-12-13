<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="sysTaskReject" list="${queryPage.list}" varIndex="status" custom="false">
        <list:data-column property="fdId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column headerStyle="width:70px" col="docCreator.name" title="${lfn:message('sys-task:sysTaskReject.docCreator')}" escape="false">
            <c:out value="${sysTaskReject.docCreator.fdName}" />
        </list:data-column>
        <list:data-column col="docCreator.id" escape="false">
            <c:out value="${sysTaskReject.docCreator.fdId}" />
        </list:data-column>
        <list:data-column property="fdReason" title="${lfn:message('sys-task:sysTaskReject.fdReason')}" />
        <list:data-column headerStyle="width:120px" col="docCreateTime" title="${lfn:message('sys-task:sysTaskReject.docCreateTime')}">
            <kmss:showDate value="${sysTaskReject.docCreateTime}" type="datetime"></kmss:showDate>
        </list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
    <list:data-paging page="${queryPage}" />
</list:data>
