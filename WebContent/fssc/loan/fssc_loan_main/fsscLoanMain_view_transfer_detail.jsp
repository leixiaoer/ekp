<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<html:form action="/fssc/loan/fssc_loan_main/fsscLoanMain.do">
    <c:if test="${queryPage.totalrows==0}">
        <%@ include file="/resource/jsp/list_norecord.jsp"%>
    </c:if>
    <c:if test="${queryPage.totalrows>0}">
        <%@ include file="/resource/jsp/list_pagenav_top.jsp"%>
        <c:set var="totalMoney" value="0"/>
        <table id="List_ViewTable">
            <tr>
                <sunbor:columnHead htmlTag="td">
                    <td width="40pt">
                        <bean:message key="page.serial"/>
                    </td>
                    <sunbor:column property="fsscLoanExecuteDetail.fdModelSubject">
                        <bean:message bundle="fssc-loan" key="fsscLoanMain.transfer.details.docSubject"/>
                    </sunbor:column>
                    <sunbor:column property="fsscLoanExecuteDetail.fdModelNumber">
                        <bean:message bundle="fssc-loan" key="fsscLoanMain.transfer.details.docNumber"/>
                    </sunbor:column>
                    <sunbor:column property="fsscLoanExecuteDetail.fdType">
                        <bean:message bundle="fssc-loan" key="fsscLoanMain.transfer.details.docStatus"/>
                    </sunbor:column>
                    <sunbor:column property="fsscLoanExecuteDetail.fdModelReceive">
                        <bean:message bundle="fssc-loan" key="fsscLoanMain.transfer.details.fdReceiveName"/>
                    </sunbor:column>
                    <sunbor:column property="fsscLoanExecuteDetail.fdMoney">
                        <bean:message bundle="fssc-loan" key="fsscLoanMain.transfer.details.fdMoney"/>
                    </sunbor:column>
                </sunbor:columnHead>
            </tr>
            <c:forEach items="${queryPage.list}" var="fsscLoanExecuteDetail" varStatus="vstatus">
                <c:choose>
                    <c:when test="${fsscLoanExecuteDetail.fdModelName == 'com.landray.kmss.fssc.loan.model.FsscLoanTransfer'}">
                        <tr kmss_href="<c:url value="/fssc/loan/fssc_loan_transfer/fsscLoanTransfer.do" />?method=view&fdId=${fsscLoanExecuteDetail.fdModelId}">
                    </c:when>
                    <c:otherwise>
                        <tr align="center">
                    </c:otherwise>
                </c:choose>
                    <td>${vstatus.index+1}</td>
                    <td>${fsscLoanExecuteDetail.fdModelSubject}</td>
                    <td>${fsscLoanExecuteDetail.fdModelNumber}</td>
                    <td>
                        <c:choose>
                            <c:when test="${fsscLoanExecuteDetail.fdType == '2' }">
                                <bean:message bundle="fssc-loan" key="enums.doc_status.20"/>
                            </c:when>
                            <c:otherwise>
                                <bean:message bundle="fssc-loan" key="enums.doc_status.30"/>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>${fsscLoanExecuteDetail.fdModelReceive.fdName}</td>
                    <td>
                        <c:set var="totalMoney" value="${totalMoney+fsscLoanExecuteDetail.fdMoney }" />
                            <kmss:showNumber value="${fsscLoanExecuteDetail.fdMoney}" pattern="###,##0.00"></kmss:showNumber> 
                    </td>
                </tr>
            </c:forEach>
            <tr align="center">
                <td></td><td></td><td></td><td></td><td></td>
                <td>
                    <bean:message bundle="fssc-loan" key="fsscLoanMain.details.totalMoney" />
                    ：<kmss:showNumber value="${totalMoney}" pattern="###,##0.00"></kmss:showNumber> 
                </td>
            </tr>
        </table>
        <%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
    </c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>