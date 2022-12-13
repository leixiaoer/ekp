<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="com.landray.kmss.sys.subordinate.plugin.PropertyItem"%>
<%@ page import="com.landray.kmss.sys.task.subordinate.SysTaskMainProvider"%>

<%
	SysTaskMainProvider provider = new SysTaskMainProvider();
	List<PropertyItem> propertyItems = provider.items();
%>

<script type="text/javascript">
	seajs.use(['theme!list']);	
</script>
<style>
	.listview .columnTable .lui_listview_body {
		overflow-x:inherit;
	}
</style>

<ui:tabpanel>
	<% for (PropertyItem propertyItem : propertyItems) { 
		pageContext.setAttribute("propertyItem", propertyItem);
	%>
		<ui:content id="${propertyItem.item}Content" title='${propertyItem.itemMessageKey}'>
			<%--右侧--%>
			<list:criteria id="sysTaskMainCriteria${propertyItem.item}" channel="sysTaskMain${propertyItem.item}">
				<%-- 主题、任务状态、任务接收人、任务指派人、接收人部门、指派人部门、要求完成时间--%>
				<%-- 搜索条件:任务名称--%>
				<list:cri-ref key="docSubject" ref="criterion.sys.docSubject" title="${lfn:message('sys-task:sysTaskMain.docSubject') }">
				</list:cri-ref>
				
				<%--任务状态--%>
				<list:cri-criterion title="${ lfn:message('sys-task:sysTaskMain.fdStatus') }" key="fdStatus" channel="sysTaskMain${propertyItem.item}">
					<list:box-select><list:item-select>
						<ui:source type="Static">
								[{text:'${ lfn:message('sys-task:tree.sysTaskMain.status.inactive') }', value:'1'},
								{text:'${ lfn:message('sys-task:tree.sysTaskMain.status.progress') }',value:'2'}, 
								{text:'${ lfn:message('sys-task:tree.sysTaskMain.status.complete') }', value: '3'},
								{text:'${ lfn:message('sys-task:sysTaskMain.status.overrule') }', value: '5'},
								{text:'${ lfn:message('sys-task:tree.sysTaskMain.status.terminate') }', value: '4'},
								{text:'${ lfn:message('sys-task:tree.sysTaskMain.status.close') }', value: '6'}]
							</ui:source>
					</list:item-select></list:box-select>
				</list:cri-criterion>
				
				<%--是否过期--%>
				<list:cri-criterion title="${ lfn:message('sys-task:sysTaskMain.fdPastDue') }" key="fdPastDue" channel="sysTaskMain${propertyItem.item}">
					<list:box-select><list:item-select>
						<ui:source type="Static">
								[{text:'${ lfn:message('sys-task:sysTaskMain.status.overdure') }', value:'1'},
								{text:'${ lfn:message('sys-task:sysTaskMain.status.unexpired') }', value: '0'}]
							</ui:source>
					</list:item-select></list:box-select>
				</list:cri-criterion>
				
				<%--任务类型--%>
				<list:cri-criterion title="${ lfn:message('sys-task:sysTaskMain.fdCategoryId') }" key="sysTaskCategory" channel="sysTaskMain${propertyItem.item}">
					<list:box-select><list:item-select>
						<ui:source type="AjaxJson">
							{url:'/sys/task/sys_task_category/sysTaskCategory.do?method=getTaskCategory'}
						</ui:source>
					</list:item-select></list:box-select>
				</list:cri-criterion>
				
				<%--任务评价--%>
				<list:cri-criterion title="${ lfn:message('sys-task:table.sysTaskEvaluate') }" key="taskApproves" multi="false" channel="sysTaskMain${propertyItem.item}">
					<list:box-select><list:item-select>
						<ui:source type="AjaxJson">
							{url:'/sys/task/sys_task_approve/sysTaskApprove.do?method=getTaskApprove'}
						</ui:source>
					</list:item-select></list:box-select>
				</list:cri-criterion>
				
				<!-- 任务来源 -->
				<list:cri-criterion title="${lfn:message('sys-task:sysTaskMain.fdSourceSubject') }" key="fdModelName" multi="true" channel="sysTaskMain${propertyItem.item}">
					<list:box-select>
						<list:item-select type="lui/criteria!CriterionSelectDatas">
							<ui:source type="AjaxJson" >
								{url: "/sys/task/sys_task_main/sysTaskIndex.do?method=getModules"}
							</ui:source>
						</list:item-select>
					</list:box-select>
				</list:cri-criterion>
				<list:cri-auto modelName="com.landray.kmss.sys.task.model.SysTaskMain"  property="fdPlanCompleteDateTime" />
			</list:criteria>
			
			<%--操作栏--%>
			<div class="lui_list_operation">
				<div style='color: #979797;float: left;padding-top:1px;'>
					${ lfn:message('list.orderType') }：
				</div>
				<div style="float:left">
					<div style="display: inline-block;vertical-align: middle;">
						<ui:toolbar layout="sys.ui.toolbar.sort" style="float:left" count="3" channel="sysTaskMain${propertyItem.item}">
							<list:sortgroup>
								<list:sort property="docCreateTime" text="${lfn:message('sys-task:sysTaskMain.docCreateTime') }" group="sort.list" value="down"></list:sort>
								<list:sort property="fdPlanCompleteDateTime" text="${lfn:message('sys-task:sysTaskMain.fdPlanCompleteTime') }" group="sort.list" ></list:sort>
								<list:sort property="fdProgressNumber" text="${lfn:message('sys-task:sysTaskMain.fdProgress') }" group="sort.list"></list:sort>
							</list:sortgroup>
						</ui:toolbar>
					</div>
				</div>
				<div style="float:left;">	
					<list:paging layout="sys.ui.paging.top" channel="sysTaskMain${propertyItem.item}">
					</list:paging>
				</div>
			</div>
			<ui:fixed elem=".lui_list_operation"></ui:fixed>
			<%--list视图--%>
			<list:listview id="listview${propertyItem.item}" channel="sysTaskMain${propertyItem.item}">
				<ui:source type="AjaxJson">
					{url:'/sys/subordinate/sysSubordinate.do?method=list&modelName=com.landray.kmss.sys.task.model.SysTaskMain&item=${propertyItem.item}&orgId=${JsParam.orgId}'}
				</ui:source>
				<%--列表形式--%>
				<list:colTable isDefault="false" layout="sys.task.listview.columntable" channel="collaborateMain${propertyItem.item}"
					rowHref="/sys/subordinate/sysSubordinate.do?method=view&modelId=!{fdId}&modelName=com.landray.kmss.sys.task.model.SysTaskMain&orgId=${JsParam.orgId}"  name="columntable">
					<list:col-serial></list:col-serial>
					<list:col-auto props=""></list:col-auto>
				</list:colTable>   
			</list:listview> 
			<list:paging channel="sysTaskMain${propertyItem.item}"></list:paging>
		</ui:content>
	<% } %>
</ui:tabpanel>