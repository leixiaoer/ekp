<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@ taglib uri="/WEB-INF/KmssConfig/fssc/common/fssc.tld" prefix="fssc" %>
<template:include ref="config.list">
	<template:replace name="path">
		<span class="txtlistpath">
			<div class="lui_icon_s lui_icon_s_home" style="float: left;"></div>
			<div style="float: left;margin:5px 10px;">
				<bean:message key="page.curPath" /><%=java.net.URLDecoder.decode(request.getParameter("s_path"), "utf-8")%>
			</div></span>
    </template:replace>
    <template:replace name="content">
        <div style="margin:5px 10px;">
            <!-- 筛选 -->
            <list:criteria id="criteria1">
                <list:cri-ref key="fdName" ref="criterion.sys.docSubject" title="${lfn:message('fssc-base:fsscBaseExpenseItem.fdName')}" />
                <list:cri-auto modelName="com.landray.kmss.fssc.base.model.FsscBaseExpenseItem" property="fdCode" expand="true" />
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
                <list:cri-criterion title="${lfn:message('fssc-base:fsscBaseExpenseItem.fdIsAvailable')}" key="fdIsAvailable">
					<list:box-select>
						<list:item-select  cfg-defaultValue="true">
							<ui:source type="Static">
							    [{text:'${ lfn:message('message.yes')}', value:'true'},
								{text:'${ lfn:message('message.no')}',value:'false'}]
							</ui:source>
						</list:item-select>
					</list:box-select>
				</list:cri-criterion>
                <list:cri-auto modelName="com.landray.kmss.fssc.base.model.FsscBaseExpenseItem" property="docCreator" />
                <list:cri-auto modelName="com.landray.kmss.fssc.base.model.FsscBaseExpenseItem" property="docCreateTime" />

            </list:criteria>
            <!-- 操作 -->
            <div class="lui_list_operation">

                <div style='color: #979797;float: left;padding-top:1px;'>
                    ${ lfn:message('list.orderType') }：
                </div>
                <div style="float:left">
                    <div style="display: inline-block;vertical-align: middle;">
                        <ui:toolbar layout="sys.ui.toolbar.sort" style="float:left">
                            <list:sort property="fdCode" text="${lfn:message('fssc-base:fsscBaseExpenseItem.fdCode')}" group="sort.list" value="up"/>
                        </ui:toolbar>
                    </div>
                </div>
                <div style="float:left;">
                    <list:paging layout="sys.ui.paging.top" />
                </div>
                <div style="float:right">
                    <div style="display: inline-block;vertical-align: middle;">
                        <ui:toolbar count="9" id="btn">
                        	<ui:button text="${lfn:message('fssc-base:button.showTree')}" onclick="switchTree()" order="1" />
                        	<kmss:auth requestURL="/fssc/base/fssc_base_expense_item/fsscBaseExpenseItem.do?method=add">
                                <ui:button text="${lfn:message('button.add')}" onclick="addDoc()" order="2" />
                            </kmss:auth>
							<%-- <kmss:auth requestURL="/fssc/base/fssc_base_expense_item/fsscBaseExpenseItem.do?method=copy">
								<ui:button text="${lfn:message('fssc-base:button.copy')}" onclick="copy()" order="3" />
							</kmss:auth> --%>
							<kmss:auth requestURL="/fssc/base/fssc_base_expense_item/fsscBaseExpenseItem.do?method=enable">
								<ui:button text="${lfn:message('fssc-base:button.enable')}" onclick="enable()" order="3" />
							</kmss:auth>
							<kmss:auth requestURL="/fssc/base/fssc_base_expense_item/fsscBaseExpenseItem.do?method=disable">
								<ui:button text="${lfn:message('fssc-base:button.disable')}" onclick="disable()" order="3" />
							</kmss:auth>
                            <kmss:auth requestURL="/fssc/base/fssc_base_expense_item/fsscBaseExpenseItem.do?method=deleteall">
                                <c:set var="canDelete" value="true" />
                            </kmss:auth>
                            <!---->
                            <ui:button text="${lfn:message('button.deleteall')}" onclick="deleteAll()" order="6" id="btnDelete" />

                        </ui:toolbar>
                    </div>
                </div>
            </div>
            <ui:fixed elem=".lui_list_operation" />
            <!-- 列表 -->
            <list:listview id="listview">
                <ui:source type="AjaxJson">
                    {url:'/fssc/base/fssc_base_expense_item/fsscBaseExpenseItem.do?method=data&fdCompanyId=${param.fdCompanyId }'}
                </ui:source>
                <!-- 列表视图 -->
                <list:colTable isDefault="false" rowHref="/fssc/base/fssc_base_expense_item/fsscBaseExpenseItem.do?method=view&fdId=!{fdId}" name="columntable">
                    <list:col-checkbox />
                    <list:col-serial/>
                    <list:col-auto props="fdName;fdCode;fdCompany.name;fdParent.name;fdIsAvailable.name;fdOrder;docCreator.name;docCreateTime;operations" /></list:colTable>
            </list:listview>
            <!-- 翻页 -->
            <list:paging />
        </div>
        <script>
            var listOption = {
                contextPath: '${LUI_ContextPath}',
                modelName: 'com.landray.kmss.fssc.base.model.FsscBaseExpenseItem',
                templateName: '',
                basePath: '/fssc/base/fssc_base_expense_item/fsscBaseExpenseItem.do',
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