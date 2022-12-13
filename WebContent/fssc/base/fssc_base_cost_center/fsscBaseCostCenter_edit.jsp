<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@ include file="/resource/jsp/edit_top.jsp" %>
<%@ include file="/fssc/base/resource/jsp/jshead.jsp" %>
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
	"fsscBaseCostCenter.fdType":"${lfn:message('fssc-base:fsscBaseCostCenter.fdType')}",
	"fsscBaseCostCenter.fdSystemParam.U8":"${lfn:message('fssc-base:fsscBaseCostCenter.fdSystemParam.U8')}",
	"fsscBaseCostCenter.fdSystemParam.K3":"${lfn:message('fssc-base:fsscBaseCostCenter.fdSystemParam.K3')}"
    };
    Com_IncludeFile("security.js");
    Com_IncludeFile("domain.js");
    Com_IncludeFile("form.js");
    Com_IncludeFile("common.js|data.js");
    Com_IncludeFile("config_edit.js", "${LUI_ContextPath}/fssc/base/resource/js/", 'js', true);
    Com_IncludeFile("form_option.js", "${LUI_ContextPath}/fssc/base/fssc_base_cost_center/", 'js', true);
    Com_IncludeFile("fsscCostCenter.js", "${LUI_ContextPath}/fssc/base/fssc_base_cost_center/", 'js', true);
</script>

    <% pageContext.setAttribute("currentUser", UserUtil.getKMSSUser()); %>

