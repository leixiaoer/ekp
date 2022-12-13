<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>

<template:include ref="default.simple4list">
    <template:replace name="title">
        <c:out value="${ lfn:message('fssc-ledger:module.fssc.ledger') }-${ lfn:message('fssc-ledger:table.fsscLedgerInvoice') }" />
    </template:replace>
    <template:replace name="path">
        <ui:menu layout="sys.ui.menu.nav">
            <ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" href="/" target="_top" />
            <ui:menu-item text="${ lfn:message('fssc-ledger:table.fsscLedgerInvoice') }" />
        </ui:menu>
    </template:replace>
    <template:replace name="nav">
        <ui:combin ref="menu.nav.create">
            <ui:varParam name="title" value="${ lfn:message('fssc-ledger:table.fsscLedgerInvoice') }" />
            <ui:varParam name="button">
                [ {"text": "","href": "javascript:void(0);","icon": "/fssc/ledger/fssc_ledger_invoice/fsscLedgerInvoice.do"} ]
            </ui:varParam>
        </ui:combin>
        <div class="lui_list_nav_frame">
            <ui:accordionpanel>
                <c:if test="${param.j_iframe=='true'}">
                    <c:set var="j_iframe" value="?j_iframe=true" />
                </c:if>

                <ui:content title="${ lfn:message('list.search') }">
                    <ul class='lui_list_nav_list'>

                        <li><a href="javascript:void(0)" onclick="openQuery();LUI('criteria1').clearValue();">${ lfn:message('list.alldoc') }</a>
                        </li>
                    </ul>
                </ui:content>

                <ui:content title="${ lfn:message('list.otherOpt') }">
                    <ul class='lui_list_nav_list'>
                        <li><a href="${LUI_ContextPath}/sys/profile/index.jsp#app/ekp/fssc/ledger" target="_blank">${ lfn:message('list.manager') }</a>
                        </li>
                    </ul>
                </ui:content>
            </ui:accordionpanel>
        </div>
    </template:replace>
    <template:replace name="content">
        <div style="margin:5px 10px;">
            <!-- 筛选 -->
            <list:criteria id="criteria1">
                <list:cri-ref key="fdInvoiceNumber" ref="criterion.sys.docSubject" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdInvoiceNumber')}" />
                <list:cri-auto modelName="com.landray.kmss.fssc.ledger.model.FsscLedgerInvoice" property="fdInvoiceType" expand="true" />
                <list:cri-auto modelName="com.landray.kmss.fssc.ledger.model.FsscLedgerInvoice" property="fdInvoiceCode" expand="true" />
                <list:cri-auto modelName="com.landray.kmss.fssc.ledger.model.FsscLedgerInvoice" property="fdBillingDate" />
                <list:cri-auto modelName="com.landray.kmss.fssc.ledger.model.FsscLedgerInvoice" property="fdJym" />
                <list:cri-auto modelName="com.landray.kmss.fssc.ledger.model.FsscLedgerInvoice" property="fdTotalAmount" />
                <list:cri-auto modelName="com.landray.kmss.fssc.ledger.model.FsscLedgerInvoice" property="fdDeductible" />
                <list:cri-auto modelName="com.landray.kmss.fssc.ledger.model.FsscLedgerInvoice" property="fdCheckStatus" />
                <list:cri-auto modelName="com.landray.kmss.fssc.ledger.model.FsscLedgerInvoice" property="fdUseStatus" />
                <list:cri-auto modelName="com.landray.kmss.fssc.ledger.model.FsscLedgerInvoice" property="fdSource" />
                <list:cri-auto modelName="com.landray.kmss.fssc.ledger.model.FsscLedgerInvoice" property="fdDeductibleDate" />

            </list:criteria>
            <!-- 操作 -->
            <div class="lui_list_operation">

                <div style='color: #979797;float: left;padding-top:1px;'>
                    ${ lfn:message('list.orderType') }：
                </div>
                <div style="float:left">
                    <div style="display: inline-block;vertical-align: middle;">
                        <ui:toolbar layout="sys.ui.toolbar.sort" style="float:left">
                            <list:sort property="fsscLedgerInvoice.fdInvoiceNumber" text="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdInvoiceNumber')}" group="sort.list" />
                            <list:sort property="fsscLedgerInvoice.fdBillingDate" text="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdBillingDate')}" group="sort.list" />
                        </ui:toolbar>
                    </div>
                </div>
                <div style="float:left;">
                    <list:paging layout="sys.ui.paging.top" />
                </div>
                <div style="float:right">
                    <div style="display: inline-block;vertical-align: middle;">
                        <ui:toolbar count="3">

                            <kmss:auth requestURL="/fssc/ledger/fssc_ledger_invoice/fsscLedgerInvoice.do?method=add">
                                <!--add-->
                                <ui:button text="${lfn:message('button.add')}" onclick="addDoc('')" order="2" />
                            </kmss:auth>
                            <kmss:auth requestURL="/fssc/ledger/fssc_ledger_invoice/fsscLedgerInvoice.do?method=deleteall">
                                <c:set var="canDelete" value="true" />
                            </kmss:auth>
                            <!--deleteall-->
                            <ui:button text="${lfn:message('button.deleteall')}" onclick="deleteAllOfInvoice();" order="4" id="btnDelete" />
                            <ui:button id="addBatchPrint" text="${lfn:message('fssc-ledger:button.qrcodes')}" order="2" onclick="addBatchPrint();"></ui:button>
                            <kmss:auth requestURL="/sys/transport/sys_transport_export/SysTransportExport.do?method=listExport&fdModelName=com.landray.kmss.fssc.ledger.model.FsscLedgerInvoice">
                                <ui:button text="${lfn:message('button.export')}" id="export" onclick="listExport('${LUI_ContextPath}/sys/transport/sys_transport_export/SysTransportExport.do?method=listExport&fdModelName=com.landray.kmss.fssc.ledger.model.FsscLedgerInvoice')">
                                </ui:button>
                            </kmss:auth>
                        </ui:toolbar>
                    </div>
                </div>
            </div>
            <ui:fixed elem=".lui_list_operation" />
            <!-- 列表 -->
            <list:listview id="listview">
                <ui:source type="AjaxJson">
                    {url:appendQueryParameter('/fssc/ledger/fssc_ledger_invoice/fsscLedgerInvoice.do?method=data')}
                </ui:source>
                <!-- 列表视图 -->
                <list:colTable isDefault="false" rowHref="/fssc/ledger/fssc_ledger_invoice/fsscLedgerInvoice.do?method=view&fdId=!{fdId}" name="columntable">
                    <list:col-checkbox />
                    <list:col-serial/>
                    <list:col-auto props="" url="/sys/profile/listShow/sys_listShow/sysListShow.do?method=getSort&modelName=com.landray.kmss.fssc.ledger.model.FsscLedgerInvoice" /></list:colTable>
            </list:listview>
            <!-- 翻页 -->
            <list:paging />
        </div>
        <script>
            var listOption = {
                contextPath: '${LUI_ContextPath}',
                jPath: 'invoice',
                modelName: 'com.landray.kmss.fssc.ledger.model.FsscLedgerInvoice',
                templateName: '',
                basePath: '/fssc/ledger/fssc_ledger_invoice/fsscLedgerInvoice.do',
                canDelete: '${canDelete}',
                mode: '',
                templateService: '',
                templateAlert: '${lfn:message("fssc-ledger:treeModel.alert.templateAlert")}',
                customOpts: {

                    ____fork__: 0
                },
                lang: {
                    noSelect: '${lfn:message("page.noSelect")}',
                    comfirmDelete: '${lfn:message("page.comfirmDelete")}'
                }

            };
            Com_IncludeFile("list.js", "${LUI_ContextPath}/fssc/ledger/resource/js/", 'js', true);
        </script>
    </template:replace>
</template:include>