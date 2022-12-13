<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@ taglib uri="/WEB-INF/KmssConfig/fssc/common/fssc.tld" prefix="fssc"%>
<ui:content title="${lfn:message('fssc-ledger:table.fsscLedgerContractClause') }" expand="true">
<div class="btn_container">
	<div class="fssc_expense_btn" onclick="FSSC_AddClauseDetail()">
	<span class="iconfont icon-tianjia"></span>
		${lfn:message('fssc-ledger:button.addLedgerClause') }
	</div>
</div>
<table id="TABLE_DocList_fdDetailList_Form" class="tb_normal" width=100% align="center" tbdraggable="true">
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
        <td style="width:120px;">
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
        <td style="width:40px;">
        </td>
    </tr>
	<tr KMSS_IsReferRow="1" style="display:none;">
        <td align="center" KMSS_IsRowIndex="1">
            !{index}
        </td>
        <td align="center">
            <%-- 付款期--%>
            <input type="hidden" name="fdDetailList_Form[!{index}].fdId" value="" disabled="true" />
            <input type="hidden" name="fdDetailList_Form[!{index}].fdPaymentMoney" value="${fdDetailList_FormItem.fdPaymentMoney}" />
            <div id="_xform_fdDetailList_Form[!{index}].fdPaymentPeriod" _xform_type="text">
                <xform:text property="fdDetailList_Form[!{index}].fdPaymentPeriod" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerContractClause.fdPaymentPeriod')}" validators=" maxLength(50)" style="width:95%;" />
            </div>
        </td>
        <td align="center">
            <%-- 付款条件--%>
            <div id="_xform_fdDetailList_Form[!{index}].fdClause" _xform_type="text">
                <xform:text property="fdDetailList_Form[!{index}].fdClause" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerContractClause.fdClause')}" validators=" maxLength(1000)" style="width:95%;" />
            </div>
        </td>
        <td align="center">
            <%-- 约定付款日期--%>
            <div id="_xform_fdDetailList_Form[!{index}].fdPaymentDate" _xform_type="datetime">
                <xform:datetime property="fdDetailList_Form[!{index}].fdPaymentDate" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerContractClause.fdPaymentDate')}" required="true" dateTimeType="date" style="width:95%;" />
            </div>
        </td>
        <td align="center">
            <%-- 付款比例(%)--%>
            <div id="_xform_fdDetailList_Form[!{index}].fdPaymentRatio" _xform_type="text">
                <xform:text property="fdDetailList_Form[!{index}].fdPaymentRatio" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerContractClause.fdPaymentRatio')}" validators=" number min(0) max(100) scaleLength(2) validateFdPaymentRatio" required="true" onValueChange="FS_getFdMoneyByPaymentRatio" style="width:90%;" />
            </div>
        </td>
        <td align="center">
            <%-- 付款金额--%>
            <div id="_xform_fdDetailList_Form[!{index}].fdPaymentAmount" _xform_type="text">
                <xform:text required="true" property="fdDetailList_Form[!{index}].fdPaymentAmount" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerContractClause.fdPaymentAmount')}" validators="currency-dollar min(0)" onValueChange="Fs_getFdPaymentAmount" style="width:90%;" />
            </div>
        </td>
        <td align="center">
             <%-- 本期剩余应付金额--%>
             <div id="_xform_fdDetailList_Form[!{index}].fdLeftMoney" _xform_type="text">
                 <xform:text property="fdDetailList_Form[!{index}].fdLeftMoney" showStatus="readOnly" subject="${lfn:message('fssc-ledger:fsscLedgerContractClause.fdLeftMoney')}" validators=" number" style="width:95%;color:333;" />
             </div>
         </td>
        <td align="center">
            <%-- 付款方式--%>
            <div id="_xform_fdDetailList_Form[!{index}].fdPaymentMethod" _xform_type="text">
                <xform:text required="true" property="fdDetailList_Form[!{index}].fdPaymentMethod" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerContractClause.fdPaymentMethod')}" validators=" maxLength(200)" style="width:90%;" />
            </div>
        </td>
        <td align="center">
            <a href="javascript:void(0);" onclick="DocList_DeleteRow();" title="${lfn:message('doclist.delete')}">
                <img src="${KMSS_Parameter_StylePath}icons/icon_del.png" border="0" />
            </a>
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
                <c:choose>
	            	<c:when test="${not empty fdDetailList_FormItem.fdPaymentMoney}">
		            	<input type="hidden" name="fdDetailList_Form[${vstatus.index}].fdPaymentMoney" value="${fdDetailList_FormItem.fdPaymentMoney}" />
		            </c:when>
		            <c:otherwise>
		            	<input type="hidden" name="fdDetailList_Form[${vstatus.index}].fdPaymentMoney" value="${fdDetailList_FormItem.fdInitPayedMoney}" />
		            </c:otherwise>
	            </c:choose>
                <div id="_xform_fdDetailList_Form[${vstatus.index}].fdPaymentPeriod" _xform_type="text">
                    <xform:text property="fdDetailList_Form[${vstatus.index}].fdPaymentPeriod" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerContractClause.fdPaymentPeriod')}" validators=" maxLength(50)" style="width:95%;" />
                </div>
            </td>
            <td align="center">
                <%-- 付款条件--%>
                <div id="_xform_fdDetailList_Form[${vstatus.index}].fdClause" _xform_type="text">
                    <xform:text property="fdDetailList_Form[${vstatus.index}].fdClause" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerContractClause.fdClause')}" validators=" maxLength(1000)" style="width:95%;" />
                </div>
            </td>
            <td align="center">
                <%-- 约定付款日期--%>
                <div id="_xform_fdDetailList_Form[${vstatus.index}].fdPaymentDate" _xform_type="datetime">
                    <xform:datetime property="fdDetailList_Form[${vstatus.index}].fdPaymentDate" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerContractClause.fdPaymentDate')}" required="true" dateTimeType="date" style="width:95%;" />
                </div>
            </td>
            <td align="center">
                <%-- 付款比例(%)--%>
                <div id="_xform_fdDetailList_Form[${vstatus.index}].fdPaymentRatio" _xform_type="text">
                    <xform:text property="fdDetailList_Form[${vstatus.index}].fdPaymentRatio" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerContractClause.fdPaymentRatio')}" validators=" number min(0) max(100) scaleLength(2) validateFdPaymentRatio" required="true" onValueChange="FS_getFdMoneyByPaymentRatio" style="width:90%;" />
                </div>
            </td>
            <td align="center">
                <%-- 付款金额--%>
                <div id="_xform_fdDetailList_Form[${vstatus.index}].fdPaymentAmount" _xform_type="text">
                	<input name="fdDetailList_Form[${vstatus.index}].fdPaymentAmount" value="<kmss:showNumber value="${fdDetailList_FormItem.fdPaymentAmount}" pattern="0.00"></kmss:showNumber>" subject="${lfn:message('fssc-ledger:fsscLedgerContractClause.fdPaymentAmount')}" onchange="Fs_getFdPaymentAmount()" class="inputsgl" validate="currency-dollar min(0) reuired" style="width:90%;"/>
                	<span style="color:#FF0000;">*</span>
                </div>
            </td>
            <td align="center">
                <%-- 本期剩余应付金额--%>
                <div id="_xform_fdDetailList_Form[${vstatus.index}].fdLeftMoney" _xform_type="text">
                 	<input name="fdDetailList_Form[${vstatus.index}].fdLeftMoney" value="<kmss:showNumber value="${fdDetailList_FormItem.fdLeftMoney}" pattern="####0.00"></kmss:showNumber>"  class="inputsgl" subject="${lfn:message('fssc-ledger:fsscLedgerContractClause.fdLeftMoney')}" validate=" number" readonly style="width:95%;color:#333;"/>
                </div>
            </td>
            <td align="center">
                <%-- 付款方式--%>
                <div id="_xform_fdDetailList_Form[${vstatus.index}].fdPaymentMethod" _xform_type="text">
                    <xform:text required="true" property="fdDetailList_Form[${vstatus.index}].fdPaymentMethod" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerContractClause.fdPaymentMethod')}" validators=" maxLength(200)" style="width:90%;" />
                </div>
            </td>
            <td align="center">
                <a href="javascript:void(0);" onclick="DocList_DeleteRow();" title="${lfn:message('doclist.delete')}">
                    <img src="${KMSS_Parameter_StylePath}icons/icon_del.png" border="0" />
                </a>
            </td>
        </tr>
    </c:forEach>
</table>
<input type="hidden" name="fdDetailList_Flag" value="1">
<script>
    Com_IncludeFile("doclist.js");
</script>
<script>
    DocList_Info.push('TABLE_DocList_fdDetailList_Form');
</script>

<script>
	window.onload = function(){
		setTimeout(function(){
			var width = $("#t-btn")[0].offsetWidth
			$("#detail_div_for_length").css("width",parseInt(width)).show();
		},200);
	}
	$(".lui-fm-slide-btn").click(function(){
		setTimeout(function(){
			var width = $("#t-btn")[0].offsetWidth
			$("#detail_div_for_length").css("width",parseInt(width)).show();
		},500);
	})
</script>
</ui:content>