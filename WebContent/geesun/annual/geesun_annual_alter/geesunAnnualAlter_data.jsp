<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="geesunAnnualAlter" list="${queryPage.list}" varIndex="status" custom="false">
        <list:data-column property="fdId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column property="fdFieldName" title="${lfn:message('geesun-annual:geesunAnnualAlter.fdFieldName')}" />
        <list:data-column property="fdModelId" title="${lfn:message('geesun-annual:geesunAnnualAlter.fdModelId')}" />
        <list:data-column property="fdSource" title="${lfn:message('geesun-annual:geesunAnnualAlter.fdSource')}" />
        <list:data-column col="docCreator.name" title="${lfn:message('geesun-annual:geesunAnnualAlter.docCreator')}" escape="false">
            <c:out value="${geesunAnnualAlter.docCreator.fdName}" />
        </list:data-column>
        <list:data-column col="docCreator.id" escape="false">
            <c:out value="${geesunAnnualAlter.docCreator.fdId}" />
        </list:data-column>
        <list:data-column col="docCreateTime" title="${lfn:message('geesun-annual:geesunAnnualAlter.docCreateTime')}">
            <kmss:showDate value="${geesunAnnualAlter.docCreateTime}" type="datetime"></kmss:showDate>
        </list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
    <list:data-paging page="${queryPage}" />
</list:data>
