<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>

<template:include ref="default.list">
    <template:replace name="title">
        <c:out value="${ lfn:message('geesun-leave:module.geesun.leave') }-${ lfn:message('geesun-leave:table.geesunLeaveMain') }" />
    </template:replace>
    <template:replace name="path">
        <ui:menu layout="sys.ui.menu.nav">
            <ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" href="/" target="_top" />
            <ui:menu-item text="${ lfn:message('geesun-leave:table.geesunLeaveMain') }" />
        </ui:menu>
    </template:replace>
    <template:replace name="nav">
        <ui:combin ref="menu.nav.create">
            <ui:varParam name="title" value="${ lfn:message('geesun-leave:table.geesunLeaveMain') }" />
            <ui:varParam name="button">
                [ {"text": "","href": "javascript:void(0);","icon": "/geesun/leave/geesun_leave_main/geesunLeaveMain.do"} ]
            </ui:varParam>
        </ui:combin>
        <div class="lui_list_nav_frame">
            <ui:accordionpanel>
                <c:if test="${param.j_iframe=='true'}">
                    <c:set var="j_iframe" value="?j_iframe=true" />
                </c:if>

                <ui:content title="${ lfn:message('geesun-leave:py.ChangYongChaXun') }">
                    <ul class='lui_list_nav_list'>
                        <li><a href="${LUI_ContextPath}/geesun/leave/geesun_leave_main/index.jsp${j_iframe}">${lfn:message('geesun-leave:table.geesunLeaveMain')}</a>
                        </li>
                        <li><a href="${LUI_ContextPath}/geesun/leave/geesun_leave_adjust/index.jsp${j_iframe}">${lfn:message('geesun-leave:table.geesunLeaveAdjust')}</a>
                        </li>
                        <li><a href="${LUI_ContextPath}/geesun/leave/geesun_leave_barter/index.jsp${j_iframe}">${lfn:message('geesun-leave:table.geesunLeaveBarter')}</a>
                        </li>
                    </ul>
                </ui:content>
                <ui:content title="${ lfn:message('geesun-leave:py.QiTaCaoZuo') }">
                    <ul class='lui_list_nav_list'>
                       <!-- 后台配置：<li><a href="${LUI_ContextPath}/sys/profile/index.jsp#app/ekp/geesun/leave" target="_blank">${ lfn:message('list.manager') }</a>
                        </li> -->
                    </ul>
                </ui:content>
            </ui:accordionpanel>
        </div>
    </template:replace>
    <template:replace name="content">
        <div style="margin:5px 10px;">
            <!-- 筛选 -->
            <list:criteria id="criteria1">
                <list:cri-ref key="fdTime" ref="criterion.sys.docSubject" title="${lfn:message('geesun-leave:geesunLeaveMain.fdTime')}" />
                <list:cri-auto modelName="com.landray.kmss.geesun.leave.model.GeesunLeaveMain" property="docCreator" />
                <list:cri-auto modelName="com.landray.kmss.geesun.leave.model.GeesunLeaveMain" property="fdOwnerNo" />

            </list:criteria>
            <!-- 操作 -->
            <div class="lui_list_operation">

                <div style='color: #979797;float: left;padding-top:1px;'>
                    ${ lfn:message('list.orderType') }：
                </div>
                <div style="float:left">
                    <div style="display: inline-block;vertical-align: middle;">
                        <ui:toolbar layout="sys.ui.toolbar.sort" style="float:left">
                            <list:sort property="geesunLeaveMain.docCreateTime" text="${lfn:message('geesun-leave:geesunLeaveMain.docCreateTime')}" group="sort.list" />
                        </ui:toolbar>
                    </div>
                </div>
                <div style="float:left;">
                    <list:paging layout="sys.ui.paging.top" />
                </div>
                <div style="float:right">
                    <div style="display: inline-block;vertical-align: middle;">
                        <ui:toolbar count="3">

                           <!-- <kmss:auth requestURL="/geesun/leave/geesun_leave_main/geesunLeaveMain.do?method=add">
                                <ui:button text="${lfn:message('button.add')}" onclick="addDoc()" order="2" />
                            </kmss:auth> -->
                            <kmss:auth requestURL="/geesun/leave/geesun_leave_main/geesunLeaveMain.do?method=deleteall">
                                <c:set var="canDelete" value="true" />
                            </kmss:auth>
                            
                            <!-- 后续新增的导入按钮:设置可见人员范围-kmss:authShow -->
                            <kmss:authShow roles="ROLE_GEESUNANNUAL_ADMIN">
                            	<ui:button text="${lfn:message('geesun-leave:geesunLeaveMain.export.downloadTemplate')}"  onclick="downloadUpdateTemplate();" order="2"/>
                           		<ui:button text="${lfn:message('geesun-leave:geesunLeaveMain.initLeaveInfo')}"  onclick="initAnnualInfo();" order="3"/>
                            </kmss:authShow>
                            
                            <ui:button text="${lfn:message('button.deleteall')}" onclick="deleteAll()" order="4" id="btnDelete" />
                            <kmss:auth requestURL="/sys/transport/sys_transport_export/SysTransportExport.do?method=listExport&fdModelName=com.landray.kmss.geesun.leave.model.GeesunLeaveMain">
                                <ui:button text="${lfn:message('button.export')}" id="export" onclick="listExport('${LUI_ContextPath}/sys/transport/sys_transport_export/SysTransportExport.do?method=listExport&fdModelName=com.landray.kmss.geesun.leave.model.GeesunLeaveMain')">
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
                    {url:appendQueryParameter('/geesun/leave/geesun_leave_main/geesunLeaveMain.do?method=data')}
                </ui:source>
                <!-- 列表视图 -->
                <list:colTable isDefault="false" rowHref="/geesun/leave/geesun_leave_main/geesunLeaveMain.do?method=view&fdId=!{fdId}" name="columntable">
                    <list:col-checkbox />
                    <list:col-serial/>
                    <list:col-auto props="fdTime;docCreator.name;fdOwnerNo;docDept.name;fdSurplusLeave;fdUseLeave;fdSunLeave;docCreateTime" url="" /></list:colTable>
            </list:listview>
            <!-- 翻页 -->
            <list:paging />
        </div>
        <script>
        
        	//下载员工调休额度信息初始化模板
			function downloadUpdateTemplate(){
				seajs.use(['lui/jquery', 'lui/dialog' ,'lui/topic'],function($,dialog, topic) {
					javascript:location.href='<c:url value="/geesun/leave/geesun_leave_main/geesunLeaveMain.do" />?method=downloadTableImport';
				});
			}
        
        	//初始化年假信息批量导入页面
			function initAnnualInfo(){
				seajs.use(['lui/jquery', 'lui/dialog' ,'lui/topic'],function($,dialog, topic) {
					Com_OpenWindow('<c:url value="/geesun/leave/geesun_leave_main/geesunLeaveMain_intiLeaveInfos.jsp"/>');
				});
			}
        
            var listOption = {
                contextPath: '${LUI_ContextPath}',
                jPath: 'main',
                modelName: 'com.landray.kmss.geesun.leave.model.GeesunLeaveMain',
                templateName: '',
                basePath: '/geesun/leave/geesun_leave_main/geesunLeaveMain.do',
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