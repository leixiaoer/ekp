<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@ include file="/fssc/base/resource/jsp/jshead.jsp" %>
<%@ include file="/resource/jsp/edit_top.jsp" %>
<%@ taglib uri="/WEB-INF/KmssConfig/fssc/common/fssc.tld" prefix="fssc" %>
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

    };
    Com_IncludeFile("security.js");
    Com_IncludeFile("domain.js");
    Com_IncludeFile("form.js");
    Com_IncludeFile("config_edit.js", "${LUI_ContextPath}/fssc/base/resource/js/", 'js', true);
    Com_IncludeFile("form_option.js", "${LUI_ContextPath}/fssc/base/fssc_base_exchange_rate/", 'js', true);
</script>

    <% pageContext.setAttribute("currentUser", UserUtil.getKMSSUser()); %>

<html:form action="/fssc/base/fssc_base_exchange_rate/fsscBaseExchangeRate.do">
    <div id="optBarDiv">
        <c:choose>
            <c:when test="${fsscBaseExchangeRateForm.method_GET=='edit'}">
                <input type="button" value="${ lfn:message('button.update') }" onclick="Com_Submit(document.fsscBaseExchangeRateForm, 'update');">
            </c:when>
            <c:when test="${fsscBaseExchangeRateForm.method_GET=='add'}">
                <input type="button" value="${ lfn:message('button.save') }" onclick="Com_Submit(document.fsscBaseExchangeRateForm, 'save');">
                <input type="button" value="${ lfn:message('button.saveadd') }" onclick="Com_Submit(document.fsscBaseExchangeRateForm, 'saveadd');">
            </c:when>
        </c:choose>
        <input type="button" value="${ lfn:message('button.close') }" onclick="Com_CloseWindow();">
    </div>
    <p class="txttitle">${ lfn:message('fssc-base:table.fsscBaseExchangeRate') }</p>
    <center>

        <div style="width:95%;">
            <table class="tb_normal" width="100%">
            	<tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseExchangeRate.fdCompany')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdCompanyId" _xform_type="dialog">
                        	<xform:text property="fdCompanyId" showStatus="noShow"></xform:text>
                            <fssc:switchOff property="fdShowType">
	                            <xform:dialog propertyId="fdCompanyId" propertyName="fdCompanyName" subject="${lfn:message('fssc-base:fsscBaseExchangeRate.fdCompany')}" showStatus="view" style="width:95%;">
	                                dialogSelect(false,'fssc_base_company_fdCompany','fdCompanyId','fdCompanyName');
	                            </xform:dialog>
                            </fssc:switchOff>
                        	<fssc:switchOn property="fdShowType">
	                            <xform:dialog propertyId="fdCompanyId" propertyName="fdCompanyName" subject="${lfn:message('fssc-base:fsscBaseExchangeRate.fdCompany')}" showStatus="edit" required="true" style="width:95%;">
	                                dialogSelect(false,'fssc_base_company_fdCompany','fdCompanyId','fdCompanyName');
	                            </xform:dialog>
                            </fssc:switchOn>
                        </div>
                        </a>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseExchangeRate.fdSourceCurrency')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdSourceCurrencyId" _xform_type="dialog">
                            <xform:dialog propertyId="fdSourceCurrencyId" propertyName="fdSourceCurrencyName" subject="${lfn:message('fssc-base:fsscBaseExchangeRate.fdSourceCurrency')}" showStatus="edit" style="width:95%;">
                                dialogSelect(false,'fssc_base_currency_fdCurrency','fdSourceCurrencyId','fdSourceCurrencyName');
                            </xform:dialog>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseExchangeRate.fdTargetCurrency')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdTargetCurrencyId" _xform_type="dialog">
                            <xform:dialog propertyId="fdTargetCurrencyId" propertyName="fdTargetCurrencyName" subject="${lfn:message('fssc-base:fsscBaseExchangeRate.fdTargetCurrency')}" showStatus="edit" style="width:95%;">
                                dialogSelect(false,'fssc_base_currency_fdCurrency','fdTargetCurrencyId','fdTargetCurrencyName');
                            </xform:dialog>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseExchangeRate.fdRate')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdRate" _xform_type="text">
                            <%-- <input name="fdRate" subject="${lfn:message('fssc-base:fsscBaseExchangeRate.fdRate')}" validate="required number" value="<kmss:showNumber value="${fsscBaseExchangeRateForm.fdRate }" pattern="0.0#####"/>" class="inputsgl" style="width:95%"> --%>
                            <input name="fdRate" subject="${lfn:message('fssc-base:fsscBaseExchangeRate.fdRate')}" validate="required number" value="${fsscBaseExchangeRateForm.fdRateStr}" class="inputsgl" style="width:95%">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseExchangeRate.fdOrder')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdOrder" _xform_type="text">
                            <xform:text property="fdOrder" showStatus="edit" style="width:95%;" />
                        </div>
                    </td>
                </tr>
                <fssc:switchOn property="fdRateEnabled">
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseExchangeRate.fdType')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdType" _xform_type="radio">
                            <xform:radio property="fdType">
                            	<xform:enumsDataSource enumsType="fssc_base_exchange_rate_type"></xform:enumsDataSource>
                            </xform:radio>
                        </div>
                    </td>
                </tr>
                </fssc:switchOn>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseExchangeRate.fdIsAvailable')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdIsAvailable" _xform_type="radio">
                            <xform:radio property="fdIsAvailable" showStatus="edit">
                                <xform:enumsDataSource enumsType="common_yesno" />
                            </xform:radio>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseExchangeRate.docCreator')}
                    </td>
                    <td width="35%">
                        <div id="_xform_docCreatorId" _xform_type="address">
                            <ui:person personId="${fsscBaseExchangeRateForm.docCreatorId}" personName="${fsscBaseExchangeRateForm.docCreatorName}" />
                        </div>
                    </td>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseExchangeRate.docCreateTime')}
                    </td>
                    <td width="35%">
                        <div id="_xform_docCreateTime" _xform_type="datetime">
                            <xform:datetime property="docCreateTime" showStatus="view" style="width:95%;" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseExchangeRate.docAlteror')}
                    </td>
                    <td width="35%">
                        <div id="_xform_docAlterorId" _xform_type="address">
                            <ui:person personId="${fsscBaseExchangeRateForm.docAlterorId}" personName="${fsscBaseExchangeRateForm.docAlterorName}" />
                        </div>
                    </td>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseExchangeRate.docAlterTime')}
                    </td>
                    <td width="35%">
                        <div id="_xform_docAlterTime" _xform_type="datetime">
                            <xform:datetime property="docAlterTime" showStatus="view" style="width:95%;" />
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </center>
    <html:hidden property="fdId" />
    <fssc:switchOff property="fdRateEnabled">
    <html:hidden property="fdType" />
    </fssc:switchOff>
    <html:hidden property="method_GET" />
    <script>
        $KMSSValidation();
    </script>
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp" %>