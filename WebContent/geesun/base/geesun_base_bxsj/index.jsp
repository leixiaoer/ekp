<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>

<template:include ref="default.list">
    <template:replace name="title">
        <c:out value="${ lfn:message('geesun-base:module.geesun.base') }-${ lfn:message('geesun-base:base.tree') }" />
    </template:replace>
    <template:replace name="path">
        <ui:menu layout="sys.ui.menu.nav">
            <ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" href="/" target="_top" />
            <ui:menu-item text="${ lfn:message('geesun-base:base.tree') }" />
        </ui:menu>
    </template:replace>
    <template:replace name="nav">
        <ui:combin ref="menu.nav.create">
            <ui:varParam name="title" value="${ lfn:message('geesun-base:table.geesunBaseBxsj') }" />
            <ui:varParam name="button">
                [ {"text": "","href": "javascript:void(0);","icon": "/geesun/base/geesun_base_bxsj/geesunBaseBxsj.do"} ]
            </ui:varParam>
        </ui:combin>
        <div class="lui_list_nav_frame">
            <ui:accordionpanel>
                <c:if test="${param.j_iframe=='true'}">
                    <c:set var="j_iframe" value="?j_iframe=true" />
                </c:if>

                <ui:content title="${ lfn:message('list.search') }">
                    <ul class='lui_list_nav_list'>
                        <li><a href="javascript:void(0)" onclick="openQuery();LUI('criteria1').clearValue();">${ lfn:message('geesun-base:list.query') }</a>
                        </li>
                        <li><a href="${LUI_ContextPath}/geesun/base/geesun_base_account/index.jsp${j_iframe}">${lfn:message('geesun-base:table.geesunBaseAccount')}</a>
                        </li>
                        <li><a href="${LUI_ContextPath}/geesun/base/geesun_base_audit/index.jsp${j_iframe}">${lfn:message('geesun-base:table.geesunBaseAudit')}</a>
                        </li>
                        <kmss:authShow roles="ROLE_GEESUNBASE_PAYING">
                        	<li><a href="${LUI_ContextPath}/geesun/base/geesun_base_pay/index.jsp${j_iframe}">${lfn:message('geesun-base:table.geesunBasePay')}</a>
                        	</li>
                        </kmss:authShow>
                        <li><a href="${LUI_ContextPath}/geesun/base/geesun_base_project/index.jsp${j_iframe}">${lfn:message('geesun-base:table.geesunBaseProject')}</a>
                        </li>
                    </ul>
                </ui:content>

                <ui:content title="${ lfn:message('list.otherOpt') }">
                    <ul class='lui_list_nav_list'>
                        <li><a href="${LUI_ContextPath}/sys/profile/index.jsp#app/ekp/geesun/base" target="_blank">${ lfn:message('list.manager') }</a>
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
                <list:cri-ref key="fdTwoAccountCode" ref="criterion.sys.docSubject" title="${lfn:message('geesun-base:geesunBaseBxsj.fdTwoAccountCode')}" />
                <list:cri-auto modelName="com.landray.kmss.geesun.base.model.GeesunBaseBxsj" property="fdTwoAccountName" />
                <list:cri-auto modelName="com.landray.kmss.geesun.base.model.GeesunBaseBxsj" property="fdRelateName" />
                <list:cri-auto modelName="com.landray.kmss.geesun.base.model.GeesunBaseBxsj" property="fdRelateCode" />
                <list:cri-auto modelName="com.landray.kmss.geesun.base.model.GeesunBaseBxsj" property="fdRelateType" />

            </list:criteria>
            <!-- ?????? -->
            <div class="lui_list_operation">

                <div style='color: #979797;float: left;padding-top:1px;'>
                    ${ lfn:message('list.orderType') }???
                </div>
                <div style="float:left">
                    <div style="display: inline-block;vertical-align: middle;">
                        <ui:toolbar layout="sys.ui.toolbar.sort" style="float:left">
                            <list:sort property="geesunBaseBxsj.docAlterTime" text="${lfn:message('geesun-base:geesunBaseBxsj.docAlterTime')}" group="sort.list" value="down" />
                        </ui:toolbar>
                    </div>
                </div>
                <div style="float:left;">
                    <list:paging layout="sys.ui.paging.top" />
                </div>
                <div style="float:right">
                    <div style="display: inline-block;vertical-align: middle;">
                        <ui:toolbar count="3">

                            <kmss:auth requestURL="/geesun/base/geesun_base_bxsj/geesunBaseBxsj.do?method=add">
                                <ui:button text="${lfn:message('button.add')}" onclick="addDoc()" order="2" />
                            </kmss:auth>
                            <kmss:auth requestURL="/geesun/base/geesun_base_bxsj/geesunBaseBxsj.do?method=deleteall">
                                <c:set var="canDelete" value="true" />
                            </kmss:auth>
                            <!---->
                            <ui:button text="${lfn:message('button.deleteall')}" onclick="deleteAll()" order="4" id="btnDelete" />
                            <kmss:auth requestURL="/sys/transport/sys_transport_export/SysTransportExport.do?method=listExport&fdModelName=com.landray.kmss.geesun.base.model.GeesunBaseBxsj">
                                <ui:button text="${lfn:message('button.export')}" id="export" onclick="listExport('${LUI_ContextPath}/sys/transport/sys_transport_export/SysTransportExport.do?method=listExport&fdModelName=com.landray.kmss.geesun.base.model.GeesunBaseBxsj')">
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
                    {url:appendQueryParameter('/geesun/base/geesun_base_bxsj/geesunBaseBxsj.do?method=data')}
                </ui:source>
                <!-- ???????????? -->
                <list:colTable isDefault="false" rowHref="/geesun/base/geesun_base_bxsj/geesunBaseBxsj.do?method=view&fdId=!{fdId}" name="columntable">
                    <list:col-checkbox />
                    <list:col-serial/>
                    <list:col-auto props="fdTwoAccountName;fdTwoAccountCode;fdRelateName;fdRelateCode;fdRelateType.name" url="" /></list:colTable>
            </list:listview>
            <!-- ?????? -->
            <list:paging />
        </div>
        <script>
            var listOption = {
                contextPath: '${LUI_ContextPath}',
                jPath: 'bxsj',
                modelName: 'com.landray.kmss.geesun.base.model.GeesunBaseBxsj',
                templateName: '',
                basePath: '/geesun/base/geesun_base_bxsj/geesunBaseBxsj.do',
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