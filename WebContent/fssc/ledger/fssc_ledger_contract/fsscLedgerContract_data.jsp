<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="fsscLedgerContract" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column property="fdContractName" title="${lfn:message('fssc-ledger:fsscLedgerContract.fdContractName')}" />
        <list:data-column property="fdContractCode" title="${lfn:message('fssc-ledger:fsscLedgerContract.fdContractCode')}" />
        <list:data-column col="fdContractType.fdName" title="${lfn:message('fssc-ledger:fsscLedgerContract.fdContractType')}">
            <sunbor:enumsShow value="${fsscLedgerContract.fdContractType}" enumsType="fssc_ledger_contract_type" />
        </list:data-column>
        <list:data-column col="fdContractType.id">
            <c:out value="${fsscLedgerContract.fdContractType}" />
        </list:data-column>
        <list:data-column col="fdLedgerType.fdName" title="${lfn:message('fssc-ledger:fsscLedgerContract.fdLedgerType')}">
            <sunbor:enumsShow value="${fsscLedgerContract.fdLedgerType}" enumsType="fssc_ledger_ledger_type" />
        </list:data-column>
        <list:data-column col="fdLedegrType.id">
            <c:out value="${fsscLedgerContract.fdLedgerType}" />
        </list:data-column>
        <list:data-column col="fdEffectDate" title="${lfn:message('fssc-ledger:fsscLedgerContract.fdEffectDate')}">
            <kmss:showDate value="${fsscLedgerContract.fdEffectDate}" type="date"></kmss:showDate>
        </list:data-column>
        <list:data-column col="fdContractAmount" title="${lfn:message('fssc-ledger:fsscLedgerContract.fdContractAmount')}">
        	<kmss:showNumber value="${fsscLedgerContract.fdContractAmount}" pattern="#0.00"/>
        </list:data-column>
        <list:data-column col="fdPayedAmount" title="${lfn:message('fssc-ledger:fsscLedgerContract.fdPayedAmount')}">
        	<c:choose>
          		<c:when test="${not empty  fsscLedgerContract.fdPayedAmount}">
          			<kmss:showNumber value="${fsscLedgerContract.fdPayedAmount}" pattern="0.00"/>
          		</c:when>
          		<c:otherwise>
          			<c:if test="${not empty  fsscLedgerContract.fdInitPayedAmount}">
          				<kmss:showNumber value="${fsscLedgerContract.fdInitPayedAmount}" pattern="0.00"/>
          			</c:if>
          		</c:otherwise>
          </c:choose>
        </list:data-column>
        <list:data-column col="fdUnpayAmount" title="${lfn:message('fssc-ledger:fsscLedgerContract.fdUnpayAmount')}">
        	<kmss:showNumber value="${fsscLedgerContract.fdUnpayAmount}" pattern="#0.00"/>
        </list:data-column>
        <list:data-column col="fdPayingAmount" title="${lfn:message('fssc-ledger:fsscLedgerContract.fdPayingAmount')}">
        	<c:choose>
                <c:when test="${not empty  fsscLedgerContract.fdPayingAmount}">
            		<kmss:showNumber value="${fsscLedgerContract.fdPayingAmount}" pattern="0.00"/>
           		</c:when>
           		<c:otherwise>
           			<c:if test="${not empty  fsscLedgerContract.fdInitPayingAmount}">
           			<kmss:showNumber value="${fsscLedgerContract.fdInitPayingAmount}" pattern="0.00"/>
           			</c:if>
           		</c:otherwise>
           	</c:choose>
        </list:data-column>
        <list:data-column col="fdContractStatus.name" title="${lfn:message('fssc-ledger:fsscLedgerContract.fdContractStatus')}">
            <sunbor:enumsShow value="${fsscLedgerContract.fdContractStatus}" enumsType="fssc_ledger_contract_status" />
        </list:data-column>
        <list:data-column col="fdContractStatus.id">
            <c:out value="${fsscLedgerContract.fdContractStatus}" />
        </list:data-column>
        <list:data-column property="fdErpNo" title="${lfn:message('fssc-ledger:fsscLedgerContract.fdErpNo')}" />
        <list:data-column property="fdParentContractNo" title="${lfn:message('fssc-ledger:fsscLedgerContract.fdParentContractNo')}" />
        <list:data-column col="fdSignDate" title="${lfn:message('fssc-ledger:fsscLedgerContract.fdSignDate')}">
            <kmss:showDate value="${fsscLedgerContract.fdSignDate}" type="date"></kmss:showDate>
        </list:data-column>
        <list:data-column property="fdPerforBond" title="${lfn:message('fssc-ledger:fsscLedgerContract.fdPerforBond')}" />
        <list:data-column property="fdContractSubject" title="${lfn:message('fssc-ledger:fsscLedgerContract.fdContractSubject')}" />
        <list:data-column property="fdPrice" title="${lfn:message('fssc-ledger:fsscLedgerContract.fdPrice')}" />
        <list:data-column property="fdReason" title="${lfn:message('fssc-ledger:fsscLedgerContract.fdReason')}" />
        <list:data-column col="fdSupplier.fdName" title="${lfn:message('fssc-ledger:fsscLedgerContract.fdSupplier')}">
            ${fsscLedgerContract.fdSupplier.fdName}
        </list:data-column>
        <list:data-column col="fdSupplier.id">
            <c:out value="${fsscLedgerContract.fdSupplier.fdId}" />
        </list:data-column>
        <list:data-column col="fdAgent.fdName" title="${lfn:message('fssc-ledger:fsscLedgerContract.fdAgent')}">
            ${fsscLedgerContract.fdAgent.fdName}
        </list:data-column>
        <list:data-column col="fdAgent.id">
            <c:out value="${fsscLedgerContract.fdAgent.fdId}" />
        </list:data-column>
        <list:data-column col="fdContractDept.fdName" title="${lfn:message('fssc-ledger:fsscLedgerContract.fdContractDept')}">
            ${fsscLedgerContract.fdContractDept.fdName}
        </list:data-column>
        <list:data-column col="fdContractDept.id">
            <c:out value="${fsscLedgerContract.fdContractDept.fdId}" />
        </list:data-column>
        <list:data-column col="fdExecuteDept.fdName" title="${lfn:message('fssc-ledger:fsscLedgerContract.fdExecuteDept')}">
            ${fsscLedgerContract.fdExecuteDept.fdName}
        </list:data-column>
        <list:data-column col="fdExecuteDept.id">
            <c:out value="${fsscLedgerContract.fdExecuteDept.fdId}" />
        </list:data-column>
        <list:data-column col="fdCurrency.fdName" title="${lfn:message('fssc-ledger:fsscLedgerContract.fdCurrency')}">
            ${fsscLedgerContract.fdCurrency.fdName}
        </list:data-column>
        <list:data-column col="fdCurrency.id">
            <c:out value="${fsscLedgerContract.fdCurrency.fdId}" />
        </list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
    <list:data-paging page="${queryPage}" />
</list:data>
