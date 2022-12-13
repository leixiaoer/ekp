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

    <kmss:auth requestURL="/fssc/base/fssc_base_pay_bank/fsscBasePayBank.do?method=edit&fdId=${param.fdId}">
        <input type="button" value="${lfn:message('button.edit')}" onclick="Com_OpenWindow('fsscBasePayBank.do?method=edit&fdId=${param.fdId}','_self');" order="2" />
    </kmss:auth>
    <kmss:auth requestURL="/fssc/base/fssc_base_pay_bank/fsscBasePayBank.do?method=delete&fdId=${param.fdId}">
        <input type="button" value="${lfn:message('button.delete')}" onclick="if(!confirmDelete())return;Com_OpenWindow('fsscBasePayBank.do?method=delete&fdId=${param.fdId}','_self');" />
    </kmss:auth>
    <input type="button" value="${lfn:message('button.close')}" onclick="Com_CloseWindow();" />
</div>
<p class="txttitle">${ lfn:message('fssc-base:table.fsscBasePayBank') }</p>
<center>

    <div style="width:95%;">
        <table class="tb_normal" width="100%">
            <tr>
                <td class="td_normal_title" width="15%">
                    ${lfn:message('fssc-base:fsscBasePayBank.fdCompany')}
                </td>
                <td colspan="3" width="85.0%">
                    <div id="_xform_fdCompanyId" _xform_type="dialog">
                        <xform:dialog propertyId="fdCompanyId" propertyName="fdCompanyName" showStatus="view" style="width:95%;">
                            dialogSelect(false,'fssc_base_company_fdCompany','fdCompanyId','fdCompanyName');
                        </xform:dialog>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="td_normal_title" width="15%">
                    ${lfn:message('fssc-base:fsscBasePayBank.fdAccountName')}
                </td>
                <td colspan="3" width="85.0%">
                    <div id="_xform_fdAccountName" _xform_type="text">
                        <xform:text property="fdAccountName" showStatus="view" style="width:95%;" />
                    </div>
                </td>
            </tr>
            <tr>
                <td class="td_normal_title" width="15%">
                    ${lfn:message('fssc-base:fsscBasePayBank.fdCode')}
                </td>
                <td colspan="3" width="85.0%">
                    <div id="_xform_fdCode" _xform_type="text">
                        <xform:text property="fdCode" showStatus="view" style="width:95%;" />
                    </div>
                </td>
            <tr>
                <td class="td_normal_title" width="15%">
                    ${lfn:message('fssc-base:fsscBasePayBank.fdBankName')}
                </td>
                <td colspan="3" width="85.0%">
                    <div id="_xform_fdBankName" _xform_type="text">
                        <xform:text property="fdBankName" showStatus="view" style="width:95%;" />
                    </div>
                </td>
            </tr>
            <tr>
                <td class="td_normal_title" width="15%">
                    ${lfn:message('fssc-base:fsscBasePayBank.fdBankNo')}
                </td>
                <td colspan="3" width="85.0%">
                    <div id="_xform_fdBankNo" _xform_type="text">
                        <xform:text property="fdBankNo" showStatus="view" style="width:95%;" />
                    </div>
                </td>
            </tr>
            <tr>
                <td class="td_normal_title" width="15%">
                    ${lfn:message('fssc-base:fsscBasePayBank.fdBankAccount')}
                </td>
                <td colspan="3" width="85.0%">
                    <div id="_xform_fdBankAccount" _xform_type="text">
                        <xform:text property="fdBankAccount" showStatus="view" style="width:95%;" />
                    </div>
                </td>
            </tr>
            <tr>
               	 <td class="td_normal_title" width="15%">
                       ${lfn:message('fssc-base:fsscBasePayBank.fdAccountsCom')}
                   </td>
                   <td colspan="3" width="85.0%">
                       <xform:dialog propertyId="fdAccountsComId" propertyName="fdAccountsComName" showStatus="view" required="true" style="width:95%;">
                         dialogSelect(false,'fssc_base_accounts_com_fdAccount','fdAccountsComId','fdAccountsComName');
                     </xform:dialog>
                   </td>
               </tr>
            <tr>
                <td class="td_normal_title" width="15%">
                    ${lfn:message('fssc-base:fsscBasePayBank.fdUse')}
                </td>
                <td colspan="3" width="85.0%">
                    <div id="_xform_fdUse" _xform_type="textarea">
                        <xform:textarea property="fdUse" showStatus="view" style="width:95%;" />
                    </div>
                </td>
            </tr>
               <fssc:checkUseBank >
                  <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBasePayBank.fdPayBankBelong')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdPayBankBelong"  showStatus="view">
                          <xform:select property="fdPayBankBelong" >
                          			<xform:enumsDataSource enumsType="fs_base_pay_bank_belong" />
                          </xform:select>
                        </div>
                    </td>
                    </tr>
                 </fssc:checkUseBank>
                 <fssc:checkUseBank fdBank="CMB" >
                    <tr>
                     <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBasePayBank.fdAccountAreaName')}
                    </td>
					 <td colspan="3" width="85.0%">
                       	<div id="_xform_fdAccountAreaName" _xform_type="dialog">
                           <xform:dialog propertyId="fdAccountAreaId" propertyName="fdAccountAreaName" required="true" showStatus="view" style="width:95%;" subject="${lfn:message('fssc-cmb:fsscBasePayBank.fdAccountAreaName')}" >
                               dialogSelect(false,'fssc_cmb_account_area','fdAccountAreaId','fdAccountAreaName',null,null,selectFdAccountAreaCallback);
                           </xform:dialog>
                           <input name="fdAccountAreaId" type="hidden"/>
                       	</div>
                  		</td>
                    </tr>
                </fssc:checkUseBank>
            <tr>
                <td class="td_normal_title" width="15%">
                    ${lfn:message('fssc-base:fsscBasePayBank.fdIsAvailable')}
                </td>
                <td colspan="3" width="85.0%">
                    <div id="_xform_fdIsAvailable" _xform_type="radio">
                        <xform:radio property="fdIsAvailable" showStatus="view">
                            <xform:enumsDataSource enumsType="common_yesno" />
                        </xform:radio>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="td_normal_title" width="15%">
                    ${lfn:message('fssc-base:fsscBasePayBank.docCreator')}
                </td>
                <td width="35%">
                    <div id="_xform_docCreatorId" _xform_type="address">
                        <ui:person personId="${fsscBasePayBankForm.docCreatorId}" personName="${fsscBasePayBankForm.docCreatorName}" />
                    </div>
                </td>
                <td class="td_normal_title" width="15%">
                    ${lfn:message('fssc-base:fsscBasePayBank.docCreateTime')}
                </td>
                <td width="35%">
                    <div id="_xform_docCreateTime" _xform_type="datetime">
                        <xform:datetime property="docCreateTime" showStatus="view" style="width:95%;" />
                    </div>
                </td>
            </tr>
            <tr>
                <td class="td_normal_title" width="15%">
                    ${lfn:message('fssc-base:fsscBasePayBank.docAlteror')}
                </td>
                <td width="35%">
                    <div id="_xform_docAlterorId" _xform_type="address">
                        <ui:person personId="${fsscBasePayBankForm.docAlterorId}" personName="${fsscBasePayBankForm.docAlterorName}" />
                    </div>
                </td>
                <td class="td_normal_title" width="15%">
                    ${lfn:message('fssc-base:fsscBasePayBank.docAlterTime')}
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
        basePath: '/fssc/base/fssc_base_pay_bank/fsscBasePayBank.do',
        customOpts: {

            ____fork__: 0
        }
    };
    Com_IncludeFile("security.js");
    Com_IncludeFile("domain.js");
</script>
<%@ include file="/resource/jsp/view_down.jsp" %>