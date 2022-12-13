<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="geesunBaseAudit" list="${queryPage.list}" varIndex="status" custom="false">
        <list:data-column property="fdId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column property="fdAccountName" title="${lfn:message('geesun-base:geesunBaseAudit.fdAccountName')}" />
        <list:data-column property="fdAccountCode" title="${lfn:message('geesun-base:geesunBaseAudit.fdAccountCode')}" />
        <list:data-column col="docCreator.name" title="${lfn:message('geesun-base:geesunBaseAudit.docCreator')}" escape="false">
            <c:out value="${geesunBaseAudit.docCreator.fdName}" />
        </list:data-column>
        <list:data-column col="docCreator.id" escape="false">
            <c:out value="${geesunBaseAudit.docCreator.fdId}" />
        </list:data-column>
        <list:data-column col="docCreateTime" title="${lfn:message('geesun-base:geesunBaseAudit.docCreateTime')}">
            <kmss:showDate value="${geesunBaseAudit.docCreateTime}" type="datetime"></kmss:showDate>
        </list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
    <list:data-paging page="${queryPage}" />
</list:data>
