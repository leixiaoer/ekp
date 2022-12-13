<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/fssc/common/fssc.tld" prefix="fssc"%>
<div data-dojo-type="mui/table/ScrollableHContainer" >
	<div data-dojo-type="mui/table/ScrollableHView" style="margin-top:20px;" id="dt_wrap_invoice_hview">
		    <table class="muiNormal" id="TABLE_DocList_fdInvoiceList_Form" width="100%" border="0" cellspacing="0" cellpadding="0">
		    <tr align="center" class="tr_normal_title">
		        <td width="5%">
		            ${lfn:message('page.serial')}
		        </td>
		        <td width="14%">
		            ${lfn:message('fssc-expense:fsscExpenseInvoiceDetail.fdInvoiceType')}
		        </td>
		        <td width="8%">
		            ${lfn:message('fssc-expense:fsscExpenseInvoiceDetail.fdInvoiceNumber')}
		        </td>
		        <td width="12%">
		            ${lfn:message('fssc-expense:fsscExpenseInvoiceDetail.fdInvoiceCode')}
		        </td>
		        <td width="8%">
		            ${lfn:message('fssc-expense:fsscExpenseInvoiceDetail.fdInvoiceDate')}
		        </td>
		        <td width="8%">
		            ${lfn:message('fssc-expense:fsscExpenseInvoiceDetail.fdInvoiceMoney')}
		        </td>
		        <td width="8%">
		            ${lfn:message('fssc-expense:fsscExpenseInvoiceDetail.fdTaxMoney')}
		        </td>
		        <td width="8%">
		            ${lfn:message('fssc-expense:fsscExpenseInvoiceDetail.fdNoTaxMoney')}
		        </td>
		        <td width="8%">
		            ${lfn:message('fssc-expense:fsscExpenseInvoiceDetail.fdCheckStatus')}
		        </td>
		    </tr>
		    <kmss:ifModuleExist path="/fssc/ledger/"><c:set value="true" var="ledgerExist"></c:set></kmss:ifModuleExist>
		    <c:forEach items="${fsscExpenseMainForm.fdInvoiceList_Form}" var="fdInvoiceList_FormItem" varStatus="vstatus">
		        <tr KMSS_IsContentRow="1">
		            <td align="center">
		                ${vstatus.index+1}
		            </td>
		            <td align="center">
			            <div id="_xform_fdInvoiceList_Form[${vstatus.index}].fdInvoiceType" _xform_type="text">
			                	 <xform:select property="fdInvoiceList_Form[${vstatus.index}].fdInvoiceType" htmlElementProperties="id='fdInvoiceType'">
				                    <xform:enumsDataSource enumsType="fssc_invoice_type" />
				                </xform:select>
			            </div>
			        </td>
		            <td align="center">
			            <div id="_xform_fdInvoiceList_Form[${vstatus.index}].fdInvoiceNumber" _xform_type="text">
			                	<xform:text property="fdInvoiceList_Form[${vstatus.index}].fdInvoiceNumber" subject="${lfn:message('fssc-expense:fsscExpenseInvoiceDetail.fdInvoiceNumber') }" style="width:85%;" />
			            </div>
			        </td>
			        
			        <td align="center">
			            <div id="_xform_fdInvoiceList_Form[${vstatus.index}].fdInvoiceCode" _xform_type="text" class="vat">
			                	<xform:text property="fdInvoiceList_Form[${vstatus.index}].fdInvoiceCode" subject="${lfn:message('fssc-expense:fsscExpenseInvoiceDetail.fdInvoiceCode') }" style="width:85%;" />
			            </div>
			        </td>
			        <td align="center">
			            <div id="_xform_fdInvoiceList_Form[${vstatus.index}].fdInvoiceDate" _xform_type="text" class="vat">
			                	<xform:datetime dateTimeType="date" property="fdInvoiceList_Form[${vstatus.index}].fdInvoiceDate" subject="${lfn:message('fssc-expense:fsscExpenseInvoiceDetail.fdInvoiceDate') }" style="width:85%;" />
			            </div>
			        </td>
			        <td align="center">
			            <div id="_xform_fdInvoiceList_Form[${vstatus.index}].fdInvoiceMoney" _xform_type="text" class="vat">
			                	<kmss:showNumber value="${fdInvoiceList_FormItem.fdInvoiceMoney }" pattern="0.00"/>
			            </div>
			        </td>
			        <td align="center">
			            <div id="_xform_fdInvoiceList_Form[${vstatus.index}].fdTaxMoney" _xform_type="text" class="vat">
			                	<kmss:showNumber value="${fdInvoiceList_FormItem.fdTaxMoney }" pattern="0.00"/>
			            </div>
			        </td>
			        <td align="center">
			            <div id="_xform_fdInvoiceList_Form[${vstatus.index}].fdNotTaxMoney" _xform_type="text" class="vat">
			                	<kmss:showNumber value="${fdInvoiceList_FormItem.fdNoTaxMoney }" pattern="0.00"/>
			            </div>
			        </td>
			        <td align="center">
			            <div id="_xform_fdInvoiceList_Form[${vstatus.index}].fdCheckStatus" _xform_type="text" class="vat">
			                <sunbor:enumsShow enumsType="fssc_invoice_check_status" value="${fdInvoiceList_FormItem.fdCheckStatus }"></sunbor:enumsShow>
			            </div>
			        </td>
		        </tr>
		    </c:forEach>
			</table>
		<input type="hidden" name="fdAccountsList_Flag" value="1">
	</div>
</div>


