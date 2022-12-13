<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="geesunAnnualReset" list="${queryPage.list}" varIndex="status" custom="false">
        <list:data-column property="fdId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column col="fdOwner.name" title="${lfn:message('geesun-annual:geesunAnnualReset.fdOwner')}" escape="false">
            <c:out value="${geesunAnnualReset.fdOwner.fdName}" />
        </list:data-column>
        <list:data-column col="fdOwner.id" escape="false">
            <c:out value="${geesunAnnualReset.fdOwner.fdId}" />
        </list:data-column>
        <list:data-column col="fdHasExecute.name" title="${lfn:message('geesun-annual:geesunAnnualReset.fdHasExecute')}">
            <sunbor:enumsShow value="${geesunAnnualReset.fdHasExecute}" enumsType="geesun_annual_is_execute" />
        </list:data-column>
        <list:data-column col="fdHasExecute">
            <c:out value="${geesunAnnualReset.fdHasExecute}" />
        </list:data-column>
        <list:data-column col="fdExecuteTime" title="${lfn:message('geesun-annual:geesunAnnualReset.fdExecuteTime')}">
            <kmss:showDate value="${geesunAnnualReset.fdExecuteTime}" type="datetime"></kmss:showDate>
        </list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
    <list:data-paging page="${queryPage}" />
</list:data>
