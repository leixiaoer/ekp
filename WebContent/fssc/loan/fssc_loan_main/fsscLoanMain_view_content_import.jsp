<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/KmssConfig/fssc/common/fssc.tld" prefix="fssc" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<c:import url="/fssc/loan/fssc_loan_main/fsscLoanMain_edit_content_import.jsp"></c:import>

<c:if test="${fsscLoanMainForm.docStatus =='30' }">
    <%--冲抵明细--%>
    <ui:content title="${ lfn:message('fssc-loan:fsscLoanMain.offset.details') }" expand="false">
        <table class="tb_normal" width="100%">
            <tr>
                <td class="td_normal_title" width="12.5%">
                    ${lfn:message('fssc-loan:fsscLoanMain.fdLoanMoney')}
                </td>
                <td width="12.5%">
                    <%-- 借款金额--%>
                    <kmss:showNumber value="${fsscLoanMainForm.fdLoanMoney}" pattern="###,##0.00"></kmss:showNumber>
                </td>
                <td class="td_normal_title" width="12.5%">
                    ${lfn:message('fssc-loan:fsscLoanMain.fdRealTime20Money')}
                </td>
                <td width="12.5%">
                    <%-- 待批金额--%>
                    <kmss:showNumber value="${fdRealTime20Money}" pattern="###,##0.00"></kmss:showNumber>
                </td>
                <td class="td_normal_title" width="12.5%">
                    ${lfn:message('fssc-loan:fsscLoanMain.fdRealTime30Money')}
                </td>
                <td width="12.5%">
                    <%-- 已还金额--%>
                    <kmss:showNumber value="${fdRealTime30Money}" pattern="###,##0.00"></kmss:showNumber>
                </td>
                <td class="td_normal_title" width="12.5%">
                    ${lfn:message('fssc-loan:fsscLoanMain.fdRealTimeSurplusMoney')}
                </td>
                <td width="12.5%">
                    <%-- 剩余金额--%>
                    <kmss:showNumber value="${fdRealTimeSurplusMoney}" pattern="###,##0.00"></kmss:showNumber>
                </td>
            </tr>
        </table>
        <ui:event event="show">
            document.getElementById("offsetListIframe").src= '${LUI_ContextPath }/fssc/loan/fssc_loan_main/fsscLoanMain.do?method=getOffsetDetail&fdLoanMainId=${fsscLoanMainForm.fdId}';
        </ui:event>
        <table id="Label_Tabel_1" width=100%>
            <tr>
                <td>
                    <iframe id="offsetListIframe" width=100% frameborder=0 height="280px"
                            marginheight="0" marginwidth="0"
                            src=""
                            scrolling=yes></iframe>
                </td>
            </tr>
        </table>
    </ui:content>
    <%--借款转移明细--%>
    <fssc:checkVersion version="true">
    <ui:content title="${ lfn:message('fssc-loan:fsscLoanMain.transfer.details') }" expand="false">
        <ui:event event="show">
            document.getElementById("transferListIframe").src= '${LUI_ContextPath }/fssc/loan/fssc_loan_main/fsscLoanMain.do?method=getOffsetDetail&fdType=getTransferDetail&fdLoanMainId=${fsscLoanMainForm.fdId}';
        </ui:event>
        <table id="Label_Tabel_2" width=100%>
            <tr>
                <td>
                    <iframe id="transferListIframe" width=100% frameborder=0 height="280px"
                            marginheight="0" marginwidth="0"
                            src=""
                            scrolling=yes></iframe>
                </td>
            </tr>
        </table>
    </ui:content>
    </fssc:checkVersion>
</c:if>
<c:if test="${not empty fsscLoanMainForm.fdPaymentStatus }">
<kmss:ifModuleExist path="/fssc/cashier/">
	<fssc:auth authType="staff" fdCompanyId="${fsscLoanMainForm.fdCompanyId}">
         <c:set var="cashier_auth" value="true"></c:set>
    </fssc:auth>
	<kmss:authShow roles="ROLE_FSSCCASHIER_DEFAULT">
       <c:set var="cashier_default" value="true"></c:set>
    </kmss:authShow>
    <c:if test="${cashier_default || cashier_auth}">
     <ui:content title="${lfn:message('fssc-cashier:table.fsscCashierPaymentDetail')}">
        <c:import url="/fssc/cashier/fssc_cashier_payment_detail/fsscCashierPaymentDetail_modelView.jsp" charEncoding="UTF-8">
            <c:param name="fdModelId" value="${fsscLoanMainForm.fdId}" />
            <c:param name="fdModelName" value="com.landray.kmss.fssc.loan.model.FsscLoanMain" />
        </c:import>
    </ui:content>
    </c:if>
</kmss:ifModuleExist>
</c:if>
<c:if test="${not empty fsscLoanMainForm.fdVoucherStatus }">
<kmss:ifModuleExist path="/fssc/voucher/">
<c:set var="voucherView"  value="false"></c:set>
<!-- 凭证查看权限 -->
<kmss:authShow roles="ROLE_FSSCVOUCHER_VIEW">
	<c:set var="voucherView"  value="true"></c:set>
</kmss:authShow>
<!-- 财务人员 -->
<fssc:auth authType="staff" fdCompanyId="${fsscLoanMainForm.fdCompanyId}">
	<c:set var="voucherView"  value="true"></c:set>
</fssc:auth>
<!-- 重新制证权限 -->
<kmss:auth requestURL="/fssc/voucher/fssc_voucher_main/fsscVoucherMain.do?method=refreshVoucher&fdId=${param.fdId}&fdModelName=com.landray.kmss.fssc.loan.model.FsscLoanMain">
	<c:set var="voucherView"  value="true"></c:set>
</kmss:auth>
<c:if test="${voucherView=='true'}">
    <ui:content title="${lfn:message('fssc-voucher:fsscVoucherMain.title.message')}">
        <c:import url="/fssc/voucher/fssc_voucher_main/fsscVoucherMain_modelView.jsp" charEncoding="UTF-8">
            <c:param name="fdModelId" value="${fsscLoanMainForm.fdId}" />
            <c:param name="fdModelName" value="com.landray.kmss.fssc.loan.model.FsscLoanMain" />
            <c:param name="fdModelNumber" value="${fsscLoanMainForm.docNumber}" />
            <c:param name="fdBookkeepingStatus" value="${fsscLoanMainForm.fdBookkeepingStatus}" />
            <c:param name="fdIsVoucherVariant" value="${fsscLoanMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.voucherVariant}" />
        </c:import>
    </ui:content>
</c:if>
</kmss:ifModuleExist>
</c:if>