<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>

<template:include ref="default.list">
    <template:replace name="title">
        <c:out value="${ lfn:message('fssc-ledger:module.fssc.ledger') }-${ lfn:message('fssc-ledger:table.fsscLedgerCredit') }" />
    </template:replace>
    <template:replace name="path">
        <ui:menu layout="sys.ui.menu.nav">
            <ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" href="/" target="_top" />
            <ui:menu-item text="${ lfn:message('fssc-ledger:table.fsscLedgerCredit') }" />
        </ui:menu>
    </template:replace>
    <template:replace name="nav">
        <ui:combin ref="menu.nav.create">
            <ui:varParam name="title" value="${ lfn:message('fssc-ledger:table.fsscLedgerCredit') }" />
            <ui:varParam name="button">
                [ {"text": "","href": "javascript:void(0);","icon": "/fssc/ledger/fssc_ledger_credit/fsscLedgerCredit.do"} ]
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
                        <li><a href="${LUI_ContextPath}/fssc/ledger/fssc_ledger_invoice/index.jsp${j_iframe}">${lfn:message('fssc-ledger:table.fsscLedgerInvoice')}</a>
                        </li>
                        <li><a href="${LUI_ContextPath}/fssc/ledger/fssc_ledger_material/index.jsp${j_iframe}">${lfn:message('fssc-ledger:table.fsscLedgerMaterial')}</a>
                        </li>
                        <li><a href="${LUI_ContextPath}/fssc/ledger/fssc_ledger_material_stock/index.jsp${j_iframe}">${lfn:message('fssc-ledger:table.fsscLedgerMaterialStock')}</a>
                        </li>
                        <li><a href="${LUI_ContextPath}/fssc/ledger/fssc_ledger_contract/index.jsp${j_iframe}">${lfn:message('fssc-ledger:table.fsscLedgerContract')}</a>
                        </li>
                        <li><a href="${LUI_ContextPath}/sys/profile/index.jsp#app/ekp/fssc/ledger" target="_blank">${ lfn:message('list.manager') }</a>
                        </li>
                    </ul>
                </ui:content>
            </ui:accordionpanel>
        </div>
    </template:replace>
    <template:replace name="content">
        <div style="margin:5px 10px;">
            <!-- ?????? -->
            <list:criteria id="criteria1">
                <list:cri-auto modelName="com.landray.kmss.fssc.ledger.model.FsscLedgerCredit" property="fdPerson" />
                <list:cri-auto modelName="com.landray.kmss.fssc.ledger.model.FsscLedgerCredit" property="fdCreditNo" />

            </list:criteria>
            <!-- ?????? -->
            <div class="lui_list_operation">

                <div style='color: #979797;float: left;padding-top:1px;'>
                    ${ lfn:message('list.orderType') }???
                </div>
                <div style="float:left">
                    <div style="display: inline-block;vertical-align: middle;">
                        <ui:toolbar layout="sys.ui.toolbar.sort" style="float:left">
                            <list:sort property="fsscLedgerCredit.fdCreditNo" text="${lfn:message('fssc-ledger:fsscLedgerCredit.fdCreditNo')}" group="sort.list" />
                        </ui:toolbar>
                    </div>
                </div>
                <div style="float:left;">
                    <list:paging layout="sys.ui.paging.top" />
                </div>
                <div style="float:right">
                    <div style="display: inline-block;vertical-align: middle;">
                        <ui:toolbar count="3">

                            <kmss:auth requestURL="/fssc/ledger/fssc_ledger_credit/fsscLedgerCredit.do?method=add">
                                <ui:button text="${lfn:message('button.add')}" onclick="addDoc()" order="2" />
                            </kmss:auth>
                            <kmss:auth requestURL="/fssc/ledger/fssc_ledger_credit/fsscLedgerCredit.do?method=deleteall">
                                <c:set var="canDelete" value="true" />
                            </kmss:auth>
                            <!---->
                            <ui:button text="${lfn:message('button.deleteall')}" onclick="deleteAll()" order="4" id="btnDelete" />
                            <kmss:auth requestURL="/sys/transport/sys_transport_export/SysTransportExport.do?method=listExport&fdModelName=com.landray.kmss.fssc.ledger.model.FsscLedgerCredit">
                                <ui:button text="${lfn:message('button.export')}" id="export" onclick="listExport('${LUI_ContextPath}/sys/transport/sys_transport_export/SysTransportExport.do?method=listExport&fdModelName=com.landray.kmss.fssc.ledger.model.FsscLedgerCredit')">
                                </ui:button>
                            </kmss:auth>
                        </ui:toolbar>
                    </div>
                </div>
            </div>
            <ui:fixed elem=".lui_list_operation" />
            <!-- ?????? -->
            <list:listview id="listview">
                <ui:source type="AjaxJson">
                    {url:appendQueryParameter('/fssc/ledger/fssc_ledger_credit/fsscLedgerCredit.do?method=data')}
                </ui:source>
                <!-- ???????????? -->
                <list:colTable isDefault="false" rowHref="/fssc/ledger/fssc_ledger_credit/fsscLedgerCredit.do?method=view&fdId=!{fdId}" name="columntable">
                    <list:col-checkbox />
                    <list:col-serial/>
                    <list:col-auto props="" url="/sys/profile/listShow/sys_listShow/sysListShow.do?method=getSort&modelName=com.landray.kmss.fssc.ledger.model.FsscLedgerCredit" /></list:colTable>
            </list:listview>
            <!-- ?????? -->
            <list:paging />
        </div>
        <script>
            var listOption = {
                contextPath: '${LUI_ContextPath}',
                jPath: 'credit',
                modelName: 'com.landray.kmss.fssc.ledger.model.FsscLedgerCredit',
                templateName: '',
                basePath: '/fssc/ledger/fssc_ledger_credit/fsscLedgerCredit.do',
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