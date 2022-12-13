<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@ include file="/sys/mobile/jsp/ajax-accept.jsp" %>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person" %>
<%@page import="com.landray.kmss.fssc.ledger.util.FsscLedgerUtil" %>
    
        <% pageContext.setAttribute("currentUser", UserUtil.getKMSSUser());
        pageContext.setAttribute("currentPost", UserUtil.getKMSSUser().getPostIds());
        pageContext.setAttribute("currentDept", UserUtil.getKMSSUser().getDeptId());
        if(UserUtil.getUser().getFdParentOrg() != null) {
            pageContext.setAttribute("currentOrg", UserUtil.getUser().getFdParentOrg().getFdId());
        } else {
            pageContext.setAttribute("currentOrg", "");
        } %>
    
    <template:include ref="mobile.edit" compatibleMode="true">
        <template:replace name="title">
            <c:choose>
                <c:when test="${fsscLedgerInvoiceForm.method_GET == 'add' }">
                    <c:out value="${ lfn:message('operation.create') } - ${ lfn:message('fssc-ledger:table.fsscLedgerInvoice') }" />
                </c:when>
                <c:otherwise>
                    <c:out value="${fsscLedgerInvoiceForm.fdInvoiceNumber} - " />
                    <c:out value="${lfn:message('fssc-ledger:table.fsscLedgerInvoice') }" />
                </c:otherwise>
            </c:choose>
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

                var initData = {
                    contextPath: '${LUI_ContextPath}',
                };
                Com_IncludeFile("security.js");
                Com_IncludeFile("domain.js");
                Com_IncludeFile("form_option.js", "${LUI_ContextPath}/fssc/ledger/fssc_ledger_invoice/", 'js', true);
                Com_IncludeFile("mobile_edit.js", "${LUI_ContextPath}/fssc/ledger/resource/js/", 'js', true);
            </script>
        </template:replace>
        <template:replace name="content">
            <html:form action="/fssc/ledger/fssc_ledger_invoice/fsscLedgerInvoice.do?method=save">

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
                                                <xform:text property="fdCycs" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdInvoiceCode')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdInvoiceCode" _xform_type="text">
                                                <xform:text property="fdInvoiceCode" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdInvoiceNumber')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdInvoiceNumber" _xform_type="text">
                                                <xform:text property="fdInvoiceNumber" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdBillingDate')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdBillingDate" _xform_type="datetime">
                                                <xform:datetime property="fdBillingDate" showStatus="edit" dateTimeType="date" required="true" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdJqbm')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdJqbm" _xform_type="text">
                                                <xform:text property="fdJqbm" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdPurchaserName')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdPurchaserName" _xform_type="text">
                                                <xform:text property="fdPurchaserName" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdPurchaserTaxNo')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdPurchaserTaxNo" _xform_type="text">
                                                <xform:text property="fdPurchaserTaxNo" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdGfdzdh')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdGfdzdh" _xform_type="text">
                                                <xform:text property="fdGfdzdh" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdGfyhzh')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdGfyhzh" _xform_type="text">
                                                <xform:text property="fdGfyhzh" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdSalesTaxName')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdSalesTaxName" _xform_type="text">
                                                <xform:text property="fdSalesTaxName" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdSalesTaxNo')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdSalesTaxNo" _xform_type="text">
                                                <xform:text property="fdSalesTaxNo" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdXfdzdh')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdXfdzdh" _xform_type="text">
                                                <xform:text property="fdXfdzdh" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdXfyhzh')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdXfyhzh" _xform_type="text">
                                                <xform:text property="fdXfyhzh" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdBz')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdBz" _xform_type="text">
                                                <xform:text property="fdBz" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdInvoiceType')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdInvoiceType" _xform_type="radio">
                                                <xform:radio property="fdInvoiceType" htmlElementProperties="id='fdInvoiceType'" showStatus="edit" mobile="true">
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
                                                <xform:text property="fdJym" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdZfbz')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdZfbz" _xform_type="radio">
                                                <xform:radio property="fdZfbz" htmlElementProperties="id='fdZfbz'" showStatus="edit" mobile="true">
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
                                                <xform:text property="fdTotalAmount" showStatus="edit" validators=" number min(0)" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdTotalTax')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdTotalTax" _xform_type="text">
                                                <xform:text property="fdTotalTax" showStatus="edit" validators=" number min(0)" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdIsAvailable')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdIsAvailable" _xform_type="radio">
                                                <xform:radio property="fdIsAvailable" htmlElementProperties="id='fdIsAvailable'" showStatus="edit" mobile="true">
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
                                            <div id="_xform_docCreatorId" _xform_type="address">
                                                <ui:person personId="${fsscLedgerInvoiceForm.docCreatorId}" personName="${fsscLedgerInvoiceForm.docCreatorName}" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.docAlteror')}
                                        </td>
                                        <td>
                                            <div id="_xform_docAlterorId" _xform_type="address">
                                                <ui:person personId="${fsscLedgerInvoiceForm.docAlterorId}" personName="${fsscLedgerInvoiceForm.docAlterorName}" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.docCreateTime')}
                                        </td>
                                        <td>
                                            <div id="_xform_docCreateTime" _xform_type="datetime">
                                                <xform:datetime property="docCreateTime" showStatus="view" dateTimeType="datetime" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.docAlterTime')}
                                        </td>
                                        <td>
                                            <div id="_xform_docAlterTime" _xform_type="datetime">
                                                <xform:datetime property="docAlterTime" showStatus="view" dateTimeType="datetime" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdDesc')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdDesc" _xform_type="textarea">
                                                <xform:textarea property="fdDesc" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdState')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdState" _xform_type="radio">
                                                <xform:radio property="fdState" htmlElementProperties="id='fdState'" showStatus="edit" mobile="true">
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
                                                <xform:radio property="fdDeductible" htmlElementProperties="id='fdDeductible'" showStatus="edit" mobile="true">
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
                                                <xform:datetime property="fdDeductibleDate" showStatus="edit" dateTimeType="date" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdModelId')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdModelId" _xform_type="text">
                                                <xform:text property="fdModelId" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdModelName')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdModelName" _xform_type="text">
                                                <xform:text property="fdModelName" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdJshj')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdJshj" _xform_type="text">
                                                <xform:text property="fdJshj" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdSfz')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdSfz" _xform_type="text">
                                                <xform:text property="fdSfz" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdCllx')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdCllx" _xform_type="text">
                                                <xform:text property="fdCllx" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdCpxh')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdCpxh" _xform_type="text">
                                                <xform:text property="fdCpxh" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdCd')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdCd" _xform_type="text">
                                                <xform:text property="fdCd" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdHgzh')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdHgzh" _xform_type="text">
                                                <xform:text property="fdHgzh" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdSjdh')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdSjdh" _xform_type="text">
                                                <xform:text property="fdSjdh" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdFdjhm')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdFdjhm" _xform_type="text">
                                                <xform:text property="fdFdjhm" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdClsbdh')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdClsbdh" _xform_type="text">
                                                <xform:text property="fdClsbdh" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdJkzmsh')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdJkzmsh" _xform_type="text">
                                                <xform:text property="fdJkzmsh" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdDh')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdDh" _xform_type="text">
                                                <xform:text property="fdDh" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdDz')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdDz" _xform_type="text">
                                                <xform:text property="fdDz" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdKhyh')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdKhyh" _xform_type="text">
                                                <xform:text property="fdKhyh" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdZh')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdZh" _xform_type="text">
                                                <xform:text property="fdZh" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdZgswjg')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdZgswjg" _xform_type="text">
                                                <xform:text property="fdZgswjg" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdZgswjgmc')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdZgswjgmc" _xform_type="text">
                                                <xform:text property="fdZgswjgmc" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdWspzhm')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdWspzhm" _xform_type="text">
                                                <xform:text property="fdWspzhm" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdDw')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdDw" _xform_type="text">
                                                <xform:text property="fdDw" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdXcrs')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdXcrs" _xform_type="text">
                                                <xform:text property="fdXcrs" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdSl')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdSl" _xform_type="text">
                                                <xform:text property="fdSl" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdCyrsh')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdCyrsh" _xform_type="text">
                                                <xform:text property="fdCyrsh" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdSpf')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdSpf" _xform_type="text">
                                                <xform:text property="fdSpf" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdSpfsh')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdSpfsh" _xform_type="text">
                                                <xform:text property="fdSpfsh" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdShr')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdShr" _xform_type="text">
                                                <xform:text property="fdShr" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdShrsh')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdShrsh" _xform_type="text">
                                                <xform:text property="fdShrsh" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdFhr')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdFhr" _xform_type="text">
                                                <xform:text property="fdFhr" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdFhrsh')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdFhrsh" _xform_type="text">
                                                <xform:text property="fdFhrsh" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdYshwxx')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdYshwxx" _xform_type="text">
                                                <xform:text property="fdYshwxx" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdQyd')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdQyd" _xform_type="text">
                                                <xform:text property="fdQyd" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdCzch')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdCzch" _xform_type="text">
                                                <xform:text property="fdCzch" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdZgswjgdm')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdZgswjgdm" _xform_type="text">
                                                <xform:text property="fdZgswjgdm" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdGfdw')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdGfdw" _xform_type="text">
                                                <xform:text property="fdGfdw" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdGfdwdm')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdGfdwdm" _xform_type="text">
                                                <xform:text property="fdGfdwdm" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdGfdwdz')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdGfdwdz" _xform_type="text">
                                                <xform:text property="fdGfdwdz" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdGfdwdh')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdGfdwdh" _xform_type="text">
                                                <xform:text property="fdGfdwdh" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdMfdw')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdMfdw" _xform_type="text">
                                                <xform:text property="fdMfdw" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdMfdwdm')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdMfdwdm" _xform_type="text">
                                                <xform:text property="fdMfdwdm" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdMfdwdz')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdMfdwdz" _xform_type="text">
                                                <xform:text property="fdMfdwdz" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdMfdwdh')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdMfdwdh" _xform_type="text">
                                                <xform:text property="fdMfdwdh" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdCpzh')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdCpzh" _xform_type="text">
                                                <xform:text property="fdCpzh" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdDjzh')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdDjzh" _xform_type="text">
                                                <xform:text property="fdDjzh" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdCjh')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdCjh" _xform_type="text">
                                                <xform:text property="fdCjh" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdZrdclgls')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdZrdclgls" _xform_type="text">
                                                <xform:text property="fdZrdclgls" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdCjhj')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdCjhj" _xform_type="text">
                                                <xform:text property="fdCjhj" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdJydw')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdJydw" _xform_type="text">
                                                <xform:text property="fdJydw" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdJydwdz')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdJydwdz" _xform_type="text">
                                                <xform:text property="fdJydwdz" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdJydwnsrsbh')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdJydwnsrsbh" _xform_type="text">
                                                <xform:text property="fdJydwnsrsbh" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdJydwkhyhzh')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdJydwkhyhzh" _xform_type="text">
                                                <xform:text property="fdJydwkhyhzh" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdJydwdh')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdJydwdh" _xform_type="text">
                                                <xform:text property="fdJydwdh" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdEscsc')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdEscsc" _xform_type="text">
                                                <xform:text property="fdEscsc" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdEscnsrsbh')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdEscnsrsbh" _xform_type="text">
                                                <xform:text property="fdEscnsrsbh" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdEscdz')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdEscdz" _xform_type="text">
                                                <xform:text property="fdEscdz" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdEscdz')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdEscdz" _xform_type="text">
                                                <xform:text property="fdEscdz" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-ledger:fsscLedgerInvoice.fdEscdz')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdEscdz" _xform_type="text">
                                                <xform:text property="fdEscdz" showStatus="edit" mobile="true" style="width:95%;" />
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
                                                    <tr data-dojo-type="mui/form/Template" KMSS_IsReferRow="1" style="display:none;" border='0'>
                                                        <td class="detail_wrap_td">
                                                            <xform:text showStatus="noShow" property="fdDetail_Form[!{index}].fdId" />
                                                            <table class="muiSimple">
                                                                <tr celltr-title="true" onclick="expandRow(this);">
                                                                    <td colspan="2" align="left" valign="middle" class="muiDetailTableNo">
                                                                        <div class="muiDetailDisplayOpt muiDetailDown"></div>
                                                                        <span>${lfn:message('page.the')}!{index}${ lfn:message('page.row') }</span>
                                                                        <div class="muiDetailTableDel" onclick="delRowExpand('TABLE_DocList_fdDetail_Form',this);">
                                                                            <bean:message key="button.delete" />
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr data-celltr="true">
                                                                    <td class="muiTitle">
                                                                        ${lfn:message('fssc-ledger:fsscLedgerDetail.fdXh')}
                                                                    </td>
                                                                    <td>

                                                                        <div id="_xform_fdDetail_Form[!{index}].fdXh" _xform_type="text">
                                                                            <xform:text property="fdDetail_Form[!{index}].fdXh" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdXh')}" validators=" maxLength(12)" mobile="true" style="width:95%;" />
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr data-celltr="true">
                                                                    <td class="muiTitle">
                                                                        ${lfn:message('fssc-ledger:fsscLedgerDetail.fdSpmc')}
                                                                    </td>
                                                                    <td>

                                                                        <div id="_xform_fdDetail_Form[!{index}].fdSpmc" _xform_type="text">
                                                                            <xform:text property="fdDetail_Form[!{index}].fdSpmc" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdSpmc')}" validators=" maxLength(200)" mobile="true" style="width:95%;" />
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr data-celltr="true">
                                                                    <td class="muiTitle">
                                                                        ${lfn:message('fssc-ledger:fsscLedgerDetail.fdGgxh')}
                                                                    </td>
                                                                    <td>

                                                                        <div id="_xform_fdDetail_Form[!{index}].fdGgxh" _xform_type="text">
                                                                            <xform:text property="fdDetail_Form[!{index}].fdGgxh" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdGgxh')}" validators=" maxLength(50)" mobile="true" style="width:95%;" />
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr data-celltr="true">
                                                                    <td class="muiTitle">
                                                                        ${lfn:message('fssc-ledger:fsscLedgerDetail.fdJldw')}
                                                                    </td>
                                                                    <td>

                                                                        <div id="_xform_fdDetail_Form[!{index}].fdJldw" _xform_type="text">
                                                                            <xform:text property="fdDetail_Form[!{index}].fdJldw" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdJldw')}" validators=" maxLength(20)" mobile="true" style="width:95%;" />
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr data-celltr="true">
                                                                    <td class="muiTitle">
                                                                        ${lfn:message('fssc-ledger:fsscLedgerDetail.fdSl')}
                                                                    </td>
                                                                    <td>

                                                                        <div id="_xform_fdDetail_Form[!{index}].fdSl" _xform_type="text">
                                                                            <xform:text property="fdDetail_Form[!{index}].fdSl" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdSl')}" validators=" maxLength(20)" mobile="true" style="width:95%;" />
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr data-celltr="true">
                                                                    <td class="muiTitle">
                                                                        ${lfn:message('fssc-ledger:fsscLedgerDetail.fdDj')}
                                                                    </td>
                                                                    <td>

                                                                        <div id="_xform_fdDetail_Form[!{index}].fdDj" _xform_type="text">
                                                                            <xform:text property="fdDetail_Form[!{index}].fdDj" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdDj')}" validators=" maxLength(20)" mobile="true" style="width:95%;" />
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr data-celltr="true">
                                                                    <td class="muiTitle">
                                                                        ${lfn:message('fssc-ledger:fsscLedgerDetail.fdJe')}
                                                                    </td>
                                                                    <td>

                                                                        <div id="_xform_fdDetail_Form[!{index}].fdJe" _xform_type="text">
                                                                            <xform:text property="fdDetail_Form[!{index}].fdJe" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdJe')}" validators=" maxLength(20)" mobile="true" style="width:95%;" />
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr data-celltr="true">
                                                                    <td class="muiTitle">
                                                                        ${lfn:message('fssc-ledger:fsscLedgerDetail.fdSlv')}
                                                                    </td>
                                                                    <td>

                                                                        <div id="_xform_fdDetail_Form[!{index}].fdSlv" _xform_type="text">
                                                                            <xform:text property="fdDetail_Form[!{index}].fdSlv" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdSlv')}" validators=" maxLength(10)" mobile="true" style="width:95%;" />
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr data-celltr="true">
                                                                    <td class="muiTitle">
                                                                        ${lfn:message('fssc-ledger:fsscLedgerDetail.fdSe')}
                                                                    </td>
                                                                    <td>

                                                                        <div id="_xform_fdDetail_Form[!{index}].fdSe" _xform_type="text">
                                                                            <xform:text property="fdDetail_Form[!{index}].fdSe" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdSe')}" validators=" maxLength(20)" mobile="true" style="width:95%;" />
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr data-celltr="true">
                                                                    <td class="muiTitle">
                                                                        ${lfn:message('fssc-ledger:fsscLedgerDetail.fdXmmc')}
                                                                    </td>
                                                                    <td>

                                                                        <div id="_xform_fdDetail_Form[!{index}].fdXmmc" _xform_type="text">
                                                                            <xform:text property="fdDetail_Form[!{index}].fdXmmc" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdXmmc')}" validators=" maxLength(200)" mobile="true" style="width:95%;" />
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr data-celltr="true">
                                                                    <td class="muiTitle">
                                                                        ${lfn:message('fssc-ledger:fsscLedgerDetail.fdCph')}
                                                                    </td>
                                                                    <td>

                                                                        <div id="_xform_fdDetail_Form[!{index}].fdCph" _xform_type="text">
                                                                            <xform:text property="fdDetail_Form[!{index}].fdCph" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdCph')}" validators=" maxLength(50)" mobile="true" style="width:95%;" />
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr data-celltr="true">
                                                                    <td class="muiTitle">
                                                                        ${lfn:message('fssc-ledger:fsscLedgerDetail.fdLx')}
                                                                    </td>
                                                                    <td>

                                                                        <div id="_xform_fdDetail_Form[!{index}].fdLx" _xform_type="text">
                                                                            <xform:text property="fdDetail_Form[!{index}].fdLx" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdLx')}" validators=" maxLength(20)" mobile="true" style="width:95%;" />
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr data-celltr="true">
                                                                    <td class="muiTitle">
                                                                        ${lfn:message('fssc-ledger:fsscLedgerDetail.fdTxrqq')}
                                                                    </td>
                                                                    <td>

                                                                        <div id="_xform_fdDetail_Form[!{index}].fdTxrqq" _xform_type="text">
                                                                            <xform:text property="fdDetail_Form[!{index}].fdTxrqq" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdTxrqq')}" validators=" maxLength(20)" mobile="true" style="width:95%;" />
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr data-celltr="true">
                                                                    <td class="muiTitle">
                                                                        ${lfn:message('fssc-ledger:fsscLedgerDetail.fdTxrqz')}
                                                                    </td>
                                                                    <td>

                                                                        <div id="_xform_fdDetail_Form[!{index}].fdTxrqz" _xform_type="text">
                                                                            <xform:text property="fdDetail_Form[!{index}].fdTxrqz" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdTxrqz')}" validators=" maxLength(20)" mobile="true" style="width:95%;" />
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <c:forEach items="${fsscLedgerInvoiceForm.fdDetail_Form}" var="_xformEachBean" varStatus="vstatus">
                                                        <tr KMSS_IsContentRow="1">
                                                            <td class="detail_wrap_td">
                                                                <xform:text showStatus="noShow" property="fdDetail_Form[${vstatus.index}].fdId" />
                                                                <table class="muiSimple">
                                                                    <tr celltr-title="true" onclick="expandRow(this);">
                                                                        <td colspan="2" align="left" valign="middle" class="muiDetailTableNo">
                                                                            <div class="muiDetailDisplayOpt muiDetailDown"></div>
                                                                            <span>${lfn:message('page.the')}${vstatus.index}${ lfn:message('page.row') }</span>
                                                                            <div class="muiDetailTableDel" onclick="delRowExpand('TABLE_DocList_fdDetail_Form',this);">
                                                                                <bean:message key="button.delete" />
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr data-celltr="true">
                                                                        <td class="muiTitle">
                                                                            ${lfn:message('fssc-ledger:fsscLedgerDetail.fdXh')}
                                                                        </td>
                                                                        <td>

                                                                            <div id="_xform_fdDetail_Form[${vstatus.index}].fdXh" _xform_type="text">
                                                                                <xform:text property="fdDetail_Form[${vstatus.index}].fdXh" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdXh')}" validators=" maxLength(12)" mobile="true" style="width:95%;" />
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr data-celltr="true">
                                                                        <td class="muiTitle">
                                                                            ${lfn:message('fssc-ledger:fsscLedgerDetail.fdSpmc')}
                                                                        </td>
                                                                        <td>

                                                                            <div id="_xform_fdDetail_Form[${vstatus.index}].fdSpmc" _xform_type="text">
                                                                                <xform:text property="fdDetail_Form[${vstatus.index}].fdSpmc" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdSpmc')}" validators=" maxLength(200)" mobile="true" style="width:95%;" />
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr data-celltr="true">
                                                                        <td class="muiTitle">
                                                                            ${lfn:message('fssc-ledger:fsscLedgerDetail.fdGgxh')}
                                                                        </td>
                                                                        <td>

                                                                            <div id="_xform_fdDetail_Form[${vstatus.index}].fdGgxh" _xform_type="text">
                                                                                <xform:text property="fdDetail_Form[${vstatus.index}].fdGgxh" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdGgxh')}" validators=" maxLength(50)" mobile="true" style="width:95%;" />
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr data-celltr="true">
                                                                        <td class="muiTitle">
                                                                            ${lfn:message('fssc-ledger:fsscLedgerDetail.fdJldw')}
                                                                        </td>
                                                                        <td>

                                                                            <div id="_xform_fdDetail_Form[${vstatus.index}].fdJldw" _xform_type="text">
                                                                                <xform:text property="fdDetail_Form[${vstatus.index}].fdJldw" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdJldw')}" validators=" maxLength(20)" mobile="true" style="width:95%;" />
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr data-celltr="true">
                                                                        <td class="muiTitle">
                                                                            ${lfn:message('fssc-ledger:fsscLedgerDetail.fdSl')}
                                                                        </td>
                                                                        <td>

                                                                            <div id="_xform_fdDetail_Form[${vstatus.index}].fdSl" _xform_type="text">
                                                                                <xform:text property="fdDetail_Form[${vstatus.index}].fdSl" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdSl')}" validators=" maxLength(20)" mobile="true" style="width:95%;" />
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr data-celltr="true">
                                                                        <td class="muiTitle">
                                                                            ${lfn:message('fssc-ledger:fsscLedgerDetail.fdDj')}
                                                                        </td>
                                                                        <td>

                                                                            <div id="_xform_fdDetail_Form[${vstatus.index}].fdDj" _xform_type="text">
                                                                                <xform:text property="fdDetail_Form[${vstatus.index}].fdDj" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdDj')}" validators=" maxLength(20)" mobile="true" style="width:95%;" />
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr data-celltr="true">
                                                                        <td class="muiTitle">
                                                                            ${lfn:message('fssc-ledger:fsscLedgerDetail.fdJe')}
                                                                        </td>
                                                                        <td>

                                                                            <div id="_xform_fdDetail_Form[${vstatus.index}].fdJe" _xform_type="text">
                                                                                <xform:text property="fdDetail_Form[${vstatus.index}].fdJe" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdJe')}" validators=" maxLength(20)" mobile="true" style="width:95%;" />
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr data-celltr="true">
                                                                        <td class="muiTitle">
                                                                            ${lfn:message('fssc-ledger:fsscLedgerDetail.fdSlv')}
                                                                        </td>
                                                                        <td>

                                                                            <div id="_xform_fdDetail_Form[${vstatus.index}].fdSlv" _xform_type="text">
                                                                                <xform:text property="fdDetail_Form[${vstatus.index}].fdSlv" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdSlv')}" validators=" maxLength(10)" mobile="true" style="width:95%;" />
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr data-celltr="true">
                                                                        <td class="muiTitle">
                                                                            ${lfn:message('fssc-ledger:fsscLedgerDetail.fdSe')}
                                                                        </td>
                                                                        <td>

                                                                            <div id="_xform_fdDetail_Form[${vstatus.index}].fdSe" _xform_type="text">
                                                                                <xform:text property="fdDetail_Form[${vstatus.index}].fdSe" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdSe')}" validators=" maxLength(20)" mobile="true" style="width:95%;" />
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr data-celltr="true">
                                                                        <td class="muiTitle">
                                                                            ${lfn:message('fssc-ledger:fsscLedgerDetail.fdXmmc')}
                                                                        </td>
                                                                        <td>

                                                                            <div id="_xform_fdDetail_Form[${vstatus.index}].fdXmmc" _xform_type="text">
                                                                                <xform:text property="fdDetail_Form[${vstatus.index}].fdXmmc" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdXmmc')}" validators=" maxLength(200)" mobile="true" style="width:95%;" />
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr data-celltr="true">
                                                                        <td class="muiTitle">
                                                                            ${lfn:message('fssc-ledger:fsscLedgerDetail.fdCph')}
                                                                        </td>
                                                                        <td>

                                                                            <div id="_xform_fdDetail_Form[${vstatus.index}].fdCph" _xform_type="text">
                                                                                <xform:text property="fdDetail_Form[${vstatus.index}].fdCph" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdCph')}" validators=" maxLength(50)" mobile="true" style="width:95%;" />
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr data-celltr="true">
                                                                        <td class="muiTitle">
                                                                            ${lfn:message('fssc-ledger:fsscLedgerDetail.fdLx')}
                                                                        </td>
                                                                        <td>

                                                                            <div id="_xform_fdDetail_Form[${vstatus.index}].fdLx" _xform_type="text">
                                                                                <xform:text property="fdDetail_Form[${vstatus.index}].fdLx" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdLx')}" validators=" maxLength(20)" mobile="true" style="width:95%;" />
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr data-celltr="true">
                                                                        <td class="muiTitle">
                                                                            ${lfn:message('fssc-ledger:fsscLedgerDetail.fdTxrqq')}
                                                                        </td>
                                                                        <td>

                                                                            <div id="_xform_fdDetail_Form[${vstatus.index}].fdTxrqq" _xform_type="text">
                                                                                <xform:text property="fdDetail_Form[${vstatus.index}].fdTxrqq" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdTxrqq')}" validators=" maxLength(20)" mobile="true" style="width:95%;" />
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr data-celltr="true">
                                                                        <td class="muiTitle">
                                                                            ${lfn:message('fssc-ledger:fsscLedgerDetail.fdTxrqz')}
                                                                        </td>
                                                                        <td>

                                                                            <div id="_xform_fdDetail_Form[${vstatus.index}].fdTxrqz" _xform_type="text">
                                                                                <xform:text property="fdDetail_Form[${vstatus.index}].fdTxrqz" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerDetail.fdTxrqz')}" validators=" maxLength(20)" mobile="true" style="width:95%;" />
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </table>
                                            </div>
                                            <div data-dojo-type="sys/xform/mobile/controls/DetailTableAddButton" onclick="window.addRowExpand('TABLE_DocList_fdDetail_Form')">
                                                ${lfn:message('doclist.add')}(${lfn:message('fssc-ledger:table.fsscLedgerDetail')})
                                            </div>
                                            <script type="text/javascript">
                                                Com_IncludeFile('doclist.js');
                                            </script>
                                            <script type="text/javascript">
                                                DocList_Info.push('TABLE_DocList_fdDetail_Form');
                                            </script>
                                            <input type="hidden" name="fdDetail_Flag" value="1" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                    <ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom" data-dojo-props='fill:"grid"'>
                        <li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtnNext " data-dojo-props="colSize:2,onClick:function(){submitFormValidate();}">
                            <bean:message key="button.submit" />
                        </li>
                    </ul>
                </div>
                <html:hidden property="fdId" />
                <html:hidden property="method_GET" />


            </html:form>
        </template:replace>
    </template:include>