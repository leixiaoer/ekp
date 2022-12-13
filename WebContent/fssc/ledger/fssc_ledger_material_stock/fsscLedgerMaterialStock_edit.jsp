<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@page import="com.landray.kmss.fssc.ledger.util.FsscLedgerUtil" %>
    
        <% pageContext.setAttribute("currentUser", UserUtil.getKMSSUser());
        pageContext.setAttribute("currentPerson", UserUtil.getKMSSUser().getUserId());
        pageContext.setAttribute("currentPost", UserUtil.getKMSSUser().getPostIds());
        pageContext.setAttribute("currentDept", UserUtil.getKMSSUser().getDeptId());
        if(UserUtil.getUser().getFdParentOrg() != null) {
            pageContext.setAttribute("currentOrg", UserUtil.getUser().getFdParentOrg().getFdId());
        } else {
            pageContext.setAttribute("currentOrg", "");
        } %>
    
    <template:include ref="default.edit">
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

                var initData = {
                    contextPath: '${LUI_ContextPath}',
                };
                Com_IncludeFile("security.js");
                Com_IncludeFile("domain.js");
                Com_IncludeFile("form.js");
                Com_IncludeFile("form_option.js", "${LUI_ContextPath}/fssc/ledger/fssc_ledger_material_stock/", 'js', true);
                Com_IncludeFile("main_edit.js", "${LUI_ContextPath}/fssc/ledger/resource/js/", 'js', true);
                Com_IncludeFile("swf_attachment.js", "${KMSS_Parameter_ContextPath}sys/attachment/js/", "js", true);
            </script>
        </template:replace>

        <template:replace name="title">
            <c:choose>
                <c:when test="${fsscLedgerMaterialStockForm.method_GET == 'add' }">
                    <c:out value="${ lfn:message('operation.create') } - ${ lfn:message('fssc-ledger:table.fsscLedgerMaterialStock') }" />
                </c:when>
                <c:otherwise>
                    <c:out value="${fsscLedgerMaterialStockForm.fdModelName} - " />
                    <c:out value="${ lfn:message('fssc-ledger:table.fsscLedgerMaterialStock') }" />
                </c:otherwise>
            </c:choose>
        </template:replace>
        <template:replace name="toolbar">
            <ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="3">
                <c:choose>
                    <c:when test="${ fsscLedgerMaterialStockForm.method_GET == 'edit' }">
                        <ui:button text="${ lfn:message('button.update') }" onclick="if(validateDetail()){Com_Submit(document.fsscLedgerMaterialStockForm, 'update');}" />
                    </c:when>
                    <c:when test="${ fsscLedgerMaterialStockForm.method_GET == 'add' }">
                        <ui:button text="${ lfn:message('button.save') }" onclick="if(validateDetail()){Com_Submit(document.fsscLedgerMaterialStockForm, 'save');}" />
                    </c:when>
                </c:choose>

                <ui:button text="${ lfn:message('button.close') }" order="5" onclick="Com_CloseWindow();" />
            </ui:toolbar>
        </template:replace>
        <template:replace name="path">
            <ui:menu layout="sys.ui.menu.nav">
                <ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" />
                <ui:menu-item text="${ lfn:message('fssc-ledger:table.fsscLedgerMaterialStock') }" />
            </ui:menu>
        </template:replace>
        <template:replace name="content">
            <html:form action="/fssc/ledger/fssc_ledger_material_stock/fsscLedgerMaterialStock.do">

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
                                        <xform:text property="fdStockId" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerMaterialStock.fdModelId')}
                                </td>
                                <td width="16.6%">
                                    <%-- 域名Id--%>
                                    <div id="_xform_fdModelId" _xform_type="text">
                                        <xform:text property="fdModelId" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerMaterialStock.fdModelName')}
                                </td>
                                <td width="16.6%">
                                    <%-- 域名名称--%>
                                    <div id="_xform_fdModelName" _xform_type="text">
                                        <xform:text property="fdModelName" showStatus="edit" style="width:95%;" />
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
                                        <xform:datetime property="fdWarehousingDate" showStatus="edit" dateTimeType="date" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerMaterialStock.fdUnit')}
                                </td>
                                <td width="16.6%">
                                    <%-- 台--%>
                                    <div id="_xform_fdUnit" _xform_type="text">
                                        <xform:text property="fdUnit" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerMaterialStock.fdPrice')}
                                </td>
                                <td width="16.6%">
                                    <%-- 单价--%>
                                    <div id="_xform_fdPrice" _xform_type="text">
                                        <xform:text property="fdPrice" showStatus="edit" validators=" number" style="width:95%;" />
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
                                        <xform:text property="fdQuantity" showStatus="edit" validators=" digits" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerMaterialStock.fdModel')}
                                </td>
                                <td width="16.6%">
                                    <%-- 型号--%>
                                    <div id="_xform_fdModel" _xform_type="text">
                                        <xform:text property="fdModel" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerMaterialStock.fdUser')}
                                </td>
                                <td width="16.6%">
                                    <%-- 领用人--%>
                                    <div id="_xform_fdUserId" _xform_type="address">
                                        <xform:address propertyId="fdUserId" propertyName="fdUserName" orgType="ORG_TYPE_PERSON" showStatus="edit" style="width:95%;" />
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
                                        <xform:address propertyId="fdUserDeptId" propertyName="fdUserDeptName" orgType="ORG_TYPE_ORGORDEPT" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td colspan="4">
                                </td>
                            </tr>
                        </table>
                    </ui:content>
                </ui:tabpage>
                <html:hidden property="fdId" />


                <html:hidden property="method_GET" />
            </html:form>
        </template:replace>


    </template:include>