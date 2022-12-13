<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>

<template:include ref="default.simple4list">
    <template:replace name="title">
        <c:out value="${ lfn:message('fssc-ledger:module.fssc.ledger') }-${ lfn:message('fssc-ledger:table.fsscLedgerMaterial') }" />
    </template:replace>
    <template:replace name="path">
        <ui:menu layout="sys.ui.menu.nav">
            <ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" href="/" target="_top" />
            <ui:menu-item text="${ lfn:message('fssc-ledger:table.fsscLedgerMaterial') }" />
        </ui:menu>
    </template:replace>
    <template:replace name="nav">
        <ui:combin ref="menu.nav.create">
            <ui:varParam name="title" value="${ lfn:message('fssc-ledger:table.fsscLedgerMaterial') }" />
            <ui:varParam name="button">
                [ {"text": "","href": "javascript:void(0);","icon": "/fssc/ledger/fssc_ledger_material/fsscLedgerMaterial.do"} ]
            </ui:varParam>
        </ui:combin>
        <div class="lui_list_nav_frame">
            <ui:accordionpanel>
                <c:if test="${param.j_iframe=='true'}">
                    <c:set var="j_iframe" value="?j_iframe=true" />
                </c:if>

                <ui:content title="${ lfn:message('fssc-ledger:py.ChangYongChaXun') }">
                    <ul class='lui_list_nav_list'>
                    </ul>
                </ui:content>
            </ui:accordionpanel>
        </div>
    </template:replace>
    <template:replace name="content">
        <div style="margin:5px 10px;">
            <!-- 筛选 -->
            <list:criteria id="criteria1">
                <list:cri-ref key="fdCode" ref="criterion.sys.docSubject" title="${lfn:message('fssc-ledger:fsscLedgerMaterial.fdCode')}" />
                <list:cri-criterion title="${lfn:message('fssc-ledger:fsscLedgerMaterial.fdType')}" key="fdType.fdName">
                    <list:box-select>
                        <list:item-select type="lui/criteria/criterion_input!TextInput">
                            <ui:source type="Static">
                                [{placeholder:'${lfn:message('fssc-ledger:fsscLedgerMaterial.fdType')}'}]
                            </ui:source>
                        </list:item-select>
                    </list:box-select>
                </list:cri-criterion>
                <list:cri-auto modelName="com.landray.kmss.fssc.ledger.model.FsscLedgerMaterial" property="fdIsInventory" />
                <list:cri-auto modelName="com.landray.kmss.fssc.ledger.model.FsscLedgerMaterial" property="fdStatus" />

            </list:criteria>
            <!-- 操作 -->
            <div class="lui_list_operation">

                <div style="float:left;">
                    <list:paging layout="sys.ui.paging.top" />
                </div>
                <div style="float:right">
                    <div style="display: inline-block;vertical-align: middle;">
                        <ui:toolbar count="5">
							<!-- 物质不做新建，因为新建无法初始化入库记录 -->
                           <%--  <kmss:auth requestURL="/fssc/ledger/fssc_ledger_material/fsscLedgerMaterial.do?method=add">
                                <ui:button text="${lfn:message('button.add')}" onclick="addDoc()" order="2" />
                            </kmss:auth> --%>
                            <kmss:auth requestURL="/fssc/ledger/fssc_ledger_material/fsscLedgerMaterial.do?method=deleteall">
                                <c:set var="canDelete" value="true" />
                            </kmss:auth>
                            <!---->
                            <kmss:auth requestURL="/fssc/ledger/fssc_ledger_material/fsscLedgerMaterial.do?method=add">
	                            <ui:button text="${lfn:message('button.deleteall')}" onclick="deleteAll()" order="4" id="btnDelete" />
	                            <ui:button text="${lfn:message('fssc-ledger:button.exportTemplate') }" onclick="downloadTemp()"></ui:button>
								<ui:button text="${lfn:message('button.import') }" onclick="importMaterial()"></ui:button>
								<ui:button text="${lfn:message('button.export') }" onclick="exportMaterial()"></ui:button>
							</kmss:auth>
                        </ui:toolbar>
                    </div>
                </div>
            </div>
            <ui:fixed elem=".lui_list_operation" />
            <!-- 列表 -->
            <list:listview id="listview">
                <ui:source type="AjaxJson">
                    {url:appendQueryParameter('/fssc/ledger/fssc_ledger_material/fsscLedgerMaterial.do?method=data')}
                </ui:source>
                <!-- 列表视图 -->
                <list:colTable isDefault="false" rowHref="/fssc/ledger/fssc_ledger_material/fsscLedgerMaterial.do?method=view&fdId=!{fdId}" name="columntable">
                    <list:col-checkbox />
                    <list:col-serial/>
                    <list:col-auto />
                </list:colTable>
            </list:listview>
            <!-- 翻页 -->
            <list:paging />
        </div>
        <script>
            var listOption = {
                contextPath: '${LUI_ContextPath}',
                jPath: 'material',
                modelName: 'com.landray.kmss.fssc.ledger.model.FsscLedgerMaterial',
                templateName: '',
                basePath: '/fssc/ledger/fssc_ledger_material/fsscLedgerMaterial.do',
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
            Com_IncludeFile("fsscLedgerMaterial.js", "${LUI_ContextPath}/fssc/ledger/fssc_ledger_material/", 'js', true);
        </script>
    </template:replace>
</template:include>