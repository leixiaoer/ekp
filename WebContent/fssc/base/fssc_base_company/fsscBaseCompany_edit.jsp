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
    		"fsscBaseCompany.fdSystemParam.U8":"${lfn:message('fssc-base:fsscBaseCompany.fdSystemParam.U8')}",
    		"fsscBaseCompany.fdSystemParam.K3":"${lfn:message('fssc-base:fsscBaseCompany.fdSystemParam.K3')}"
    };
    Com_IncludeFile("security.js");
    Com_IncludeFile("domain.js");
    Com_IncludeFile("form.js");
    Com_IncludeFile("config_edit.js", "${LUI_ContextPath}/fssc/base/resource/js/", 'js', true);
    Com_IncludeFile("form_option.js", "${LUI_ContextPath}/fssc/base/fssc_base_company/", 'js', true);
    Com_IncludeFile("fsscCompany.js", "${LUI_ContextPath}/fssc/base/fssc_base_company/", 'js', true);
</script>

    <% pageContext.setAttribute("currentUser", UserUtil.getKMSSUser()); %>

<html:form action="/fssc/base/fssc_base_company/fsscBaseCompany.do">
    <div id="optBarDiv">
        <c:choose>
            <c:when test="${fsscBaseCompanyForm.method_GET=='edit'}">
                <input type="button" value="${ lfn:message('button.update') }" onclick="Com_Submit(document.fsscBaseCompanyForm, 'update');">
            </c:when>
            <c:when test="${fsscBaseCompanyForm.method_GET=='add'}">
                <input type="button" value="${ lfn:message('button.save') }" onclick="Com_Submit(document.fsscBaseCompanyForm, 'save');">
                <input type="button" value="${ lfn:message('button.saveadd') }" onclick="Com_Submit(document.fsscBaseCompanyForm, 'saveadd');">
            </c:when>
        </c:choose>
        <input type="button" value="${ lfn:message('button.close') }" onclick="Com_CloseWindow();">
    </div>
    <p class="txttitle">${ lfn:message('fssc-base:table.fsscBaseCompany') }</p>
    <center>

        <div style="width:95%;">
            <table class="tb_normal" width="100%">
            	<fssc:switchOn property="fdCompanyGroup">
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseCompany.fdGroup')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdGroupId" _xform_type="dialog">
                            <xform:dialog propertyId="fdGroupId" propertyName="fdGroupName" required="true" subject="${lfn:message('fssc-base:fsscBaseCompany.fdGroup')}" showStatus="edit" style="width:95%;">
                                dialogSelect(false,'fssc_base_company_group_fdGroup','fdGroupId','fdGroupName');
                            </xform:dialog>
                        </div>
                    </td>
                </tr>
                </fssc:switchOn>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseCompany.fdName')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdName" _xform_type="text">
                            <xform:text property="fdName" showStatus="edit" style="width:95%;" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseCompany.fdCode')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdCode" _xform_type="text">
                            <c:if test="${empty fsscBaseCompanyForm.fdCode}">
                        		<xform:text property="fdCode" showStatus="edit" required="true" style="width:95%;" />
                        	</c:if>
                        	<c:if test="${not empty fsscBaseCompanyForm.fdCode}">
                        		<xform:text property="fdCode" showStatus="view" style="width:95%;" />
                        	</c:if>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseCompany.fdAccountCurrency')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdAccountCurrencyId" _xform_type="dialog">
                            <xform:dialog propertyId="fdAccountCurrencyId" propertyName="fdAccountCurrencyName" showStatus="edit" required="true" subject="${lfn:message('fssc-base:fsscBaseCompany.fdAccountCurrency')}" style="width:95%;">
                                dialogSelect(false,'fssc_base_currency_fdCurrency','fdAccountCurrencyId','fdAccountCurrencyName');
                            </xform:dialog>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseCompany.fdBudgetCurrency')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdBudgetCurrencyId" _xform_type="dialog">
                            <xform:dialog propertyId="fdBudgetCurrencyId" propertyName="fdBudgetCurrencyName" showStatus="edit" required="true" subject="${lfn:message('fssc-base:fsscBaseCompany.fdBudgetCurrency')}" style="width:95%;">
                                dialogSelect(false,'fssc_base_currency_fdCurrency','fdBudgetCurrencyId','fdBudgetCurrencyName');
                            </xform:dialog>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseCompany.fdDutyParagraph')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdDutyParagraph" _xform_type="dialog">
                            <xform:text property="fdDutyParagraph" showStatus="edit" style="width:95%;" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseCompany.fdEkpOrg')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdEkpOrgIds" _xform_type="address">
                            <xform:address propertyId="fdEkpOrgIds" propertyName="fdEkpOrgNames" mulSelect="true" orgType="ORG_TYPE_ALLORG" showStatus="edit" required="true" subject="${lfn:message('fssc-base:fsscBaseCompany.fdEkpOrg')}" textarea="true" style="width:95%;" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseCompany.fdFinancialStaff')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdFinancialStaffIds" _xform_type="address">
                            <xform:address propertyId="fdFinancialStaffIds" propertyName="fdFinancialStaffNames" mulSelect="true" orgType="ORG_TYPE_ALLORG" showStatus="edit" required="true" subject="${lfn:message('fssc-base:fsscBaseCompany.fdFinancialStaff')}" textarea="true" style="width:95%;"
                            />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseCompany.fdFinancialManager')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdFinancialManagerIds" _xform_type="address">
                            <xform:address propertyId="fdFinancialManagerIds" propertyName="fdFinancialManagerNames" mulSelect="true" orgType="ORG_TYPE_ALLORG" showStatus="edit" required="true" subject="${lfn:message('fssc-base:fsscBaseCompany.fdFinancialManager')}" textarea="true"
                            style="width:95%;" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseCompany.fdType')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdType" _xform_type="radio">
                            <xform:radio property="fdType" showStatus="edit">
                                <xform:enumsDataSource enumsType="fssc_base_company_type" />
                            </xform:radio>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseCompany.fdIsAvailable')}
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
                        ${lfn:message('fssc-base:fsscBaseCompany.fdJoinSystem')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdJoinSystem" _xform_type="text">
                            <xform:radio property="fdJoinSystem" value="${fsscBaseCompanyForm.fdJoinSystem}" onValueChange="changeSystem">
                            	<c:forEach items="${financialSystemList}" var="system">
                            		<xform:simpleDataSource value="${system}"></xform:simpleDataSource>
                            	</c:forEach>
                            </xform:radio>
                        </div>
                    </td>
                </tr>
                <tr style="display:none;" id="systemParam">
                    <td class="td_normal_title" width="15%" id="systemTitle">
                        
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdJoinSystem" _xform_type="text">
                            <xform:text property="fdSystemParam" style="width:95%;"></xform:text>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseCompany.docCreator')}
                    </td>
                    <td width="35%">
                        <div id="_xform_docCreatorId" _xform_type="address">
                            <ui:person personId="${fsscBaseCompanyForm.docCreatorId}" personName="${fsscBaseCompanyForm.docCreatorName}" />
                        </div>
                    </td>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseCompany.docCreateTime')}
                    </td>
                    <td width="35%">
                        <div id="_xform_docCreateTime" _xform_type="datetime">
                            <xform:datetime property="docCreateTime" showStatus="view" style="width:95%;" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseCompany.docAlteror')}
                    </td>
                    <td width="35%">
                        <div id="_xform_docAlterorId" _xform_type="address">
                            <ui:person personId="${fsscBaseCompanyForm.docAlterorId}" personName="${fsscBaseCompanyForm.docAlterorName}" />
                        </div>
                    </td>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseCompany.docAlterTime')}
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
    <html:hidden property="method_GET" />
    <script>
        $KMSSValidation();
    </script>
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp" %>