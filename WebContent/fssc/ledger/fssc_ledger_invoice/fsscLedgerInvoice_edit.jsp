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

                    'fdDetail': '${lfn:escapeJs(lfn:message("fssc-ledger:table.fsscLedgerDetail"))}'
                };

                var initData = {
                    contextPath: '${LUI_ContextPath}',
                };
                Com_IncludeFile("security.js");
                Com_IncludeFile("domain.js");
                Com_IncludeFile("form.js");
                Com_IncludeFile("form_option.js", "${LUI_ContextPath}/fssc/ledger/fssc_ledger_invoice/", 'js', true);
                Com_IncludeFile("main_edit.js", "${LUI_ContextPath}/fssc/ledger/resource/js/", 'js', true);
                Com_IncludeFile("swf_attachment.js", "${KMSS_Parameter_ContextPath}sys/attachment/js/", "js", true);
            </script>
        </template:replace>

        <template:replace name="title">
            <c:choose>
                <c:when test="${fsscLedgerInvoiceForm.method_GET == 'add' }">
                    <c:out value="${ lfn:message('operation.create') } - ${ lfn:message('fssc-ledger:table.fsscLedgerInvoice') }" />
                </c:when>
                <c:otherwise>
                    <c:out value="${fsscLedgerInvoiceForm.fdInvoiceNumber} - " />
                    <c:out value="${ lfn:message('fssc-ledger:table.fsscLedgerInvoice') }" />
                </c:otherwise>
            </c:choose>
        </template:replace>
        <template:replace name="toolbar">
            <ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="3">
                <c:choose>
                    <c:when test="${ fsscLedgerInvoiceForm.method_GET == 'edit' }">
                        <ui:button text="${ lfn:message('button.update') }" onclick="if(validateDetail()){Com_Submit(document.fsscLedgerInvoiceForm, 'update');}" />
                    </c:when>
                    <c:when test="${ fsscLedgerInvoiceForm.method_GET == 'add' }">
                        <ui:button text="${ lfn:message('button.save') }" onclick="if(validateDetail()){Com_Submit(document.fsscLedgerInvoiceForm, 'save');}" />
                    </c:when>
                </c:choose>

                <ui:button text="${ lfn:message('button.close') }" order="5" onclick="Com_CloseWindow();" />
            </ui:toolbar>
        </template:replace>
        <template:replace name="path">
            <ui:menu layout="sys.ui.menu.nav">
                <ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" />
                <ui:menu-item text="${ lfn:message('fssc-ledger:table.fsscLedgerInvoice') }" />
            </ui:menu>
        </template:replace>
        <template:replace name="content">
            <html:form action="/fssc/ledger/fssc_ledger_invoice/fsscLedgerInvoice.do">

                <ui:tabpage expand="false" var-navwidth="90%">
                    <ui:content title="${ lfn:message('fssc-ledger:py.JiBenXinXi') }" expand="true">
                        <table class="tb_simple" width="100%">
                            <tr>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdCycs')}
                                </td>
                                <td width="16.6%">
                                    <%-- 查验次数--%>
                                    <div id="_xform_fdCycs" _xform_type="text">
                                        <xform:text property="fdCycs" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdInvoiceCode')}
                                </td>
                                <td width="16.6%">
                                    <%-- 发票代码--%>
                                    <div id="_xform_fdInvoiceCode" _xform_type="text">
                                        <xform:text property="fdInvoiceCode" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdInvoiceNumber')}
                                </td>
                                <td width="16.6%">
                                    <%-- 发票号码--%>
                                    <div id="_xform_fdInvoiceNumber" _xform_type="text">
                                        <xform:text property="fdInvoiceNumber" showStatus="edit" style="width:95%;" />
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
                                        <xform:datetime property="fdBillingDate" showStatus="edit" dateTimeType="date" required="true" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdJqbm')}
                                </td>
                                <td width="16.6%">
                                    <%-- 机器编码--%>
                                    <div id="_xform_fdJqbm" _xform_type="text">
                                        <xform:text property="fdJqbm" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdPurchaserName')}
                                </td>
                                <td width="16.6%">
                                    <%-- 购方名称--%>
                                    <div id="_xform_fdPurchaserName" _xform_type="text">
                                        <xform:text property="fdPurchaserName" showStatus="edit" style="width:95%;" />
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
                                        <xform:text property="fdPurchaserTaxNo" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdGfdzdh')}
                                </td>
                                <td width="16.6%">
                                    <%-- 购方地址电话--%>
                                    <div id="_xform_fdGfdzdh" _xform_type="text">
                                        <xform:text property="fdGfdzdh" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdGfyhzh')}
                                </td>
                                <td width="16.6%">
                                    <%-- 购方银行账号--%>
                                    <div id="_xform_fdGfyhzh" _xform_type="text">
                                        <xform:text property="fdGfyhzh" showStatus="edit" style="width:95%;" />
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
                                        <xform:text property="fdSalesTaxName" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdSalesTaxNo')}
                                </td>
                                <td width="16.6%">
                                    <%-- 销方税号--%>
                                    <div id="_xform_fdSalesTaxNo" _xform_type="text">
                                        <xform:text property="fdSalesTaxNo" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdXfdzdh')}
                                </td>
                                <td width="16.6%">
                                    <%-- 销方地址电话--%>
                                    <div id="_xform_fdXfdzdh" _xform_type="text">
                                        <xform:text property="fdXfdzdh" showStatus="edit" style="width:95%;" />
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
                                        <xform:text property="fdXfyhzh" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdBz')}
                                </td>
                                <td width="16.6%">
                                    <%-- 备注--%>
                                    <div id="_xform_fdBz" _xform_type="text">
                                        <xform:text property="fdBz" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdInvoiceType')}
                                </td>
                                <td width="16.6%">
                                    <%-- 发票类型--%>
                                    <div id="_xform_fdInvoiceType" _xform_type="radio">
                                        <xform:select property="fdInvoiceType" htmlElementProperties="id='fdInvoiceType'" showStatus="edit">
                                            <xform:enumsDataSource enumsType="fssc_ledger_type" />
                                        </xform:select>
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
                                        <xform:text property="fdJym" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdZfbz')}
                                </td>
                                <td width="16.6%">
                                    <%-- 作废标志--%>
                                    <div id="_xform_fdZfbz" _xform_type="radio">
                                        <xform:radio property="fdZfbz" htmlElementProperties="id='fdZfbz'" showStatus="edit">
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
                                    	<c:choose>
											<c:when test="${not empty fsscLedgerInvoiceForm.fdTotalAmount}">
												<input type="text" value="<kmss:showNumber value="${fsscLedgerInvoiceForm.fdTotalAmount }" pattern="0.00"/>" name="fdTotalAmount" class="inputsgl" validate="number min(0)" style="width:95%;"/>
											</c:when>
											<c:when test="${empty fsscLedgerInvoiceForm.fdTotalAmount}">
												<input type="text" value="" name="fdTotalAmount" class="inputsgl" validate="number min(0)" style="width:95%;"/>
											</c:when>
										</c:choose>
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
                                      	<c:choose>
											<c:when test="${not empty fsscLedgerInvoiceForm.fdTotalTax}">
												<input type="text" value="<kmss:showNumber value="${fsscLedgerInvoiceForm.fdTotalTax }" pattern="0.00"/>" name="fdTotalTax" class="inputsgl" validate="number min(0)" style="width:95%;"/>
											</c:when>
											<c:when test="${empty fsscLedgerInvoiceForm.fdTotalTax}">
												<input type="text" value="" name="fdTotalTax" class="inputsgl" validate="number min(0)" style="width:95%;"/>
											</c:when>
										</c:choose>
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdIsAvailable')}
                                </td>
                                <td width="16.6%">
                                    <%-- 是否有效--%>
                                    <div id="_xform_fdIsAvailable" _xform_type="radio">
                                        <xform:radio property="fdIsAvailable" htmlElementProperties="id='fdIsAvailable'" showStatus="edit">
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
                                        <xform:textarea property="fdDesc" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdState')}
                                </td>
                                <td width="16.6%">
                                    <%-- 发票状态--%>
                                    <div id="_xform_fdState" _xform_type="radio">
                                        <xform:select property="fdState" htmlElementProperties="id='fdState'" showStatus="edit">
                                            <xform:enumsDataSource enumsType="fssc_ledger_invoice_status" />
                                        </xform:select>
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdDeductible')}
                                </td>
                                <td width="16.6%">
                                    <%-- 是否认证--%>
                                    <div id="_xform_fdDeductible" _xform_type="radio">
                                        <xform:radio property="fdDeductible" htmlElementProperties="id='fdDeductible'" showStatus="edit">
                                            <xform:enumsDataSource enumsType="fssc_ledger_invoice_deductible" />
                                        </xform:radio>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdIsBlockChain')}
                                </td>
                                <td width="16.6%">
                                    <%-- 是否区块链发票--%>
                                    <div id="_xform_fdIsBlockChain" _xform_type="radio">
                                        <xform:radio property="fdIsBlockChain" htmlElementProperties="id='fdIsBlockChain'" showStatus="edit">
                                            <xform:enumsDataSource enumsType="fssc_ledger_common_yesno" />
                                        </xform:radio>
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdIsElectronicMark')}
                                </td>
                                <td width="16.6%">
                                    <%-- 是否电子专票--%>
                                    <div id="_xform_fdIsElectronicMark" _xform_type="radio">
                                        <xform:radio property="fdIsElectronicMark" htmlElementProperties="id='fdIsElectronicMark'" showStatus="edit">
                                            <xform:enumsDataSource enumsType="fssc_ledger_common_yesno" />
                                        </xform:radio>
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdIsTransitMark')}
                                </td>
                                <td width="16.6%">
                                    <%-- 是否收费公路电子普通发票--%>
                                    <div id="_xform_fdIsTransitMark" _xform_type="radio">
                                        <xform:radio property="fdIsTransitMark" htmlElementProperties="id='fdIsTransitMark'" showStatus="edit">
                                            <xform:enumsDataSource enumsType="fssc_ledger_common_yesno" />
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
                                        <xform:datetime property="fdDeductibleDate" showStatus="edit" dateTimeType="date" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdModelId')}
                                </td>
                                <td width="16.6%">
                                    <%-- 数据id--%>
                                    <div id="_xform_fdModelId" _xform_type="text">
                                        <xform:text property="fdModelId" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdModelName')}
                                </td>
                                <td width="16.6%">
                                    <%-- 模块name--%>
                                    <div id="_xform_fdModelName" _xform_type="text">
                                        <xform:text property="fdModelName" showStatus="edit" style="width:95%;" />
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
                                    	<c:choose>
											<c:when test="${not empty fsscLedgerInvoiceForm.fdJshj}">
												<input type="text" value="<kmss:showNumber value="${fsscLedgerInvoiceForm.fdJshj }" pattern="0.00"/>" name="fdJshj" class="inputsgl" validate="number min(0)" style="width:95%;"/>
											</c:when>
											<c:when test="${empty fsscLedgerInvoiceForm.fdJshj}">
												<input type="text" value="" name="fdJshj" class="inputsgl" validate="number min(0)" style="width:95%;"/>
											</c:when>
										</c:choose>
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdSfz')}
                                </td>
                                <td width="16.6%">
                                    <%-- 身份证号码/组织机构代码--%>
                                    <div id="_xform_fdSfz" _xform_type="text">
                                        <xform:text property="fdSfz" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdCllx')}
                                </td>
                                <td width="16.6%">
                                    <%-- 车辆类型--%>
                                    <div id="_xform_fdCllx" _xform_type="text">
                                        <xform:text property="fdCllx" showStatus="edit" style="width:95%;" />
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
                                        <xform:text property="fdCpxh" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdCd')}
                                </td>
                                <td width="16.6%">
                                    <%-- 产地--%>
                                    <div id="_xform_fdCd" _xform_type="text">
                                        <xform:text property="fdCd" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdHgzh')}
                                </td>
                                <td width="16.6%">
                                    <%-- 合格证号--%>
                                    <div id="_xform_fdHgzh" _xform_type="text">
                                        <xform:text property="fdHgzh" showStatus="edit" style="width:95%;" />
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
                                        <xform:text property="fdSjdh" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdFdjhm')}
                                </td>
                                <td width="16.6%">
                                    <%-- 发动机号码--%>
                                    <div id="_xform_fdFdjhm" _xform_type="text">
                                        <xform:text property="fdFdjhm" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdClsbdh')}
                                </td>
                                <td width="16.6%">
                                    <%-- 车辆识别代号--%>
                                    <div id="_xform_fdClsbdh" _xform_type="text">
                                        <xform:text property="fdClsbdh" showStatus="edit" style="width:95%;" />
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
                                        <xform:text property="fdJkzmsh" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdDh')}
                                </td>
                                <td width="16.6%">
                                    <%-- 电话--%>
                                    <div id="_xform_fdDh" _xform_type="text">
                                        <xform:text property="fdDh" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdDz')}
                                </td>
                                <td width="16.6%">
                                    <%-- 地址--%>
                                    <div id="_xform_fdDz" _xform_type="text">
                                        <xform:text property="fdDz" showStatus="edit" style="width:95%;" />
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
                                        <xform:text property="fdKhyh" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdZh')}
                                </td>
                                <td width="16.6%">
                                    <%-- 账号--%>
                                    <div id="_xform_fdZh" _xform_type="text">
                                        <xform:text property="fdZh" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdZgswjg')}
                                </td>
                                <td width="16.6%">
                                    <%-- 主管税务机关代码--%>
                                    <div id="_xform_fdZgswjg" _xform_type="text">
                                        <xform:text property="fdZgswjg" showStatus="edit" style="width:95%;" />
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
                                        <xform:text property="fdZgswjgmc" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdWspzhm')}
                                </td>
                                <td width="16.6%">
                                    <%-- 完税凭证号码--%>
                                    <div id="_xform_fdWspzhm" _xform_type="text">
                                        <xform:text property="fdWspzhm" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdDw')}
                                </td>
                                <td width="16.6%">
                                    <%-- 吨位--%>
                                    <div id="_xform_fdDw" _xform_type="text">
                                        <xform:text property="fdDw" showStatus="edit" style="width:95%;" />
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
                                        <xform:text property="fdXcrs" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdSl')}
                                </td>
                                <td width="16.6%">
                                    <%-- 税率--%>
                                    <div id="_xform_fdSl" _xform_type="text">
                                        <xform:text property="fdSl" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdCyrsh')}
                                </td>
                                <td width="16.6%">
                                    <%-- 承运人税号--%>
                                    <div id="_xform_fdCyrsh" _xform_type="text">
                                        <xform:text property="fdCyrsh" showStatus="edit" style="width:95%;" />
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
                                        <xform:text property="fdSpf" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdSpfsh')}
                                </td>
                                <td width="16.6%">
                                    <%-- 实际受票方税号--%>
                                    <div id="_xform_fdSpfsh" _xform_type="text">
                                        <xform:text property="fdSpfsh" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdShr')}
                                </td>
                                <td width="16.6%">
                                    <%-- 收货人--%>
                                    <div id="_xform_fdShr" _xform_type="text">
                                        <xform:text property="fdShr" showStatus="edit" style="width:95%;" />
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
                                        <xform:text property="fdShrsh" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdFhr')}
                                </td>
                                <td width="16.6%">
                                    <%-- 发货人--%>
                                    <div id="_xform_fdFhr" _xform_type="text">
                                        <xform:text property="fdFhr" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdFhrsh')}
                                </td>
                                <td width="16.6%">
                                    <%-- 发货人税号--%>
                                    <div id="_xform_fdFhrsh" _xform_type="text">
                                        <xform:text property="fdFhrsh" showStatus="edit" style="width:95%;" />
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
                                        <xform:text property="fdYshwxx" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdQyd')}
                                </td>
                                <td width="16.6%">
                                    <%-- 起运地、经由、到达地--%>
                                    <div id="_xform_fdQyd" _xform_type="text">
                                        <xform:text property="fdQyd" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdCzch')}
                                </td>
                                <td width="16.6%">
                                    <%-- 车种车号--%>
                                    <div id="_xform_fdCzch" _xform_type="text">
                                        <xform:text property="fdCzch" showStatus="edit" style="width:95%;" />
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
                                        <xform:text property="fdZgswjgdm" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdGfdw')}
                                </td>
                                <td width="16.6%">
                                    <%-- 买方单位/个人--%>
                                    <div id="_xform_fdGfdw" _xform_type="text">
                                        <xform:text property="fdGfdw" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdGfdwdm')}
                                </td>
                                <td width="16.6%">
                                    <%-- 买方单位代码/身份证号码--%>
                                    <div id="_xform_fdGfdwdm" _xform_type="text">
                                        <xform:text property="fdGfdwdm" showStatus="edit" style="width:95%;" />
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
                                        <xform:text property="fdGfdwdz" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdGfdwdh')}
                                </td>
                                <td width="16.6%">
                                    <%-- 买方单位电话--%>
                                    <div id="_xform_fdGfdwdh" _xform_type="text">
                                        <xform:text property="fdGfdwdh" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdMfdw')}
                                </td>
                                <td width="16.6%">
                                    <%-- 卖方单位/个人--%>
                                    <div id="_xform_fdMfdw" _xform_type="text">
                                        <xform:text property="fdMfdw" showStatus="edit" style="width:95%;" />
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
                                        <xform:text property="fdMfdwdm" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdMfdwdz')}
                                </td>
                                <td width="16.6%">
                                    <%-- 卖方单位/个人地址--%>
                                    <div id="_xform_fdMfdwdz" _xform_type="text">
                                        <xform:text property="fdMfdwdz" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdMfdwdh')}
                                </td>
                                <td width="16.6%">
                                    <%-- 卖方单位电话--%>
                                    <div id="_xform_fdMfdwdh" _xform_type="text">
                                        <xform:text property="fdMfdwdh" showStatus="edit" style="width:95%;" />
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
                                        <xform:text property="fdCpzh" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdDjzh')}
                                </td>
                                <td width="16.6%">
                                    <%-- 登记证号--%>
                                    <div id="_xform_fdDjzh" _xform_type="text">
                                        <xform:text property="fdDjzh" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdCjh')}
                                </td>
                                <td width="16.6%">
                                    <%-- 车架号/车辆识别代码--%>
                                    <div id="_xform_fdCjh" _xform_type="text">
                                        <xform:text property="fdCjh" showStatus="edit" style="width:95%;" />
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
                                        <xform:text property="fdZrdclgls" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdCjhj')}
                                </td>
                                <td width="16.6%">
                                    <%-- 车价合计--%>
                                    <div id="_xform_fdCjhj" _xform_type="text">
                                        <xform:text property="fdCjhj" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdJydw')}
                                </td>
                                <td width="16.6%">
                                    <%-- 经营、拍卖单位--%>
                                    <div id="_xform_fdJydw" _xform_type="text">
                                        <xform:text property="fdJydw" showStatus="edit" style="width:95%;" />
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
                                        <xform:text property="fdJydwdz" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdJydwnsrsbh')}
                                </td>
                                <td width="16.6%">
                                    <%-- 经营、拍卖单位纳税人识别号--%>
                                    <div id="_xform_fdJydwnsrsbh" _xform_type="text">
                                        <xform:text property="fdJydwnsrsbh" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdJydwkhyhzh')}
                                </td>
                                <td width="16.6%">
                                    <%-- 经营、拍卖单位开户银行、账号--%>
                                    <div id="_xform_fdJydwkhyhzh" _xform_type="text">
                                        <xform:text property="fdJydwkhyhzh" showStatus="edit" style="width:95%;" />
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
                                        <xform:text property="fdJydwdh" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdEscsc')}
                                </td>
                                <td width="16.6%">
                                    <%-- 二手车市场--%>
                                    <div id="_xform_fdEscsc" _xform_type="text">
                                        <xform:text property="fdEscsc" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdEscnsrsbh')}
                                </td>
                                <td width="16.6%">
                                    <%-- 二手车市场纳税人识别号--%>
                                    <div id="_xform_fdEscnsrsbh" _xform_type="text">
                                        <xform:text property="fdEscnsrsbh" showStatus="edit" style="width:95%;" />
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
                                        <xform:text property="fdEscdz" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdEscdz')}
                                </td>
                                <td width="16.6%">
                                    <%-- 二手车市场地址--%>
                                    <div id="_xform_fdEscdz" _xform_type="text">
                                        <xform:text property="fdEscdz" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdEscdz')}
                                </td>
                                <td width="16.6%">
                                    <%-- 二手车市场地址--%>
                                    <div id="_xform_fdEscdz" _xform_type="text">
                                        <xform:text property="fdEscdz" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="td_normal_title" width="16.6%">
                                        ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdCompany')}
                                </td>
                                <td width="16.6%">
                                        <%-- 发票所属公司--%>
                                    <div id="_xform_fdCompany" _xform_type="text">
                                            <xform:dialog propertyId="fdCompanyId" propertyName="fdCompanyName" showStatus="edit" style="width:95%;">
                                                dialogSelect(false,'eop_basedata_company_fdCompany','fdCompanyId','fdCompanyName');
                                            </xform:dialog>
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
                                <td class="td_normal_title" colspan="6" width="100%">
                                    ${ lfn:message('fssc-ledger:py.FaPiaoMingXi') }
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6" width="100%">
                                    <table class="tb_normal" width="100%" id="TABLE_DocList_fdDetail_Form" align="center" tbdraggable="true">
                                        <tr align="center" class="tr_normal_title">
                                            <td style="width:20px;"></td>
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
                                            <td style="width:80px;">
                                            </td>
                                        </tr>
                                        <tr KMSS_IsReferRow="1" style="display:none;">
                                            <td align="center">
                                                <input type='checkbox' name='DocList_Selected' />
                                            </td>
                                            <td align="center" KMSS_IsRowIndex="1">
                                                !{index}
                                            </td>
                                            <td align="center">
                                                <%-- 序号--%>
                                                <input type="hidden" name="fdDetail_Form[!{index}].fdId" value="" disabled="true" />
                                                <div id="_xform_fdDetail_Form[!{index}].fdXh" _xform_type="text">
                                                    <xform:text property="fdDetail_Form[!{index}].fdXh" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdXh')}" validators=" maxLength(12)" style="width:95%;" />
                                                </div>
                                            </td>
                                            <td align="center">
                                                <%-- 商品名称--%>
                                                <div id="_xform_fdDetail_Form[!{index}].fdSpmc" _xform_type="text">
                                                    <xform:text property="fdDetail_Form[!{index}].fdSpmc" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdSpmc')}" validators=" maxLength(200)" style="width:95%;" />
                                                </div>
                                            </td>
                                            <td align="center">
                                                <%-- 规格型号--%>
                                                <div id="_xform_fdDetail_Form[!{index}].fdGgxh" _xform_type="text">
                                                    <xform:text property="fdDetail_Form[!{index}].fdGgxh" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdGgxh')}" validators=" maxLength(50)" style="width:95%;" />
                                                </div>
                                            </td>
                                            <td align="center">
                                                <%-- 计量单位--%>
                                                <div id="_xform_fdDetail_Form[!{index}].fdJldw" _xform_type="text">
                                                    <xform:text property="fdDetail_Form[!{index}].fdJldw" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdJldw')}" validators=" maxLength(20)" style="width:95%;" />
                                                </div>
                                            </td>
                                            <td align="center">
                                                <%-- 数量--%>
                                                <div id="_xform_fdDetail_Form[!{index}].fdSl" _xform_type="text">
                                                    <xform:text property="fdDetail_Form[!{index}].fdSl" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdSl')}" validators=" maxLength(20)" style="width:95%;" />
                                                </div>
                                            </td>
                                            <td align="center">
                                                <%-- 不含税单价--%>
                                                <div id="_xform_fdDetail_Form[!{index}].fdDj" _xform_type="text">
                                                    <xform:text property="fdDetail_Form[!{index}].fdDj" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdDj')}" validators=" maxLength(20)" style="width:95%;" />
                                                </div>
                                            </td>
                                            <td align="center">
                                                <%-- 金额--%>
                                                <div id="_xform_fdDetail_Form[!{index}].fdJe" _xform_type="text">
                                                    <xform:text property="fdDetail_Form[!{index}].fdJe" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdJe')}" validators=" maxLength(20)" style="width:95%;" />
                                                </div>
                                            </td>
                                            <td align="center">
                                                <%-- 税率--%>
                                                <div id="_xform_fdDetail_Form[!{index}].fdSlv" _xform_type="text">
                                                    <xform:text property="fdDetail_Form[!{index}].fdSlv" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdSlv')}" validators=" maxLength(10)" style="width:95%;" />
                                                </div>
                                            </td>
                                            <td align="center">
                                                <%-- 税额--%>
                                                <div id="_xform_fdDetail_Form[!{index}].fdSe" _xform_type="text">
                                                    <xform:text property="fdDetail_Form[!{index}].fdSe" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdSe')}" validators=" maxLength(20)" style="width:95%;" />
                                                </div>
                                            </td>
                                            <td align="center">
                                                <%-- 项目名称--%>
                                                <div id="_xform_fdDetail_Form[!{index}].fdXmmc" _xform_type="text">
                                                    <xform:text property="fdDetail_Form[!{index}].fdXmmc" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdXmmc')}" validators=" maxLength(200)" style="width:95%;" />
                                                </div>
                                            </td>
                                            <td align="center">
                                                <%-- 车牌号--%>
                                                <div id="_xform_fdDetail_Form[!{index}].fdCph" _xform_type="text">
                                                    <xform:text property="fdDetail_Form[!{index}].fdCph" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdCph')}" validators=" maxLength(50)" style="width:95%;" />
                                                </div>
                                            </td>
                                            <td align="center">
                                                <%-- 类型--%>
                                                <div id="_xform_fdDetail_Form[!{index}].fdLx" _xform_type="text">
                                                    <xform:text property="fdDetail_Form[!{index}].fdLx" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdLx')}" validators=" maxLength(20)" style="width:95%;" />
                                                </div>
                                            </td>
                                            <td align="center">
                                                <%-- 通行日期起--%>
                                                <div id="_xform_fdDetail_Form[!{index}].fdTxrqq" _xform_type="text">
                                                    <xform:text property="fdDetail_Form[!{index}].fdTxrqq" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdTxrqq')}" validators=" maxLength(20)" style="width:95%;" />
                                                </div>
                                            </td>
                                            <td align="center">
                                                <%-- 通行日期止--%>
                                                <div id="_xform_fdDetail_Form[!{index}].fdTxrqz" _xform_type="text">
                                                    <xform:text property="fdDetail_Form[!{index}].fdTxrqz" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdTxrqz')}" validators=" maxLength(20)" style="width:95%;" />
                                                </div>
                                            </td>
                                            <td align="center">
                                                <a href="javascript:void(0);" onclick="DocList_CopyRow();" title="${lfn:message('doclist.copy')}">
                                                    <img src="${KMSS_Parameter_StylePath}icons/icon_copy.png" border="0" />
                                                </a>
                                                &nbsp;
                                                <a href="javascript:void(0);" onclick="DocList_DeleteRow();" title="${lfn:message('doclist.delete')}">
                                                    <img src="${KMSS_Parameter_StylePath}icons/icon_del.png" border="0" />
                                                </a>
                                            </td>
                                        </tr>
                                        <c:forEach items="${fsscLedgerInvoiceForm.fdDetail_Form}" var="fdDetail_FormItem" varStatus="vstatus">
                                            <tr KMSS_IsContentRow="1">
                                                <td align="center">
                                                    <input type="checkbox" name="DocList_Selected" />
                                                </td>
                                                <td align="center">
                                                    ${vstatus.index+1}
                                                </td>
                                                <td align="center">
                                                    <%-- 序号--%>
                                                    <input type="hidden" name="fdDetail_Form[${vstatus.index}].fdId" value="${fdDetail_FormItem.fdId}" />
                                                    <div id="_xform_fdDetail_Form[${vstatus.index}].fdXh" _xform_type="text">
                                                        <xform:text property="fdDetail_Form[${vstatus.index}].fdXh" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdXh')}" validators=" maxLength(12)" style="width:95%;" />
                                                    </div>
                                                </td>
                                                <td align="center">
                                                    <%-- 商品名称--%>
                                                    <div id="_xform_fdDetail_Form[${vstatus.index}].fdSpmc" _xform_type="text">
                                                        <xform:text property="fdDetail_Form[${vstatus.index}].fdSpmc" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdSpmc')}" validators=" maxLength(200)" style="width:95%;" />
                                                    </div>
                                                </td>
                                                <td align="center">
                                                    <%-- 规格型号--%>
                                                    <div id="_xform_fdDetail_Form[${vstatus.index}].fdGgxh" _xform_type="text">
                                                        <xform:text property="fdDetail_Form[${vstatus.index}].fdGgxh" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdGgxh')}" validators=" maxLength(50)" style="width:95%;" />
                                                    </div>
                                                </td>
                                                <td align="center">
                                                    <%-- 计量单位--%>
                                                    <div id="_xform_fdDetail_Form[${vstatus.index}].fdJldw" _xform_type="text">
                                                        <xform:text property="fdDetail_Form[${vstatus.index}].fdJldw" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdJldw')}" validators=" maxLength(20)" style="width:95%;" />
                                                    </div>
                                                </td>
                                                <td align="center">
                                                    <%-- 数量--%>
                                                    <div id="_xform_fdDetail_Form[${vstatus.index}].fdSl" _xform_type="text">
                                                        <xform:text property="fdDetail_Form[${vstatus.index}].fdSl" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdSl')}" validators=" maxLength(20)" style="width:95%;" />
                                                    </div>
                                                </td>
                                                <td align="center">
                                                    <%-- 不含税单价--%>
                                                    <div id="_xform_fdDetail_Form[${vstatus.index}].fdDj" _xform_type="text">
                                                        <xform:text property="fdDetail_Form[${vstatus.index}].fdDj" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdDj')}" validators=" maxLength(20)" style="width:95%;" />
                                                    </div>
                                                </td>
                                                <td align="center">
                                                    <%-- 金额--%>
                                                    <div id="_xform_fdDetail_Form[${vstatus.index}].fdJe" _xform_type="text">
                                                        <xform:text property="fdDetail_Form[${vstatus.index}].fdJe" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdJe')}" validators=" maxLength(20)" style="width:95%;" />
                                                    </div>
                                                </td>
                                                <td align="center">
                                                    <%-- 税率--%>
                                                    <div id="_xform_fdDetail_Form[${vstatus.index}].fdSlv" _xform_type="text">
                                                        <xform:text property="fdDetail_Form[${vstatus.index}].fdSlv" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdSlv')}" validators=" maxLength(10)" style="width:95%;" />
                                                    </div>
                                                </td>
                                                <td align="center">
                                                    <%-- 税额--%>
                                                    <div id="_xform_fdDetail_Form[${vstatus.index}].fdSe" _xform_type="text">
                                                        <xform:text property="fdDetail_Form[${vstatus.index}].fdSe" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdSe')}" validators=" maxLength(20)" style="width:95%;" />
                                                    </div>
                                                </td>
                                                <td align="center">
                                                    <%-- 项目名称--%>
                                                    <div id="_xform_fdDetail_Form[${vstatus.index}].fdXmmc" _xform_type="text">
                                                        <xform:text property="fdDetail_Form[${vstatus.index}].fdXmmc" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdXmmc')}" validators=" maxLength(200)" style="width:95%;" />
                                                    </div>
                                                </td>
                                                <td align="center">
                                                    <%-- 车牌号--%>
                                                    <div id="_xform_fdDetail_Form[${vstatus.index}].fdCph" _xform_type="text">
                                                        <xform:text property="fdDetail_Form[${vstatus.index}].fdCph" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdCph')}" validators=" maxLength(50)" style="width:95%;" />
                                                    </div>
                                                </td>
                                                <td align="center">
                                                    <%-- 类型--%>
                                                    <div id="_xform_fdDetail_Form[${vstatus.index}].fdLx" _xform_type="text">
                                                        <xform:text property="fdDetail_Form[${vstatus.index}].fdLx" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdLx')}" validators=" maxLength(20)" style="width:95%;" />
                                                    </div>
                                                </td>
                                                <td align="center">
                                                    <%-- 通行日期起--%>
                                                    <div id="_xform_fdDetail_Form[${vstatus.index}].fdTxrqq" _xform_type="text">
                                                        <xform:text property="fdDetail_Form[${vstatus.index}].fdTxrqq" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdTxrqq')}" validators=" maxLength(20)" style="width:95%;" />
                                                    </div>
                                                </td>
                                                <td align="center">
                                                    <%-- 通行日期止--%>
                                                    <div id="_xform_fdDetail_Form[${vstatus.index}].fdTxrqz" _xform_type="text">
                                                        <xform:text property="fdDetail_Form[${vstatus.index}].fdTxrqz" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdTxrqz')}" validators=" maxLength(20)" style="width:95%;" />
                                                    </div>
                                                </td>
                                                <td align="center">
                                                    <a href="javascript:void(0);" onclick="DocList_CopyRow();" title="${lfn:message('doclist.copy')}">
                                                        <img src="${KMSS_Parameter_StylePath}icons/icon_copy.png" border="0" />
                                                    </a>
                                                    &nbsp;
                                                    <a href="javascript:void(0);" onclick="DocList_DeleteRow();" title="${lfn:message('doclist.delete')}">
                                                        <img src="${KMSS_Parameter_StylePath}icons/icon_del.png" border="0" />
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        <tr type="optRow" class="tr_normal_opt" invalidrow="true">
                                            <td colspan="17">
                                                <a href="javascript:void(0);" onclick="DocList_AddRow();">
                                                    <img src="${KMSS_Parameter_StylePath}icons/icon_add.png" border="0" />${lfn:message('doclist.add')}
                                                </a>
                                                &nbsp;
                                                <a href="javascript:void(0);" onclick="DocList_MoveRowBySelect(-1);">
                                                    <img src="${KMSS_Parameter_StylePath}icons/icon_up.png" border="0" />${lfn:message('doclist.moveup')}
                                                </a>
                                                &nbsp;
                                                <a href="javascript:void(0);" onclick="DocList_MoveRowBySelect(1);">
                                                    <img src="${KMSS_Parameter_StylePath}icons/icon_down.png" border="0" />${lfn:message('doclist.movedown')}
                                                </a>
                                                &nbsp;
                                            </td>
                                        </tr>
                                    </table>
                                    <input type="hidden" name="fdDetail_Flag" value="1">
                                    <script>
                                        Com_IncludeFile("doclist.js");
                                    </script>
                                    <script>
                                        DocList_Info.push('TABLE_DocList_fdDetail_Form');
                                    </script>
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