<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html:form action="/fssc/ledger/fssc_ledger_contract/fsscLedgerContract.do">
<c:if test="${queryPage.totalrows==0}">
    <%@ include file="/resource/jsp/list_norecord.jsp"%>
</c:if>
<c:if test="${queryPage.totalrows>0}">
    <%@ include file="/resource/jsp/list_pagenav_top.jsp"%>
    <c:set var="totalMoney" value="0"/>
    <table id="List_ViewTable" >
        <tr>
            <sunbor:columnHead htmlTag="td">
                <td width="40pt">
                    <bean:message key="page.serial"/>
                </td>
                <sunbor:column property="fsscPaymentMain.docSubject">
                    <bean:message bundle="fssc-payment" key="fsscPaymentMain.docSubject"/>
                </sunbor:column>
                <sunbor:column property="fsscPaymentMain.docNumber">
                    <bean:message bundle="fssc-payment" key="fsscPaymentMain.docNumber"/>
                </sunbor:column>
                <sunbor:column property="fsscPaymentMain.fdShuldAmount">
                    <bean:message bundle="fssc-payment" key="fsscPaymentMain.fdShuldAmount"/>
                </sunbor:column>
                <sunbor:column property="fsscPaymentMain.fdPaymentTotal">
                    <bean:message bundle="fssc-payment" key="fsscPaymentMain.fdPaymentTotal"/>
                </sunbor:column>
                <sunbor:column property="fsscPaymentMain.docStatus">
                    <bean:message bundle="fssc-payment" key="fsscPaymentMain.docStatus"/>
                </sunbor:column>
                <sunbor:column property="fsscPaymentMain.docCreateTime">
                    <bean:message bundle="fssc-payment" key="fsscPaymentMain.docCreateTime"/>
                </sunbor:column>
            </sunbor:columnHead>
        </tr>
        <c:forEach items="${queryPage.list}" var="fsscPaymentMain" varStatus="vstatus">
            <tr kmss_href="<c:url value="/fssc/payment/fssc_payment_main/fsscPaymentMain.do"/>?method=view&fdId=${fsscPaymentMain.fdId}">
                <td>${vstatus.index+1}</td>
                <td>${fsscPaymentMain.docSubject}</td>
                <td>${fsscPaymentMain.docNumber}</td>
                <td><kmss:showNumber value="${fsscPaymentMain.fdShuldAmount}" pattern="0.00"/></td>
                <td><kmss:showNumber value="${fsscPaymentMain.fdPaymentMoney}" pattern="0.00"/></td> 
                <td><sunbor:enumsShow enumsType="common_status" value="${fsscPaymentMain.docStatus }"></sunbor:enumsShow></td>
                <td><fmt:formatDate value="${fsscPaymentMain.docCreateTime}" pattern="yyyy-MM-dd" /></td>
            </tr>
        </c:forEach>
    </table>
    <%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>