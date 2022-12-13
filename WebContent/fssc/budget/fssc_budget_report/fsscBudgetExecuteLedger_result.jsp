<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<html:form action="/fssc/budget/fssc_budget_data/fsscBudgetData.do">
    <c:if test="${queryPage == null || queryPage.totalrows == 0}">
        <%@ include file="/resource/jsp/list_norecord.jsp"%>
    </c:if>
    <c:if test="${queryPage.totalrows > 0}">
        <c:set var="totalMoney" value="0"/>
        <table id="List_ViewTable" style="width:100%;">
            <tr>
                <sunbor:columnHead htmlTag="td">
                    <td>${lfn:message('page.serial')}</td>
                   <c:forEach items="${ledgerTitle}" var="title" varStatus="status">
                   		<td>${title}</td>
                   </c:forEach>
                   <td>${lfn:message('fssc-budget:fsscBudgetData.fdYear')}</td>
                   <td>${lfn:message('fssc-budget:fsscBudgetData.fdQuarter')}</td>
                   <td>${lfn:message('fssc-budget:fsscBudgetData.fdMonth')}</td>
                   <td>${lfn:message('fssc-budget:fsscBudgetData.fdMoney')}</td>
                   <td>${lfn:message('fssc-budget:fsscBudgetData.fdAdjustMoney')}</td>
                   <td>${lfn:message('fssc-budget:fsscBudgetData.fdTotalMoney')}</td>
                   <td>${lfn:message('fssc-budget:fsscBudgetData.fdAlreadyUsedMoney')}</td>
                   <td>${lfn:message('fssc-budget:fsscBudgetData.fdOccupyMoney')}</td>
                   <td>${lfn:message('fssc-budget:fsscBudgetData.fdCanUseMoney')}</td>
                   <td>${lfn:message('fssc-budget:fsscBudgetData.fdBudgetStatus')}</td>
                </sunbor:columnHead>
            </tr>
            <c:forEach items="${queryPage.list}" var="budgetData" varStatus="vstatus">
                <tr kmss_href="<c:url value="/fssc/budget/fssc_budget_data/fsscBudgetData.do" />?method=view&fdId=${budgetData[0]}">
                    <td>${vstatus.index+1}</td>
                    <c:forEach items="${ledgerTitle}" var="title"  varStatus="status">
                   		<td>${budgetData[status.index+1]}</td>
                   </c:forEach>
                   <c:set value="${fn:length(ledgerTitle)}" var="len"></c:set>
                   <td>${budgetData[len+1]}</td>
                   <td>
                   		<c:if test="${not empty  budgetData[len+2]}">
                   			${budgetData[len+2]}${lfn:message('fssc-budget:enums.budget.period.type.quarter')}
                   		</c:if>
                   </td>
                   <td>
                   		<c:if test="${not empty  budgetData[len+3]}">
                   			${budgetData[len+3]}${lfn:message('fssc-budget:enums.budget.period.type.report.month')}
                   		</c:if>
                   </td>
                   <td>
                 		<kmss:showNumber value="${budgetData[len+4]}" pattern="###,##0.00"></kmss:showNumber>
                   </td>
                   <td>
                 		<kmss:showNumber value="${budgetData[len+5]}" pattern="###,##0.00"></kmss:showNumber>
                   </td>
                   <td>
                 		<kmss:showNumber value="${budgetData[len+6]}" pattern="###,##0.00"></kmss:showNumber>
                   </td>
                   <td>
                 		<kmss:showNumber value="${budgetData[len+7]}" pattern="###,##0.00"></kmss:showNumber>
                   </td>
                   <td>
                 		<kmss:showNumber value="${budgetData[len+8]}" pattern="###,##0.00"></kmss:showNumber>
                   </td>
                   <td>
                 		<kmss:showNumber value="${budgetData[len+9]}" pattern="###,##0.00"></kmss:showNumber>
                   </td>
                   <td>
                 		<sunbor:enumsShow enumsType="fssc_budget_status" value="${budgetData[len+10]}"></sunbor:enumsShow>
                   </td>
                </tr>
            </c:forEach>
        </table>
        <%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
    </c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>