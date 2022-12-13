<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="fsscLedgerMaterial" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column property="fdCode" title="${lfn:message('fssc-ledger:fsscLedgerMaterial.fdCode')}" />
        <list:data-column col="fdType.fdName" title="${lfn:message('fssc-ledger:fsscLedgerMaterial.fdType')}" escape="false">
            <c:out value="${fsscLedgerMaterial.fdType.fdName}" />
        </list:data-column>
        <list:data-column col="fdType.id" escape="false">
            <c:out value="${fsscLedgerMaterial.fdType.fdId}" />
        </list:data-column>
        <list:data-column col="fdMaterial.fdName" title="${lfn:message('fssc-ledger:fsscLedgerMaterial.fdMaterial')}" escape="false">
            <c:out value="${fsscLedgerMaterial.fdMaterial.fdName}" />
        </list:data-column>
        <list:data-column col="fdMaterial.id" escape="false">
            <c:out value="${fsscLedgerMaterial.fdMaterial.fdId}" />
        </list:data-column>
        <list:data-column col="fdPurchase.fdName" title="${lfn:message('fssc-ledger:fsscLedgerMaterial.fdPurchase')}" escape="false">
            <c:out value="${fsscLedgerMaterial.fdPurchase.fdName}" />
        </list:data-column>
        <list:data-column col="fdPurchase.id" escape="false">
            <c:out value="${fsscLedgerMaterial.fdPurchase.fdId}" />
        </list:data-column>
        <list:data-column col="fdPurchaseDept.fdName" title="${lfn:message('fssc-ledger:fsscLedgerMaterial.fdPurchaseDept')}" escape="false">
            <c:out value="${fsscLedgerMaterial.fdPurchaseDept.fdName}" />
        </list:data-column>
        <list:data-column col="fdPurchaseDept.id" escape="false">
            <c:out value="${fsscLedgerMaterial.fdPurchaseDept.fdId}" />
        </list:data-column>
        <list:data-column col="fdIsInventory.fdName" title="${lfn:message('fssc-ledger:fsscLedgerMaterial.fdIsInventory')}">
            <sunbor:enumsShow value="${fsscLedgerMaterial.fdIsInventory}" enumsType="common_yesno" />
        </list:data-column>
        <list:data-column col="fdIsInventory.id" escape="false">
            <c:out value="${fsscLedgerMaterial.fdIsInventory}" />
        </list:data-column>
        <list:data-column col="fdStatus.fdName" title="${lfn:message('fssc-ledger:fsscLedgerMaterial.fdStatus')}">
            <sunbor:enumsShow value="${fsscLedgerMaterial.fdStatus}" enumsType="fssc_ledger_material_status" />
        </list:data-column>
        <list:data-column col="fdStatus.id" escape="false">
            <c:out value="${fsscLedgerMaterial.fdStatus}" />
        </list:data-column>
        <list:data-column property="fdStock" title="${lfn:message('fssc-ledger:fsscLedgerMaterial.fdStock')}" />
        <list:data-column property="fdUnit" title="${lfn:message('fssc-ledger:fsscLedgerMaterial.fdUnit')}" />
        <list:data-column property="fdDesc" title="${lfn:message('fssc-ledger:fsscLedgerMaterial.fdDesc')}" />
        <list:data-column property="fdPhone" title="${lfn:message('fssc-ledger:fsscLedgerMaterial.fdPhone')}" />
        <list:data-column col="docAlterTime" title="${lfn:message('fssc-ledger:fsscLedgerMaterial.docAlterTime')}">
            <kmss:showDate value="${fsscLedgerMaterial.docAlterTime}" type="datetime"></kmss:showDate>
        </list:data-column>
        <list:data-column col="docCreateTime" title="${lfn:message('fssc-ledger:fsscLedgerMaterial.docCreateTime')}">
            <kmss:showDate value="${fsscLedgerMaterial.docCreateTime}" type="datetime"></kmss:showDate>
        </list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
    <list:data-paging page="${queryPage}" />
</list:data>
