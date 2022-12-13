<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="fsscLedgerCredit" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column col="docCreateTime" title="${lfn:message('fssc-ledger:fsscLedgerCredit.docCreateTime')}">
            <kmss:showDate value="${fsscLedgerCredit.docCreateTime}" type="datetime"></kmss:showDate>
        </list:data-column>
        <list:data-column col="docAlterTime" title="${lfn:message('fssc-ledger:fsscLedgerCredit.docAlterTime')}">
            <kmss:showDate value="${fsscLedgerCredit.docAlterTime}" type="datetime"></kmss:showDate>
        </list:data-column>
        <list:data-column property="fdCreditNo" title="${lfn:message('fssc-ledger:fsscLedgerCredit.fdCreditNo')}" />
        <list:data-column property="fdOrder" title="${lfn:message('fssc-ledger:fsscLedgerCredit.fdOrder')}" />
        <list:data-column property="fdDesc" title="${lfn:message('fssc-ledger:fsscLedgerCredit.fdDesc')}" />
        <list:data-column col="docAlteror.name" title="${lfn:message('fssc-ledger:fsscLedgerCredit.docAlteror')}" escape="false">
            <c:out value="${fsscLedgerCredit.docAlteror.fdName}" />
        </list:data-column>
        <list:data-column col="docAlteror.id" escape="false">
            <c:out value="${fsscLedgerCredit.docAlteror.fdId}" />
        </list:data-column>
        <list:data-column col="fdPerson.name" title="${lfn:message('fssc-ledger:fsscLedgerCredit.fdPerson')}" escape="false">
            <c:out value="${fsscLedgerCredit.fdPerson.fdName}" />
        </list:data-column>
        <list:data-column col="fdPerson.id" escape="false">
            <c:out value="${fsscLedgerCredit.fdPerson.fdId}" />
        </list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
    <list:data-paging page="${queryPage}" />
</list:data>
