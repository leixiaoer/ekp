<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@ taglib uri="/WEB-INF/KmssConfig/fssc/common/fssc.tld" prefix="fssc" %>

<% pageContext.setAttribute("currentUser", UserUtil.getKMSSUser()); %>

<template:include ref="default.edit">
    <template:replace name="head">
        <style type="text/css">

                .lui_paragraph_title{
                    font-size: 15px;
                    color: #15a4fa;
                    padding: 15px 0px 5px 0px;
                }
                .lui_paragraph_title span{
                    display: inline-block;
                    margin: -2px 5px 0px 0px;
                }
                .inputsgl[readonly], .tb_normal .inputsgl[readonly] {
                    border: 0px;
                    color: #868686
                }

        </style>
        <script type="text/javascript">
            var formInitData = {

            };
            var messageInfo = {
                "fssc-cashier:fsscCashierPayment.fdPaymentMoney.message" : "${lfn:message('fssc-cashier:fsscCashierPayment.fdPaymentMoney.message')}"
            };
            Com_IncludeFile("security.js");
            Com_IncludeFile("domain.js");
            Com_IncludeFile("form.js");
            Com_IncludeFile("Number.js", "${LUI_ContextPath}/fssc/common/resource/js/", 'js', true);
            Com_IncludeFile("form_option.js", "${LUI_ContextPath}/fssc/cashier/fssc_cashier_payment/", 'js', true);
            Com_IncludeFile("fsscCashierPayment_edit.js", "${LUI_ContextPath}/fssc/cashier/fssc_cashier_payment/", 'js', true);
            Com_IncludeFile("main_edit.js", "${LUI_ContextPath}/fssc/cashier/resource/js/", 'js', true);
            Com_IncludeFile("swf_attachment.js", "${KMSS_Parameter_ContextPath}sys/attachment/js/", "js", true);
        </script>
    </template:replace>
    <template:replace name="title">
        <c:choose>
            <c:when test="${fsscCashierPaymentForm.method_GET == 'add' }">
                <c:out value="${ lfn:message('operation.create') } - ${ lfn:message('fssc-cashier:table.fsscCashierPayment') }" />
            </c:when>
            <c:otherwise>
                <c:out value="${fsscCashierPaymentForm.docSubject} - " />
                <c:out value="${ lfn:message('fssc-cashier:table.fsscCashierPayment') }" />
            </c:otherwise>
        </c:choose>
    </template:replace>
    <template:replace name="toolbar">
        <ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="3">
            <c:choose>
                <c:when test="${ fsscCashierPaymentForm.method_GET == 'edit' }">
                    <ui:button text="${ lfn:message('button.submit') }" onclick="mySubmit(document.fsscCashierPaymentForm, 'update');" />
                </c:when>
                <c:when test="${ fsscCashierPaymentForm.method_GET == 'add' }">
                    <ui:button text="${ lfn:message('button.submit') }" order="2" onclick="mySubmit(document.fsscCashierPaymentForm, 'save');" />
                </c:when>
            </c:choose>

            <ui:button text="${ lfn:message('button.close') }" order="5" onclick="Com_CloseWindow();" />
        </ui:toolbar>
    </template:replace>
    <template:replace name="path">
        <ui:menu layout="sys.ui.menu.nav">
            <ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" />
            <ui:menu-item text="${ lfn:message('fssc-cashier:table.fsscCashierPayment') }" />
        </ui:menu>
    </template:replace>
    <template:replace name="content">
