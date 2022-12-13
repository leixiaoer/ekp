<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<template:include ref="default.view">
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
    </template:replace>
    <template:replace name="title">
        <c:out value="${ lfn:message('fssc-budgeting:table.fsscBudgetingAuth') }" />
    </template:replace>
    <template:replace name="toolbar">
        <script>
            function deleteDoc(delUrl) {
                seajs.use(['lui/dialog'], function(dialog) {
                    dialog.confirm('${ lfn:message("page.comfirmDelete") }', function(isOk) {
                        if(isOk) {
                            Com_OpenWindow(delUrl, '_self');
                        }
                    });
                });
            }

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
                basePath: '/fssc/budgeting/fssc_budgeting_auth/fsscBudgetingAuth.do',
                customOpts: {

                    ____fork__: 0
                }
            };
            Com_IncludeFile("security.js");
            Com_IncludeFile("domain.js");
        </script>
        <ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="4">
        	 <kmss:auth requestURL="/fssc/budgeting/fssc_budgeting_auth/fsscBudgetingAuth.do?method=edit&fdId=${param.fdId}">
		        <ui:button text="${lfn:message('button.edit')}" onclick="Com_OpenWindow('fsscBudgetingAuth.do?method=edit&fdId=${param.fdId}','_self');" order="2" />
		    </kmss:auth>
		    <kmss:auth requestURL="/fssc/budgeting/fssc_budgeting_auth/fsscBudgetingAuth.do?method=delete&fdId=${param.fdId}">
		        <ui:button text="${lfn:message('button.delete')}" onclick="if(!confirmDelete())return;Com_OpenWindow('fsscBudgetingAuth.do?method=delete&fdId=${param.fdId}','_self');" />
		    </kmss:auth>
		    <ui:button text="${lfn:message('button.close')}" onclick="Com_CloseWindow();" />
        </ui:toolbar>
    </template:replace>
    <template:replace name="path">
        <ui:menu layout="sys.ui.menu.nav">
            <ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" href="/" target="_self" />
            <ui:menu-item text="${ lfn:message('fssc-budgeting:table.fsscBudgetingAuth') }" href="/fssc/budget/fssc_budgeting_auth/" target="_self" />
        </ui:menu>
    </template:replace>
    <template:replace name="content">
                <table class="tb_normal" width="100%">
		            <tr>
		                <td class="td_normal_title" width="15%">
		                    ${lfn:message('fssc-budgeting:fsscBudgetingAuth.fdName')}
		                </td>
		                <td colspan="3" width="85.0%">
		                    <%-- 名称--%>
		                    <div id="_xform_fdName" _xform_type="text">
		                        <xform:text property="fdName" showStatus="view" style="width:95%;" />
		                    </div>
		                </td>
		            </tr>
		            <tr>
		                <td class="td_normal_title" width="15%">
		                    ${lfn:message('fssc-budgeting:fsscBudgetingAuth.fdPersonList')}
		                </td>
		                <td colspan="3" width="85.0%">
		                    <%-- 人员--%>
		                    <div id="_xform_fdPersonListIds" _xform_type="address">
		                        <xform:address propertyId="fdPersonListIds" propertyName="fdPersonListNames" mulSelect="true" orgType="ORG_TYPE_PERSON" showStatus="view" textarea="true" style="width:95%;" />
		                    </div>
		                </td>
		            </tr>
		            <tr>
		                <td class="td_normal_title" width="15%">
		                    ${lfn:message('fssc-budgeting:fsscBudgetingAuth.fdDesc')}
		                </td>
		                <td colspan="3" width="85.0%">
		                    <%-- 说明--%>
		                    <div id="_xform_fdDesc" _xform_type="textarea">
		                        <xform:textarea property="fdDesc" showStatus="view" style="width:95%;" />
		                    </div>
		                </td>
		            </tr>
		            <tr>
		                <td class="td_normal_title" width="15%">
		                    ${lfn:message('fssc-budgeting:fsscBudgetingAuth.fdOrgList')}
		                </td>
		                <td colspan="3" width="85.0%">
		                    <%-- 组织架构--%>
		                    <div id="_xform_fdOrgListIds" _xform_type="address">
		                        <xform:address idValue="${fsscBudgetingAuthForm.fdOrgListIds}" nameValue="${fsscBudgetingAuthForm.fdOrgListNames}" propertyId="fdOrgListIds" propertyName="fdOrgListNames" mulSelect="true" orgType="ORG_TYPE_ORGORDEPT" showStatus="view" textarea="true" style="width:95%;" />
		                    </div>
		                </td>
		            </tr>
		            <tr>
	                    <td class="td_normal_title" width="15%">
	                        ${lfn:message('fssc-budgeting:fsscBudgetingAuth.fdCompanyList')}
	                    </td>
	                    <td colspan="3" width="85.0%">
	                        <%-- 公司--%>
	                         <div id="_xform_fdCompanyListIds" _xform_type="dialog">
	                            <xform:dialog propertyId="fdCompanyListIds" propertyName="fdCompanyListNames" showStatus="view" style="width:95%;">
	                                dialogSelect(true,'fssc_base_company_fdCompany','fdComanyListIds','fdComanyListNames');
	                            </xform:dialog>
	                        </div>
	                    </td>
	                </tr>
		            <tr>
		                <td class="td_normal_title" width="15%">
		                    ${lfn:message('fssc-budgeting:fsscBudgetingAuth.fdCostCenterList')}
		                </td>
		                <td colspan="3" width="85.0%">
		                    <%-- 成本中心--%>
		                    <div id="_xform_fdCostCenterListIds" _xform_type="dialog">
		                        <xform:dialog propertyId="fdCostCenterListIds" propertyName="fdCostCenterListNames" showStatus="view" style="width:95%;">
		                            dialogSelect(true,'fssc_base_cost_center_selectCostCenter','fdCostCenterListIds','fdCostCenterListNames');
		                        </xform:dialog>
		                    </div>
		                </td>
		            </tr>
		            <tr>
		                <td class="td_normal_title" width="15%">
		                    ${lfn:message('fssc-budgeting:fsscBudgetingAuth.fdBudgetItemList')}
		                </td>
		                <td colspan="3" width="85.0%">
		                    <%-- 预算科目--%>
		                    <div id="_xform_fdBudgetItemListIds" _xform_type="dialog">
		                        <xform:dialog propertyId="fdBudgetItemListIds" propertyName="fdBudgetItemListNames" showStatus="view" style="width:95%;">
		                            dialogSelect(true,'fssc_base_budget_item_fdBudgetItem','fdBudgetItemListIds','fdBudgetItemListNames');
		                        </xform:dialog>
		                    </div>
		                </td>
		            </tr>
		            <tr>
		                <td class="td_normal_title" width="15%">
		                    ${lfn:message('fssc-budgeting:fsscBudgetingAuth.fdProjectList')}
		                </td>
		                <td colspan="3" width="85.0%">
		                    <%-- 项目--%>
		                    <div id="_xform_fdProjectListIds" _xform_type="dialog">
		                        <xform:dialog propertyId="fdProjectListIds" propertyName="fdProjectListNames" showStatus="view" style="width:95%;">
		                            dialogSelect(true,'fssc_base_project_project','fdProjectListIds','fdProjectListNames');
		                        </xform:dialog>
		                    </div>
		                </td>
		            </tr>
		            <tr>
		                <td class="td_normal_title" width="15%">
		                    ${lfn:message('fssc-budgeting:fsscBudgetingAuth.fdIsAvailable')}
		                </td>
		                <td colspan="3" width="85.0%">
		                    <%-- 是否有效--%>
		                    <div id="_xform_fdIsAvailable" _xform_type="radio">
		                        <xform:radio property="fdIsAvailable" htmlElementProperties="id='fdIsAvailable'" showStatus="view">
		                            <xform:enumsDataSource enumsType="common_yesno" />
		                        </xform:radio>
		                    </div>
		                </td>
		            </tr>
		            <tr>
		                <td class="td_normal_title" width="15%">
		                    ${lfn:message('fssc-budgeting:fsscBudgetingAuth.docCreator')}
		                </td>
		                <td width="35%">
		                    <%-- 创建人--%>
		                    <div id="_xform_docCreatorId" _xform_type="address">
		                        <ui:person personId="${fsscBudgetingAuthForm.docCreatorId}" personName="${fsscBudgetingAuthForm.docCreatorName}" />
		                    </div>
		                </td>
		                <td class="td_normal_title" width="15%">
		                    ${lfn:message('fssc-budgeting:fsscBudgetingAuth.docCreateTime')}
		                </td>
		                <td width="35%">
		                    <%-- 创建时间--%>
		                    <div id="_xform_docCreateTime" _xform_type="datetime">
		                        <xform:datetime property="docCreateTime" showStatus="view" style="width:95%;" />
		                    </div>
		                </td>
		            </tr>
		            <tr>
		                <td class="td_normal_title" width="15%">
		                    ${lfn:message('fssc-budgeting:fsscBudgetingAuth.docAlteror')}
		                </td>
		                <td width="35%">
		                    <%-- 修改人--%>
		                    <div id="_xform_docAlterorId" _xform_type="address">
		                        <ui:person personId="${fsscBudgetingAuthForm.docAlterorId}" personName="${fsscBudgetingAuthForm.docAlterorName}" />
		                    </div>
		                </td>
		                <td class="td_normal_title" width="15%">
		                    ${lfn:message('fssc-budgeting:fsscBudgetingAuth.docAlterTime')}
		                </td>
		                <td width="35%">
		                    <%-- 更新时间--%>
		                    <div id="_xform_docAlterTime" _xform_type="datetime">
		                        <xform:datetime property="docAlterTime" showStatus="view" style="width:95%;" />
		                    </div>
		                </td>
		            </tr>
		        </table>
    </template:replace>

</template:include>