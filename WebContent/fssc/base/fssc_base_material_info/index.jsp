<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>

<template:include ref="config.list">
    <template:replace name="content">
        <div style="margin:5px 10px;">
            <!-- 筛选 -->
            <list:criteria id="criteria1">
                <list:cri-ref key="fdName" ref="criterion.sys.docSubject" title="${lfn:message('fssc-base:fsscBaseMaterialInfo.fdName')}" />
                <list:cri-auto modelName="com.landray.kmss.fssc.base.model.FsscBaseMaterialInfo" property="fdCode" />
                <list:cri-criterion title="${lfn:message('fssc-base:fsscBaseMaterialInfo.fdType')}" key="fdType.fdName">
                    <list:box-select>
                        <list:item-select type="lui/criteria/criterion_input!TextInput">
                            <ui:source type="Static">
                                [{placeholder:'${lfn:message('fssc-base:fsscBaseMaterialInfo.fdType')}'}]
                            </ui:source>
                        </list:item-select>
                    </list:box-select>
                </list:cri-criterion>
                <list:cri-auto modelName="com.landray.kmss.fssc.base.model.FsscBaseMaterialInfo" property="fdStatus" />
                <list:cri-auto modelName="com.landray.kmss.fssc.base.model.FsscBaseMaterialInfo" property="fdIsInventory" />

            </list:criteria>
            <!-- 操作 -->
            <div class="lui_list_operation">
                <div style="float:left;">
                    <list:paging layout="sys.ui.paging.top" />
                </div>
                <div style="float:right">
                    <div style="display: inline-block;vertical-align: middle;">
                        <ui:toolbar count="9" id="btn">

                            <kmss:auth requestURL="/fssc/base/fssc_base_material_info/fsscBaseMaterialInfo.do?method=add">
                                <ui:button text="${lfn:message('button.add')}" onclick="addDoc()" order="2" />
                            </kmss:auth>
                            <kmss:auth requestURL="/fssc/base/fssc_base_material_info/fsscBaseMaterialInfo.do?method=deleteall">
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
                    {url:appendQueryParameter('/fssc/base/fssc_base_material_info/fsscBaseMaterialInfo.do?method=data')}
                </ui:source>
                <!-- 列表视图 -->
                <list:colTable isDefault="false" rowHref="/fssc/base/fssc_base_material_info/fsscBaseMaterialInfo.do?method=view&fdId=!{fdId}" name="columntable">
                    <list:col-checkbox />
                    <list:col-serial/>
                    <list:col-auto props="fdName;fdCode;fdType.name;fdUnit;fdPrice;fdStatus.name;fdIsInventory.name" url="" /></list:colTable>
            </list:listview>
            <!-- 翻页 -->
            <list:paging />
        </div>
        <script>
            var listOption = {
                contextPath: '${LUI_ContextPath}',
                modelName: 'com.landray.kmss.fssc.base.model.FsscBaseMaterialInfo',
                templateName: '',
                basePath: '/fssc/base/fssc_base_material_info/fsscBaseMaterialInfo.do',
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
        <c:import url="/fssc/base/resource/jsp/fsscBaseImport_include.jsp">
        </c:import>
    </template:replace>
</template:include>