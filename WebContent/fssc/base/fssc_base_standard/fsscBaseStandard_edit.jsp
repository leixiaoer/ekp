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
    Com_IncludeFile("form_option.js", "${LUI_ContextPath}/fssc/base/fssc_base_standard/", 'js', true);
</script>

    <% pageContext.setAttribute("currentUser", UserUtil.getKMSSUser()); %>

<html:form action="/fssc/base/fssc_base_standard/fsscBaseStandard.do">
    <div id="optBarDiv">
        <c:choose>
            <c:when test="${fsscBaseStandardForm.method_GET=='edit'}">
                <input type="button" value="${ lfn:message('button.update') }" onclick="Com_Submit(document.fsscBaseStandardForm, 'update');">
            </c:when>
            <c:when test="${fsscBaseStandardForm.method_GET=='add'}">
                <input type="button" value="${ lfn:message('button.save') }" onclick="Com_Submit(document.fsscBaseStandardForm, 'save');">
                <input type="button" value="${ lfn:message('button.saveadd') }" onclick="Com_Submit(document.fsscBaseStandardForm, 'saveadd');">
            </c:when>
        </c:choose>
        <input type="button" value="${ lfn:message('button.close') }" onclick="Com_CloseWindow();">
    </div>
    <p class="txttitle">${ lfn:message('fssc-base:table.fsscBaseStandard') }</p>
    <center>

        <div style="width:95%;">
            <table class="tb_normal" width="100%">
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseStandard.fdCompany')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdCompanyId" _xform_type="dialog">
                            <fssc:switchOff property="fdShowType">
	                            <xform:dialog propertyId="fdCompanyId" propertyName="fdCompanyName" showStatus="view" style="width:95%;">
	                                dialogSelect(false,'fssc_base_company_fdCompany','fdCompanyId','fdCompanyName');
	                            </xform:dialog>
	                            <html:hidden property="fdCompanyId"/>
                            </fssc:switchOff>
                        	<fssc:switchOn property="fdShowType">
	                            <xform:dialog propertyId="fdCompanyId" propertyName="fdCompanyName" subject="${lfn:message('fssc-base:fsscBaseStandard.fdCompany')}" showStatus="edit" required="true" style="width:95%;">
	                                dialogSelect(false,'fssc_base_company_fdCompany','fdCompanyId','fdCompanyName',changeCompany);
	                            </xform:dialog>
                            </fssc:switchOn>
                        </div>
                        </a>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseStandard.fdItem')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdItemId" _xform_type="dialog">
                            <xform:dialog propertyId="fdItemId" propertyName="fdItemName" subject="${lfn:message('fssc-base:fsscBaseStandard.fdItem')}" showStatus="edit" required="true" style="width:95%;">
                                dialogSelect(false,'fssc_base_expense_item_fdParent','fdItemId','fdItemName');
                            </xform:dialog>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseStandard.fdPerson')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdLevelId" _xform_type="dialog">
                            <xform:address propertyName="fdPersonName" propertyId="fdPersonId" orgType="ORG_TYPE_PERSON" style="width:95%;"></xform:address>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseStandard.fdLevel')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdLevelId" _xform_type="dialog">
                            <xform:dialog propertyId="fdLevelId" propertyName="fdLevelName" subject="${lfn:message('fssc-base:fsscBaseStandard.fdLevel')}"  showStatus="edit" style="width:95%;">
                                dialogSelect(false,'fssc_base_level_fdLevel','fdLevelId','fdLevelName');
                            </xform:dialog>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseStandard.fdArea')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdAreaId" _xform_type="dialog">
                            <xform:dialog propertyId="fdAreaId" propertyName="fdAreaName" subject="${lfn:message('fssc-base:fsscBaseStandard.fdArea')}" showStatus="edit" style="width:95%;">
                                dialogSelect(false,'fssc_base_area_fdArea','fdAreaId','fdAreaName');
                            </xform:dialog>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseStandard.fdVehicle')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdVehicleId" _xform_type="dialog">
                            <xform:dialog propertyId="fdVehicleId" propertyName="fdVehicleName" subject="${lfn:message('fssc-base:fsscBaseStandard.fdVehicle')}" showStatus="edit" style="width:95%;">
                                dialogSelect(false,'fssc_base_vehicle_fdVehicle','fdVehicleId','fdVehicleName',afterVehicleSelected);
                            </xform:dialog>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseStandard.fdBerth')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdBerthId" _xform_type="dialog">
                            <xform:dialog propertyId="fdBerthId" propertyName="fdBerthName" subject="${lfn:message('fssc-base:fsscBaseStandard.fdBerth')}" showStatus="edit" style="width:95%;">
                                FSSC_SelectBerth();
                            </xform:dialog>
                        </div>
                    </td>
                </tr>
                <%-- <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseStandard.fdSpecialItem')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdBerthId" _xform_type="dialog">
                            <xform:dialog propertyId="fdSpecialItemId" propertyName="fdSpecialItemName" showStatus="edit" style="width:95%;">
                                dialogSelect(false,'fssc_base_special_item','fdSpecialItemId','fdSpecialItemName');
                            </xform:dialog>
                        </div>
                    </td>
                </tr> --%>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseStandard.fdMoney')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdMoney" _xform_type="text">
                            <xform:text property="fdMoney" showStatus="edit" style="width:95%;" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseStandard.fdCurrency')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdCurrencyId" _xform_type="dialog">
                            <xform:dialog propertyId="fdCurrencyId" propertyName="fdCurrencyName" subject="${lfn:message('fssc-base:fsscBaseStandard.fdCurrency')}" showStatus="edit" required="true" style="width:95%;">
                                dialogSelect(false,'fssc_base_currency_fdCurrency','fdCurrencyId','fdCurrencyName');
                            </xform:dialog>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseStandard.fdOrder')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdOrder" _xform_type="text">
                            <xform:text property="fdOrder" showStatus="edit" style="width:95%;" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseStandard.fdIsAvailable')}
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
                        ${lfn:message('fssc-base:fsscBaseStandard.docCreator')}
                    </td>
                    <td width="35%">
                        <div id="_xform_docCreatorId" _xform_type="address">
                            <ui:person personId="${fsscBaseStandardForm.docCreatorId}" personName="${fsscBaseStandardForm.docCreatorName}" />
                        </div>
                    </td>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseStandard.docCreateTime')}
                    </td>
                    <td width="35%">
                        <div id="_xform_docCreateTime" _xform_type="datetime">
                            <xform:datetime property="docCreateTime" showStatus="view" style="width:95%;" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseStandard.docAlteror')}
                    </td>
                    <td width="35%">
                        <div id="_xform_docAlterorId" _xform_type="address">
                            <ui:person personId="${fsscBaseStandardForm.docAlterorId}" personName="${fsscBaseStandardForm.docAlterorName}" />
                        </div>
                    </td>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseStandard.docAlterTime')}
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
        function FSSC_SelectBerth(){
        	var fdVehicleId = $("[name=fdVehicleId]").val();
        	if(!fdVehicleId){
        		seajs.use(['lui/dialog'],function(dialog){
        			dialog.alert("${lfn:message('fssc-base:message.standard.pleaseSelectVehicle')}");
        		});
        		return false;
        	}
        	dialogSelect(false,'fssc_base_berth_fdBerth','fdBerthId','fdBerthName',null,{"fdVehicleId":$("[name=fdVehicleId]").val()});
        }
        function afterVehicleSelected(){
        	$("[name=fdBerthId],[name=fdBerthName]").val("");
        }
        function changeCompany(){
        	$("[name=fdAreaId],[name=fdAreaName],[name=fdItemId],[name=fdItemName],[name=fdBerthId],[name=fdBerthName]").val("");
        	$("[name=fdLevelId],[name=fdLevelName],[name=fdVehicleId],[name=fdVehicleName]").val("");
        }
    </script>
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp" %>