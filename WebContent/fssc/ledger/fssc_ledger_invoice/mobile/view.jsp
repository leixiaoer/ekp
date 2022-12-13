<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person" %>
<%@page import="com.landray.kmss.fssc.ledger.util.FsscLedgerUtil" %>
    
        <%
            pageContext.setAttribute("currentPost", UserUtil.getKMSSUser().getPostIds());
        pageContext.setAttribute("currentDept", UserUtil.getKMSSUser().getDeptId());
        if(UserUtil.getUser().getFdParentOrg() != null) {
            pageContext.setAttribute("currentOrg", UserUtil.getUser().getFdParentOrg().getFdId());
        } else {
            pageContext.setAttribute("currentOrg", "");
        } %>
    
    <template:include ref="mobile.view" compatibleMode="true">
        <template:replace name="title">
            <c:out value="${fsscLedgerInvoiceForm.fdInvoiceNumber} - " />
            <c:out value="${lfn:message('fssc-ledger:table.fsscLedgerInvoice') }" />
        </template:replace>
        <template:replace name="head">
            <style>
                .detailTips{
                				color: red;
                	    		font-weight: lighter;
                	    		display: inline-block;
                	    		font-size: 1rem;
                			}
                			.muiFormNoContent{
                				padding-left:1rem;
                				border-top:1px solid #ddd;
                				border-bottom: 1px solid #ddd;
                			}
                			.muiDocFrameExt{
                				margin-left: 0rem;
                			}
                			.muiDocFrameExt .muiDocInfo{
                				border: none;
                			}
            </style>
            <script type="text/javascript">
                var formInitData = {

                };
                var lang = {
                    "the": "${lfn:message('page.the')}",
                    "row": "${lfn:message('page.row')}"
                };
                var messageInfo = {

                    'fdDetail': '${lfn:escapeJs(lfn:message("fssc-ledger:table.fsscLedgerDetail"))}'
                };
                Com_IncludeFile("security.js");
                Com_IncludeFile("domain.js");
                Com_IncludeFile("mobile_edit.js", "${LUI_ContextPath}/fssc/ledger/resource/js/", 'js', true);
                Com_IncludeFile("form_option.js", "${LUI_ContextPath}/fssc/ledger/fssc_ledger_invoice/", 'js', true);
            </script>
        </template:replace>
        <template:replace name="content">
            <html:form action="/fssc/ledger/fssc_ledger_invoice/fsscLedgerInvoice.do">

                <div id="scrollView" data-dojo-type="mui/view/DocScrollableView" data-dojo-mixins="mui/form/_ValidateMixin">
                    <div data-dojo-type="mui/panel/AccordionPanel">
                        <div data-dojo-type="mui/panel/Content" data-dojo-props="title:'${lfn:message('fssc-ledger:py.JiBenXinXi') }',icon:'mui-ul'">
                            <div class="muiFormContent">
                                <div class="muiDocFrame muiDocFrameExt">
                                    <div class="muiDocSubject">
                                        ${lfn:message('fssc-ledger:table.fsscLedgerInvoice')}
                                    </div>
                                </div>
                                <table class="muiSimple" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdCycs')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdCycs" _xform_type="text">
                                                <xform:text property="fdCycs" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdInvoiceCode')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdInvoiceCode" _xform_type="text">
                                                <xform:text property="fdInvoiceCode" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdInvoiceNumber')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdInvoiceNumber" _xform_type="text">
                                                <xform:text property="fdInvoiceNumber" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdBillingDate')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdBillingDate" _xform_type="datetime">
                                                <xform:datetime property="fdBillingDate" showStatus="view" dateTimeType="date" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdJqbm')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdJqbm" _xform_type="text">
                                                <xform:text property="fdJqbm" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdPurchaserName')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdPurchaserName" _xform_type="text">
                                                <xform:text property="fdPurchaserName" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdPurchaserTaxNo')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdPurchaserTaxNo" _xform_type="text">
                                                <xform:text property="fdPurchaserTaxNo" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdGfdzdh')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdGfdzdh" _xform_type="text">
                                                <xform:text property="fdGfdzdh" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdGfyhzh')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdGfyhzh" _xform_type="text">
                                                <xform:text property="fdGfyhzh" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdSalesTaxName')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdSalesTaxName" _xform_type="text">
                                                <xform:text property="fdSalesTaxName" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdSalesTaxNo')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdSalesTaxNo" _xform_type="text">
                                                <xform:text property="fdSalesTaxNo" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdXfdzdh')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdXfdzdh" _xform_type="text">
                                                <xform:text property="fdXfdzdh" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdXfyhzh')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdXfyhzh" _xform_type="text">
                                                <xform:text property="fdXfyhzh" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdBz')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdBz" _xform_type="text">
                                                <xform:text property="fdBz" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdInvoiceType')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdInvoiceType" _xform_type="radio">
                                                <xform:radio property="fdInvoiceType" htmlElementProperties="id='fdInvoiceType'" showStatus="view" mobile="true">
                                                    <xform:enumsDataSource enumsType="fssc_ledger_type" />
                                                </xform:radio>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdJym')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdJym" _xform_type="text">
                                                <xform:text property="fdJym" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdZfbz')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdZfbz" _xform_type="radio">
                                                <xform:radio property="fdZfbz" htmlElementProperties="id='fdZfbz'" showStatus="view" mobile="true">
                                                    <xform:enumsDataSource enumsType="fssc_ledger_zfbz" />
                                                </xform:radio>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdTotalAmount')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdTotalAmount" _xform_type="text">
                                                <xform:text property="fdTotalAmount" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdTotalTax')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdTotalTax" _xform_type="text">
                                                <xform:text property="fdTotalTax" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdIsAvailable')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdIsAvailable" _xform_type="radio">
                                                <xform:radio property="fdIsAvailable" htmlElementProperties="id='fdIsAvailable'" showStatus="view" mobile="true">
                                                    <xform:enumsDataSource enumsType="common_yesno" />
                                                </xform:radio>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.docCreator')}
                                        </td>
                                        <td>
                                            <ui:person personId="${fsscLedgerInvoiceForm.docCreatorId}" personName="${fsscLedgerInvoiceForm.docCreatorName}" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.docAlteror')}
                                        </td>
                                        <td>
                                            <ui:person personId="${fsscLedgerInvoiceForm.docAlterorId}" personName="${fsscLedgerInvoiceForm.docAlterorName}" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.docCreateTime')}
                                        </td>
                                        <td>
                                            <c:out value="${fsscLedgerInvoiceForm.docCreateTime}"></c:out>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.docAlterTime')}
                                        </td>
                                        <td>
                                            <c:out value="${fsscLedgerInvoiceForm.docAlterTime}"></c:out>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdDesc')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdDesc" _xform_type="textarea">
                                                <xform:textarea property="fdDesc" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdState')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdState" _xform_type="radio">
                                                <xform:radio property="fdState" htmlElementProperties="id='fdState'" showStatus="view" mobile="true">
                                                    <xform:enumsDataSource enumsType="fssc_ledger_invoice_status" />
                                                </xform:radio>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdDeductible')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdDeductible" _xform_type="radio">
                                                <xform:radio property="fdDeductible" htmlElementProperties="id='fdDeductible'" showStatus="view" mobile="true">
                                                    <xform:enumsDataSource enumsType="fssc_ledger_invoice_deductible" />
                                                </xform:radio>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdDeductibleDate')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdDeductibleDate" _xform_type="datetime">
                                                <xform:datetime property="fdDeductibleDate" showStatus="view" dateTimeType="date" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdModelId')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdModelId" _xform_type="text">
                                                <xform:text property="fdModelId" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdModelName')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdModelName" _xform_type="text">
                                                <xform:text property="fdModelName" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdJshj')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdJshj" _xform_type="text">
                                                <xform:text property="fdJshj" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdSfz')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdSfz" _xform_type="text">
                                                <xform:text property="fdSfz" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdCllx')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdCllx" _xform_type="text">
                                                <xform:text property="fdCllx" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdCpxh')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdCpxh" _xform_type="text">
                                                <xform:text property="fdCpxh" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdCd')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdCd" _xform_type="text">
                                                <xform:text property="fdCd" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdHgzh')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdHgzh" _xform_type="text">
                                                <xform:text property="fdHgzh" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdSjdh')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdSjdh" _xform_type="text">
                                                <xform:text property="fdSjdh" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdFdjhm')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdFdjhm" _xform_type="text">
                                                <xform:text property="fdFdjhm" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdClsbdh')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdClsbdh" _xform_type="text">
                                                <xform:text property="fdClsbdh" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdJkzmsh')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdJkzmsh" _xform_type="text">
                                                <xform:text property="fdJkzmsh" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdDh')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdDh" _xform_type="text">
                                                <xform:text property="fdDh" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdDz')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdDz" _xform_type="text">
                                                <xform:text property="fdDz" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdKhyh')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdKhyh" _xform_type="text">
                                                <xform:text property="fdKhyh" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdZh')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdZh" _xform_type="text">
                                                <xform:text property="fdZh" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdZgswjg')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdZgswjg" _xform_type="text">
                                                <xform:text property="fdZgswjg" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdZgswjgmc')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdZgswjgmc" _xform_type="text">
                                                <xform:text property="fdZgswjgmc" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdWspzhm')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdWspzhm" _xform_type="text">
                                                <xform:text property="fdWspzhm" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdDw')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdDw" _xform_type="text">
                                                <xform:text property="fdDw" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdXcrs')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdXcrs" _xform_type="text">
                                                <xform:text property="fdXcrs" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdSl')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdSl" _xform_type="text">
                                                <xform:text property="fdSl" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdCyrsh')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdCyrsh" _xform_type="text">
                                                <xform:text property="fdCyrsh" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdSpf')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdSpf" _xform_type="text">
                                                <xform:text property="fdSpf" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdSpfsh')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdSpfsh" _xform_type="text">
                                                <xform:text property="fdSpfsh" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdShr')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdShr" _xform_type="text">
                                                <xform:text property="fdShr" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdShrsh')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdShrsh" _xform_type="text">
                                                <xform:text property="fdShrsh" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdFhr')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdFhr" _xform_type="text">
                                                <xform:text property="fdFhr" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdFhrsh')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdFhrsh" _xform_type="text">
                                                <xform:text property="fdFhrsh" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdYshwxx')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdYshwxx" _xform_type="text">
                                                <xform:text property="fdYshwxx" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdQyd')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdQyd" _xform_type="text">
                                                <xform:text property="fdQyd" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdCzch')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdCzch" _xform_type="text">
                                                <xform:text property="fdCzch" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdZgswjgdm')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdZgswjgdm" _xform_type="text">
                                                <xform:text property="fdZgswjgdm" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdGfdw')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdGfdw" _xform_type="text">
                                                <xform:text property="fdGfdw" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdGfdwdm')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdGfdwdm" _xform_type="text">
                                                <xform:text property="fdGfdwdm" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdGfdwdz')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdGfdwdz" _xform_type="text">
                                                <xform:text property="fdGfdwdz" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdGfdwdh')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdGfdwdh" _xform_type="text">
                                                <xform:text property="fdGfdwdh" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdMfdw')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdMfdw" _xform_type="text">
                                                <xform:text property="fdMfdw" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdMfdwdm')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdMfdwdm" _xform_type="text">
                                                <xform:text property="fdMfdwdm" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdMfdwdz')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdMfdwdz" _xform_type="text">
                                                <xform:text property="fdMfdwdz" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdMfdwdh')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdMfdwdh" _xform_type="text">
                                                <xform:text property="fdMfdwdh" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdCpzh')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdCpzh" _xform_type="text">
                                                <xform:text property="fdCpzh" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdDjzh')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdDjzh" _xform_type="text">
                                                <xform:text property="fdDjzh" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdCjh')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdCjh" _xform_type="text">
                                                <xform:text property="fdCjh" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdZrdclgls')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdZrdclgls" _xform_type="text">
                                                <xform:text property="fdZrdclgls" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdCjhj')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdCjhj" _xform_type="text">
                                                <xform:text property="fdCjhj" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdJydw')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdJydw" _xform_type="text">
                                                <xform:text property="fdJydw" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdJydwdz')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdJydwdz" _xform_type="text">
                                                <xform:text property="fdJydwdz" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdJydwnsrsbh')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdJydwnsrsbh" _xform_type="text">
                                                <xform:text property="fdJydwnsrsbh" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdJydwkhyhzh')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdJydwkhyhzh" _xform_type="text">
                                                <xform:text property="fdJydwkhyhzh" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdJydwdh')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdJydwdh" _xform_type="text">
                                                <xform:text property="fdJydwdh" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdEscsc')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdEscsc" _xform_type="text">
                                                <xform:text property="fdEscsc" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdEscnsrsbh')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdEscnsrsbh" _xform_type="text">
                                                <xform:text property="fdEscnsrsbh" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdEscdz')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdEscdz" _xform_type="text">
                                                <xform:text property="fdEscdz" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdEscdz')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdEscdz" _xform_type="text">
                                                <xform:text property="fdEscdz" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdEscdz')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdEscdz" _xform_type="text">
                                                <xform:text property="fdEscdz" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle" colspan="2">
                                            <div class="mblListItemLayoutLeft">
                                                ${lfn:message('fssc-ledger:table.fsscLedgerDetail')}
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <div class="detailTableContent">
                                                <table width="100%" border="0" cellspacing="0" cellpadding="0" id="TABLE_DocList_fdDetail_Form">
                                                    <tr style="display:none;">
                                                        <td></td>
                                                    </tr>
                                                    <c:forEach items="${fsscLedgerInvoiceForm.fdDetail_Form}" var="_xformEachBean" varStatus="vstatus">
                                                        <tr KMSS_IsContentRow="1">
                                                            <td class="detail_wrap_td">
                                                                <xform:text showStatus="noShow" property="fdDetail_Form[${vstatus.index}].fdId" />
                                                                <table class="muiSimple">
                                                                    <tr celltr-title="true" onclick="expandRow(this);">
                                                                        <td colspan="2" align="left" valign="middle" class="muiDetailTableNo">
                                                                            <div class="muiDetailDisplayOpt muiDetailDown"></div>
                                                                            <span>${lfn:message('page.the')}${vstatus.index+1}${ lfn:message('page.row') }</span>
                                                                        </td>
                                                                    </tr>
                                                                    <tr data-celltr="true">
                                                                        <td class="muiTitle">
                                                                            ${lfn:message('fssc-ledger:fsscLedgerDetail.fdXh')}
                                                                        </td>
                                                                        <td>

                                                                            <div id="_xform_fdDetail_Form[${vstatus.index}].fdXh" _xform_type="text">
                                                                                <xform:text property="fdDetail_Form[${vstatus.index}].fdXh" showStatus="view" mobile="true" style="width:95%;" />
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr data-celltr="true">
                                                                        <td class="muiTitle">
                                                                            ${lfn:message('fssc-ledger:fsscLedgerDetail.fdSpmc')}
                                                                        </td>
                                                                        <td>

                                                                            <div id="_xform_fdDetail_Form[${vstatus.index}].fdSpmc" _xform_type="text">
                                                                                <xform:text property="fdDetail_Form[${vstatus.index}].fdSpmc" showStatus="view" mobile="true" style="width:95%;" />
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr data-celltr="true">
                                                                        <td class="muiTitle">
                                                                            ${lfn:message('fssc-ledger:fsscLedgerDetail.fdGgxh')}
                                                                        </td>
                                                                        <td>

                                                                            <div id="_xform_fdDetail_Form[${vstatus.index}].fdGgxh" _xform_type="text">
                                                                                <xform:text property="fdDetail_Form[${vstatus.index}].fdGgxh" showStatus="view" mobile="true" style="width:95%;" />
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr data-celltr="true">
                                                                        <td class="muiTitle">
                                                                            ${lfn:message('fssc-ledger:fsscLedgerDetail.fdJldw')}
                                                                        </td>
                                                                        <td>

                                                                            <div id="_xform_fdDetail_Form[${vstatus.index}].fdJldw" _xform_type="text">
                                                                                <xform:text property="fdDetail_Form[${vstatus.index}].fdJldw" showStatus="view" mobile="true" style="width:95%;" />
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr data-celltr="true">
                                                                        <td class="muiTitle">
                                                                            ${lfn:message('fssc-ledger:fsscLedgerDetail.fdSl')}
                                                                        </td>
                                                                        <td>

                                                                            <div id="_xform_fdDetail_Form[${vstatus.index}].fdSl" _xform_type="text">
                                                                                <xform:text property="fdDetail_Form[${vstatus.index}].fdSl" showStatus="view" mobile="true" style="width:95%;" />
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr data-celltr="true">
                                                                        <td class="muiTitle">
                                                                            ${lfn:message('fssc-ledger:fsscLedgerDetail.fdDj')}
                                                                        </td>
                                                                        <td>

                                                                            <div id="_xform_fdDetail_Form[${vstatus.index}].fdDj" _xform_type="text">
                                                                                <xform:text property="fdDetail_Form[${vstatus.index}].fdDj" showStatus="view" mobile="true" style="width:95%;" />
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr data-celltr="true">
                                                                        <td class="muiTitle">
                                                                            ${lfn:message('fssc-ledger:fsscLedgerDetail.fdJe')}
                                                                        </td>
                                                                        <td>

                                                                            <div id="_xform_fdDetail_Form[${vstatus.index}].fdJe" _xform_type="text">
                                                                                <xform:text property="fdDetail_Form[${vstatus.index}].fdJe" showStatus="view" mobile="true" style="width:95%;" />
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr data-celltr="true">
                                                                        <td class="muiTitle">
                                                                            ${lfn:message('fssc-ledger:fsscLedgerDetail.fdSlv')}
                                                                        </td>
                                                                        <td>

                                                                            <div id="_xform_fdDetail_Form[${vstatus.index}].fdSlv" _xform_type="text">
                                                                                <xform:text property="fdDetail_Form[${vstatus.index}].fdSlv" showStatus="view" mobile="true" style="width:95%;" />
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr data-celltr="true">
                                                                        <td class="muiTitle">
                                                                            ${lfn:message('fssc-ledger:fsscLedgerDetail.fdSe')}
                                                                        </td>
                                                                        <td>

                                                                            <div id="_xform_fdDetail_Form[${vstatus.index}].fdSe" _xform_type="text">
                                                                                <xform:text property="fdDetail_Form[${vstatus.index}].fdSe" showStatus="view" mobile="true" style="width:95%;" />
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr data-celltr="true">
                                                                        <td class="muiTitle">
                                                                            ${lfn:message('fssc-ledger:fsscLedgerDetail.fdXmmc')}
                                                                        </td>
                                                                        <td>

                                                                            <div id="_xform_fdDetail_Form[${vstatus.index}].fdXmmc" _xform_type="text">
                                                                                <xform:text property="fdDetail_Form[${vstatus.index}].fdXmmc" showStatus="view" mobile="true" style="width:95%;" />
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr data-celltr="true">
                                                                        <td class="muiTitle">
                                                                            ${lfn:message('fssc-ledger:fsscLedgerDetail.fdCph')}
                                                                        </td>
                                                                        <td>

                                                                            <div id="_xform_fdDetail_Form[${vstatus.index}].fdCph" _xform_type="text">
                                                                                <xform:text property="fdDetail_Form[${vstatus.index}].fdCph" showStatus="view" mobile="true" style="width:95%;" />
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr data-celltr="true">
                                                                        <td class="muiTitle">
                                                                            ${lfn:message('fssc-ledger:fsscLedgerDetail.fdLx')}
                                                                        </td>
                                                                        <td>

                                                                            <div id="_xform_fdDetail_Form[${vstatus.index}].fdLx" _xform_type="text">
                                                                                <xform:text property="fdDetail_Form[${vstatus.index}].fdLx" showStatus="view" mobile="true" style="width:95%;" />
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr data-celltr="true">
                                                                        <td class="muiTitle">
                                                                            ${lfn:message('fssc-ledger:fsscLedgerDetail.fdTxrqq')}
                                                                        </td>
                                                                        <td>

                                                                            <div id="_xform_fdDetail_Form[${vstatus.index}].fdTxrqq" _xform_type="text">
                                                                                <xform:text property="fdDetail_Form[${vstatus.index}].fdTxrqq" showStatus="view" mobile="true" style="width:95%;" />
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr data-celltr="true">
                                                                        <td class="muiTitle">
                                                                            ${lfn:message('fssc-ledger:fsscLedgerDetail.fdTxrqz')}
                                                                        </td>
                                                                        <td>

                                                                            <div id="_xform_fdDetail_Form[${vstatus.index}].fdTxrqz" _xform_type="text">
                                                                                <xform:text property="fdDetail_Form[${vstatus.index}].fdTxrqz" showStatus="view" mobile="true" style="width:95%;" />
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                    <ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom" data-dojo-props='fill:"grid"'>

                        <kmss:auth requestURL="/fssc/ledger/fssc_ledger_invoice/fsscLedgerInvoice.do?method=edit&fdId=${param.fdId}">
                            <div data-dojo-type="mui/tabbar/TabBarButton" data-dojo-props="icon1:'',label:'${lfn:message('button.edit') }',align:'',href:'/fssc/ledger/fssc_ledger_invoice/fsscLedgerInvoice.do?method=edit&fdId=${param.fdId}'"></div>
                        </kmss:auth>
                    </ul>
                </div>

                <script type="text/javascript">
                    require(["mui/form/ajax-form!fsscLedgerInvoiceForm"]);
                </script>
            </html:form>
        </template:replace>
    </template:include>