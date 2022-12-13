<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@ taglib uri="/WEB-INF/KmssConfig/fssc/common/fssc.tld" prefix="fssc"%>
    <template:include ref="default.simple4list" spa="true" rwd="true">
        <template:replace name="title">
            <c:out value="${ lfn:message('fssc-budget:module.fssc.budget') }-${ lfn:message('fssc-budget:table.fsscBudgetData') }" />
        </template:replace>
        <template:replace name="content">
        	<ui:tabpanel id="fsDataPanel" layout="sys.ui.tabpanel.list" cfg-router="true">
			<ui:content id="fsDataContent" title="${lfn:message('fssc-budget:table.fsscBudgetData')}">
            <div style="margin:5px 10px;">
                <!-- 筛选条件页面 -->
               <c:import url="/fssc/budget/fssc_budget_data/scheme_criteria.jsp" charEncoding="UTF-8"></c:import>
                <!-- 操作 -->
                <div class="lui_list_operation">

                    <div style="float:left;">
                        <list:paging layout="sys.ui.paging.top" />
                    </div>
                    <div style="float:right">
                        <div style="display: inline-block;vertical-align: middle;">
                            <ui:toolbar count="5">
								<kmss:authShow roles="ROLE_FSSCBUDGET_RESTART_PAUSE">
	                                <ui:button text="${lfn:message('fssc-budget:fsscBudget.button.budget.stop')}" onclick="alterBudgetStatus('stop')" order="1" />
	                                <ui:button text="${lfn:message('fssc-budget:fsscBudget.button.budget.batch.restart')}" onclick="alterBudgetStatus('restart')" order="2" />
	                            </kmss:authShow>
	                            <kmss:authShow roles="ROLE_FSSCBUDGET_CLOSE">
                                  	<ui:button text="${lfn:message('fssc-budget:fsscBudget.button.budget.batch.close')}" onclick="alterBudgetStatus('close')" order="3" />
	                            </kmss:authShow>
                                <kmss:auth requestURL="/fssc/budget/fssc_budget_data/fsscBudgetData.do?method=deleteall">
                                    <c:set var="canDelete" value="true" />
                                </kmss:auth>
                                <!---->
                                <ui:button text="${lfn:message('button.deleteall')}" onclick="deleteAllBudgetData()" order="5" id="btnDelete" />
                            </ui:toolbar>
                        </div>
                    </div>
                </div>
                <ui:fixed elem=".lui_list_operation" />
                <!-- 列表 -->
                <list:listview id="listview">
                    <ui:source type="AjaxJson">
                        {url:appendQueryParameter('/fssc/budget/fssc_budget_data/fsscBudgetData.do?method=data&fdSchemeId=${HtmlParam.fdSchemeId }')}
                    </ui:source>
                    <!-- 列表视图 -->
                    <list:colTable isDefault="false" rowHref="/fssc/budget/fssc_budget_data/fsscBudgetData.do?method=view&fdId=!{fdId}" name="columntable">
                        <list:col-checkbox />
                        <list:col-serial/>
                        <list:col-auto props="${fssc:showBudgetColomu(param.fdSchemeId)}fdMoney;fdElasticPercent;fdBudgetStatus;docCreator.name;docCreateTime;"
                        /></list:colTable>
                </list:listview>
                <!-- 翻页 -->
                <list:paging />
            </div>
            </ui:content>
            </ui:tabpanel>
            <script>
                var listOption = {
                    contextPath: '${LUI_ContextPath}',
                    modelName: 'com.landray.kmss.fssc.budget.model.FsscBudgetData',
                    templateName: '',
                    basePath: '/fssc/budget/fssc_budget_data/fsscBudgetData.do',
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
                Com_IncludeFile("list.js", "${LUI_ContextPath}/fssc/budget/resource/js/", 'js', true);
            </script>
        </template:replace>
    </template:include>