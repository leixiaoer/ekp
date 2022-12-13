<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@ include file="/resource/jsp/view_top.jsp" %>
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

    <kmss:auth requestURL="/fssc/base/fssc_base_pay_way/fsscBasePayWay.do?method=edit&fdId=${param.fdId}">
        <input type="button" value="${lfn:message('button.edit')}" onclick="Com_OpenWindow('fsscBasePayWay.do?method=edit&fdId=${param.fdId}','_self');" order="2" />
    </kmss:auth>
    <kmss:auth requestURL="/fssc/base/fssc_base_pay_way/fsscBasePayWay.do?method=delete&fdId=${param.fdId}">
        <input type="button" value="${lfn:message('button.delete')}" onclick="if(!confirmDelete())return;Com_OpenWindow('fsscBasePayWay.do?method=delete&fdId=${param.fdId}','_self');" />
    </kmss:auth>
    <input type="button" value="${lfn:message('button.close')}" onclick="Com_CloseWindow();" />
</div>
<p class="txttitle">${ lfn:message('fssc-base:table.fsscBasePayWay') }</p>
<center>

    <div style="width:95%;">
        <table class="tb_normal" width="100%">
            <tr>
                <td class="td_normal_title" width="15%">
                    ${lfn:message('fssc-base:fsscBasePayWay.fdCompany')}
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
                    ${lfn:message('fssc-base:fsscBasePayWay.fdName')}
                </td>
                <td colspan="3" width="85.0%">
                    <div id="_xform_fdName" _xform_type="text">
                        <xform:text property="fdName" showStatus="view" style="width:95%;" />
                    </div>
                </td>
            </tr>
            <tr>
                <td class="td_normal_title" width="15%">
                    ${lfn:message('fssc-base:fsscBasePayWay.fdIsDefault')}
                </td>
                <td colspan="3" width="85.0%">
                    <div id="_xform_fdIsAvailable" _xform_type="radio">
                        <xform:radio property="fdIsDefault">
                            <xform:enumsDataSource enumsType="common_yesno" />
                        </xform:radio>
                    </div>
                </td>
            </tr>
            <%--是否涉及转账--%>
            <tr>
                <td class="td_normal_title" width="15%">
                    ${lfn:message('fssc-base:fsscBasePayWay.fdIsTransfer')}
                </td>
                <td colspan="3" width="85.0%">
                    <div id="_xform_fdIsTransfer" _xform_type="radio">
                        <xform:radio property="fdIsTransfer">
                            <xform:enumsDataSource enumsType="common_yesno" />
                        </xform:radio>
                        &nbsp;&nbsp;&nbsp;<span class="com_help">${lfn:message('fssc-base:fssc.base.payWay.fdIstransfer.tips')} </span>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="td_normal_title" width="15%">
                    ${lfn:message('fssc-base:fsscBasePayWay.fdAccount')}
                </td>
                <td colspan="3" width="85.0%">
                    <div id="_xform_fdAccountId" _xform_type="dialog">
                        <xform:dialog propertyId="fdAccountId" propertyName="fdAccountName" showStatus="view" style="width:95%;">
                            dialogSelect(false,'fssc_base_accounts_com_fdAccount','fdAccountId','fdAccountName');
                        </xform:dialog>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="td_normal_title" width="15%">
                    ${lfn:message('fssc-base:fsscBasePayWay.fdDefaultPayBank')}
                </td>
                <td colspan="3" width="85.0%">
                    ${fsscBasePayWayForm.fdDefaultPayBankName }${fsscBasePayWayForm.fdDefaultPayBankAccount }
                </td>
            </tr>
            <tr>
                <td class="td_normal_title" width="15%">
                    ${lfn:message('fssc-base:fsscBasePayWay.fdOrder')}
                </td>
                <td colspan="3" width="85.0%">
                    <div id="_xform_fdOrder" _xform_type="text">
                        <xform:text property="fdOrder" showStatus="view" style="width:95%;" />
                    </div>
                </td>
            </tr>
            <tr>
                <td class="td_normal_title" width="15%">
                    ${lfn:message('fssc-base:fsscBasePayWay.fdIsAvailable')}
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
                    ${lfn:message('fssc-base:fsscBasePayWay.docCreator')}
                </td>
                <td width="35%">
                    <div id="_xform_docCreatorId" _xform_type="address">
                        <ui:person personId="${fsscBasePayWayForm.docCreatorId}" personName="${fsscBasePayWayForm.docCreatorName}" />
                    </div>
                </td>
                <td class="td_normal_title" width="15%">
                    ${lfn:message('fssc-base:fsscBasePayWay.docCreateTime')}
                </td>
                <td width="35%">
                    <div id="_xform_docCreateTime" _xform_type="datetime">
                        <xform:datetime property="docCreateTime" showStatus="view" style="width:95%;" />
                    </div>
                </td>
            </tr>
            <tr>
                <td class="td_normal_title" width="15%">
                    ${lfn:message('fssc-base:fsscBasePayWay.docAlteror')}
                </td>
                <td width="35%">
                    <div id="_xform_docAlterorId" _xform_type="address">
                        <ui:person personId="${fsscBasePayWayForm.docAlterorId}" personName="${fsscBasePayWayForm.docAlterorName}" />
                    </div>
                </td>
                <td class="td_normal_title" width="15%">
                    ${lfn:message('fssc-base:fsscBasePayWay.docAlterTime')}
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
        basePath: '/fssc/base/fssc_base_pay_way/fsscBasePayWay.do',
        customOpts: {

            ____fork__: 0
        }
    };
    Com_IncludeFile("security.js");
    Com_IncludeFile("domain.js");
</script>
<%@ include file="/resource/jsp/view_down.jsp" %>