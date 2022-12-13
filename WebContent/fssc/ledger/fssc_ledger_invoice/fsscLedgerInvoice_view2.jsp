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

                    'fdDetail': '${lfn:escapeJs(lfn:message("fssc-ledger:table.fsscLedgerDetail"))}'
                };
                Com_IncludeFile("swf_attachment.js", "${KMSS_Parameter_ContextPath}sys/attachment/js/", "js", true);
            </script>
        </template:replace>
        <template:replace name="title">
            <c:out value="${fsscLedgerInvoiceForm.fdInvoiceNumber} - " />
            <c:out value="${ lfn:message('fssc-ledger:table.fsscLedgerInvoice') }" />
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
                    basePath: '/fssc/ledger/fssc_ledger_invoice/fsscLedgerInvoice.do',
                    customOpts: {

                        ____fork__: 0
                    }
                };

                Com_IncludeFile("security.js");
                Com_IncludeFile("domain.js");
            </script>
            <ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="3">

                <!--edit-->
                <kmss:auth requestURL="/fssc/ledger/fssc_ledger_invoice/fsscLedgerInvoice.do?method=edit&fdId=${param.fdId}">
                    <ui:button text="${lfn:message('button.edit')}" onclick="Com_OpenWindow('fsscLedgerInvoice.do?method=edit&fdId=${param.fdId}','_self');" order="2" />
                </kmss:auth>
                <!--delete-->
                <kmss:auth requestURL="/fssc/ledger/fssc_ledger_invoice/fsscLedgerInvoice.do?method=delete&fdId=${param.fdId}">
                    <ui:button text="${lfn:message('button.delete')}" onclick="deleteDoc('fsscLedgerInvoice.do?method=delete&fdId=${param.fdId}');" order="4" />
                </kmss:auth>
                <ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();" />


            </ui:toolbar>
        </template:replace>
        <template:replace name="path">
            <ui:menu layout="sys.ui.menu.nav">
                <ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" href="/" target="_self" />
                <ui:menu-item text="${ lfn:message('fssc-ledger:table.fsscLedgerInvoice') }" href="/fssc/ledger/fssc_ledger_invoice/" target="_self" />
            </ui:menu>
        </template:replace>
        <template:replace name="content">

            <ui:tabpage expand="false" var-navwidth="90%">
                <ui:content title="${ lfn:message('fssc-ledger:py.JiBenXinXi') }" expand="true">
                    <div class='lui_form_title_frame'>
                        <div class='lui_form_subject'>
                            ${lfn:message('fssc-ledger:table.fsscLedgerInvoice')}
                        </div>
                        <div class='lui_form_baseinfo'>

                        </div>
                    </div>
                    <table class="tb_normal" width="100%">
                        <tr>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdCycs')}
                            </td>
                            <td width="16.6%">
                                <%-- 查验次数--%>
                                <div id="_xform_fdCycs" _xform_type="text">
                                    <xform:text property="fdCycs" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdInvoiceCode')}
                            </td>
                            <td width="16.6%">
                                <%-- 发票代码--%>
                                <div id="_xform_fdInvoiceCode" _xform_type="text">
                                    <xform:text property="fdInvoiceCode" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdInvoiceNumber')}
                            </td>
                            <td width="16.6%">
                                <%-- 发票号码--%>
                                <div id="_xform_fdInvoiceNumber" _xform_type="text">
                                    <xform:text property="fdInvoiceNumber" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdBillingDate')}
                            </td>
                            <td width="16.6%">
                                <%-- 开票日期--%>
                                <div id="_xform_fdBillingDate" _xform_type="datetime">
                                    <xform:datetime property="fdBillingDate" showStatus="view" dateTimeType="date" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdJqbm')}
                            </td>
                            <td width="16.6%">
                                <%-- 机器编码--%>
                                <div id="_xform_fdJqbm" _xform_type="text">
                                    <xform:text property="fdJqbm" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdPurchaserName')}
                            </td>
                            <td width="16.6%">
                                <%-- 购方名称--%>
                                <div id="_xform_fdPurchaserName" _xform_type="text">
                                    <xform:text property="fdPurchaserName" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdPurchaserTaxNo')}
                            </td>
                            <td width="16.6%">
                                <%-- 购方税号--%>
                                <div id="_xform_fdPurchaserTaxNo" _xform_type="text">
                                    <xform:text property="fdPurchaserTaxNo" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdGfdzdh')}
                            </td>
                            <td width="16.6%">
                                <%-- 购方地址电话--%>
                                <div id="_xform_fdGfdzdh" _xform_type="text">
                                    <xform:text property="fdGfdzdh" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdGfyhzh')}
                            </td>
                            <td width="16.6%">
                                <%-- 购方银行账号--%>
                                <div id="_xform_fdGfyhzh" _xform_type="text">
                                    <xform:text property="fdGfyhzh" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdSalesTaxName')}
                            </td>
                            <td width="16.6%">
                                <%-- 销方名称--%>
                                <div id="_xform_fdSalesTaxName" _xform_type="text">
                                    <xform:text property="fdSalesTaxName" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdSalesTaxNo')}
                            </td>
                            <td width="16.6%">
                                <%-- 销方税号--%>
                                <div id="_xform_fdSalesTaxNo" _xform_type="text">
                                    <xform:text property="fdSalesTaxNo" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdXfdzdh')}
                            </td>
                            <td width="16.6%">
                                <%-- 销方地址电话--%>
                                <div id="_xform_fdXfdzdh" _xform_type="text">
                                    <xform:text property="fdXfdzdh" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdXfyhzh')}
                            </td>
                            <td width="16.6%">
                                <%-- 销方银行账号--%>
                                <div id="_xform_fdXfyhzh" _xform_type="text">
                                    <xform:text property="fdXfyhzh" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdBz')}
                            </td>
                            <td width="16.6%">
                                <%-- 备注--%>
                                <div id="_xform_fdBz" _xform_type="text">
                                    <xform:text property="fdBz" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdInvoiceType')}
                            </td>
                            <td width="16.6%">
                                <%-- 发票类型--%>
                                <div id="_xform_fdInvoiceType" _xform_type="radio">
                                    <xform:radio property="fdInvoiceType" htmlElementProperties="id='fdInvoiceType'" showStatus="view">
                                        <xform:enumsDataSource enumsType="fssc_ledger_type" />
                                    </xform:radio>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdJym')}
                            </td>
                            <td width="16.6%">
                                <%-- 校验码--%>
                                <div id="_xform_fdJym" _xform_type="text">
                                    <xform:text property="fdJym" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdZfbz')}
                            </td>
                            <td width="16.6%">
                                <%-- 作废标志--%>
                                <div id="_xform_fdZfbz" _xform_type="radio">
                                    <xform:radio property="fdZfbz" htmlElementProperties="id='fdZfbz'" showStatus="view">
                                        <xform:enumsDataSource enumsType="fssc_ledger_zfbz" />
                                    </xform:radio>
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdTotalAmount')}
                            </td>
                            <td width="16.6%">
                                <%-- 发票金额--%>
                                <div id="_xform_fdTotalAmount" _xform_type="text">
                                    <xform:text property="fdTotalAmount" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdTotalTax')}
                            </td>
                            <td width="16.6%">
                                <%-- 发票税额--%>
                                <div id="_xform_fdTotalTax" _xform_type="text">
                                      <input type="text" name="fdTotalTax"  readonly="readonly" value="<kmss:showNumber value="${fsscLedgerInvoiceForm.fdTotalTax }" pattern="0.00"/>" class="inputsgl" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdIsAvailable')}
                            </td>
                            <td width="16.6%">
                                <%-- 是否有效--%>
                                <div id="_xform_fdIsAvailable" _xform_type="radio">
                                    <xform:radio property="fdIsAvailable" htmlElementProperties="id='fdIsAvailable'" showStatus="view">
                                        <xform:enumsDataSource enumsType="common_yesno" />
                                    </xform:radio>
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.docCreator')}
                            </td>
                            <td width="16.6%">
                                <%-- 创建人--%>
                                <div id="_xform_docCreatorId" _xform_type="address">
                                    <ui:person personId="${fsscLedgerInvoiceForm.docCreatorId}" personName="${fsscLedgerInvoiceForm.docCreatorName}" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.docAlteror')}
                            </td>
                            <td width="16.6%">
                                <%-- 修改人--%>
                                <div id="_xform_docAlterorId" _xform_type="address">
                                    <ui:person personId="${fsscLedgerInvoiceForm.docAlterorId}" personName="${fsscLedgerInvoiceForm.docAlterorName}" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.docCreateTime')}
                            </td>
                            <td width="16.6%">
                                <%-- 创建时间--%>
                                <div id="_xform_docCreateTime" _xform_type="datetime">
                                    <xform:datetime property="docCreateTime" showStatus="view" dateTimeType="datetime" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.docAlterTime')}
                            </td>
                            <td width="16.6%">
                                <%-- 更新时间--%>
                                <div id="_xform_docAlterTime" _xform_type="datetime">
                                    <xform:datetime property="docAlterTime" showStatus="view" dateTimeType="datetime" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdDesc')}
                            </td>
                            <td width="16.6%">
                                <%-- 描述--%>
                                <div id="_xform_fdDesc" _xform_type="textarea">
                                    <xform:textarea property="fdDesc" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdState')}
                            </td>
                            <td width="16.6%">
                                <%-- 发票状态--%>
                                <div id="_xform_fdState" _xform_type="radio">
                                    <xform:radio property="fdState" htmlElementProperties="id='fdState'" showStatus="view">
                                        <xform:enumsDataSource enumsType="fssc_ledger_invoice_status" />
                                    </xform:radio>
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdDeductible')}
                            </td>
                            <td width="16.6%">
                                <%-- 是否认证--%>
                                <div id="_xform_fdDeductible" _xform_type="radio">
                                    <xform:radio property="fdDeductible" htmlElementProperties="id='fdDeductible'" showStatus="view">
                                        <xform:enumsDataSource enumsType="fssc_ledger_invoice_deductible" />
                                    </xform:radio>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdDeductibleDate')}
                            </td>
                            <td width="16.6%">
                                <%-- 认证时间--%>
                                <div id="_xform_fdDeductibleDate" _xform_type="datetime">
                                    <xform:datetime property="fdDeductibleDate" showStatus="view" dateTimeType="date" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdModelId')}
                            </td>
                            <td width="16.6%">
                                <%-- 数据id--%>
                                <div id="_xform_fdModelId" _xform_type="text">
                                    <xform:text property="fdModelId" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdModelName')}
                            </td>
                            <td width="16.6%">
                                <%-- 模块name--%>
                                <div id="_xform_fdModelName" _xform_type="text">
                                    <xform:text property="fdModelName" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdJshj')}
                            </td>
                            <td width="16.6%">
                                <%-- 价税合计--%>
                                <div id="_xform_fdJshj" _xform_type="text">
                                   <input type="text" name="fdJshj" readonly="readonly" value="<kmss:showNumber value="${fsscLedgerInvoiceForm.fdJshj }" pattern="0.00"/>" calss="inputsgl" style="width:95%"/> 
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdSfz')}
                            </td>
                            <td width="16.6%">
                                <%-- 身份证号码/组织机构代码--%>
                                <div id="_xform_fdSfz" _xform_type="text">
                                    <xform:text property="fdSfz" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdCllx')}
                            </td>
                            <td width="16.6%">
                                <%-- 车辆类型--%>
                                <div id="_xform_fdCllx" _xform_type="text">
                                    <xform:text property="fdCllx" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdCpxh')}
                            </td>
                            <td width="16.6%">
                                <%-- 车牌型号--%>
                                <div id="_xform_fdCpxh" _xform_type="text">
                                    <xform:text property="fdCpxh" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdCd')}
                            </td>
                            <td width="16.6%">
                                <%-- 产地--%>
                                <div id="_xform_fdCd" _xform_type="text">
                                    <xform:text property="fdCd" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdHgzh')}
                            </td>
                            <td width="16.6%">
                                <%-- 合格证号--%>
                                <div id="_xform_fdHgzh" _xform_type="text">
                                    <xform:text property="fdHgzh" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdSjdh')}
                            </td>
                            <td width="16.6%">
                                <%-- 商检单号--%>
                                <div id="_xform_fdSjdh" _xform_type="text">
                                    <xform:text property="fdSjdh" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdFdjhm')}
                            </td>
                            <td width="16.6%">
                                <%-- 发动机号码--%>
                                <div id="_xform_fdFdjhm" _xform_type="text">
                                    <xform:text property="fdFdjhm" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdClsbdh')}
                            </td>
                            <td width="16.6%">
                                <%-- 车辆识别代号--%>
                                <div id="_xform_fdClsbdh" _xform_type="text">
                                    <xform:text property="fdClsbdh" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdJkzmsh')}
                            </td>
                            <td width="16.6%">
                                <%-- 进口证明书号--%>
                                <div id="_xform_fdJkzmsh" _xform_type="text">
                                    <xform:text property="fdJkzmsh" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdDh')}
                            </td>
                            <td width="16.6%">
                                <%-- 电话--%>
                                <div id="_xform_fdDh" _xform_type="text">
                                    <xform:text property="fdDh" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdDz')}
                            </td>
                            <td width="16.6%">
                                <%-- 地址--%>
                                <div id="_xform_fdDz" _xform_type="text">
                                    <xform:text property="fdDz" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdKhyh')}
                            </td>
                            <td width="16.6%">
                                <%-- 开户银行--%>
                                <div id="_xform_fdKhyh" _xform_type="text">
                                    <xform:text property="fdKhyh" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdZh')}
                            </td>
                            <td width="16.6%">
                                <%-- 账号--%>
                                <div id="_xform_fdZh" _xform_type="text">
                                    <xform:text property="fdZh" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdZgswjg')}
                            </td>
                            <td width="16.6%">
                                <%-- 主管税务机关代码--%>
                                <div id="_xform_fdZgswjg" _xform_type="text">
                                    <xform:text property="fdZgswjg" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdZgswjgmc')}
                            </td>
                            <td width="16.6%">
                                <%-- 主管税务机关名称--%>
                                <div id="_xform_fdZgswjgmc" _xform_type="text">
                                    <xform:text property="fdZgswjgmc" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdWspzhm')}
                            </td>
                            <td width="16.6%">
                                <%-- 完税凭证号码--%>
                                <div id="_xform_fdWspzhm" _xform_type="text">
                                    <xform:text property="fdWspzhm" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdDw')}
                            </td>
                            <td width="16.6%">
                                <%-- 吨位--%>
                                <div id="_xform_fdDw" _xform_type="text">
                                    <xform:text property="fdDw" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdXcrs')}
                            </td>
                            <td width="16.6%">
                                <%-- 限乘人数--%>
                                <div id="_xform_fdXcrs" _xform_type="text">
                                    <xform:text property="fdXcrs" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdSl')}
                            </td>
                            <td width="16.6%">
                                <%-- 税率--%>
                                <div id="_xform_fdSl" _xform_type="text">
                                    <xform:text property="fdSl" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdCyrsh')}
                            </td>
                            <td width="16.6%">
                                <%-- 承运人税号--%>
                                <div id="_xform_fdCyrsh" _xform_type="text">
                                    <xform:text property="fdCyrsh" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdSpf')}
                            </td>
                            <td width="16.6%">
                                <%-- 实际受票方--%>
                                <div id="_xform_fdSpf" _xform_type="text">
                                    <xform:text property="fdSpf" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdSpfsh')}
                            </td>
                            <td width="16.6%">
                                <%-- 实际受票方税号--%>
                                <div id="_xform_fdSpfsh" _xform_type="text">
                                    <xform:text property="fdSpfsh" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdShr')}
                            </td>
                            <td width="16.6%">
                                <%-- 收货人--%>
                                <div id="_xform_fdShr" _xform_type="text">
                                    <xform:text property="fdShr" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdShrsh')}
                            </td>
                            <td width="16.6%">
                                <%-- 收货人税号--%>
                                <div id="_xform_fdShrsh" _xform_type="text">
                                    <xform:text property="fdShrsh" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdFhr')}
                            </td>
                            <td width="16.6%">
                                <%-- 发货人--%>
                                <div id="_xform_fdFhr" _xform_type="text">
                                    <xform:text property="fdFhr" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdFhrsh')}
                            </td>
                            <td width="16.6%">
                                <%-- 发货人税号--%>
                                <div id="_xform_fdFhrsh" _xform_type="text">
                                    <xform:text property="fdFhrsh" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdYshwxx')}
                            </td>
                            <td width="16.6%">
                                <%-- 运输货物信息--%>
                                <div id="_xform_fdYshwxx" _xform_type="text">
                                    <xform:text property="fdYshwxx" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdQyd')}
                            </td>
                            <td width="16.6%">
                                <%-- 起运地、经由、到达地--%>
                                <div id="_xform_fdQyd" _xform_type="text">
                                    <xform:text property="fdQyd" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdCzch')}
                            </td>
                            <td width="16.6%">
                                <%-- 车种车号--%>
                                <div id="_xform_fdCzch" _xform_type="text">
                                    <xform:text property="fdCzch" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdZgswjgdm')}
                            </td>
                            <td width="16.6%">
                                <%-- 主管税务机关代码--%>
                                <div id="_xform_fdZgswjgdm" _xform_type="text">
                                    <xform:text property="fdZgswjgdm" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdGfdw')}
                            </td>
                            <td width="16.6%">
                                <%-- 买方单位/个人--%>
                                <div id="_xform_fdGfdw" _xform_type="text">
                                    <xform:text property="fdGfdw" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdGfdwdm')}
                            </td>
                            <td width="16.6%">
                                <%-- 买方单位代码/身份证号码--%>
                                <div id="_xform_fdGfdwdm" _xform_type="text">
                                    <xform:text property="fdGfdwdm" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdGfdwdz')}
                            </td>
                            <td width="16.6%">
                                <%-- 买方单位/个人地址--%>
                                <div id="_xform_fdGfdwdz" _xform_type="text">
                                    <xform:text property="fdGfdwdz" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdGfdwdh')}
                            </td>
                            <td width="16.6%">
                                <%-- 买方单位电话--%>
                                <div id="_xform_fdGfdwdh" _xform_type="text">
                                    <xform:text property="fdGfdwdh" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdMfdw')}
                            </td>
                            <td width="16.6%">
                                <%-- 卖方单位/个人--%>
                                <div id="_xform_fdMfdw" _xform_type="text">
                                    <xform:text property="fdMfdw" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdMfdwdm')}
                            </td>
                            <td width="16.6%">
                                <%-- 卖方单位代码/身份证号码--%>
                                <div id="_xform_fdMfdwdm" _xform_type="text">
                                    <xform:text property="fdMfdwdm" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdMfdwdz')}
                            </td>
                            <td width="16.6%">
                                <%-- 卖方单位/个人地址--%>
                                <div id="_xform_fdMfdwdz" _xform_type="text">
                                    <xform:text property="fdMfdwdz" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdMfdwdh')}
                            </td>
                            <td width="16.6%">
                                <%-- 卖方单位电话--%>
                                <div id="_xform_fdMfdwdh" _xform_type="text">
                                    <xform:text property="fdMfdwdh" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdCpzh')}
                            </td>
                            <td width="16.6%">
                                <%-- 车牌照号--%>
                                <div id="_xform_fdCpzh" _xform_type="text">
                                    <xform:text property="fdCpzh" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdDjzh')}
                            </td>
                            <td width="16.6%">
                                <%-- 登记证号--%>
                                <div id="_xform_fdDjzh" _xform_type="text">
                                    <xform:text property="fdDjzh" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdCjh')}
                            </td>
                            <td width="16.6%">
                                <%-- 车架号/车辆识别代码--%>
                                <div id="_xform_fdCjh" _xform_type="text">
                                    <xform:text property="fdCjh" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdZrdclgls')}
                            </td>
                            <td width="16.6%">
                                <%-- 转入地车辆管理所名称--%>
                                <div id="_xform_fdZrdclgls" _xform_type="text">
                                    <xform:text property="fdZrdclgls" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdCjhj')}
                            </td>
                            <td width="16.6%">
                                <%-- 车价合计--%>
                                <div id="_xform_fdCjhj" _xform_type="text">
                                    <xform:text property="fdCjhj" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdJydw')}
                            </td>
                            <td width="16.6%">
                                <%-- 经营、拍卖单位--%>
                                <div id="_xform_fdJydw" _xform_type="text">
                                    <xform:text property="fdJydw" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdJydwdz')}
                            </td>
                            <td width="16.6%">
                                <%-- 经营、拍卖单位地址--%>
                                <div id="_xform_fdJydwdz" _xform_type="text">
                                    <xform:text property="fdJydwdz" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdJydwnsrsbh')}
                            </td>
                            <td width="16.6%">
                                <%-- 经营、拍卖单位纳税人识别号--%>
                                <div id="_xform_fdJydwnsrsbh" _xform_type="text">
                                    <xform:text property="fdJydwnsrsbh" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdJydwkhyhzh')}
                            </td>
                            <td width="16.6%">
                                <%-- 经营、拍卖单位开户银行、账号--%>
                                <div id="_xform_fdJydwkhyhzh" _xform_type="text">
                                    <xform:text property="fdJydwkhyhzh" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdJydwdh')}
                            </td>
                            <td width="16.6%">
                                <%-- 经营、拍卖单位电话--%>
                                <div id="_xform_fdJydwdh" _xform_type="text">
                                    <xform:text property="fdJydwdh" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdEscsc')}
                            </td>
                            <td width="16.6%">
                                <%-- 二手车市场--%>
                                <div id="_xform_fdEscsc" _xform_type="text">
                                    <xform:text property="fdEscsc" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdEscnsrsbh')}
                            </td>
                            <td width="16.6%">
                                <%-- 二手车市场纳税人识别号--%>
                                <div id="_xform_fdEscnsrsbh" _xform_type="text">
                                    <xform:text property="fdEscnsrsbh" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdEscdz')}
                            </td>
                            <td width="16.6%">
                                <%-- 二手车市场地址--%>
                                <div id="_xform_fdEscdz" _xform_type="text">
                                    <xform:text property="fdEscdz" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdEscdz')}
                            </td>
                            <td width="16.6%">
                                <%-- 二手车市场地址--%>
                                <div id="_xform_fdEscdz" _xform_type="text">
                                    <xform:text property="fdEscdz" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdEscdz')}
                            </td>
                            <td width="16.6%">
                                <%-- 二手车市场地址--%>
                                <div id="_xform_fdEscdz" _xform_type="text">
                                    <xform:text property="fdEscdz" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" colspan="6" width="100%">
                                ${ lfn:message('fssc-ledger:py.FaPiaoMingXi') }
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6" width="100%">
                                <table class="tb_normal" width="100%" id="TABLE_DocList_fdDetail_Form" align="center" tbdraggable="true">
                                    <tr align="center" class="tr_normal_title">
                                        <td style="width:40px;">
                                            ${lfn:message('page.serial')}
                                        </td>
                                        <td>
                                            ${lfn:message('fssc-ledger:fsscLedgerDetail.fdXh')}
                                        </td>
                                        <td>
                                            ${lfn:message('fssc-ledger:fsscLedgerDetail.fdSpmc')}
                                        </td>
                                        <td>
                                            ${lfn:message('fssc-ledger:fsscLedgerDetail.fdGgxh')}
                                        </td>
                                        <td>
                                            ${lfn:message('fssc-ledger:fsscLedgerDetail.fdJldw')}
                                        </td>
                                        <td>
                                            ${lfn:message('fssc-ledger:fsscLedgerDetail.fdSl')}
                                        </td>
                                        <td>
                                            ${lfn:message('fssc-ledger:fsscLedgerDetail.fdDj')}
                                        </td>
                                        <td>
                                            ${lfn:message('fssc-ledger:fsscLedgerDetail.fdJe')}
                                        </td>
                                        <td>
                                            ${lfn:message('fssc-ledger:fsscLedgerDetail.fdSlv')}
                                        </td>
                                        <td>
                                            ${lfn:message('fssc-ledger:fsscLedgerDetail.fdSe')}
                                        </td>
                                        <td>
                                            ${lfn:message('fssc-ledger:fsscLedgerDetail.fdXmmc')}
                                        </td>
                                        <td>
                                            ${lfn:message('fssc-ledger:fsscLedgerDetail.fdCph')}
                                        </td>
                                        <td>
                                            ${lfn:message('fssc-ledger:fsscLedgerDetail.fdLx')}
                                        </td>
                                        <td>
                                            ${lfn:message('fssc-ledger:fsscLedgerDetail.fdTxrqq')}
                                        </td>
                                        <td>
                                            ${lfn:message('fssc-ledger:fsscLedgerDetail.fdTxrqz')}
                                        </td>
                                    </tr>
                                    <c:forEach items="${fsscLedgerInvoiceForm.fdDetail_Form}" var="fdDetail_FormItem" varStatus="vstatus">
                                        <tr KMSS_IsContentRow="1">
                                            <td align="center">
                                                ${vstatus.index+1}
                                            </td>
                                            <td align="center">
                                                <%-- 序号--%>
                                                <input type="hidden" name="fdDetail_Form[${vstatus.index}].fdId" value="${fdDetail_FormItem.fdId}" />
                                                <div id="_xform_fdDetail_Form[${vstatus.index}].fdXh" _xform_type="text">
                                                    <xform:text property="fdDetail_Form[${vstatus.index}].fdXh" showStatus="view" style="width:95%;" />
                                                </div>
                                            </td>
                                            <td align="center">
                                                <%-- 商品名称--%>
                                                <div id="_xform_fdDetail_Form[${vstatus.index}].fdSpmc" _xform_type="text">
                                                    <xform:text property="fdDetail_Form[${vstatus.index}].fdSpmc" showStatus="view" style="width:95%;" />
                                                </div>
                                            </td>
                                            <td align="center">
                                                <%-- 规格型号--%>
                                                <div id="_xform_fdDetail_Form[${vstatus.index}].fdGgxh" _xform_type="text">
                                                    <xform:text property="fdDetail_Form[${vstatus.index}].fdGgxh" showStatus="view" style="width:95%;" />
                                                </div>
                                            </td>
                                            <td align="center">
                                                <%-- 计量单位--%>
                                                <div id="_xform_fdDetail_Form[${vstatus.index}].fdJldw" _xform_type="text">
                                                    <xform:text property="fdDetail_Form[${vstatus.index}].fdJldw" showStatus="view" style="width:95%;" />
                                                </div>
                                            </td>
                                            <td align="center">
                                                <%-- 数量--%>
                                                <div id="_xform_fdDetail_Form[${vstatus.index}].fdSl" _xform_type="text">
                                                    <xform:text property="fdDetail_Form[${vstatus.index}].fdSl" showStatus="view" style="width:95%;" />
                                                </div>
                                            </td>
                                            <td align="center">
                                                <%-- 不含税单价--%>
                                                <div id="_xform_fdDetail_Form[${vstatus.index}].fdDj" _xform_type="text">
                                                    <xform:text property="fdDetail_Form[${vstatus.index}].fdDj" showStatus="view" style="width:95%;" />
                                                </div>
                                            </td>
                                            <td align="center">
                                                <%-- 金额--%>
                                                <div id="_xform_fdDetail_Form[${vstatus.index}].fdJe" _xform_type="text">
                                                    <xform:text property="fdDetail_Form[${vstatus.index}].fdJe" showStatus="view" style="width:95%;" />
                                                </div>
                                            </td>
                                            <td align="center">
                                                <%-- 税率--%>
                                                <div id="_xform_fdDetail_Form[${vstatus.index}].fdSlv" _xform_type="text">
                                                    <xform:text property="fdDetail_Form[${vstatus.index}].fdSlv" showStatus="view" style="width:95%;" />
                                                </div>
                                            </td>
                                            <td align="center">
                                                <%-- 税额--%>
                                                <div id="_xform_fdDetail_Form[${vstatus.index}].fdSe" _xform_type="text">
                                                    <xform:text property="fdDetail_Form[${vstatus.index}].fdSe" showStatus="view" style="width:95%;" />
                                                </div>
                                            </td>
                                            <td align="center">
                                                <%-- 项目名称--%>
                                                <div id="_xform_fdDetail_Form[${vstatus.index}].fdXmmc" _xform_type="text">
                                                    <xform:text property="fdDetail_Form[${vstatus.index}].fdXmmc" showStatus="view" style="width:95%;" />
                                                </div>
                                            </td>
                                            <td align="center">
                                                <%-- 车牌号--%>
                                                <div id="_xform_fdDetail_Form[${vstatus.index}].fdCph" _xform_type="text">
                                                    <xform:text property="fdDetail_Form[${vstatus.index}].fdCph" showStatus="view" style="width:95%;" />
                                                </div>
                                            </td>
                                            <td align="center">
                                                <%-- 类型--%>
                                                <div id="_xform_fdDetail_Form[${vstatus.index}].fdLx" _xform_type="text">
                                                    <xform:text property="fdDetail_Form[${vstatus.index}].fdLx" showStatus="view" style="width:95%;" />
                                                </div>
                                            </td>
                                            <td align="center">
                                                <%-- 通行日期起--%>
                                                <div id="_xform_fdDetail_Form[${vstatus.index}].fdTxrqq" _xform_type="text">
                                                    <xform:text property="fdDetail_Form[${vstatus.index}].fdTxrqq" showStatus="view" style="width:95%;" />
                                                </div>
                                            </td>
                                            <td align="center">
                                                <%-- 通行日期止--%>
                                                <div id="_xform_fdDetail_Form[${vstatus.index}].fdTxrqz" _xform_type="text">
                                                    <xform:text property="fdDetail_Form[${vstatus.index}].fdTxrqz" showStatus="view" style="width:95%;" />
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </table>
                            </td>
                        </tr>
                    </table>
                </ui:content>
            </ui:tabpage>
        </template:replace>

    </template:include>