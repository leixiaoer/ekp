<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="fsscLedgerInvoice" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column property="fdCycs" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdCycs')}" />
        <list:data-column property="fdInvoiceCode" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdInvoiceCode')}" />
        <list:data-column property="fdInvoiceNumber" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdInvoiceNumber')}" />
        <list:data-column col="fdBillingDate" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdBillingDate')}">
            <kmss:showDate value="${fsscLedgerInvoice.fdBillingDate}" type="date"></kmss:showDate>
        </list:data-column>
        <list:data-column property="fdJqbm" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdJqbm')}" />
        <list:data-column property="fdPurchaserName" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdPurchaserName')}" />
        <list:data-column property="fdPurchaserTaxNo" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdPurchaserTaxNo')}" />
        <list:data-column property="fdGfdzdh" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdGfdzdh')}" />
        <list:data-column property="fdGfyhzh" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdGfyhzh')}" />
        <list:data-column property="fdSalesTaxName" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdSalesTaxName')}" />
        <list:data-column property="fdSalesTaxNo" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdSalesTaxNo')}" />
        <list:data-column property="fdXfdzdh" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdXfdzdh')}" />
        <list:data-column property="fdXfyhzh" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdXfyhzh')}" />
        <list:data-column property="fdBz" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdBz')}" />
        <list:data-column col="fdInvoiceType" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdInvoiceType')}">
            <sunbor:enumsShow value="${fsscLedgerInvoice.fdInvoiceType}" enumsType="fssc_ledger_type" />
        </list:data-column>
        <list:data-column property="fdJym" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdJym')}" />
        <list:data-column col="fdZfbz" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdZfbz')}">
            <sunbor:enumsShow value="${fsscLedgerInvoice.fdZfbz}" enumsType="fssc_ledger_zfbz" />
        </list:data-column>
        <list:data-column property="fdTotalAmount" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdTotalAmount')}" />
        <list:data-column property="fdTotalTax" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdTotalTax')}" />
        <list:data-column col="fdIsAvailable" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdIsAvailable')}">
            <sunbor:enumsShow value="${fsscLedgerInvoice.fdIsAvailable}" enumsType="common_yesno" />
        </list:data-column>
        <list:data-column col="docCreateTime" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.docCreateTime')}">
            <kmss:showDate value="${fsscLedgerInvoice.docCreateTime}" type="datetime"></kmss:showDate>
        </list:data-column>
        <list:data-column col="docAlterTime" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.docAlterTime')}">
            <kmss:showDate value="${fsscLedgerInvoice.docAlterTime}" type="datetime"></kmss:showDate>
        </list:data-column>
        <list:data-column property="fdDesc" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdDesc')}" />
        <list:data-column col="fdState" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdState')}">
            <sunbor:enumsShow value="${fsscLedgerInvoice.fdState}" enumsType="fssc_ledger_invoice_status" />
        </list:data-column>
        <list:data-column col="fdDeductible" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdDeductible')}">
            <sunbor:enumsShow value="${fsscLedgerInvoice.fdDeductible}" enumsType="fssc_ledger_invoice_deductible" />
        </list:data-column>
        <list:data-column col="fdDeductibleDate" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdDeductibleDate')}">
            <kmss:showDate value="${fsscLedgerInvoice.fdDeductibleDate}" type="date"></kmss:showDate>
        </list:data-column>
        <list:data-column property="fdModelId" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdModelId')}" />
        <list:data-column property="fdModelName" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdModelName')}" />
        <list:data-column property="fdJshj" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdJshj')}" />
        <list:data-column property="fdSfz" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdSfz')}" />
        <list:data-column property="fdCllx" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdCllx')}" />
        <list:data-column property="fdCpxh" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdCpxh')}" />
        <list:data-column property="fdCd" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdCd')}" />
        <list:data-column property="fdHgzh" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdHgzh')}" />
        <list:data-column property="fdSjdh" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdSjdh')}" />
        <list:data-column property="fdFdjhm" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdFdjhm')}" />
        <list:data-column property="fdClsbdh" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdClsbdh')}" />
        <list:data-column property="fdJkzmsh" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdJkzmsh')}" />
        <list:data-column property="fdDh" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdDh')}" />
        <list:data-column property="fdDz" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdDz')}" />
        <list:data-column property="fdKhyh" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdKhyh')}" />
        <list:data-column property="fdZh" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdZh')}" />
        <list:data-column property="fdZgswjg" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdZgswjg')}" />
        <list:data-column property="fdZgswjgmc" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdZgswjgmc')}" />
        <list:data-column property="fdWspzhm" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdWspzhm')}" />
        <list:data-column property="fdDw" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdDw')}" />
        <list:data-column property="fdXcrs" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdXcrs')}" />
        <list:data-column property="fdSl" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdSl')}" />
        <list:data-column property="fdCyrsh" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdCyrsh')}" />
        <list:data-column property="fdSpf" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdSpf')}" />
        <list:data-column property="fdSpfsh" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdSpfsh')}" />
        <list:data-column property="fdShr" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdShr')}" />
        <list:data-column property="fdShrsh" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdShrsh')}" />
        <list:data-column property="fdFhr" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdFhr')}" />
        <list:data-column property="fdFhrsh" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdFhrsh')}" />
        <list:data-column property="fdYshwxx" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdYshwxx')}" />
        <list:data-column property="fdQyd" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdQyd')}" />
        <list:data-column property="fdCzch" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdCzch')}" />
        <list:data-column property="fdZgswjgdm" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdZgswjgdm')}" />
        <list:data-column property="fdGfdw" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdGfdw')}" />
        <list:data-column property="fdGfdwdm" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdGfdwdm')}" />
        <list:data-column property="fdGfdwdz" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdGfdwdz')}" />
        <list:data-column property="fdGfdwdh" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdGfdwdh')}" />
        <list:data-column property="fdMfdw" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdMfdw')}" />
        <list:data-column property="fdMfdwdm" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdMfdwdm')}" />
        <list:data-column property="fdMfdwdz" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdMfdwdz')}" />
        <list:data-column property="fdMfdwdh" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdMfdwdh')}" />
        <list:data-column property="fdCpzh" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdCpzh')}" />
        <list:data-column property="fdDjzh" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdDjzh')}" />
        <list:data-column property="fdCjh" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdCjh')}" />
        <list:data-column property="fdZrdclgls" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdZrdclgls')}" />
        <list:data-column property="fdCjhj" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdCjhj')}" />
        <list:data-column property="fdJydw" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdJydw')}" />
        <list:data-column property="fdJydwdz" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdJydwdz')}" />
        <list:data-column property="fdJydwnsrsbh" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdJydwnsrsbh')}" />
        <list:data-column property="fdJydwkhyhzh" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdJydwkhyhzh')}" />
        <list:data-column property="fdJydwdh" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdJydwdh')}" />
        <list:data-column property="fdEscsc" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdEscsc')}" />
        <list:data-column property="fdEscnsrsbh" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdEscnsrsbh')}" />
        <list:data-column property="fdEscdz" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdEscdz')}" />
        <list:data-column col="docCreator.name" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.docCreator')}" escape="false">
            <c:out value="${fsscLedgerInvoice.docCreator.fdName}" />
        </list:data-column>
        <list:data-column col="docCreator.id" escape="false">
            <c:out value="${fsscLedgerInvoice.docCreator.fdId}" />
        </list:data-column>
        <list:data-column col="docAlteror.name" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.docAlteror')}" escape="false">
            <c:out value="${fsscLedgerInvoice.docAlteror.fdName}" />
        </list:data-column>
        <list:data-column col="docAlteror.id" escape="false">
            <c:out value="${fsscLedgerInvoice.docAlteror.fdId}" />
        </list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
    <list:data-paging page="${queryPage}" />
</list:data>
