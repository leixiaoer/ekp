<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>

<template:include ref="default.list">
    <template:replace name="title">
        <c:out value="${ lfn:message('geesun-annual:module.geesun.annual') }-${ lfn:message('geesun-annual:table.geesunAnnualMain') }" />
    </template:replace>
    <template:replace name="path">
        <ui:menu layout="sys.ui.menu.nav">
            <ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" href="/" target="_top" />
            <ui:menu-item text="${ lfn:message('geesun-annual:table.geesunAnnualMain') }" />
        </ui:menu>
    </template:replace>
    <template:replace name="nav">
        <ui:combin ref="menu.nav.create">
            <ui:varParam name="title" value="${ lfn:message('geesun-annual:table.geesunAnnualMain') }" />
            <ui:varParam name="button">
                [ {"text": "","href": "javascript:void(0);","icon": "/geesun/annual/geesun_annual_main/geesunAnnualMain.do"} ]
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
                        <li><a href="${LUI_ContextPath}/geesun/annual/geesun_annual_use/index.jsp${j_iframe}">${lfn:message('geesun-annual:table.geesunAnnualUse')}</a>
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
            <!-- ?????? -->
            <list:criteria id="criteria1">
                <list:cri-ref key="fdOwnerNo" ref="criterion.sys.docSubject" title="${lfn:message('geesun-annual:geesunAnnualMain.fdOwnerNo')}" />
                <list:cri-auto modelName="com.landray.kmss.geesun.annual.model.GeesunAnnualMain" property="fdOwner" />
                <list:cri-auto modelName="com.landray.kmss.geesun.annual.model.GeesunAnnualMain" property="docDept" />
                <list:cri-auto modelName="com.landray.kmss.geesun.annual.model.GeesunAnnualMain" property="fdTotal" />

            </list:criteria>
            <!-- ?????? -->
            <div class="lui_list_operation">

                <div style='color: #979797;float: left;padding-top:1px;'>
                    ${ lfn:message('list.orderType') }???
                </div>
                <div style="float:left">
                    <div style="display: inline-block;vertical-align: middle;">
                        <ui:toolbar layout="sys.ui.toolbar.sort" style="float:left">
                            <list:sort property="geesunAnnualMain.docCreateTime" text="${lfn:message('geesun-annual:geesunAnnualMain.docCreateTime')}" group="sort.list" value="down" />
                        </ui:toolbar>
                    </div>
                </div>
                <div style="float:left;">
                    <list:paging layout="sys.ui.paging.top" />
                </div>
                <div style="float:right">
                    <div style="display: inline-block;vertical-align: middle;">
                        <ui:toolbar count="3">

                            <kmss:auth requestURL="/geesun/annual/geesun_annual_main/geesunAnnualMain.do?method=add">
                                <ui:button text="${lfn:message('button.add')}" onclick="addDoc()" order="2" />
                            </kmss:auth>
                            <kmss:auth requestURL="/geesun/annual/geesun_annual_main/geesunAnnualMain.do?method=deleteall">
                                <c:set var="canDelete" value="true" />
                            </kmss:auth>
                            <!---->
                            <ui:button text="${lfn:message('button.deleteall')}" onclick="deleteAll()" order="4" id="btnDelete" />
                            <kmss:auth requestURL="/sys/transport/sys_transport_export/SysTransportExport.do?method=listExport&fdModelName=com.landray.kmss.geesun.annual.model.GeesunAnnualMain">
                                <ui:button text="${lfn:message('button.export')}" id="export" onclick="listExport('${LUI_ContextPath}/sys/transport/sys_transport_export/SysTransportExport.do?method=listExport&fdModelName=com.landray.kmss.geesun.annual.model.GeesunAnnualMain')">
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
                    {url:appendQueryParameter('/geesun/annual/geesun_annual_main/geesunAnnualMain.do?method=data')}
                </ui:source>
                <!-- ???????????? -->
                <list:colTable isDefault="false" rowHref="/geesun/annual/geesun_annual_main/geesunAnnualMain.do?method=view&fdId=!{fdId}" name="columntable">
                    <list:col-checkbox />
                    <list:col-serial/>
                    <list:col-auto props="fdOwner.name;fdOwnerNo;docDept.name;fdTotal;fdRemain;docCreateTime" url="" /></list:colTable>
            </list:listview>
            <!-- ?????? -->
            <list:paging />
        </div>
        <script>
            var listOption = {
                contextPath: '${LUI_ContextPath}',
                jPath: 'main',
                modelName: 'com.landray.kmss.geesun.annual.model.GeesunAnnualMain',
                templateName: '',
                basePath: '/geesun/annual/geesun_annual_main/geesunAnnualMain.do',
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