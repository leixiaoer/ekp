<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>

<template:include ref="default.simple4list">
    <template:replace name="title">
        <c:out value="${ lfn:message('fssc-ledger:module.fssc.ledger') }-${ lfn:message('fssc-ledger:table.fsscLedgerContract') }" />
    </template:replace>
    <template:replace name="path">
        <ui:menu layout="sys.ui.menu.nav">
            <ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" href="/" target="_top" />
            <ui:menu-item text="${ lfn:message('fssc-ledger:table.fsscLedgerContract') }" />
        </ui:menu>
    </template:replace>
    <template:replace name="nav">
        <ui:combin ref="menu.nav.create">
            <ui:varParam name="title" value="${ lfn:message('fssc-ledger:table.fsscLedgerContract') }" />
            <ui:varParam name="button">
                [ {"text": "","href": "javascript:void(0);","icon": "/fssc/ledger/fssc_ledger_contract/fsscLedgerContract.do"} ]
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
            </ui:accordionpanel>
        </div>
    </template:replace>
    <template:replace name="content">
        <div style="margin:5px 10px;">
            <!-- 筛选 -->
            <list:criteria id="criteria1">
                <list:cri-ref key="fdContractName" ref="criterion.sys.docSubject" title="${lfn:message('fssc-ledger:fsscLedgerContract.fdContractName')}" />
                <list:cri-auto modelName="com.landray.kmss.fssc.ledger.model.FsscLedgerContract" property="fdContractCode" expand="true" />
                <list:cri-criterion title="${lfn:message('fssc-ledger:fsscLedgerContract.fdSupplier')}" key="fdSupplier.fdName">
                    <list:box-select>
                        <list:item-select type="lui/criteria/criterion_input!TextInput">
                            <ui:source type="Static">
                                [{placeholder:'${lfn:message('fssc-ledger:fsscLedgerContract.fdSupplier')}'}]
                            </ui:source>
                        </list:item-select>
                    </list:box-select>
                </list:cri-criterion>
                <list:cri-auto modelName="com.landray.kmss.fssc.ledger.model.FsscLedgerContract" property="fdSignDate" />
                <list:cri-auto modelName="com.landray.kmss.fssc.ledger.model.FsscLedgerContract" property="fdContractType" />
            </list:criteria>
            
            <!-- 操作 -->
            <div class="lui_list_operation">

                <div style="float:left;">
                    <list:paging layout="sys.ui.paging.top" />
                </div>
                <div style="float:right">
                    <div style="display: inline-block;vertical-align: middle;">
                        <ui:toolbar count="9">

                            <kmss:auth requestURL="/fssc/ledger/fssc_ledger_contract/fsscLedgerContract.do?method=add">
                                <ui:button text="${lfn:message('button.add')}" onclick="addDoc()" order="2" />
                            </kmss:auth>
                            <kmss:auth requestURL="/fssc/ledger/fssc_ledger_contract/fsscLedgerContract.do?method=deleteall">
                                <c:set var="canDelete" value="true" />
                            </kmss:auth>
                            <!---->
                            <ui:button text="${lfn:message('button.deleteall')}" onclick="deleteAll()" order="4" id="btnDelete" />
                            <kmss:auth requestURL="/fssc/ledger/fssc_ledger_contract/fsscLedgerContract.do?method=add">
								<ui:button text="${lfn:message('fssc-base:button.exportTemplate') }" onclick="downloadTemp()"></ui:button>
								<ui:button text="${lfn:message('button.import') }" onclick="importLedgerContract()"></ui:button>
								<ui:button text="${lfn:message('button.export') }" onclick="exportLedgerContract()"></ui:button>
							</kmss:auth>
                        </ui:toolbar>
                    </div>
                </div>
            </div>
            <ui:fixed elem=".lui_list_operation" />
            <!-- 列表 -->
            <list:listview id="listview">
                <ui:source type="AjaxJson">
                    {url:appendQueryParameter('/fssc/ledger/fssc_ledger_contract/fsscLedgerContract.do?method=data&q.j_path=contract')}
                </ui:source>
                <!-- 列表视图 -->
                <list:colTable isDefault="false" rowHref="/fssc/ledger/fssc_ledger_contract/fsscLedgerContract.do?method=view&fdId=!{fdId}" name="columntable">
                    <list:col-checkbox />
                    <list:col-serial/>
                    <list:col-auto  />
                </list:colTable>
            </list:listview>
            <!-- 翻页 -->
            <list:paging />
        </div>
        <script>
            var listOption = {
                contextPath: '${LUI_ContextPath}',
                jPath: 'contract',
                modelName: 'com.landray.kmss.fssc.ledger.model.FsscLedgerContract',
                templateName: '',
                basePath: '/fssc/ledger/fssc_ledger_contract/fsscLedgerContract.do',
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
        	Com_IncludeFile("index.js", "${LUI_ContextPath}/fssc/ledger/fssc_ledger_contract/", 'js', true);
        </script>
    </template:replace>
</template:include>