<html:form action="/fssc/cashier/fssc_cashier_payment/fsscCashierPayment.do">
    <div class='lui_form_title_frame'>
        <div class='lui_form_subject'>
            <table width="100%">
                <tr>
                    <td align="center" height="80px" style="font-size:25px;">
                        ${ lfn:message('fssc-cashier:table.fsscCashierPayment') }
                    </td>
                </tr>
            </table>
        </div>
        <div class='lui_form_baseinfo'>

        </div>
    </div>
    <center>

        <div style="width:95%;">
            <table class="tb_normal" width="100%">
                <tr>
                    <td class="td_normal_title" width="16.6%">
                        ${lfn:message('fssc-cashier:fsscCashierPayment.fdCompany')}
                    </td>
                    <td width="16.6%">
                        <%-- ??????????????????--%>
                        <div id="_xform_fdCompanyId" _xform_type="dialog">
                            <xform:dialog propertyId="fdCompanyId" propertyName="fdCompanyName" showStatus="readOnly" required="true" subject="${lfn:message('fssc-cashier:fsscCashierPayment.fdCompany')}" style="width:95%;">
                                dialogSelect(false,'fssc_base_company_fdCompany','fdCompanyId','fdCompanyName');
                            </xform:dialog>
                        </div>
                    </td>
                    <td class="td_normal_title" width="16.6%">
                        ${lfn:message('fssc-cashier:fsscCashierPayment.fdPaymentMoney')}
                    </td>
                    <td width="16.6%">
                        <%-- ???????????????--%>
                        <div _xform_type="textarea">
                            <xform:text property="fdPaymentMoney" showStatus="readOnly" style="width:95%;" />
                        </div>
                    </td>
                    <td class="td_normal_title" width="16.6%">
                            ${lfn:message('fssc-cashier:fsscCashierPayment.fdModel')}
                    </td>
                    <td width="16.6%">
                            <%-- ????????????--%>
                        <div _xform_type="text">
                            <a href="${LUI_ContextPath}${fsscCashierPaymentForm.fdModelUrl}" target="_blank">${fsscCashierPaymentForm.fdModelNumber}</a>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="16.6%">
                        ${lfn:message('fssc-cashier:fsscCashierPayment.fdDesc')}
                    </td>
                    <td colspan="5" width="83.0%">
                        <%-- ????????????--%>
                        <div id="_xform_fdDesc" _xform_type="textarea">
                            <xform:textarea property="fdDesc" showStatus="edit" style="width:95%;" />
                        </div>
                        <%--<input type="hidden" name="fdBaseCurrencyId" value="${fsscCashierPaymentForm.fdBaseCurrencyId}"/>
                        <input type="hidden" name="fdBaseCurrencyName" value="${fsscCashierPaymentForm.fdBaseCurrencyName}"/>
                        <input type="hidden" name="fdRate" value="${fsscCashierPaymentForm.fdRate}"/>--%>
                        <input  name="fdModelCurrencyIds" value="${fsscCashierPaymentForm.fdModelCurrencyIds}" type="hidden"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="6" width="100%">
                        <span class="lui_icon_s lui_icon_s_icon_18"></span>
                        ${lfn:message('fssc-cashier:table.fsscCashierPaymentDetail')}
                    </td>
                </tr>
                <tr>
                    <td colspan="6">
                        <table class="tb_normal" width="100%" id="TABLE_DocList_fdDetail_Form" align="center"  >
                            <tr align="center" class="tr_normal_title">
                                <td style="width:20px;"></td>
                                <td style="width:40px;">
                                    ${lfn:message('page.serial')}
                                </td>
                                <td style="width:8%;">
                                    ${lfn:message('fssc-cashier:fsscCashierPaymentDetail.docNumber')}
                                </td>
                                <td style="width:8%;">
                                    ${lfn:message('fssc-cashier:fsscCashierPaymentDetail.fdBasePayWay')}
                                </td>
                                <td style="width:8%;">
                                    ${lfn:message('fssc-cashier:fsscCashierPaymentDetail.fdBasePayBank')}
                                </td>
                                <td style="width:8%;">
                                    ${lfn:message('fssc-cashier:fsscCashierPaymentDetail.fdBaseCurrency')}
                                </td>
                               <%--  <td style="width:10%;">
                                    ${lfn:message('fssc-cashier:fsscCashierPaymentDetail.fdRate')}
                                </td> --%>
                                <td style="width:8%;">
                                    ${lfn:message('fssc-cashier:fsscCashierPaymentDetail.fdPayeeName')}
                                </td>
                                <td style="width:8%;">
                                    ${lfn:message('fssc-cashier:fsscCashierPaymentDetail.fdPayeeAccount')}
                                </td>
                                <td style="width:8%;">
                                    ${lfn:message('fssc-cashier:fsscCashierPaymentDetail.fdPayeeBankName')}
                                </td>
                                <fssc:checkUseBank fdBank="BOC">
                                    <td style="width:9%;">
                                    ${lfn:message('fssc-cashier:fsscCashierPaymentDetail.fdPayeeBankNo')}
                                	</td>
                                </fssc:checkUseBank>
                               <fssc:checkUseBank fdBank="CMB">
                                	<td style="width:8%;">
                                    	${lfn:message('fssc-cashier:fsscCashierPaymentDetail.fdPayeeCity')}
                                	</td>
                               </fssc:checkUseBank>
	                           <fssc:checkUseBank fdBank="BANK">  
                                    <td style="width:8%;">
                                    	${lfn:message('fssc-cashier:fsscCashierPaymentDetail.fdSkipFlag')}
                                	</td>
                                </fssc:checkUseBank>
                                <td style="width:8%;">
                                	${lfn:message('fssc-cashier:fsscCashierPaymentDetail.fdPlanPaymentDate')}
                            	</td>
                                <td style="width:8%;">
                                    ${lfn:message('fssc-cashier:fsscCashierPaymentDetail.fdPaymentMoney')}
                                </td>
                                 <td>
	                                ${lfn:message('fssc-cashier:fsscCashierPaymentDetail.fdRemarks')}
	                            </td>
	                            <fssc:checkUseBank fdBank="CMB">
	                             <td>
	                                ${lfn:message('fssc-cashier:fsscCashierPaymentDetail.fdCStlchn')}
	                            </td>
	                            </fssc:checkUseBank>
                                <td style="width:80px;">
                                </td>
                            </tr>
                            <tr KMSS_IsReferRow="1" style="display:none;">
                                <td align="center">
                                    <input type='checkbox' name='DocList_Selected' />
                                </td>
                                <td align="center" KMSS_IsRowIndex="1">
                                    !{index}
                                </td>
                                <td align="center">
                                    <%-- ??????--%>
                                    <div id="_xform_fdDetail_Form[!{index}].docNumber" _xform_type="text">
                                        <xform:text property="fdDetail_Form[!{index}].docNumber" showStatus="readOnly" required="true" subject="${lfn:message('fssc-cashier:fsscCashierPaymentDetail.docNumber')}" style="width:88%;" />
                                    </div>
                                    <input  name="fdDetail_Form[!{index}].fdPaymentType"    value=""  type="hidden" />
                                </td>
                                <td align="center">
                                    <xform:text property="fdDetail_Form[!{index}].fdId" showStatus="noShow"></xform:text>
                                    <xform:text property="fdDetail_Form[!{index}].fdIsTransfer" showStatus="noShow"></xform:text>
                                    <%-- ????????????--%>
                                    <div id="_xform_fdDetail_Form[!{index}].fdBasePayWayId" _xform_type="dialog">
                                        <xform:dialog propertyId="fdDetail_Form[!{index}].fdBasePayWayId" propertyName="fdDetail_Form[!{index}].fdBasePayWayName" showStatus="edit" required="true" subject="${lfn:message('fssc-cashier:fsscCashierPaymentDetail.fdBasePayWay')}" style="width:88%;">
                                            selectPayway();
                                        </xform:dialog>
                                    </div>
                                </td>
                                <td align="center">
                                    <%-- ????????????--%>
                                    <div id="_xform_fdDetail_Form[!{index}].fdBasePayBankId" _xform_type="dialog">
                                        <xform:dialog propertyId="fdDetail_Form[!{index}].fdBasePayBankId" propertyName="fdDetail_Form[!{index}].fdBasePayBankName" showStatus="edit" subject="${lfn:message('fssc-cashier:fsscCashierPaymentDetail.fdBasePayBank')}" style="width:88%;">
                                            dialogSelect(false,'fssc_base_pay_bank_fdBank','fdDetail_Form[*].fdBasePayBankId','fdDetail_Form[*].fdBasePayBankName', null, {'fdCompanyId':$('[name=fdCompanyId]').val()});
                                        </xform:dialog>
                                    </div>
                                </td>
                                <td align="center">
                                    <%-- ??????--%>
                                    <div id="_xform_fdDetail_Form[!{index}].fdBaseCurrencyId" xform_type="text">
                                        <input type="text" name="fdDetail_Form[!{index}].fdBaseCurrencyName" value="${fdDetail_FormItem.fdBaseCurrencyName }" class="inputsgl" readonly="readonly" subject="${lfn:message('fssc-cashier:fsscCashierPaymentDetail.fdBaseCurrencyName')}" style="width:45%;color:#000000;"/>
                                         <input type="text" name="fdDetail_Form[!{index}].fdRate" value="${fdDetail_FormItem.fdRate }" class="inputsgl" readonly="readonly" subject="${lfn:message('fssc-cashier:fsscCashierPaymentDetail.fdRate')}" style="width:25%;color:#000000;"/>
                                         <input name="fdDetail_Form[!{index}].fdBaseCurrencyId" value="${fdDetail_FormItem.fdBaseCurrencyId }"  type="hidden"/>
                                    </div>
                                </td>
                                <td align="center">
                                    <%-- ???????????????--%>
                                    <div id="_xform_fdDetail_Form[!{index}].fdPayeeName" _xform_type="text">
                                        <xform:text property="fdDetail_Form[!{index}].fdPayeeName" showStatus="edit" subject="${lfn:message('fssc-cashier:fsscCashierPaymentDetail.fdPayeeName')}" style="width:88%;" />
                                    	<span class="txtstrong vat_!{index}">*</span>
                                    </div>
                                </td>
                                <td align="center">
                                    <%-- ???????????????--%>
                                    <div id="_xform_fdDetail_Form[!{index}].fdPayeeAccount" _xform_type="text">
                                        <xform:text property="fdDetail_Form[!{index}].fdPayeeAccount" showStatus="edit" subject="${lfn:message('fssc-cashier:fsscCashierPaymentDetail.fdPayeeAccount')}" style="width:88%;" />
                                    	<span class="txtstrong vat_!{index}">*</span>
                                    </div>
                                </td>
                                <td align="center">
                                    <%-- ???????????????--%>
                                    <div id="_xform_fdDetail_Form[!{index}].fdPayeeBankName" _xform_type="text">
                                        <xform:text property="fdDetail_Form[!{index}].fdPayeeBankName" showStatus="edit" subject="${lfn:message('fssc-cashier:fsscCashierPaymentDetail.fdPayeeBankName')}" style="width:88%;" />
                                    	<span class="txtstrong vat_!{index}">*</span>
                                    </div>
                                </td>
                               <fssc:checkUseBank fdBank="BOC">
                                <td align="center">
                                    <%-- ?????????--%>
                                    <div id="_xform_fdDetail_Form[!{index}].fdPayeeBankNo" _xform_type="text">
                                        <xform:text property="fdDetail_Form[!{index}].fdPayeeBankNo" showStatus="edit" subject="${lfn:message('fssc-cashier:fsscCashierPaymentDetail.fdPayeeBankNo')}" style="width:88%;" />
                                    	<span class="txtstrong vat_!{index}">*</span>
                                    </div>
                                </td>
                               </fssc:checkUseBank>  
                               <fssc:checkUseBank fdBank="CMB">
                                       <td align="center">
		                                    <%-- ????????????--%>
		                                    <div id="_xform_fdDetail_Form[!{index}].fdPayeeCity" >
								                <div class="inputselectsgl" style="width:95%;">
								                <input  name="fdDetail_Form[!{index}].fdPayeeCityCode"  type="hidden">
								                <div class="selectitem" onclick="FSSC_SelectPayeeCity();"  ></div>
								                </div>
								                <span class="txtstrong vat_!{index}">*</span>
		                                    </div>
	                                   </td>
	                            </fssc:checkUseBank>
	                             <fssc:checkUseBank fdBank="BANK">  
	                                   <td align="center">
	                                    <%-- ????????????--%>
	                                    <div id="_xform_fdDetail_Form[!{index}].fdSkipFlag" >
	                                   	 		<xform:select property="fdDetail_Form[!{index}].fdSkipFlag">
	                                        		<xform:enumsDataSource enumsType="fs_base_skip_flag" />
	                                        	</xform:select>
	                                        	<input  name="fdDetail_Form[!{index}].fdSkipFlag"  value="${fdDetail_FormItem.fdSkipFlag }" type="hidden" >
	                                    </div>
	                                	</td>
                                   </fssc:checkUseBank>
                                <td align="center">
                                    <%-- ??????????????????--%>
                                    <div id="_xform_fdDetail_Form[!{index}].fdPlanPaymentDate" _xform_type="text">
                                    	<xform:datetime property="fdDetail_Form[!{index}].fdPlanPaymentDate" showStatus="edit" required="true" subject="${lfn:message('fssc-cashier:fsscCashierPaymentDetail.fdPlanPaymentDate')}"  style="width:88%;" ></xform:datetime>
                                    </div>
                                </td>
                                <td align="center">
                                    <%-- ????????????--%>
                                    <div id="_xform_fdDetail_Form[!{index}].fdPaymentMoney" _xform_type="text">
                                        <xform:text property="fdDetail_Form[!{index}].fdPaymentMoney" showStatus="edit" required="true" subject="${lfn:message('fssc-cashier:fsscCashierPaymentDetail.fdPaymentMoney')}" validators="scaleLength(2) number" style="width:88%;" />
                                    </div>
                                </td>
                                 <td align="center">
                                    <%-- ??????--%>
                                    <div id="_xform_fdDetail_Form[!{index}].fdRemarks" _xform_type="text">
                                        <xform:text property="fdDetail_Form[!{index}].fdRemarks" showStatus="edit" required="true" subject="${lfn:message('fssc-cashier:fsscCashierPaymentDetail.fdRemarks')}"  style="width:88%;" />
                                    </div>
                                </td>
                                <fssc:checkUseBank fdBank="CMB">
                                 <td align="center">
                                    <%-- ????????????--%>
                                    <div id="_xform_fdDetail_Form[!{index}].fdCStlchn" _xform_type="text">
                                        <xform:select property="fdDetail_Form[!{index}].fdCStlchn"  required="true">
	                                        		<xform:enumsDataSource enumsType="fssc_cashier_c_stlchn" />
	                                        	</xform:select>
                                    </div>
                                </td>
                                </fssc:checkUseBank>
                                
                                
                                <td align="center">
                                    <a href="javascript:void(0);" onclick="FSSC_CopyRowDeteil();" title="${lfn:message('doclist.copy')}">
                                        <img src="${KMSS_Parameter_StylePath}icons/icon_copy.png" border="0" />
                                    </a>
                                    &nbsp;
                                    <a href="javascript:void(0);" onclick="DocList_DeleteRow();" title="${lfn:message('doclist.delete')}">
                                        <img src="${KMSS_Parameter_StylePath}icons/icon_del.png" border="0" />
                                    </a>
                                </td>
                            </tr>
                            <c:forEach items="${fsscCashierPaymentForm.fdDetail_Form}" var="fdDetail_FormItem" varStatus="vstatus">
                                <tr KMSS_IsContentRow="1">
                                    <td align="center">
                                        <input type="checkbox" name="DocList_Selected" />
                                    </td>
                                    <td align="center">
                                        ${vstatus.index+1}
                                    </td>
                                    <td align="center">
                                        <%-- ??????--%>
                                        <div id="_xform_fdDetail_Form[${vstatus.index}].docNumber" _xform_type="text">
                                            <xform:text property="fdDetail_Form[${vstatus.index}].docNumber" showStatus="view" required="true" subject="${lfn:message('fssc-cashier:fsscCashierPaymentDetail.docNumber')}" style="width:88%;" />
                                        </div>
                                         <input name="fdDetail_Form[${vstatus.index}].fdPaymentType" value="${fdDetail_FormItem.fdPaymentType }"  type="hidden"/>
                                    </td>
                                    <td align="center">
                                        <input type="hidden" name="fdDetail_Form[${vstatus.index}].fdId" value="${fdDetail_FormItem.fdId}" />
                                        <xform:text property="fdDetail_Form[${vstatus.index}].fdIsTransfer" showStatus="noShow"/>
                                        <%-- ????????????--%>
                                        <div id="_xform_fdDetail_Form[${vstatus.index}].fdBasePayWayId" _xform_type="dialog">
                                            <xform:dialog propertyId="fdDetail_Form[${vstatus.index}].fdBasePayWayId" propertyName="fdDetail_Form[${vstatus.index}].fdBasePayWayName" showStatus="edit" required="true" subject="${lfn:message('fssc-cashier:fsscCashierPaymentDetail.fdBasePayWay')}" style="width:88%;">
	                                            selectPayway();
	                                        </xform:dialog>
                                        </div>
                                    </td>
                                    <td align="center">
                                        <%-- ????????????--%>
                                        <div id="_xform_fdDetail_Form[${vstatus.index}].fdBasePayBankId" _xform_type="dialog">
                                            <xform:dialog propertyId="fdDetail_Form[${vstatus.index}].fdBasePayBankId" propertyName="fdDetail_Form[${vstatus.index}].fdBasePayBankName" showStatus="${fdDetail_FormItem.fdShowStatus}" subject="${lfn:message('fssc-cashier:fsscCashierPaymentDetail.fdBasePayBank')}" style="width:88%;">
                                               selectPayBank();
                                            </xform:dialog>
                                        </div>
                                    </td>
                                    <td align="center">
                                        <%-- ??????--%>
                                        <div id="_xform_fdDetail_Form[${vstatus.index}].fdBaseCurrencyId" xform_type="text" >
                                            <input type="text"  name="fdDetail_Form[${vstatus.index}].fdBaseCurrencyName" value="${fdDetail_FormItem.fdBaseCurrencyName }" class="inputsgl" readonly="readonly"  subject="${lfn:message('fssc-cashier:fsscCashierPaymentDetail.fdBaseCurrencyName')}" style="width:45%;color:#000000;"/>
                                               <input type="text"  name="fdDetail_Form[${vstatus.index}].fdRate" value="${fdDetail_FormItem.fdRate }" class="inputsgl" readonly="readonly"  subject="${lfn:message('fssc-cashier:fsscCashierPaymentDetail.fdRate')}" style="width:25%;color:#000000;"/>
                                            <input name="fdDetail_Form[${vstatus.index}].fdBaseCurrencyId" value="${fdDetail_FormItem.fdBaseCurrencyId }"  type="hidden"/>
                                        </div>
                                    </td>
                                    <td align="center">
                                        <%-- ???????????????--%>
                                        <div id="_xform_fdDetail_Form[${vstatus.index}].fdPayeeName" _xform_type="text">
                                            <xform:text property="fdDetail_Form[${vstatus.index}].fdPayeeName" showStatus="${fdDetail_FormItem.fdShowStatus}" subject="${lfn:message('fssc-cashier:fsscCashierPaymentDetail.fdPayeeName')}" style="width:88%;" />
                                        	<span class="txtstrong vat_${vstatus.index}">*</span>
                                        </div>
                                    </td>
                                    <td align="center">
                                        <%-- ???????????????--%>
                                        <div id="_xform_fdDetail_Form[${vstatus.index}].fdPayeeAccount" _xform_type="text">
                                            <xform:text property="fdDetail_Form[${vstatus.index}].fdPayeeAccount" showStatus="${fdDetail_FormItem.fdShowStatus}" subject="${lfn:message('fssc-cashier:fsscCashierPaymentDetail.fdPayeeAccount')}" style="width:88%;" />
                                        	<span class="txtstrong vat_${vstatus.index}">*</span>
                                        </div>
                                    </td>
                                    <td align="center">
                                        <%-- ???????????????--%>
                                        <div id="_xform_fdDetail_Form[${vstatus.index}].fdPayeeBankName" _xform_type="text">
                                            <xform:text property="fdDetail_Form[${vstatus.index}].fdPayeeBankName" showStatus="${fdDetail_FormItem.fdShowStatus}" subject="${lfn:message('fssc-cashier:fsscCashierPaymentDetail.fdPayeeBankName')}" style="width:88%;" />
                                        	<span class="txtstrong vat_${vstatus.index}">*</span>
                                        </div>
                                    </td>
                                    <fssc:checkUseBank fdBank="BOC">
	                                    <td align="center">
	                                        <%-- ?????????--%>
	                                        <div id="_xform_fdDetail_Form[${vstatus.index}].fdPayeeBankNo" _xform_type="text">
	                                            <xform:text property="fdDetail_Form[${vstatus.index}].fdPayeeBankNo" showStatus="${fdDetail_FormItem.fdShowStatus}" subject="${lfn:message('fssc-cashier:fsscCashierPaymentDetail.fdPayeeBankNo')}" style="width:88%;" />
	                                        	<span class="txtstrong vat_${vstatus.index}">*</span>
	                                        </div>
	                                    </td>
                                    </fssc:checkUseBank>
                                    <fssc:checkUseBank fdBank="CMB">
                                        <td align="center">
		                                    <%-- ????????????--%>
		                                    <div id="_xform_fdDetail_Form[${vstatus.index}].fdPayeeCity">
								                <div class="inputselectsgl" style="width:95%;">
								                <input  name="fdDetail_Form[${vstatus.index}].fdPayeeCityCode" value="${fdDetail_FormItem.fdPayeeCityCode }"  type="hidden">
								                <div class="selectitem" onclick="FSSC_SelectPayeeCity();"  ></div>
								                </div>
								                <span class="txtstrong vat_${vstatus.index}">*</span>
		                                    </div>
	                                   </td>
	                                </fssc:checkUseBank>
	                             	<fssc:checkUseBank fdBank="BANK">  
	                                   <td align="center">
	                                    <%-- ????????????--%>
	                                    <div id="_xform_fdDetail_Form[${vstatus.index}].fdSkipFlag" >
	                                        <xform:select property="fdDetail_Form[${vstatus.index}].fdSkipFlag" required="true" >
	                                        	<xform:enumsDataSource enumsType="fs_base_skip_flag" />
	                                        </xform:select>
	                                        <input  name="fdDetail_Form[${vstatus.index}].fdSkipFlag"    value="${fdDetail_FormItem.fdSkipFlag }"  type="hidden" />
	                                    </div>
	                                	</td>
                                   </fssc:checkUseBank>
                                     <td align="center">
                                   		 <%-- ??????????????????--%>
                                    	<div id="_xform_fdDetail_Form[${vstatus.index}].fdPlanPaymentDate" _xform_type="text">
                                    		<xform:datetime property="fdDetail_Form[${vstatus.index}].fdPlanPaymentDate" showStatus="edit" required="true" subject="${lfn:message('fssc-cashier:fsscCashierPaymentDetail.fdPlanPaymentDate')}"  style="width:75%;"></xform:datetime>
                                    	</div>
                                	</td>
                                    <td align="center">
                                        <%-- ????????????--%>
                                        <div id="_xform_fdDetail_Form[${vstatus.index}].fdPaymentMoney" _xform_type="text">
                                            <xform:text property="fdDetail_Form[${vstatus.index}].fdPaymentMoney" showStatus="${fdDetail_FormItem.fdShowStatus}" required="true" subject="${lfn:message('fssc-cashier:fsscCashierPaymentDetail.fdPaymentMoney')}" validators="scaleLength(2) number" style="width:75%;" />
                                        </div>
                                    </td>
                                    <td align="center">
	                                    <%-- ??????--%>
	                                    <div id="_xform_fdDetail_Form[${vstatus.index}].fdRemarks" _xform_type="text">
	                                        <xform:text property="fdDetail_Form[${vstatus.index}].fdRemarks" showStatus="edit" required="true" subject="${lfn:message('fssc-cashier:fsscCashierPaymentDetail.fdRemarks')}"  style="width:88%;" />
	                                    </div>
	                                </td>
	                                <fssc:checkUseBank fdBank="CMB">
	                                 <td align="center">
	                                    <%-- ????????????--%>
	                                    <div id="_xform_fdDetail_Form[${vstatus.index}].fdCStlchn" _xform_type="text">
	                                   			 <xform:select property="fdDetail_Form[${vstatus.index}].fdCStlchn"  required="true">
	                                        		<xform:enumsDataSource enumsType="fssc_cashier_c_stlchn" />
	                                        	</xform:select>
	                                    </div>
	                                </td>
	                                </fssc:checkUseBank>
                                    <td align="center">
                                        <a href="javascript:void(0);" onclick="FSSC_CopyRowDeteil();" title="${lfn:message('doclist.copy')}">
                                            <img src="${KMSS_Parameter_StylePath}icons/icon_copy.png" border="0" />
                                        </a>
                                        <c:if test="${fdDetail_FormItem.fdShowStatus == 'edit'}">
                                            &nbsp;
                                            <a href="javascript:void(0);" onclick="DocList_DeleteRow();" title="${lfn:message('doclist.delete')}">
                                                <img src="${KMSS_Parameter_StylePath}icons/icon_del.png" border="0" />
                                            </a>
                                        </c:if>
                                    </td>
			              </tr>
                            </c:forEach>
                            <tr type="optRow" class="tr_normal_opt" invalidrow="true">
                                <td colspan="8">
                                    <a href="javascript:void(0);" onclick="FSSC_AddCashierDeteil();">
                                        <img src="${KMSS_Parameter_StylePath}icons/icon_add.png" border="0" />${lfn:message('doclist.add')}
                                    </a>
                                    &nbsp;
                                    <a href="javascript:void(0);" onclick="DocList_MoveRowBySelect(-1);">
                                        <img src="${KMSS_Parameter_StylePath}icons/icon_up.png" border="0" />${lfn:message('doclist.moveup')}
                                    </a>
                                    &nbsp;
                                    <a href="javascript:void(0);" onclick="DocList_MoveRowBySelect(1);">
                                        <img src="${KMSS_Parameter_StylePath}icons/icon_down.png" border="0" />${lfn:message('doclist.movedown')}
                                    </a>
                                    &nbsp;
                                </td>
                            </tr>
                        </table>
                        <input type="hidden" name="fdDetail_Flag" value="1">
                        <script>
                            Com_IncludeFile("doclist.js");
                        </script>
                        <script>
                            DocList_Info.push('TABLE_DocList_fdDetail_Form');
                        </script>
                    </td>
                </tr>
            	</table>
            </div>
    </center>
    <html:hidden property="fdId" />
    <html:hidden property="method_GET" />
    <script>
        $KMSSValidation();
    </script>
</html:form>
</template:replace>
</template:include>