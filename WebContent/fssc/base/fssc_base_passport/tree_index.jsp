<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>

<template:include ref="config.list">
    <template:replace name="content">
        <div style="margin:5px 10px;">
            <!-- 筛选 -->
            <list:criteria id="criteria1">
                <list:cri-ref key="fdName" ref="criterion.sys.docSubject" title="${lfn:message('fssc-base:fsscBasePassport.fdName')}" />
                <list:cri-auto modelName="com.landray.kmss.fssc.base.model.FsscBasePassport" property="fdPerson" />

            </list:criteria>
            <!-- 操作 -->
            <div class="lui_list_operation">

                <div style='color: #979797;float: left;padding-top:1px;'>
                    ${ lfn:message('list.orderType') }：
                </div>
                <div style="float:left">
                    <div style="display: inline-block;vertical-align: middle;">
                        <ui:toolbar layout="sys.ui.toolbar.sort" style="float:left">
                            <list:sort property="fsscBasePassport.docAlterTime" text="${lfn:message('fssc-base:fsscBasePassport.docAlterTime')}" group="sort.list" />
                        </ui:toolbar>
                    </div>
                </div>
                <div style="float:left;">
                    <list:paging layout="sys.ui.paging.top" />
                </div>
                <div style="float:right">
                    <div style="display: inline-block;vertical-align: middle;">
                        <ui:toolbar count="9" id="btn">
                            <kmss:auth requestURL="/fssc/base/fssc_base_passport/fsscBasePassport.do?method=add">
                                <ui:button text="${lfn:message('button.add')}" onclick="addDoc()" order="2" />
                            </kmss:auth>
                            <kmss:auth requestURL="/fssc/base/fssc_base_passport/fsscBasePassport.do?method=enable">
                                <ui:button text="${lfn:message('fssc-base:button.enable')}" onclick="enable()" order="3" />
                            </kmss:auth>
                            <kmss:auth requestURL="/fssc/base/fssc_base_passport/fsscBasePassport.do?method=disable">
                                <ui:button text="${lfn:message('fssc-base:button.disable')}" onclick="disable()" order="3" />
                            </kmss:auth>
                            <kmss:auth requestURL="/fssc/base/fssc_base_passport/fsscBasePassport.do?method=deleteall">
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
                    {url:appendQueryParameter('/fssc/base/fssc_base_passport/fsscBasePassport.do?method=data')}
                </ui:source>
                <!-- 列表视图 -->
                <list:colTable isDefault="false" rowHref="/fssc/base/fssc_base_passport/fsscBasePassport.do?method=view&fdId=!{fdId}" name="columntable">
                    <list:col-checkbox />
                    <list:col-serial/>
                    <list:col-auto props="fdName;fdPerson.name;fdIsAvailable.name;docAlteror.name;docAlterTime" /></list:colTable>
            </list:listview>
            <!-- 翻页 -->
            <list:paging />
        </div>
        <script>
            var listOption = {
                contextPath: '${LUI_ContextPath}',
                modelName: 'com.landray.kmss.fssc.base.model.FsscBasePassport',
                templateName: '',
                basePath: '/fssc/base/fssc_base_passport/fsscBasePassport.do',
                canDelete: '${canDelete}',
                mode: '',
                templateService: '',
                templateAlert: '${lfn:message("fssc-base:treeModel.alert.templateAlert")}',
                customOpts: {

                    ____fork__: 0
                },
                lang: {
                    noSelect: '${lfn:message("page.noSelect")}',
                    comfirmDelete: '${lfn:message("page.comfirmDelete")}'
                }

            };
            Com_IncludeFile("list.js", "${LUI_ContextPath}/fssc/base/resource/js/", 'js', true);
        </script>
        <!-- 维护所有人账户信息时，才有权限导入导出 -->
        <kmss:authShow roles="ROLE_FSSCBASE_PASSPORT">
        <c:import url="/fssc/base/resource/jsp/fsscBaseImport_include.jsp">
        </c:import>
        </kmss:authShow>
    </template:replace>
</template:include>