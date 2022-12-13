<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>

<template:include ref="default.list">
    <template:replace name="title">
        <c:out value="${ lfn:message('geesun-annual:module.geesun.annual') }-${ lfn:message('geesun-annual:table.geesunAnnualUse') }" />
    </template:replace>
    <template:replace name="path">
        <ui:menu layout="sys.ui.menu.nav">
            <ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" href="/" target="_top" />
            <ui:menu-item text="${ lfn:message('geesun-annual:table.geesunAnnualUse') }" />
        </ui:menu>
    </template:replace>
    <template:replace name="nav">
        <ui:combin ref="menu.nav.create">
            <ui:varParam name="title" value="${ lfn:message('geesun-annual:table.geesunAnnualUse') }" />
            <ui:varParam name="button">
                [ {"text": "","href": "javascript:void(0);","icon": "/geesun/annual/geesun_annual_use/geesunAnnualUse.do"} ]
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
                        <li><a href="${LUI_ContextPath}/geesun/annual/geesun_annual_main/index.jsp${j_iframe}">${lfn:message('geesun-annual:table.geesunAnnualMain')}</a>
                        </li>
                        <li><a href="${LUI_ContextPath}/geesun/annual/geesun_annual_alter/index.jsp${j_iframe}">${lfn:message('geesun-annual:table.geesunAnnualAlter')}</a>
                        </li>
                        <li><a href="${LUI_ContextPath}/sys/profile/index.jsp#app/ekp/geesun/annual" target="_blank">${ lfn:message('list.manager') }</a>
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
                <list:cri-ref key="docSubject" ref="criterion.sys.docSubject" title="${lfn:message('geesun-annual:geesunAnnualUse.docSubject')}" />
                <list:cri-auto modelName="com.landray.kmss.geesun.annual.model.GeesunAnnualUse" property="fdModelId" />
                <list:cri-auto modelName="com.landray.kmss.geesun.annual.model.GeesunAnnualUse" property="fdModelName" />
                <list:cri-auto modelName="com.landray.kmss.geesun.annual.model.GeesunAnnualUse" property="fdUse" />
                <list:cri-criterion title="${lfn:message('geesun-annual:geesunAnnualUse.fdAnnual')}" key="fdAnnual.fdOwnerNo">
                    <list:box-select>
                        <list:item-select type="lui/criteria/criterion_input!TextInput">
                            <ui:source type="Static">
                                [{placeholder:'${lfn:message('geesun-annual:geesunAnnualUse.fdAnnual')}'}]
                            </ui:source>
                        </list:item-select>
                    </list:box-select>
                </list:cri-criterion>
            </list:criteria>
            <!-- 操作 -->
            <div class="lui_list_operation">

                <div style='color: #979797;float: left;padding-top:1px;'>
                    ${ lfn:message('list.orderType') }：
                </div>
                <div style="float:left">
                    <div style="display: inline-block;vertical-align: middle;">
                        <ui:toolbar layout="sys.ui.toolbar.sort" style="float:left">
                            <list:sort property="geesunAnnualUse.docCreateTime" text="${lfn:message('geesun-annual:geesunAnnualUse.docCreateTime')}" group="sort.list" />
                        </ui:toolbar>
                    </div>
                </div>
                <div style="float:left;">
                    <list:paging layout="sys.ui.paging.top" />
                </div>
                <div style="float:right">
                    <div style="display: inline-block;vertical-align: middle;">
                        
                    </div>
                </div>
            </div>
            <ui:fixed elem=".lui_list_operation" />
            <!-- 列表 -->
            <list:listview id="listview">
                <ui:source type="AjaxJson">
                    {url:appendQueryParameter('/geesun/annual/geesun_annual_use/geesunAnnualUse.do?method=data')}
                </ui:source>
                <!-- 列表视图 -->
                <list:colTable isDefault="false" rowHref="/geesun/annual/geesun_annual_use/geesunAnnualUse.do?method=view&fdId=!{fdId}" name="columntable">
                    <list:col-checkbox />
                    <list:col-serial/>
                    <list:col-auto props="docSubject;fdModelId;fdUse;docCreator.name;docCreateTime;fdAnnual.name" url="" /></list:colTable>
            </list:listview>
            <!-- 翻页 -->
            <list:paging />
        </div>
        <script>
            var listOption = {
                contextPath: '${LUI_ContextPath}',
                jPath: 'use',
                modelName: 'com.landray.kmss.geesun.annual.model.GeesunAnnualUse',
                templateName: '',
                basePath: '/geesun/annual/geesun_annual_use/geesunAnnualUse.do',
                canDelete: '${canDelete}',
                mode: '',
                templateService: '',
                templateAlert: '${lfn:message("geesun-annual:treeModel.alert.templateAlert")}',
                customOpts: {

                    ____fork__: 0
                },
                lang: {
                    noSelect: '${lfn:message("page.noSelect")}',
                    comfirmDelete: '${lfn:message("page.comfirmDelete")}'
                }

            };
            Com_IncludeFile("list.js", "${LUI_ContextPath}/geesun/annual/resource/js/", 'js', true);
        </script>
    </template:replace>
</template:include>