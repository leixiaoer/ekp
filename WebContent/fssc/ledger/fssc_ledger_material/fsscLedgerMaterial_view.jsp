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
            <c:out value="${fsscLedgerMaterialForm.fdCode} - " />
            <c:out value="${ lfn:message('fssc-ledger:table.fsscLedgerMaterial') }" />
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
                    basePath: '/fssc/ledger/fssc_ledger_material/fsscLedgerMaterial.do',
                    customOpts: {

                        ____fork__: 0
                    }
                };

                Com_IncludeFile("security.js");
                Com_IncludeFile("domain.js");
            </script>
            <ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="3">

                <!--edit-->
                <kmss:auth requestURL="/fssc/ledger/fssc_ledger_material/fsscLedgerMaterial.do?method=edit&fdId=${param.fdId}">
                    <ui:button text="${lfn:message('button.edit')}" onclick="Com_OpenWindow('fsscLedgerMaterial.do?method=edit&fdId=${param.fdId}','_self');" order="2" />
                </kmss:auth>
                <!--delete-->
                <kmss:auth requestURL="/fssc/ledger/fssc_ledger_material/fsscLedgerMaterial.do?method=delete&fdId=${param.fdId}">
                    <ui:button text="${lfn:message('button.delete')}" onclick="deleteDoc('fsscLedgerMaterial.do?method=delete&fdId=${param.fdId}');" order="4" />
                </kmss:auth>
                <ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();" />


            </ui:toolbar>
        </template:replace>
        <template:replace name="path">
            <ui:menu layout="sys.ui.menu.nav">
                <ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" href="/" target="_self" />
                <ui:menu-item text="${ lfn:message('fssc-ledger:table.fsscLedgerMaterial') }" href="/fssc/ledger/fssc_ledger_material/" target="_self" />
            </ui:menu>
        </template:replace>
        <template:replace name="content">

            <ui:tabpage expand="false" var-navwidth="90%">
                <ui:content title="${ lfn:message('fssc-ledger:py.JiBenXinXi') }" expand="true">
                    <div class='lui_form_title_frame'>
                        <div class='lui_form_subject'>
                            ${lfn:message('fssc-ledger:table.fsscLedgerMaterial')}
                        </div>
                        <div class='lui_form_baseinfo'>

                        </div>
                    </div>
                    <table class="tb_normal" width="100%">
                        <tr>
                        	<td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerMaterial.fdMaterial')}
                            </td>
                            <td width="16.6%">
                                <%-- 物资名称--%>
                                <div id="_xform_fdCode" _xform_type="text">
                                    ${fsscLedgerMaterialForm.fdMaterialName }
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerMaterial.fdCode')}
                            </td>
                            <td width="16.6%">
                                <%-- 物资编码--%>
                                <div id="_xform_fdCode" _xform_type="text">
                                    <xform:text property="fdCode" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerMaterial.fdType')}
                            </td>
                            <td width="16.6%">
                                <%-- 物资类别--%>
                                <div id="_xform_fdTypeId" _xform_type="dialog">
                                    <xform:dialog propertyId="fdTypeId" propertyName="fdTypeName" showStatus="view" style="width:95%;">
                                        dialogSelect(false,'fssc_base_material_type_selectType','fdTypeId','fdTypeName');
                                    </xform:dialog>
                                </div>
                            </td>
                        </tr>
                        <tr>
                        	<td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerMaterial.fdIsInventory')}
                            </td>
                            <td width="16.6%">
                                <%-- 是否需要进行盘点--%>
                                <div id="_xform_fdIsInventory" _xform_type="radio">
                                    <xform:radio property="fdIsInventory" htmlElementProperties="id='fdIsInventory'" showStatus="view">
                                        <xform:enumsDataSource enumsType="common_yesno" />
                                    </xform:radio>
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerMaterial.fdStatus')}
                            </td>
                            <td width="16.6%">
                                <%-- 物资状态--%>
                                <div id="_xform_fdStatus" _xform_type="select">
                                    <xform:select property="fdStatus" htmlElementProperties="id='fdStatus'" showStatus="view">
                                        <xform:enumsDataSource enumsType="fssc_ledger_material_status" />
                                    </xform:select>
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerMaterial.fdStock')}
                            </td>
                            <td width="16.6%">
                                <%-- 库存--%>
                                <div id="_xform_fdStock" _xform_type="text">
                                    <xform:text property="fdStock" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                        	<td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerMaterial.fdUnit')}
                            </td>
                            <td width="16.6%">
                                <%-- 单位--%>
                                <div id="_xform_fdUnit" _xform_type="text">
                                    <xform:text property="fdUnit" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        	<td class="td_normal_title" width="16.6%">
                            </td>
                            <td width="16.6%">
                            </td>
                            <td class="td_normal_title" width="16.6%">
                            </td>
                            <td width="16.6%">
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerMaterial.fdDesc')}
                            </td>
                            <td colspan="5" width="83.0%">
                                <%-- 备注说明--%>
                                <div id="_xform_fdDesc" _xform_type="textarea">
                                    <xform:textarea property="fdDesc" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerMaterial.fdPurchase')}
                            </td>
                            <td width="16.6%">
                                <%-- 采购员--%>
                                <div id="_xform_fdPurchaseId" _xform_type="address">
                                    <xform:address propertyId="fdPurchaseId" propertyName="fdPurchaseName" orgType="ORG_TYPE_PERSON" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerMaterial.fdPurchaseDept')}
                            </td>
                            <td width="16.6%">
                                <%-- 采购人部门--%>
                                <div id="_xform_fdPurchaseDeptId" _xform_type="address">
                                    <xform:address propertyId="fdPurchaseDeptId" propertyName="fdPurchaseDeptName" orgType="ORG_TYPE_ORGORDEPT" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerMaterial.fdPhone')}
                            </td>
                            <td width="16.6%">
                                <%-- 电话--%>
                                <div id="_xform_fdPhone" _xform_type="text">
                                    <xform:text property="fdPhone" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                    </table>
                </ui:content>
                <!-- 入库记录 -->
                <ui:content title="${lfn:message('fssc-ledger:fsscLedgerMaterial.in.detail')}" expand="false" id="in_content">
					<div>
						<list:listview id="listview_in" channel="in">
							<ui:source type="AjaxJson" >
								{url:'/fssc/ledger/fssc_ledger_material_stock/fsscLedgerMaterialStock.do?method=stockData&fdType=1&fdCode=${fsscLedgerMaterialForm.fdCode}&fdStockFlag=stock'}
							</ui:source>
							<list:colTable rowHref="" layout="sys.ui.listview.listtable">
								<list:col-serial title="NO"></list:col-serial>
								<list:col-auto props="fdWarehousingDate;fdUnit;fdPrice;fdQuantity;fdModel;fdQuantity;fdMoney;fdLeft;" ></list:col-auto>
							</list:colTable>
							<list:paging layout="sys.ui.paging.simple" channel="occu"></list:paging>
						</list:listview>
						<list:paging></list:paging>
					</div>
			</ui:content>
			<!-- 出库记录 -->
            <ui:content title="${lfn:message('fssc-ledger:fsscLedgerMaterial.out.detail')}" expand="false" id="out_content">
					<div>
						<list:listview id="listview_out" channel="out">
							<ui:source type="AjaxJson" >
								{url:'/fssc/ledger/fssc_ledger_material_stock/fsscLedgerMaterialStock.do?method=stockData&fdType=3&fdCode=${fsscLedgerMaterialForm.fdCode}&fdStockFlag=stock'}
							</ui:source>
							<list:colTable rowHref="" layout="sys.ui.listview.listtable">
								<list:col-serial title="NO"></list:col-serial>
								<list:col-auto props="fdWarehousingDate;fdQuantity;fdPrice;fdUnit;fdModel;fdMoney;fdUser.name;fdUserDept.name;" ></list:col-auto>
							</list:colTable>
							<list:paging layout="sys.ui.paging.simple" channel="used"></list:paging>
						</list:listview>
						<list:paging></list:paging>
					</div>
				</ui:content>
            </ui:tabpage>
        </template:replace>

    </template:include>