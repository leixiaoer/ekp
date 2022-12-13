<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>

<template:include ref="default.list">
    <template:replace name="title">
        <c:out value="${ lfn:message('geesun-org:module.geesun.org') }-${ lfn:message('geesun-org:table.geesunOrgRecord') }" />
    </template:replace>
    <template:replace name="path">
        <ui:menu layout="sys.ui.menu.nav">
            <ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" href="/" target="_top" />
            <ui:menu-item text="${ lfn:message('geesun-org:table.geesunOrgRecord') }" />
        </ui:menu>
    </template:replace>
    <template:replace name="nav">
        <ui:combin ref="menu.nav.create">
            <ui:varParam name="title" value="${ lfn:message('geesun-org:table.geesunOrgRecord') }" />
            <ui:varParam name="button">
                [ {"text": "","href": "javascript:void(0);","icon": "/geesun/org/geesun_org_record/geesunOrgRecord.do"} ]
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
                        <li><a href="${LUI_ContextPath}/sys/profile/index.jsp#app/ekp/geesun/org" target="_blank">${ lfn:message('list.manager') }</a>
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
                <list:cri-ref key="stext" ref="criterion.sys.docSubject" title="${lfn:message('geesun-org:geesunOrgRecord.stext')}" />
                <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgRecord" property="objidUp" />
                <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgRecord" property="objid" />
                <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgRecord" property="priox" />
                <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgRecord" property="zsfyx" />
                <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgRecord" property="zhrOmJglx" />
                <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgRecord" property="zzDatum" expand="true" />
                <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgRecord" property="objidSUp" />
                <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgRecord" property="begda" />
                <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgRecord" property="nachn" />
                <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgRecord" property="phone" />
                <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgRecord" property="gbdat" />
                <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgRecord" property="call" />
                <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgRecord" property="gender" />
                <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgRecord" property="wxid" />
                <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgRecord" property="pernr" />
                <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgRecord" property="plans02" />
                <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgRecord" property="email" />
                <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgRecord" property="zhrOmGwzd" />
                <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgRecord" property="plans01" />
                <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgRecord" property="zhrOmGwzj" />
                <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgRecord" property="vnamc" />
                <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgRecord" property="orgeh" />
                <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgRecord" property="icnum" />

            </list:criteria>
            <!-- 操作 -->
            <div class="lui_list_operation">

                <div style='color: #979797;float: left;padding-top:1px;'>
                    ${ lfn:message('list.orderType') }：
                </div>
                <div style="float:left">
                    <div style="display: inline-block;vertical-align: middle;">
                        <ui:toolbar layout="sys.ui.toolbar.sort" style="float:left">
                            <list:sort property="geesunOrgRecord.docCreateTime" text="${lfn:message('geesun-org:geesunOrgRecord.docCreateTime')}" group="sort.list" value="down" />
                        </ui:toolbar>
                    </div>
                </div>
                <div style="float:left;">
                    <list:paging layout="sys.ui.paging.top" />
                </div>
                <div style="float:right">
                    <div style="display: inline-block;vertical-align: middle;">
                        <ui:toolbar count="3">

                            <kmss:auth requestURL="/geesun/org/geesun_org_record/geesunOrgRecord.do?method=add">
                                <ui:button text="${lfn:message('button.add')}" onclick="addDoc()" order="2" />
                            </kmss:auth>
                            <kmss:auth requestURL="/geesun/org/geesun_org_record/geesunOrgRecord.do?method=deleteall">
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
                    {url:appendQueryParameter('/geesun/org/geesun_org_record/geesunOrgRecord.do?method=data')}
                </ui:source>
                <!-- 列表视图 -->
                <list:colTable isDefault="false" rowHref="/geesun/org/geesun_org_record/geesunOrgRecord.do?method=view&fdId=!{fdId}" name="columntable">
                    <list:col-checkbox />
                    <list:col-serial/>
                    <list:col-auto props="fdOrganType.name;stext;nachn;pernr;objid;orgeh;zsfyx;docCreateTime" url="" /></list:colTable>
            </list:listview>
            <!-- 翻页 -->
            <list:paging />
        </div>
        <script>
            var listOption = {
                contextPath: '${LUI_ContextPath}',
                jPath: 'record',
                modelName: 'com.landray.kmss.geesun.org.model.GeesunOrgRecord',
                templateName: '',
                basePath: '/geesun/org/geesun_org_record/geesunOrgRecord.do',
                canDelete: '${canDelete}',
                mode: '',
                templateService: '',
                templateAlert: '${lfn:message("geesun-org:treeModel.alert.templateAlert")}',
                customOpts: {

                    ____fork__: 0
                },
                lang: {
                    noSelect: '${lfn:message("page.noSelect")}',
                    comfirmDelete: '${lfn:message("page.comfirmDelete")}'
                }

            };
            Com_IncludeFile("list.js", "${LUI_ContextPath}/geesun/org/resource/js/", 'js', true);
        </script>
    </template:replace>
</template:include>
