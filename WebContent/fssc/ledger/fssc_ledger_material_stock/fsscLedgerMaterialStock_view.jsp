<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@page import="com.landray.kmss.fssc.ledger.util.FsscLedgerUtil" %>
    
        <%
            pageContext.setAttribute("currentPerson", UserUtil.getKMSSUser().getUserId());
        pageContext.setAttribute("currentPost", UserUtil.getKMSSUser().getPostIds());
        pageContext.setAttribute("currentDept", UserUtil.getKMSSUser().getDeptId());
        if(UserUtil.getUser().getFdParentOrg() != null) {
            pageContext.setAttribute("currentOrg", UserUtil.getUser().getFdParentOrg().getFdId());
        } else {
            pageContext.setAttribute("currentOrg", "");
        } %>
    
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
            <script type="text/javascript">
                var formInitData = {

                };
                var messageInfo = {

                };
                Com_IncludeFile("swf_attachment.js", "${KMSS_Parameter_ContextPath}sys/attachment/js/", "js", true);
            </script>
        </template:replace>
        <template:replace name="title">
            <c:out value="${fsscLedgerMaterialStockForm.fdModelName} - " />
            <c:out value="${ lfn:message('fssc-ledger:table.fsscLedgerMaterialStock') }" />
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
                    basePath: '/fssc/ledger/fssc_ledger_material_stock/fsscLedgerMaterialStock.do',
                    customOpts: {

                        ____fork__: 0
                    }
                };

                Com_IncludeFile("security.js");
                Com_IncludeFile("domain.js");
            </script>
            <ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="3">

                <!--edit-->
                <kmss:auth requestURL="/fssc/ledger/fssc_ledger_material_stock/fsscLedgerMaterialStock.do?method=edit&fdId=${param.fdId}">
                    <ui:button text="${lfn:message('button.edit')}" onclick="Com_OpenWindow('fsscLedgerMaterialStock.do?method=edit&fdId=${param.fdId}','_self');" order="2" />
                </kmss:auth>
                <!--delete-->
                <kmss:auth requestURL="/fssc/ledger/fssc_ledger_material_stock/fsscLedgerMaterialStock.do?method=delete&fdId=${param.fdId}">
                    <ui:button text="${lfn:message('button.delete')}" onclick="deleteDoc('fsscLedgerMaterialStock.do?method=delete&fdId=${param.fdId}');" order="4" />
                </kmss:auth>
                <ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();" />


            </ui:toolbar>
        </template:replace>
        <template:replace name="path">
            <ui:menu layout="sys.ui.menu.nav">
                <ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" href="/" target="_self" />
                <ui:menu-item text="${ lfn:message('fssc-ledger:table.fsscLedgerMaterialStock') }" href="/fssc/ledger/fssc_ledger_material_stock/" target="_self" />
            </ui:menu>
        </template:replace>
        <template:replace name="content">

            <ui:tabpage expand="false" var-navwidth="90%">
                <ui:content title="${ lfn:message('fssc-ledger:py.JiBenXinXi') }" expand="true">
                    <div class='lui_form_title_frame'>
                        <div class='lui_form_subject'>
                            ${lfn:message('fssc-ledger:table.fsscLedgerMaterialStock')}
                        </div>
                        <div class='lui_form_baseinfo'>

                        </div>
                    </div>
                    <table class="tb_normal" width="100%">
                        <tr>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerMaterialStock.fdStockId')}
                            </td>
                            <td width="16.6%">
                                <%-- 相应库存ID--%>
                                <div id="_xform_fdStockId" _xform_type="text">
                                    <xform:text property="fdStockId" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerMaterialStock.fdModelId')}
                            </td>
                            <td width="16.6%">
                                <%-- 域名Id--%>
                                <div id="_xform_fdModelId" _xform_type="text">
                                    <xform:text property="fdModelId" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerMaterialStock.fdModelName')}
                            </td>
                            <td width="16.6%">
                                <%-- 域名名称--%>
                                <div id="_xform_fdModelName" _xform_type="text">
                                    <xform:text property="fdModelName" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerMaterialStock.fdWarehousingDate')}
                            </td>
                            <td width="16.6%">
                                <%-- 入库时间--%>
                                <div id="_xform_fdWarehousingDate" _xform_type="datetime">
                                    <xform:datetime property="fdWarehousingDate" showStatus="view" dateTimeType="date" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerMaterialStock.fdUnit')}
                            </td>
                            <td width="16.6%">
                                <%-- 台--%>
                                <div id="_xform_fdUnit" _xform_type="text">
                                    <xform:text property="fdUnit" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerMaterialStock.fdPrice')}
                            </td>
                            <td width="16.6%">
                                <%-- 单价--%>
                                <div id="_xform_fdPrice" _xform_type="text">
                                    <xform:text property="fdPrice" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerMaterialStock.fdQuantity')}
                            </td>
                            <td width="16.6%">
                                <%-- 入库数量--%>
                                <div id="_xform_fdQuantity" _xform_type="text">
                                    <xform:text property="fdQuantity" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerMaterialStock.fdModel')}
                            </td>
                            <td width="16.6%">
                                <%-- 型号--%>
                                <div id="_xform_fdModel" _xform_type="text">
                                    <xform:text property="fdModel" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerMaterialStock.fdUser')}
                            </td>
                            <td width="16.6%">
                                <%-- 领用人--%>
                                <div id="_xform_fdUserId" _xform_type="address">
                                    <xform:address propertyId="fdUserId" propertyName="fdUserName" orgType="ORG_TYPE_PERSON" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerMaterialStock.fdUserDept')}
                            </td>
                            <td width="16.6%">
                                <%-- 领用人部门--%>
                                <div id="_xform_fdUserDeptId" _xform_type="address">
                                    <xform:address propertyId="fdUserDeptId" propertyName="fdUserDeptName" orgType="ORG_TYPE_ORGORDEPT" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td colspan="4">
                            </td>
                        </tr>
                    </table>
                </ui:content>
            </ui:tabpage>
        </template:replace>

    </template:include>