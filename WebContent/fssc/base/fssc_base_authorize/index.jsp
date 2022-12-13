<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>

<template:include ref="default.simple4list">
    <template:replace name="title">
        <c:out value="${ lfn:message('fssc-base:table.fsscBaseAuthorize') }" />
    </template:replace>
    <template:replace name="content">
    	<ui:tabpanel id="fsscBaseAuthorizePanel" layout="sys.ui.tabpanel.list" cfg-router="true">
		<ui:content id="fsscBaseAuthorizeContent" title="${ lfn:message('fssc-base:table.fsscBaseAuthorize') }">
        <div style="margin:5px 10px;">
            <!-- 筛选 -->
            <list:criteria id="criteria1">
            	<list:cri-criterion title="${lfn:message('fssc-base:fsscBaseBudgetScheme.fdIsAvailable')}" key="fdIsAvailable">
					<list:box-select>
						<list:item-select  cfg-defaultValue="true">
							<ui:source type="Static">
							    [{text:'${ lfn:message('message.yes')}', value:'true'},
								{text:'${ lfn:message('message.no')}',value:'false'}]
							</ui:source>
						</list:item-select>
					</list:box-select>
				</list:cri-criterion>
                <list:cri-auto modelName="com.landray.kmss.fssc.base.model.FsscBaseAuthorize" property="fdAuthorizedBy" expand="true" />

            </list:criteria>
            <!-- 操作 -->
            <div class="lui_list_operation">

                <div style="float:left;">
                    <list:paging layout="sys.ui.paging.top" />
                </div>
                <div style="float:right">
                    <div style="display: inline-block;vertical-align: middle;">
                        <ui:toolbar count="9" id="btn">

                            <kmss:auth requestURL="/fssc/base/fssc_base_authorize/fsscBaseAuthorize.do?method=add">
                                <ui:button text="${lfn:message('button.add')}" onclick="addDoc()" order="2" />
                            </kmss:auth>
                             <kmss:auth requestURL="/fssc/base/fssc_base_authorize/fsscBaseAuthorize.do?method=enable">
                                <ui:button text="${lfn:message('fssc-base:button.enable')}" onclick="enable()" order="3" />
                            </kmss:auth>
                            <kmss:auth requestURL="/fssc/base/fssc_base_authorize/fsscBaseAuthorize.do?method=disable">
                                <ui:button text="${lfn:message('fssc-base:button.disable')}" onclick="disable()" order="3" />
                            </kmss:auth>
                            <kmss:auth requestURL="/fssc/base/fssc_base_authorize/fsscBaseAuthorize.do?method=deleteall">
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
                    {url:appendQueryParameter('/fssc/base/fssc_base_authorize/fsscBaseAuthorize.do?method=data')}
                </ui:source>
                <!-- 列表视图 -->
                <list:colTable isDefault="false" rowHref="/fssc/base/fssc_base_authorize/fsscBaseAuthorize.do?method=view&fdId=!{fdId}" name="columntable">
                    <list:col-checkbox />
                    <list:col-serial/>
                    <list:col-auto props="fdAuthorizedBy.name;fdToOrg.name;fdIsAvailable.name;docCreator.name;docCreateTime;operations" url="" /></list:colTable>
            </list:listview>
            <!-- 翻页 -->
            <list:paging />
        </div>
        </ui:content>
        </ui:tabpanel>
        <script>
            var listOption = {
                contextPath: '${LUI_ContextPath}',
                modelName: 'com.landray.kmss.fssc.base.model.FsscBaseAuthorize',
                templateName: '',
                basePath: '/fssc/base/fssc_base_authorize/fsscBaseAuthorize.do',
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
        <!-- 维护所有授权信息时，才有权限导入导出 -->
        <kmss:authShow roles="ROLE_FSSCBASE_AUTHORIZE">
        <c:import url="/fssc/base/resource/jsp/fsscBaseImport_include.jsp">
        </c:import>
        </kmss:authShow>
    </template:replace>
</template:include>