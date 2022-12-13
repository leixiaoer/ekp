<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.dialog">
	<template:replace name="head">
		<style type="text/css">
		</style>
	</template:replace>
	<template:replace name="content"> 
		<p class="txttitle" style="margin: 10px 0;">
			<bean:message bundle="sys-task" key="table.sysTaskReject"/>
		</p>
		<table class="tb_normal" width="98%">
			<tr>
				<td colspan="4">
					<div style="max-height: 305px;overflow-y: auto;">
						<%--列表--%>
						<list:listview id="listview" style="">
							<ui:source type="AjaxJson" >
								{url:'/sys/task/sys_task_reject/sysTaskReject.do?method=data&fdTaskId=${JsParam.taskId}&fdPerformId=${JsParam.performId}'}
							</ui:source>
							<list:colTable isDefault="false" layout="sys.ui.listview.listtable" name="columntable">
								<list:col-serial></list:col-serial>
								<list:col-auto props="docCreator.name;fdReason;docCreateTime" url="" />
							</list:colTable>
						</list:listview>
						<list:paging></list:paging>
					</div>
				</td>
			</tr>
		</table>
	
	</template:replace>
</template:include>