<html:form action="/fssc/base/fssc_base_cost_center/fsscBaseCostCenter.do">
    <div id="optBarDiv">
        <c:choose>
            <c:when test="${fsscBaseCostCenterForm.method_GET=='edit'}">
                <input type="button" value="${ lfn:message('button.update') }" onclick="Com_Submit(document.fsscBaseCostCenterForm, 'update');">
            </c:when>
            <c:when test="${fsscBaseCostCenterForm.method_GET=='add'}">
                <input type="button" value="${ lfn:message('button.save') }" onclick="Com_Submit(document.fsscBaseCostCenterForm, 'save');">
                <input type="button" value="${ lfn:message('button.saveadd') }" onclick="Com_Submit(document.fsscBaseCostCenterForm, 'saveadd');">
            </c:when>
        </c:choose>
        <input type="button" value="${ lfn:message('button.close') }" onclick="Com_CloseWindow();">
    </div>
    <p class="txttitle">${ lfn:message('fssc-base:table.fsscBaseCostCenter') }</p>
    <center>

        <div style="width:95%;">
            <table class="tb_normal" width="100%">
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseCostCenter.fdCompany')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdCompanyId" _xform_type="dialog">
                        	<xform:text property="fdCompanyId" showStatus="noShow"></xform:text>
                            <fssc:switchOff property="fdShowType">
	                            <xform:dialog propertyId="fdCompanyId" propertyName="fdCompanyName" showStatus="view" style="width:95%;">
	                                dialogSelect(false,'fssc_base_company_fdCompany','fdCompanyId','fdCompanyName');
	                            </xform:dialog>
                            </fssc:switchOff>
                        	<fssc:switchOn property="fdShowType">
	                            <xform:dialog propertyId="fdCompanyId" propertyName="fdCompanyName" subject="${lfn:message('fssc-base:fsscBaseCostCenter.fdCompany')}" showStatus="edit" required="true" style="width:95%;">
	                                dialogSelect(false,'fssc_base_company_fdCompany','fdCompanyId','fdCompanyName',afterSelect);
	                            </xform:dialog>
                            </fssc:switchOn>
                        </div>
                        </a>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseCostCenter.fdParent')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdParentId" _xform_type="dialog">
                            <xform:dialog propertyId="fdParentId" propertyName="fdParentName" subject="${lfn:message('fssc-base:fsscBaseCostCenter.fdParent')}"  showStatus="edit" style="width:95%;">
                                dialogSelect(false,'fssc_base_cost_center_fdParent','fdParentId','fdParentName');
                            </xform:dialog>
                        </div>
                        </a>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseCostCenter.fdName')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdName" _xform_type="text">
                            <xform:text property="fdName" showStatus="edit" style="width:95%;" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseCostCenter.fdCode')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdCode" _xform_type="text">
                            <c:if test="${empty fsscBaseCostCenterForm.fdCode}">
                        		<xform:text property="fdCode" showStatus="edit" required="true" style="width:95%;" />
                        	</c:if>
                        	<c:if test="${not empty fsscBaseCostCenterForm.fdCode}">
                        		<xform:text property="fdCode" showStatus="view" style="width:95%;" />
                        	</c:if>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseCostCenter.fdIsGroup')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdIsGroup" _xform_type="radio">
                            <xform:radio property="fdIsGroup" showStatus="edit" required="true">
                                <xform:enumsDataSource enumsType="fssc_base_cost_type" />
                            </xform:radio>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseCostCenter.fdEkpOrg')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdEkpOrgIds" _xform_type="address">
                            <xform:address propertyId="fdEkpOrgIds" propertyName="fdEkpOrgNames" mulSelect="true" orgType="ORG_TYPE_ALLORG" showStatus="edit" textarea="true" style="width:95%;" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseCostCenter.fdFirstCharger')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdFirstChargerIds" _xform_type="address">
                            <xform:address propertyId="fdFirstChargerIds" propertyName="fdFirstChargerNames" mulSelect="true" orgType="ORG_TYPE_ALLORG" showStatus="edit" style="width:95%;" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseCostCenter.fdSecondCharger')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdSecondChargerIds" _xform_type="address">
                            <xform:address propertyId="fdSecondChargerIds" propertyName="fdSecondChargerNames" mulSelect="true" orgType="ORG_TYPE_ALLORG" showStatus="edit" style="width:95%;" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseCostCenter.fdManager')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdManagerIds" _xform_type="address">
                            <xform:address propertyId="fdManagerIds" propertyName="fdManagerNames" mulSelect="true" orgType="ORG_TYPE_ALLORG" showStatus="edit" style="width:95%;" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseCostCenter.fdBudgetManager')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdBudgetManagerIds" _xform_type="address">
                            <xform:address propertyId="fdBudgetManagerIds" propertyName="fdBudgetManagerNames" mulSelect="true" orgType="ORG_TYPE_ALL" showStatus="edit" style="width:95%;" />
                        </div>
                    </td>
                </tr>
                <%-- <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseCostCenter.fdType')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdTypeId" _xform_type="dialog">
                        	<xform:radio property="fdTypeId" required="true" value="${fsscBaseCostTypeForm.fdTypeId}">
                        		<xform:beanDataSource serviceBean="fsscBaseCostTypeService" selectBlock="fdId,fdName" whereBlock="fsscBaseCostType.fdIsAvailable=true and fsscBaseCostType.fdCompany.fdId='${HtmlParam.fdCompanyId}'"></xform:beanDataSource>
                        	</xform:radio>
                        </div>
                    </td>
                </tr> --%>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseCostCenter.fdIsAvailable')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdIsAvailable" _xform_type="radio">
                            <xform:radio property="fdIsAvailable" showStatus="edit">
                                <xform:enumsDataSource enumsType="common_yesno" />
                            </xform:radio>
                        </div>
                    </td>
                </tr>
                <fssc:switchOn property="fdCostcenterToAccount">
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseCostCenter.fdJoinSystem')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdJoinSystem" _xform_type="text">
                            <xform:radio property="fdJoinSystem" value="${fsscBaseCostCenterForm.fdJoinSystem}" onValueChange="changeSystem">
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
                </fssc:switchOn>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseCostCenter.docCreator')}
                    </td>
                    <td width="35%">
                        <div id="_xform_docCreatorId" _xform_type="address">
                            <ui:person personId="${fsscBaseCostCenterForm.docCreatorId}" personName="${fsscBaseCostCenterForm.docCreatorName}" />
                        </div>
                    </td>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseCostCenter.docCreateTime')}
                    </td>
                    <td width="35%">
                        <div id="_xform_docCreateTime" _xform_type="datetime">
                            <xform:datetime property="docCreateTime" showStatus="view" style="width:95%;" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseCostCenter.docAlteror')}
                    </td>
                    <td width="35%">
                        <div id="_xform_docAlterorId" _xform_type="address">
                            <ui:person personId="${fsscBaseCostCenterForm.docAlterorId}" personName="${fsscBaseCostCenterForm.docAlterorName}" />
                        </div>
                    </td>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseCostCenter.docAlterTime')}
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
    <html:hidden property="fdType" value="${fsscBaseCostCenterForm.fdTypeId}" />
    <html:hidden property="method_GET" />
    <script>
        $KMSSValidation();
    </script>
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp" %>