<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include file="/sys/profile/resource/template/list.jsp">
<template:replace name="content">
		<!-- 筛选器 -->
		<list:criteria id="criteria">
		     <list:cri-ref key="fdId" ref="criterion.sys.docSubject" title="${lfn:message('sys-task:sysTaskApprove.fdScore') }">
			</list:cri-ref>
		</list:criteria>
		<!-- 操作栏 -->
		<div class="lui_list_operation">
			<!-- 排序 -->
			<div style='color: #979797;float: left;padding-top:1px;'>
				${ lfn:message('list.orderType') }：
			</div>
			<div style="float:left">
				<div style="display: inline-block;vertical-align: middle;">
					<ui:toolbar layout="sys.ui.toolbar.sort" style="float:left" >
					<list:sortgroup>
						<list:sort property="fdScore" text="${lfn:message('sys-task:sysTaskApprove.fdScore') }" group="sort.list" value="down"></list:sort>
						<list:sort property="fdApprove" text="${lfn:message('sys-task:sysTaskApprove.fdApprove') }" group="sort.list"></list:sort>
					</list:sortgroup>
					</ui:toolbar>
				</div>
			</div>
			<div style="float:left;">	
				<list:paging layout="sys.ui.paging.top" > 		
				</list:paging>
			</div>
			<!-- 操作按钮 -->
			<div style="float:right">
				<div style="display: inline-block;vertical-align: middle;">
					<ui:toolbar id="Btntoolbar">
						<kmss:auth requestURL="/sys/task/sys_task_approve/.do?method=add">
						    <ui:button text="${lfn:message('button.add')}" onclick="add();" order="1" ></ui:button>
						</kmss:auth>
						<kmss:auth requestURL="/sys/task/sys_task_approve/sysTaskApprove.do?method=deleteall">
						    <ui:button text="${lfn:message('button.deleteall')}" onclick="deleteAll();" order="2" ></ui:button>
						</kmss:auth>
					</ui:toolbar>
				</div>
			</div>
		</div>
		<ui:fixed elem=".lui_list_operation"></ui:fixed>
		<!-- 内容列表 -->
		<list:listview>
		<ui:source type="AjaxJson">
				{url:'/sys/task/sys_task_approve/sysTaskApprove.do?method=data&fdId=${fdId}'}
		</ui:source>
			<%-- <list:colTable isDefault="false"
			rowHref="/sys/task/sys_task_approve/sysTaskApprove.do?method=view&fdId=!{fdId}"  name="columntable">
			 <list:col-checkbox></list:col-checkbox>
				<list:col-serial></list:col-serial>
				<list:col-column property="sysTaskApprove.fdOrder" style="width:25%"></list:col-column>
				<list:col-column property="sysTaskApprove.fdApprove" style="width:10%"></list:col-column>
				<list:col-column property="sysTaskApprove.fdScore" style="width:10%"></list:col-column>
				<list:col-column property="sysTaskApprove.fdIsAvailable" style="width:10%"></list:col-column>				
			</list:colTable> --%>
			<list:colTable isDefault="true" 
			rowHref="/sys/task/sys_task_approve/sysTaskApprove.do?method=view&fdId=!{fdId}"
			layout="sys.ui.listview.columntable" >
				<list:col-checkbox></list:col-checkbox>
				<list:col-serial></list:col-serial>
				<list:col-auto props="fdApprove,fdScore,fdIsAvailable"></list:col-auto>			
			</list:colTable>
			<ui:event topic="list.loaded">
				Dropdown.init();
			</ui:event>
		</list:listview>
		<br>
		<!-- 分页 -->
	 	<list:paging/>
	 	
	 	<script type="text/javascript">
		 	seajs.use(['lui/jquery', 'lui/dialog', 'lui/topic'], function($, dialog, topic) {
		 		// 监听新建更新等成功后刷新
				topic.subscribe('successReloadPage', function() {
					topic.publish("list.refresh");
				});
			 	// 增加
		 		window.add = function() {
		 			Com_OpenWindow('<c:url value="/sys/task/sys_task_approve/sysTaskApprove.do" />?method=add');
		 		};
		 		// 编辑
		 		<%-- window.edit = function(id) {
			 		if(id)
		 				Com_OpenWindow('<c:url value="/sys/task/sys_task_approve/sysTaskApprove.do" />?method=edit&fdId=' + id);
		 		};--%>
		 		window.deleteAll = function(){
					var values = [];
					$("input[name='List_Selected']:checked").each(function(){
							values.push($(this).val());
						});
					if(values.length==0){
						dialog.alert('<bean:message key="page.noSelect"/>');
						return;
					}
					dialog.confirm('<bean:message key="page.comfirmDelete"/>',function(value){
						if(value==true){
							window.del_load = dialog.loading();
							$.post('<c:url value="/sys/task/sys_task_approve/sysTaskApprove.do?method=deleteall"/>',
									$.param({"List_Selected":values},true),delCallback,'json');
						}
					});
				};
				window.delCallback = function(data){
					if(window.del_load!=null){
						window.del_load.hide();
						topic.publish("list.refresh");
					}
					dialog.result(data);
				};
		 	});
	 	</script>
	</template:replace>
</template:include>
		