<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@ taglib uri="/WEB-INF/KmssConfig/fssc/common/fssc.tld" prefix="fssc" %>
<table class="tb_normal" width="100%" id="TABLE_DocList_fdAccountList_Form" align="center" tbdraggable="true">
    <tr align="center" class="tr_normal_title">
        <td style="width:40px;">
            ${lfn:message('page.serial')}
        </td>
        <td>
            ${lfn:message('fssc-base:fsscBaseSupplierAccount.fdSupplierArea')}
        </td>
        <td>
            ${lfn:message('fssc-base:fsscBaseSupplierAccount.fdAccountName')}
        </td>
        <td>
            ${lfn:message('fssc-base:fsscBaseSupplierAccount.fdBankName')}
        </td>
        <td>
            ${lfn:message('fssc-base:fsscBaseSupplierAccount.fdBankNo')}
        </td>
        <td>
            ${lfn:message('fssc-base:fsscBaseSupplierAccount.fdBankAccount')}
        </td>
       <fssc:checkUseBank fdBank="CMB">
	        <td>
	            ${lfn:message('fssc-base:fsscBaseSupplierAccount.fdAccountAreaName')}
	        </td>
        </fssc:checkUseBank>
        <td>
            ${lfn:message('fssc-base:fsscBaseSupplierAccount.fdBankSwift')}
        </td>
        <td>
            ${lfn:message('fssc-base:fsscBaseSupplierAccount.fdReceiveCompany')}
        </td>
        <td>
            ${lfn:message('fssc-base:fsscBaseSupplierAccount.fdReceiveBankName')}
        </td>
        <td>
            ${lfn:message('fssc-base:fsscBaseSupplierAccount.fdReceiveBankAddress')}
        </td>
        <td>
            ${lfn:message('fssc-base:fsscBaseSupplierAccount.fdInfo')}
        </td>
    </tr>
    <c:forEach items="${fsscBaseSupplierForm.fdAccountList_Form}" var="fdAccountList_FormItem" varStatus="vstatus">
        <tr KMSS_IsContentRow="1">
            <td align="center">
                ${vstatus.index+1}
            </td>
            <td align="center">
                <%-- 所在区域--%>
                <div id="_xform_fdAccountList_Form[${vstatus.index}].fdSupplierArea" _xform_type="radio">
                    <div>
                    	<c:if test="${fdAccountList_FormItem.fdSupplierArea=='0'}">${lfn:message('fssc-base:enums.supplier_area.0') }</c:if>
                    	<c:if test="${fdAccountList_FormItem.fdSupplierArea=='1'}">${lfn:message('fssc-base:enums.supplier_area.1') }</c:if>
                    </div>
                </div>
            </td>
            <td align="center">
                <%-- 收款账户名--%>
                <input type="hidden" name="fdAccountList_Form[${vstatus.index}].fdId" value="${fdAccountList_FormItem.fdId}" />
                <div id="_xform_fdAccountList_Form[${vstatus.index}].fdAccountName" _xform_type="text">
                    <xform:text property="fdAccountList_Form[${vstatus.index}].fdAccountName"  required="true" subject="${lfn:message('fssc-base:fsscBaseSupplierAccount.fdAccountName')}" validators=" maxLength(200)" style="width:85%;" />
                </div>
            </td>
            <td align="center">
                <%-- 开户行--%>
                <div id="_xform_fdAccountList_Form[${vstatus.index}].fdBankName" _xform_type="text">
                    <xform:text property="fdAccountList_Form[${vstatus.index}].fdBankName"  required="true" subject="${lfn:message('fssc-base:fsscBaseSupplierAccount.fdBankName')}" validators=" maxLength(300)" style="width:85%;" />
                </div>
            </td>
            <td align="center">
                <%-- 联行号--%>
                <div id="_xform_fdAccountList_Form[${vstatus.index}].fdBankNo" _xform_type="text">
                    <xform:text property="fdAccountList_Form[${vstatus.index}].fdBankNo"  subject="${lfn:message('fssc-base:fsscBaseSupplierAccount.fdBankNo')}" validators=" maxLength(20)" style="width:85%;" />
                </div>
            </td>
            <td align="center">
                <%-- 账号--%>
                <div id="_xform_fdAccountList_Form[${vstatus.index}].fdBankAccount" _xform_type="text">
                    <xform:text property="fdAccountList_Form[${vstatus.index}].fdBankAccount"  required="true" subject="${lfn:message('fssc-base:fsscBaseSupplierAccount.fdBankAccount')}" validators=" maxLength(200)" style="width:85%;" />
                </div>
            </td>
            <fssc:checkUseBank  fdBank="CMB">
			 	<td align="center">
			 		<div id="_xform_fdAccountList_Form[${vstatus.index}].fdAccountAreaCode" _xform_type="dialog">
	                    <xform:dialog propertyId="fdAccountList_Form[${vstatus.index}].fdAccountAreaCode" propertyName="fdAccountList_Form[${vstatus.index}].fdAccountAreaName" showStatus="view" style="width:95%;">
	                        FSSC_SelectAccountArea();
	                    </xform:dialog>
	                </div>
               	</td>
            </fssc:checkUseBank>
            <td align="center">
                <%-- 收款银行swift号--%>
                <div id="_xform_fdAccountList_Form[${vstatus.index}].fdBankSwift" _xform_type="text">
                    <xform:text property="fdAccountList_Form[${vstatus.index}].fdBankSwift"  subject="${lfn:message('fssc-base:fsscBaseSupplierAccount.fdBankSwift')}" validators=" maxLength(50)" style="width:85%;" />
                    <span class="txtstrong" style="display:none;">*</span>
                </div>
            </td>
            <td align="center">
                <%-- 收款公司名称--%>
                <div id="_xform_fdAccountList_Form[${vstatus.index}].fdReceiveCompany" _xform_type="text">
                    <xform:text property="fdAccountList_Form[${vstatus.index}].fdReceiveCompany"  subject="${lfn:message('fssc-base:fsscBaseSupplierAccount.fdReceiveCompany')}" validators=" maxLength(200)" style="width:85%;" />
                    <span class="txtstrong" style="display:none;">*</span>
                </div>
            </td>
            <td align="center">
                <%-- 收款银行名称（境外）--%>
                <div id="_xform_fdAccountList_Form[${vstatus.index}].fdReceiveBankName" _xform_type="text">
                    <xform:text property="fdAccountList_Form[${vstatus.index}].fdReceiveBankName"  subject="${lfn:message('fssc-base:fsscBaseSupplierAccount.fdReceiveBankName')}" validators=" maxLength(200)" style="width:85%;" />
                    <span class="txtstrong" style="display:none;">*</span>
                </div>
            </td>
            <td align="center">
                <%-- 收款银行地址（境外）--%>
                <div id="_xform_fdAccountList_Form[${vstatus.index}].fdReceiveBankAddress" _xform_type="text">
                    <xform:text property="fdAccountList_Form[${vstatus.index}].fdReceiveBankAddress"  subject="${lfn:message('fssc-base:fsscBaseSupplierAccount.fdReceiveBankAddress')}" validators=" maxLength(200)" style="width:85%;" />
                    <span class="txtstrong" style="display:none;">*</span>
                </div>
            </td>
            <td align="center">
                <%-- 其他信息--%>
                <div id="_xform_fdAccountList_Form[${vstatus.index}].fdInfo" _xform_type="text">
                    <xform:text property="fdAccountList_Form[${vstatus.index}].fdInfo"  subject="${lfn:message('fssc-base:fsscBaseSupplierAccount.fdInfo')}" validators=" maxLength(200)" style="width:85%;" />
                </div>
            </td>
        </tr>
    </c:forEach>
</table>
<input type="hidden" name="fdAccountList_Flag" value="1">
<script>
    Com_IncludeFile("doclist.js");
</script>
<script>
    DocList_Info.push('TABLE_DocList_fdAccountList_Form');
</script>