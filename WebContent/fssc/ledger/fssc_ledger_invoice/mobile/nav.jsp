<%@ page language="java" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>

    [{
        url: "/fssc/ledger/fssc_ledger_invoice/fsscLedgerInvoice.do?method=data&o.fdInvoiceCode=up&o.fdInvoiceNumber=up&o.fdBillingDate=up",

        text: "${ lfn:message('fssc-ledger:table.fsscLedgerInvoice') }",
        selected: true
    }]

