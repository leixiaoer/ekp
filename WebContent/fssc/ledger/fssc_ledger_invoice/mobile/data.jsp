<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person" %>

<list:data>
    <list:data-columns var="fsscLedgerInvoice" list="${queryPage.list }" varIndex="status" mobile="true">
        <list:data-column property="fdId">
        </list:data-column>
        <list:data-column col="href" escape="false">
            /fssc/ledger/fssc_ledger_invoice/fsscLedgerInvoice.do?method=view&fdId=${fsscLedgerInvoice.fdId}
        </list:data-column>


        <list:data-column col="label" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdInvoiceNumber')}" property="fdInvoiceNumber" />

        <c:if test="${fsscLedgerInvoice.docCreator.fdName!=undefined}">
            <list:data-column col="creator" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.docCreator')}" property="docCreator.fdName" />
        </c:if>

        <list:data-column col="created" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.docCreateTime')}">
            <kmss:showDate value="${fsscLedgerInvoice.docCreateTime}" type="date"></kmss:showDate>
        </list:data-column>

        <list:data-column col="icon" escape="false">
            <person:headimageUrl personId="${fsscLedgerInvoice.docCreator.fdId}" size="m" />
        </list:data-column>


        <list:data-column col="summary" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdDesc')}" property="fdDesc" />
    </list:data-columns>

    <list:data-paging currentPage="${queryPage.pageno }" pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
    </list:data-paging>
</list:data>
