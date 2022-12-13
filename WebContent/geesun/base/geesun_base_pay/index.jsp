<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>

<template:include ref="default.list">
    <template:replace name="title">
        <c:out value="${ lfn:message('geesun-base:module.geesun.base') }-${ lfn:message('geesun-base:table.geesunBasePay') }" />
    </template:replace>
    <template:replace name="path">
        <ui:menu layout="sys.ui.menu.nav">
            <ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" href="/" target="_top" />
            <ui:menu-item text="${ lfn:message('geesun-base:table.geesunBasePay') }" />
        </ui:menu>
    </template:replace>
    <template:replace name="nav">
        <ui:combin ref="menu.nav.create">
            <ui:varParam name="title" value="${ lfn:message('geesun-base:table.geesunBasePay') }" />
            <ui:varParam name="button">
                [ {"text": "","href": "javascript:void(0);","icon": "/geesun/base/geesun_base_pay/geesunBasePay.do"} ]
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
                        <li><a href="${LUI_ContextPath}/geesun/base/geesun_base_bxsj/index.jsp${j_iframe}">${lfn:message('geesun-base:table.geesunBaseBxsj')}</a>
                        </li>
                        <li><a href="${LUI_ContextPath}/geesun/base/geesun_base_account/index.jsp${j_iframe}">${lfn:message('geesun-base:table.geesunBaseAccount')}</a>
                        </li>
                        <li><a href="${LUI_ContextPath}/geesun/base/geesun_base_audit/index.jsp${j_iframe}">${lfn:message('geesun-base:table.geesunBaseAudit')}</a>
                        </li>
                        <li><a href="${LUI_ContextPath}/sys/profile/index.jsp#app/ekp/geesun/base" target="_blank">${ lfn:message('list.manager') }</a>
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
                <list:cri-auto modelName="com.landray.kmss.geesun.base.model.GeesunBasePay" property="fdPayDate" />
                <list:cri-auto modelName="com.landray.kmss.geesun.base.model.GeesunBasePay" property="fdPayBank3" />
                <list:cri-auto modelName="com.landray.kmss.geesun.base.model.GeesunBasePay" property="fdPayBank2" />
                <list:cri-auto modelName="com.landray.kmss.geesun.base.model.GeesunBasePay" property="fdPayBank1" />
                <list:cri-auto modelName="com.landray.kmss.geesun.base.model.GeesunBasePay" property="fdAccountCode" />
                <list:cri-auto modelName="com.landray.kmss.geesun.base.model.GeesunBasePay" property="fdAccountName" />
                <list:cri-auto modelName="com.landray.kmss.geesun.base.model.GeesunBasePay" property="fdDemo" />
                <list:cri-auto modelName="com.landray.kmss.geesun.base.model.GeesunBasePay" property="fdRemark" />

            </list:criteria>
            <!-- 操作 -->
            <div class="lui_list_operation">

                <div style='color: #979797;float: left;padding-top:1px;'>
                    ${ lfn:message('list.orderType') }：
                </div>
                <div style="float:left">
                    <div style="display: inline-block;vertical-align: middle;">
                        <ui:toolbar layout="sys.ui.toolbar.sort" style="float:left">
                            <list:sort property="geesunBasePay.docCreateTime" text="${lfn:message('geesun-base:geesunBasePay.docCreateTime')}" group="sort.list" />
                        </ui:toolbar>
                    </div>
                </div>
                <div style="float:left;">
                    <list:paging layout="sys.ui.paging.top" />
                </div>
                <div style="float:right">
                    <div style="display: inline-block;vertical-align: middle;">
                        <ui:toolbar count="3">

                            <kmss:auth requestURL="/geesun/base/geesun_base_pay/geesunBasePay.do?method=add">
                                <ui:button text="${lfn:message('button.add')}" onclick="addDoc()" order="2" />
                            </kmss:auth>
                            <kmss:auth requestURL="/geesun/base/geesun_base_pay/geesunBasePay.do?method=deleteall">
                                <c:set var="canDelete" value="true" />
                            </kmss:auth>
                            <!---->
                            <ui:button text="${lfn:message('button.deleteall')}" onclick="deleteAll()" order="4" id="btnDelete" />
                            <kmss:auth requestURL="/sys/transport/sys_transport_export/SysTransportExport.do?method=listExport&fdModelName=com.landray.kmss.geesun.base.model.GeesunBasePay">
                                <ui:button text="${lfn:message('button.export')}" id="export" onclick="listExport('${LUI_ContextPath}/sys/transport/sys_transport_export/SysTransportExport.do?method=listExport&fdModelName=com.landray.kmss.geesun.base.model.GeesunBasePay')">
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
                    {url:appendQueryParameter('/geesun/base/geesun_base_pay/geesunBasePay.do?method=data')}
                </ui:source>
                <!-- 列表视图 -->
                <list:colTable isDefault="false" rowHref="/geesun/base/geesun_base_pay/geesunBasePay.do?method=view&fdId=!{fdId}" name="columntable">
                    <list:col-checkbox />
                    <list:col-serial/>
                    <list:col-auto props="fdOrderId;fdYwDate;fdPayDate;fdPeriod;fdPayBank3;fdPayMoney;docCreateTime" url="" /></list:colTable>
            </list:listview>
            <!-- 翻页 -->
            <list:paging />
        </div>
        <script>
            var listOption = {
                contextPath: '${LUI_ContextPath}',
                jPath: 'pay',
                modelName: 'com.landray.kmss.geesun.base.model.GeesunBasePay',
                templateName: '',
                basePath: '/geesun/base/geesun_base_pay/geesunBasePay.do',
                canDelete: '${canDelete}',
                mode: '',
                templateService: '',
                templateAlert: '${lfn:message("geesun-base:treeModel.alert.templateAlert")}',
                customOpts: {

                    ____fork__: 0
                },
                lang: {
                    noSelect: '${lfn:message("page.noSelect")}',
                    comfirmDelete: '${lfn:message("page.comfirmDelete")}'
                }

            };
            Com_IncludeFile("list.js", "${LUI_ContextPath}/geesun/base/resource/js/", 'js', true);
        </script>
    </template:replace>
</template:include>