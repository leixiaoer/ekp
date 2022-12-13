<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<ui:content title="${ lfn:message('fssc-expense:py.JiBenXinXi') }">
	<table class="tb_normal" width="100%">
		<tr>
			<td  class="td_normal_title" width="10%" >${lfn:message('fssc-expense:fsscExpenseMain.docCreator') }</td>
			<td  width="23%">${fsscExpenseMainForm.docCreatorName }</td>
			<td  class="td_normal_title" width="10%" >${lfn:message('fssc-expense:fsscExpenseMain.docCreateTime') }</td>
			<td  width="23%">${fsscExpenseMainForm.docCreateTime }</td>
			<td  class="td_normal_title" width="10%" >${lfn:message('fssc-expense:fsscExpenseMain.fdPaymentStatus') }</td>
			<td  width="23%"><sunbor:enumsShow enumsType="fssc_base_payment_status" value="${fsscExpenseMainForm.fdPaymentStatus }"></sunbor:enumsShow></td>
		</tr>
		<tr>
			<td  class="td_normal_title" width="10%" >${lfn:message('fssc-expense:fsscExpenseMain.fdVoucherStatus') }</td>
			<td  width="23%"> <sunbor:enumsShow enumsType="fssc_base_fd_voucher_status" value="${fsscExpenseMainForm.fdVoucherStatus }"></sunbor:enumsShow></td>
			<td  class="td_normal_title" width="10%" >${lfn:message('fssc-expense:fsscExpenseMain.fdBookkeepingStatus') }</td>
			<td  width="23%"> <sunbor:enumsShow enumsType="fssc_base_fd_bookkeeping_status" value="${fsscExpenseMainForm.fdBookkeepingStatus }"></sunbor:enumsShow></td>
			<td  class="td_normal_title" width="10%">${lfn:message('fssc-expense:fsscExpenseMain.docStatus') }</td>
			<td  width="23%"><sunbor:enumsShow enumsType="common_status" value="${fsscExpenseMainForm.docStatus }"></sunbor:enumsShow></td>
		</tr>
		<tr>
			<td  class="td_normal_title" width="10%">${lfn:message('fssc-expense:fsscExpenseMain.docPublishTime') }</td>
			<td  width="23%" colspan="5">${fsscExpenseMainForm.docPublishTime}</td>
		</tr>
	</table>
</ui:content>