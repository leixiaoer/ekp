<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@ taglib uri="/WEB-INF/KmssConfig/fssc/common/fssc.tld" prefix="fssc" %>
<template:include ref="config.list">
    <template:replace name="content">
        <div style="margin:5px 10px;">
            <!-- 筛选 -->
            <list:criteria id="criteria1">
                <list:cri-ref key="fdRate" ref="criterion.sys.docSubject" title="${lfn:message('fssc-base:fsscBaseTaxRate.fdRate')}" />
                <fssc:switchOn property="fdShowType">
                <list:cri-criterion title="${lfn:message('fssc-base:fsscBaseAccountsCom.fdCompany')}" key="fdCompany.fdId"  expand="true"  multi="false">
					<list:box-select>
						<list:item-select>
							<ui:source type="AjaxXml" >
								  {"url":"/sys/common/dataxml.jsp?s_bean=fsscBaseCompanyTreeService&valid=true"}
							</ui:source>
						</list:item-select>
					</list:box-select>
				</list:cri-criterion>
				</fssc:switchOn>
                <list:cri-criterion title="${lfn:message('fssc-base:fsscBaseTaxRate.fdAccount')}" key="fdAccount.fdName">
                    <list:box-select>
                        <list:item-select type="lui/criteria/criterion_input!TextInput">
                            <ui:source type="Static">
                                [{placeholder:'${lfn:message('fssc-base:fsscBaseTaxRate.fdAccount')}'}]
                            </ui:source>
                        </list:item-select>
                    </list:box-select>
                </list:cri-criterion>
                <list:cri-auto modelName="com.landray.kmss.fssc.base.model.FsscBaseTaxRate" property="docCreator" />
                <list:cri-auto modelName="com.landray.kmss.fssc.base.model.FsscBaseTaxRate" property="docCreateTime" />

            </list:criteria>
            <!-- 操作 -->
            <div class="lui_list_operation">

                <div style='color: #979797;float: left;padding-top:1px;'>
                    ${ lfn:message('list.orderType') }：
                </div>
                <div style="float:left">
                    <div style="display: inline-block;vertical-align: middle;">
                        <ui:toolbar layout="sys.ui.toolbar.sort" style="float:left">
                            <list:sort property="fdOrder" text="${lfn:message('fssc-base:fsscBaseTaxRate.fdOrder')}" group="sort.list" />
                        </ui:toolbar>
                    </div>
                </div>
                <div style="float:left;">
                    <list:paging layout="sys.ui.paging.top" />
                </div>
                <div style="float:right">
                    <div style="display: inline-block;vertical-align: middle;">
                        <ui:toolbar count="9" id="btn">
                        	<kmss:auth requestURL="/fssc/base/fssc_base_tax_rate/fsscBaseTaxRate.do?method=add">
                                <ui:button text="${lfn:message('button.add')}" onclick="addDoc()" order="1" />
                            </kmss:auth>
							<kmss:auth requestURL="/fssc/base/fssc_base_tax_rate/fsscBaseTaxRate.do?method=enable">
								<ui:button text="${lfn:message('fssc-base:button.enable')}" onclick="enable()" order="2" />
							</kmss:auth>
							<kmss:auth requestURL="/fssc/base/fssc_base_tax_rate/fsscBaseTaxRate.do?method=disable">
								<ui:button text="${lfn:message('fssc-base:button.disable')}" onclick="disable()" order="3" />
							</kmss:auth>
                            <kmss:auth requestURL="/fssc/base/fssc_base_tax_rate/fsscBaseTaxRate.do?method=deleteall">
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
                    {url:appendQueryParameter('/fssc/base/fssc_base_tax_rate/fsscBaseTaxRate.do?method=data&fdCompanyId=${param.fdCompanyId }')}
                </ui:source>
                <!-- 列表视图 -->
                <list:colTable isDefault="false" rowHref="/fssc/base/fssc_base_tax_rate/fsscBaseTaxRate.do?method=view&fdId=!{fdId}" name="columntable">
                    <list:col-checkbox />
                    <list:col-serial/>
                    <list:col-auto props="fdCompany.name;fdRate;fdAccount.name;fdIsAvailable.name;docCreator.name;docCreateTime;operations" /></list:colTable>
            </list:listview>
            <!-- 翻页 -->
            <list:paging />
        </div>
        <script>
            var listOption = {
                contextPath: '${LUI_ContextPath}',
                modelName: 'com.landray.kmss.fssc.base.model.FsscBaseTaxRate',
                templateName: '',
                basePath: '/fssc/base/fssc_base_tax_rate/fsscBaseTaxRate.do',
                canDelete: '${canDelete}',
                mode: '',
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