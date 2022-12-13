<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@ include file="/resource/jsp/view_top.jsp" %>
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
<div id="optBarDiv">

    <kmss:auth requestURL="/fssc/base/fssc_base_company/fsscBaseCompany.do?method=edit&fdId=${param.fdId}">
        <input type="button" value="${lfn:message('button.edit')}" onclick="Com_OpenWindow('fsscBaseCompany.do?method=edit&fdId=${param.fdId}','_self');" order="2" />
    </kmss:auth>
    <kmss:auth requestURL="/fssc/base/fssc_base_company/fsscBaseCompany.do?method=delete&fdId=${param.fdId}">
        <input type="button" value="${lfn:message('button.delete')}" onclick="if(!confirmDelete())return;Com_OpenWindow('fsscBaseCompany.do?method=delete&fdId=${param.fdId}','_self');" />
    </kmss:auth>
    <input type="button" value="${lfn:message('button.close')}" onclick="Com_CloseWindow();" />
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
                        <xform:dialog propertyId="fdGroupId" propertyName="fdGroupName" showStatus="view" style="width:95%;">
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
                        <xform:text property="fdName" showStatus="view" style="width:95%;" />
                    </div>
                </td>
            </tr>
            <tr>
                <td class="td_normal_title" width="15%">
                    ${lfn:message('fssc-base:fsscBaseCompany.fdCode')}
                </td>
                <td colspan="3" width="85.0%">
                    <div id="_xform_fdCode" _xform_type="text">
                        <xform:text property="fdCode" showStatus="view" style="width:95%;" />
                    </div>
                </td>
            </tr>
            <tr>
                <td class="td_normal_title" width="15%">
                    ${lfn:message('fssc-base:fsscBaseCompany.fdAccountCurrency')}
                </td>
                <td colspan="3" width="85.0%">
                    <div id="_xform_fdAccountCurrencyId" _xform_type="dialog">
                        <xform:dialog propertyId="fdAccountCurrencyId" propertyName="fdAccountCurrencyName" showStatus="view" style="width:95%;">
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
                        <xform:dialog propertyId="fdBudgetCurrencyId" propertyName="fdBudgetCurrencyName" showStatus="view" style="width:95%;">
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
                        <xform:text property="fdDutyParagraph" showStatus="view" style="width:95%;" />
                    </div>
                </td>
            </tr>
            <tr>
                <td class="td_normal_title" width="15%">
                    ${lfn:message('fssc-base:fsscBaseCompany.fdEkpOrg')}
                </td>
                <td colspan="3" width="85.0%">
                    <div id="_xform_fdEkpOrgIds" _xform_type="address">
                        <xform:address propertyId="fdEkpOrgIds" propertyName="fdEkpOrgNames" mulSelect="true" orgType="ORG_TYPE_ALLORG" showStatus="view" textarea="true" style="width:95%;" />
                    </div>
                </td>
            </tr>
            <tr>
                <td class="td_normal_title" width="15%">
                    ${lfn:message('fssc-base:fsscBaseCompany.fdFinancialStaff')}
                </td>
                <td colspan="3" width="85.0%">
                    <div id="_xform_fdFinancialStaffIds" _xform_type="address">
                        <xform:address propertyId="fdFinancialStaffIds" propertyName="fdFinancialStaffNames" mulSelect="true" orgType="ORG_TYPE_ALLORG" showStatus="view" textarea="true" style="width:95%;" />
                    </div>
                </td>
            </tr>
            <tr>
                <td class="td_normal_title" width="15%">
                    ${lfn:message('fssc-base:fsscBaseCompany.fdFinancialManager')}
                </td>
                <td colspan="3" width="85.0%">
                    <div id="_xform_fdFinancialManagerIds" _xform_type="address">
                        <xform:address propertyId="fdFinancialManagerIds" propertyName="fdFinancialManagerNames" mulSelect="true" orgType="ORG_TYPE_ALLORG" showStatus="view" textarea="true" style="width:95%;" />
                    </div>
                </td>
            </tr>
            <tr>
                <td class="td_normal_title" width="15%">
                    ${lfn:message('fssc-base:fsscBaseCompany.fdType')}
                </td>
                <td colspan="3" width="85.0%">
                	<sunbor:enumsShow enumsType="fssc_base_company_type" value="${fsscBaseCompanyForm.fdType }"></sunbor:enumsShow>
                </td>
            </tr>
            <tr>
                <td class="td_normal_title" width="15%">
                    ${lfn:message('fssc-base:fsscBaseCompany.fdIsAvailable')}
                </td>
                <td colspan="3" width="85.0%">
                	<sunbor:enumsShow enumsType="common_yesno" value="${fsscBaseCompanyForm.fdIsAvailable }"></sunbor:enumsShow>
                </td>
            </tr>
            <c:if test="${not empty  fsscBaseCompanyForm.fdJoinSystem}">
            <tr>
                <td class="td_normal_title" width="15%">
                    ${lfn:message('fssc-base:fsscBaseCompany.fdJoinSystem')}
                </td>
                <td colspan="3" width="85.0%">
                    <div id="_xform_fdJoinSystem" _xform_type="text">
                        <xform:text property="fdJoinSystem" showStatus="view" style="width:95%;" />
                    </div>
                </td>
            </tr>
            </c:if>
            <c:if test="${not empty  fsscBaseCompanyForm.fdSystemParam}">
            <tr id="systemParam">
                <td class="td_normal_title" width="15%" id="systemTitle">
                
                </td>
                <td colspan="3" width="85.0%">
                    <div id="_xform_fdJoinSystem" _xform_type="text">
                        <xform:text property="fdSystemParam" style="width:95%;"></xform:text>
                    </div>
                </td>
            </tr>
            </c:if>
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
<script>
	$(document).ready(function(){
		var fdJoinSystem="${fsscBaseCompanyForm.fdJoinSystem}";
		if(fdJoinSystem=='U8'){
			$("#systemTitle").html("${lfn:message('fssc-base:fsscBaseCompany.fdSystemParam.U8')}");
		}else if(fdJoinSystem=='K3'){
			$("#systemTitle").html("${lfn:message('fssc-base:fsscBaseCompany.fdSystemParam.K3')}");
		}
	});
    var formInitData = {

    };

    function confirmDelete(msg) {
        return confirm('${ lfn:message("page.comfirmDelete") }');
    }

    function openWindowViaDynamicForm(popurl, params, target) {
        var form = document.createElement('form');
        if(form) {
            try {
                target = !target ? '_blank' : target;
                form.style = "display:none;";
                form.method = 'post';
                form.action = popurl;
                form.target = target;
                if(params) {
                    for(var key in params) {
                        var
                        v = params[key];
                        var vt = typeof
                        v;
                        var hdn = document.createElement('input');
                        hdn.type = 'hidden';
                        hdn.name = key;
                        if(vt == 'string' || vt == 'boolean' || vt == 'number') {
                            hdn.value =
                            v +'';
                        } else {
                            if($.isArray(
                                v)) {
                                hdn.value =
                                v.join(';');
                            } else {
                                hdn.value = toString(
                                    v);
                            }
                        }
                        form.appendChild(hdn);
                    }
                }
                document.body.appendChild(form);
                form.submit();
            } finally {
                document.body.removeChild(form);
            }
        }
    }

    function doCustomOpt(fdId, optCode) {
        if(!fdId || !optCode) {
            return;
        }

        if(viewOption.customOpts && viewOption.customOpts[optCode]) {
            var param = {
                "List_Selected_Count": 1
            };
            var argsObject = viewOption.customOpts[optCode];
            if(argsObject.popup == 'true') {
                var popurl = viewOption.contextPath + argsObject.popupUrl + '&fdId=' + fdId;
                for(var arg in argsObject) {
                    param[arg] = argsObject[arg];
                }
                openWindowViaDynamicForm(popurl, param, '_self');
                return;
            }
            var optAction = viewOption.contextPath + viewOption.basePath + '?method=' + optCode + '&fdId=' + fdId;
            Com_OpenWindow(optAction, '_self');
        }
    }
    window.doCustomOpt = doCustomOpt;
    var viewOption = {
        contextPath: '${LUI_ContextPath}',
        basePath: '/fssc/base/fssc_base_company/fsscBaseCompany.do',
        customOpts: {

            ____fork__: 0
        }
    };
    Com_IncludeFile("security.js");
    Com_IncludeFile("domain.js");
</script>
<%@ include file="/resource/jsp/view_down.jsp" %>