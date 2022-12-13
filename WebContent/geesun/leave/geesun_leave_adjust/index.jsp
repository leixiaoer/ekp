<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>

<template:include ref="default.list">
    <template:replace name="title">
        <c:out value="${ lfn:message('geesun-leave:module.geesun.leave') }-${ lfn:message('geesun-leave:table.geesunLeaveAdjust') }" />
    </template:replace>
    <template:replace name="path">
        <ui:menu layout="sys.ui.menu.nav">
            <ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" href="/" target="_top" />
            <ui:menu-item text="${ lfn:message('geesun-leave:table.geesunLeaveAdjust') }" />
        </ui:menu>
    </template:replace>
    <template:replace name="nav">
        <ui:combin ref="menu.nav.create">
            <ui:varParam name="title" value="${ lfn:message('geesun-leave:table.geesunLeaveAdjust') }" />
            <ui:varParam name="button">
                [ {"text": "","href": "javascript:void(0);","icon": "/geesun/leave/geesun_leave_adjust/geesunLeaveAdjust.do"} ]
            </ui:varParam>
        </ui:combin>
        <div class="lui_list_nav_frame">
            <ui:accordionpanel>
                <c:if test="${param.j_iframe=='true'}">
                    <c:set var="j_iframe" value="?j_iframe=true" />
                </c:if>

                <ui:content title="${ lfn:message('list.search') }">
                    <ul class='lui_list_nav_list'>
                        <!--  <li><a href="javascript:void(0)" onclick="openQuery();LUI('criteria1').clearValue();">${ lfn:message('list.alldoc') }</a>
                        </li> -->
                        
                       	<li><a href="${LUI_ContextPath}/geesun/leave/geesun_leave_main/index.jsp${j_iframe}">${lfn:message('geesun-leave:table.geesunLeaveMain')}</a>
                        </li>
                        <li><a href="${LUI_ContextPath}/geesun/leave/geesun_leave_adjust/index.jsp${j_iframe}">${lfn:message('geesun-leave:table.geesunLeaveAdjust')}</a>
                        </li>
                        <li><a href="${LUI_ContextPath}/geesun/leave/geesun_leave_barter/index.jsp${j_iframe}">${lfn:message('geesun-leave:table.geesunLeaveBarter')}</a>
                        </li>
                    </ul>
                </ui:content>

                <ui:content title="${ lfn:message('list.otherOpt') }">
                    <ul class='lui_list_nav_list'>
                      <!--  <li><a href="${LUI_ContextPath}/sys/profile/index.jsp#app/ekp/geesun/leave" target="_blank">${ lfn:message('list.manager') }</a>
                        </li>-->
                    </ul>
                </ui:content>
            </ui:accordionpanel>
        </div>
    </template:replace>
    <template:replace name="content">
        <div style="margin:5px 10px;">
            <!-- 筛选 -->
            <list:criteria id="criteria1">
                <list:cri-auto modelName="com.landray.kmss.geesun.leave.model.GeesunLeaveAdjust" property="docCreator" />
                <list:cri-auto modelName="com.landray.kmss.geesun.leave.model.GeesunLeaveAdjust" property="docCreateTime" />
                <list:cri-auto modelName="com.landray.kmss.geesun.leave.model.GeesunLeaveAdjust" property="docDept;fdModelId;fdDetailId" />

            </list:criteria>
            <!-- 操作 -->
            <div class="lui_list_operation">

                <div style='color: #979797;float: left;padding-top:1px;'>
                    ${ lfn:message('list.orderType') }：
                </div>
                <div style="float:left">
                    <div style="display: inline-block;vertical-align: middle;">
                        <ui:toolbar layout="sys.ui.toolbar.sort" style="float:left">
                            <list:sort property="geesunLeaveAdjust.docCreateTime" text="${lfn:message('geesun-leave:geesunLeaveAdjust.docCreateTime')}" group="sort.list" />
                        </ui:toolbar>
                    </div>
                </div>
                <div style="float:left;">
                    <list:paging layout="sys.ui.paging.top" />
                </div>
                <div style="float:right">
                    <div style="display: inline-block;vertical-align: middle;">
                        <ui:toolbar count="3">

                           <!-- <kmss:auth requestURL="/geesun/leave/geesun_leave_adjust/geesunLeaveAdjust.do?method=add">
                                <ui:button text="${lfn:message('button.add')}" onclick="addDoc()" order="2" />
                            </kmss:auth> -->
                            <kmss:auth requestURL="/geesun/leave/geesun_leave_adjust/geesunLeaveAdjust.do?method=deleteall">
                                <c:set var="canDelete" value="true" />
                            </kmss:auth>
                            <!---->
                            <ui:button text="${lfn:message('button.deleteall')}" onclick="deleteAll()" order="4" id="btnDelete" />
                        </ui:toolbar>
                    </div>
                </div>
            </div>
            <ui:fixed elem=".lui_list_operation" />
            <!-- 列表 -->
            <list:listview id="listview">
                <ui:source type="AjaxJson">
                    {url:appendQueryParameter('/geesun/leave/geesun_leave_adjust/geesunLeaveAdjust.do?method=data')}
                </ui:source>
                <!-- 列表视图 -->
                <list:colTable isDefault="false" rowHref="/geesun/leave/geesun_leave_adjust/geesunLeaveAdjust.do?method=view&fdId=!{fdId}" name="columntable">
                    <list:col-checkbox />
                    <list:col-serial/>
                    <list:col-auto props="docSubject;docCreator.name;docDept.name;fdDate;fdStartTime;fdEndTime;fdLeaveHour;docCreateTime" url="" /></list:colTable>
            </list:listview>
            <!-- 翻页 -->
            <list:paging />
        </div>
        <script>
            var listOption = {
                contextPath: '${LUI_ContextPath}',
                jPath: 'adjust',
                modelName: 'com.landray.kmss.geesun.leave.model.GeesunLeaveAdjust',
                templateName: '',
                basePath: '/geesun/leave/geesun_leave_adjust/geesunLeaveAdjust.do',
                canDelete: '${canDelete}',
                mode: '',
                templateService: '',
                templateAlert: '${lfn:message("geesun-leave:treeModel.alert.templateAlert")}',
                customOpts: {

                    ____fork__: 0
                },
                lang: {
                    noSelect: '${lfn:message("page.noSelect")}',
                    comfirmDelete: '${lfn:message("page.comfirmDelete")}'
                }

            };
            Com_IncludeFile("list.js", "${LUI_ContextPath}/geesun/leave/resource/js/", 'js', true);
        </script>
    </template:replace>
</template:include>