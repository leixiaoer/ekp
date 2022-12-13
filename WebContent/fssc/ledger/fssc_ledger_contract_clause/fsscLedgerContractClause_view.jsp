<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@ taglib uri="/WEB-INF/KmssConfig/fssc/common/fssc.tld" prefix="fssc"%>
<ui:content title="${lfn:message('fssc-ledger:table.fsscLedgerContractClause') }" expand="true">
<table class="tb_normal" width="100%" id="TABLE_DocList_fdDetailList_Form" align="center" tbdraggable="true">
    <tr align="center" class="tr_normal_title">
        <td style="width:40px;">
            ${lfn:message('page.serial')}
        </td>
        <td>
            ${lfn:message('fssc-ledger:fsscLedgerContractClause.fdPaymentPeriod')}
        </td>
        <td>
            ${lfn:message('fssc-ledger:fsscLedgerContractClause.fdClause')}
        </td>
        <td>
            ${lfn:message('fssc-ledger:fsscLedgerContractClause.fdPaymentDate')}
        </td>
        <td>
            ${lfn:message('fssc-ledger:fsscLedgerContractClause.fdPaymentRatio')}
        </td>
        <td>
            ${lfn:message('fssc-ledger:fsscLedgerContractClause.fdPaymentAmount')}
        </td>
        <td>
            ${lfn:message('fssc-ledger:fsscLedgerContractClause.fdLeftMoney')}
        </td>
        <td>
            ${lfn:message('fssc-ledger:fsscLedgerContractClause.fdPaymentMethod')}
        </td>
    </tr>
    <c:forEach items="${fsscLedgerContractForm.fdDetailList_Form}" var="fdDetailList_FormItem" varStatus="vstatus">
        <tr KMSS_IsContentRow="1">
            <td align="center">
                ${vstatus.index+1}
            </td>
            <td align="center">
                <%-- 付款期--%>
                <input type="hidden" name="fdDetailList_Form[${vstatus.index}].fdId" value="${fdDetailList_FormItem.fdId}" />
                <input type="hidden" name="fdDetailList_Form[${vstatus.index}].fdPaymentMoney" value="${fdDetailList_FormItem.fdPaymentMoney}" />
                <div id="_xform_fdDetailList_Form[${vstatus.index}].fdPaymentPeriod" _xform_type="text">
                    <xform:text property="fdDetailList_Form[${vstatus.index}].fdPaymentPeriod" showStatus="view" style="width:95%;" />
                </div>
            </td>
            <td align="center">
                <%-- 付款条件--%>
                <div id="_xform_fdDetailList_Form[${vstatus.index}].fdClause" _xform_type="text">
                    <xform:text property="fdDetailList_Form[${vstatus.index}].fdClause" showStatus="view" style="width:95%;" />
                </div>
            </td>
            <td align="center">
                <%-- 约定付款日期--%>
                <div id="_xform_fdDetailList_Form[${vstatus.index}].fdPaymentDate" _xform_type="datetime">
                    <xform:datetime property="fdDetailList_Form[${vstatus.index}].fdPaymentDate" showStatus="view" dateTimeType="date" style="width:95%;" />
                </div>
            </td>
            <td align="center">
                <%-- 付款比例(%)--%>
                <div id="_xform_fdDetailList_Form[${vstatus.index}].fdPaymentRatio" _xform_type="text">
                    <xform:text property="fdDetailList_Form[${vstatus.index}].fdPaymentRatio" showStatus="view" style="width:95%;" />
                </div>
            </td>
            <td align="center">
                <%-- 付款金额--%>
                <div id="_xform_fdDetailList_Form[${vstatus.index}].fdPaymentAmount" _xform_type="text">
                	<kmss:showNumber value="${fdDetailList_FormItem.fdPaymentAmount }" pattern="0.00"/>
                </div>
            </td>
            <td align="center">
                <%-- 本期剩余应付金额--%>
                <div id="_xform_fdDetailList_Form[${vstatus.index}].fdLeftMoney" _xform_type="text">
                    <kmss:showNumber value="${fdDetailList_FormItem.fdLeftMoney}" pattern="###,##0.00"></kmss:showNumber>
                </div>
            </td>
            <td align="center">
                <%-- 付款方式--%>
                <div id="_xform_fdDetailList_Form[${vstatus.index}].fdPaymentMethod" _xform_type="text">
                    <xform:text property="fdDetailList_Form[${vstatus.index}].fdPaymentMethod" showStatus="view" style="width:95%;" />
                </div>
            </td>
        </tr>
    </c:forEach>
</table>
<input type="hidden" name="fdClauseList_Flag" value="1">
<script>
    Com_IncludeFile("doclist.js");
</script>
<script>
    DocList_Info.push('TABLE_DocList_fdDetailList_Form');
</script>
</ui:content>