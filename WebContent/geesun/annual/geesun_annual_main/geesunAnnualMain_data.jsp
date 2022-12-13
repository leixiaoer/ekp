<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="geesunAnnualMain" list="${queryPage.list}" varIndex="status" custom="false">
        <list:data-column property="fdId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column col="fdOwner.name" title="${lfn:message('geesun-annual:geesunAnnualMain.fdOwner')}" escape="false">
            <c:out value="${geesunAnnualMain.fdOwner.fdName}" />
        </list:data-column>
        <list:data-column col="fdOwner.id" escape="false">
            <c:out value="${geesunAnnualMain.fdOwner.fdId}" />
        </list:data-column>
        <list:data-column property="fdOwnerNo" title="${lfn:message('geesun-annual:geesunAnnualMain.fdOwnerNo')}" />
        <list:data-column col="docDept.name" title="${lfn:message('geesun-annual:geesunAnnualMain.docDept')}" escape="false">
            <c:out value="${geesunAnnualMain.docDept.fdName}" />
        </list:data-column>
        <list:data-column col="docDept.id" escape="false">
            <c:out value="${geesunAnnualMain.docDept.fdId}" />
        </list:data-column>
        <list:data-column property="fdTotal" title="${lfn:message('geesun-annual:geesunAnnualMain.fdTotal')}" />
        <list:data-column property="fdRemain" title="${lfn:message('geesun-annual:geesunAnnualMain.fdRemain')}" />
        <list:data-column col="docCreateTime" title="${lfn:message('geesun-annual:geesunAnnualMain.docCreateTime')}">
            <kmss:showDate value="${geesunAnnualMain.docCreateTime}" type="datetime"></kmss:showDate>
        </list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
    <list:data-paging page="${queryPage}" />
</list:data>
