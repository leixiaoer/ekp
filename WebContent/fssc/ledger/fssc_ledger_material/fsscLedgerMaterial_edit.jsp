<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@page import="com.landray.kmss.fssc.ledger.util.FsscLedgerUtil" %>
    
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
                Com_IncludeFile("form_option.js", "${LUI_ContextPath}/fssc/ledger/fssc_ledger_material/", 'js', true);
                Com_IncludeFile("main_edit.js", "${LUI_ContextPath}/fssc/ledger/resource/js/", 'js', true);
                Com_IncludeFile("swf_attachment.js", "${KMSS_Parameter_ContextPath}sys/attachment/js/", "js", true);
                Com_IncludeFile("fsscLedgerMaterial.js", "${LUI_ContextPath}/fssc/ledger/fssc_ledger_material/", "js", true);
            </script>
        </template:replace>

        <template:replace name="title">
            <c:choose>
                <c:when test="${fsscLedgerMaterialForm.method_GET == 'add' }">
                    <c:out value="${ lfn:message('operation.create') } - ${ lfn:message('fssc-ledger:table.fsscLedgerMaterial') }" />
                </c:when>
                <c:otherwise>
                    <c:out value="${fsscLedgerMaterialForm.fdCode} - " />
                    <c:out value="${ lfn:message('fssc-ledger:table.fsscLedgerMaterial') }" />
                </c:otherwise>
            </c:choose>
        </template:replace>
        <template:replace name="toolbar">
            <ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="3">
                <c:choose>
                    <c:when test="${ fsscLedgerMaterialForm.method_GET == 'edit' }">
                        <ui:button text="${ lfn:message('button.update') }" onclick="if(validateDetail()){Com_Submit(document.fsscLedgerMaterialForm, 'update');}" />
                    </c:when>
                    <c:when test="${ fsscLedgerMaterialForm.method_GET == 'add' }">
                        <ui:button text="${ lfn:message('button.save') }" onclick="if(validateDetail()){Com_Submit(document.fsscLedgerMaterialForm, 'save');}" />
                    </c:when>
                </c:choose>

                <ui:button text="${ lfn:message('button.close') }" order="5" onclick="Com_CloseWindow();" />
            </ui:toolbar>
        </template:replace>
        <template:replace name="path">
            <ui:menu layout="sys.ui.menu.nav">
                <ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" />
                <ui:menu-item text="${ lfn:message('fssc-ledger:table.fsscLedgerMaterial') }" />
            </ui:menu>
        </template:replace>
        <template:replace name="content">
            <html:form action="/fssc/ledger/fssc_ledger_material/fsscLedgerMaterial.do">

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
                                        <xform:dialog propertyId="fdMaterialId" propertyName="fdMaterialName" showStatus="edit" style="width:95%;">
                                            selectMateriak();
                                        </xform:dialog>
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerMaterial.fdCode')}
                                </td>
                                <td width="16.6%">
                                    <%-- 物资编码--%>
                                    <div id="_xform_fdCode" _xform_type="text">
                                        <xform:text property="fdCode" showStatus="readOnly" style="width:95%;color:#333;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerMaterial.fdType')}
                                </td>
                                <td width="16.6%">
                                    <%-- 物资类别--%>
                                    <div id="_xform_fdTypeId" _xform_type="dialog">
                                        <xform:dialog propertyId="fdTypeId" propertyName="fdTypeName" showStatus="readOnly" style="width:95%;color:#333;">
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
                                        <xform:radio property="fdIsInventory" htmlElementProperties="id='fdIsInventory'" showStatus="edit">
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
                                        <xform:select property="fdStatus" htmlElementProperties="id='fdStatus'" showStatus="readOnly">
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
                                        <xform:text property="fdStock" showStatus="edit" validators=" number" style="width:95%;" />
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
                                        <xform:text property="fdUnit" showStatus="readOnly" style="width:95%;color:#333;" />
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
                                        <xform:textarea property="fdDesc" showStatus="edit" style="width:95%;" />
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
                                        <xform:address propertyId="fdPurchaseId" propertyName="fdPurchaseName" orgType="ORG_TYPE_PERSON" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerMaterial.fdPurchaseDept')}
                                </td>
                                <td width="16.6%">
                                    <%-- 采购人部门--%>
                                    <div id="_xform_fdPurchaseDeptId" _xform_type="address">
                                        <xform:address propertyId="fdPurchaseDeptId" propertyName="fdPurchaseDeptName" orgType="ORG_TYPE_ORGORDEPT" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerMaterial.fdPhone')}
                                </td>
                                <td width="16.6%">
                                    <%-- 电话--%>
                                    <div id="_xform_fdPhone" _xform_type="text">
                                        <xform:text property="fdPhone" showStatus="edit" style="width:95%;" />
                                    </div>
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