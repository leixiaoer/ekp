<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="fsscLedgerMaterialStock" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column property="fdModelId" title="${lfn:message('fssc-ledger:fsscLedgerMaterialStock.fdModelId')}" />
        <list:data-column property="fdModelName" title="${lfn:message('fssc-ledger:fsscLedgerMaterialStock.fdModelName')}" />
        <list:data-column property="fdStockId" title="${lfn:message('fssc-ledger:fsscLedgerMaterialStock.fdStockId')}" />
        <c:if test="${fsscLedgerMaterialStockForm.fdType=='1'}">
	        <list:data-column col="fdWarehousingDate" title="${lfn:message('fssc-ledger:fsscLedgerMaterialStock.fdWarehousingDate')}">
	            <kmss:showDate value="${fsscLedgerMaterialStock.fdWarehousingDate}" type="date"></kmss:showDate>
	        </list:data-column>
        </c:if>
        <c:if test="${fsscLedgerMaterialStockForm.fdType=='3'}">
	        <list:data-column col="fdWarehousingDate" title="${lfn:message('fssc-ledger:fsscLedgerMaterialStock.fdOutboundDate')}">
	            <kmss:showDate value="${fsscLedgerMaterialStock.fdWarehousingDate}" type="date"></kmss:showDate>
	        </list:data-column>
        </c:if>
        <list:data-column property="fdUnit" title="${lfn:message('fssc-ledger:fsscLedgerMaterialStock.fdUnit')}" />
        <list:data-column property="fdPrice" title="${lfn:message('fssc-ledger:fsscLedgerMaterialStock.fdPrice')}" />
        <c:if test="${fsscLedgerMaterialStockForm.fdType=='1'}">
        	<list:data-column property="fdQuantity" title="${lfn:message('fssc-ledger:fsscLedgerMaterialStock.fdQuantity')}" >
	        </list:data-column>
        </c:if>
        <c:if test="${fsscLedgerMaterialStockForm.fdType=='3'}">
        	<list:data-column property="fdQuantity" title="${lfn:message('fssc-ledger:fsscLedgerMaterialStock.fdOut.fdQuantity')}" >
	        </list:data-column>
        </c:if>
        <list:data-column property="fdModel" title="${lfn:message('fssc-ledger:fsscLedgerMaterialStock.fdModel')}" />
        <list:data-column property="fdMoney" title="${lfn:message('fssc-ledger:fsscLedgerMaterialStock.fdMoney')}" />
        <list:data-column col="fdLeft" title="${lfn:message('fssc-ledger:fsscLedgerMaterialStock.fdLeft')}" >
        	${valMap[fsscLedgerMaterialStock.fdId]["fdLeft"]}
	    </list:data-column>
	     <list:data-column col="fdUser.name" escape="false">
            <c:out value="${fsscLedgerMaterialStock.fdUser.fdName}" />
        </list:data-column>
         <list:data-column col="fdUserDept.name" escape="false">
            <c:out value="${fsscLedgerMaterialStock.fdUserDept.fdName}" />
        </list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
    <list:data-paging page="${queryPage}" />
</list:data>
