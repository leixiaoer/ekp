<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="geesunAnnualMain" list="${queryPage.list}" varIndex="status" custom="false">
        <list:data-column property="fdId" />
        <list:data-column property="fdOwnerNo" title="${lfn:message('geesun-annual:geesunAnnualMain.fdOwnerNo')}" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column col="fdOwner.name" title="${lfn:message('geesun-annual:geesunAnnualMain.fdOwner')}" escape="false">
            <c:out value="${geesunAnnualMain.fdOwner.fdName}" />
        </list:data-column>
        <list:data-column col="fdOwner.id" escape="false">
            <c:out value="${geesunAnnualMain.fdOwner.fdId}" />
        </list:data-column>
        <list:data-column property="fdTotal" title="${lfn:message('geesun-annual:geesunAnnualMain.fdTotal')}" />
    </list:data-columns>
    <%-- 分页信息生成 --%>
    <list:data-paging page="${queryPage}" />
</list:data>
