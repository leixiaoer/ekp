<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>

<template:include ref="config.list">
    <template:replace name="content">
        <div style="margin:5px 10px;">
            <!-- 筛选 -->
            <list:criteria id="criteria1">
                <list:cri-ref key="fdName" ref="criterion.sys.docSubject" title="${lfn:message('third-ding:thirdDingDtemplateXform.fdName')}" />
                <list:cri-auto modelName="com.landray.kmss.third.ding.model.ThirdDingDtemplateXform" property="fdAgentId" />
                <list:cri-auto modelName="com.landray.kmss.third.ding.model.ThirdDingDtemplateXform" property="fdIsAvailable" />
                <list:cri-auto modelName="com.landray.kmss.third.ding.model.ThirdDingDtemplateXform" property="fdProcessCode" />
                <list:cri-auto modelName="com.landray.kmss.third.ding.model.ThirdDingDtemplateXform" property="fdCorpId" />

            </list:criteria>
            <!-- 操作 -->
            <div class="lui_list_operation">

                <div style='color: #979797;float: left;padding-top:1px;'>
                    ${ lfn:message('list.orderType') }：
                </div>
                <div style="float:left">
                    <div style="display: inline-block;vertical-align: middle;">
                        <ui:toolbar layout="sys.ui.toolbar.sort" style="float:left">
                            <list:sort property="thirdDingDtemplateXform.fdName" text="${lfn:message('third-ding:thirdDingDtemplateXform.fdName')}" group="sort.list" />
                            <list:sort property="thirdDingDtemplateXform.fdProcessCode" text="${lfn:message('third-ding:thirdDingDtemplateXform.fdProcessCode')}" group="sort.list" />
                            <list:sort property="thirdDingDtemplateXform.fdAgentId" text="${lfn:message('third-ding:thirdDingDtemplateXform.fdAgentId')}" group="sort.list" />
                            <list:sort property="thirdDingDtemplateXform.docCreateTime" text="${lfn:message('third-ding:thirdDingDtemplateXform.docCreateTime')}" group="sort.list" />
                        </ui:toolbar>
                    </div>
                </div>
                <div style="float:left;">
                    <list:paging layout="sys.ui.paging.top" />
                </div>
                <div style="float:right">
                    <div style="display: inline-block;vertical-align: middle;">
                       <%--  <ui:toolbar count="3">

                            <kmss:auth requestURL="/third/ding/third_ding_dtemplate_xform/thirdDingDtemplateXform.do?method=deleteall">
                                <c:set var="canDelete" value="true" />
                            </kmss:auth>
                            <!--deleteall-->
                            <ui:button text="${lfn:message('button.deleteall')}" onclick="deleteAll()" order="4" id="btnDelete" />
                        </ui:toolbar> --%>
                    </div>
                </div>
            </div>
            <ui:fixed elem=".lui_list_operation" />
            <!-- 列表 -->
            <list:listview id="listview">
                <ui:source type="AjaxJson">
                    {url:appendQueryParameter('/third/ding/third_ding_dtemplate_xform/thirdDingDtemplateXform.do?method=data')}
                </ui:source>
                <!-- 列表视图 -->
                <list:colTable isDefault="false" rowHref="/third/ding/third_ding_dtemplate_xform/thirdDingDtemplateXform.do?method=view&fdId=!{fdId}" name="columntable">
                    <list:col-checkbox />
                    <list:col-serial/>
                    <list:col-auto props="fdName;fdCorpId;fdAgentId;fdIsAvailable.name;docCreateTime" url="" /></list:colTable>
            </list:listview>
            <!-- 翻页 -->
            <list:paging />
        </div>
        <script>
            var listOption = {
                contextPath: '${LUI_ContextPath}',
                jPath: 'dtemplate_xform',
                modelName: 'com.landray.kmss.third.ding.model.ThirdDingDtemplateXform',
                templateName: '',
                basePath: '/third/ding/third_ding_dtemplate_xform/thirdDingDtemplateXform.do',
                canDelete: '${canDelete}',
                mode: '',
                templateService: '',
                templateAlert: '${lfn:message("third-ding:treeModel.alert.templateAlert")}',
                customOpts: {

                    ____fork__: 0
                },
                lang: {
                    noSelect: '${lfn:message("page.noSelect")}',
                    comfirmDelete: '${lfn:message("page.comfirmDelete")}'
                }

            };
            Com_IncludeFile("list.js", "${LUI_ContextPath}/third/ding/resource/js/", 'js', true);
        </script>
    </template:replace>
</template:include>