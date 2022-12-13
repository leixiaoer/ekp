<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="geesunBaseAccount" list="${queryPage.list}" varIndex="status" custom="false">
        <list:data-column property="fdId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column col="fdOwner.name" title="${lfn:message('geesun-base:geesunBaseAccount.fdOwner')}" escape="false">
            <c:out value="${geesunBaseAccount.fdOwner.fdName}" />
        </list:data-column>
        <list:data-column col="fdOwner.id" escape="false">
            <c:out value="${geesunBaseAccount.fdOwner.fdId}" />
        </list:data-column>
        <list:data-column property="fdBankName" title="${lfn:message('geesun-base:geesunBaseAccount.fdBankName')}" />
        <list:data-column property="fdAccount" title="${lfn:message('geesun-base:geesunBaseAccount.fdAccount')}" />
        <list:data-column col="docCreator.name" title="${lfn:message('geesun-base:geesunBaseAccount.docCreator')}" escape="false">
            <c:out value="${geesunBaseAccount.docCreator.fdName}" />
        </list:data-column>
        <list:data-column col="docCreator.id" escape="false">
            <c:out value="${geesunBaseAccount.docCreator.fdId}" />
        </list:data-column>
        <list:data-column col="docCreateTime" title="${lfn:message('geesun-base:geesunBaseAccount.docCreateTime')}">
            <kmss:showDate value="${geesunBaseAccount.docCreateTime}" type="datetime"></kmss:showDate>
        </list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
    <list:data-paging page="${queryPage}" />
</list:data>
