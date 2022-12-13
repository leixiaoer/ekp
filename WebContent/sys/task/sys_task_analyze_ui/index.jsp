<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple" spa="true">
	<template:replace name="body">
	<script type="text/javascript">
		seajs.use(['theme!list']);	
	</script>
	<%--右侧--%>
		<script type="text/javascript">
		Com_IncludeFile("data.js");
		 	seajs.use(['lui/jquery','lui/dialog','lui/topic','lui/toolbar','lui/spa/const'], function($, dialog , topic,toolbar, spaConst) {
				
		 		topic.subscribe(spaConst.SPA_CHANGE_VALUES, function(evt) {
					if(LUI('add')&&evt.value['type'] != null){
						 LUI('toolbar').removeButton(LUI('add'));
						var btn=toolbar.buildButton({text:'${lfn:message("sys-task:sysTaskAnalyze.analyze.create.button")}',id:'add',click:'addAnalyze("'+evt.value.type+'")',order:'2'});
						 LUI('toolbar').addButton(btn);
					}
				});
		 		// 监听新建更新等成功后刷新
				topic.subscribe('successReloadPage', function() {
					topic.publish('list.refresh');
				});
				
		 		//新建
				window.addAnalyze = function(type) {
					Com_OpenWindow('${LUI_ContextPath}/sys/task/sys_task_analyze/sysTaskAnalyze.do?method=add&type='+type);
				};
				
				//删除
				window.delAnalyze = function(){
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
							window.delAnalyze_load = dialog.loading();
							$.post('<c:url value="/sys/task/sys_task_analyze/sysTaskAnalyze.do?method=deleteall"/>',
									$.param({"List_Selected":values},true),delAnalyzeCallback,'json');
						}
					});
				};
				
				//删除回调函数
				window.delAnalyzeCallback = function(data){
					if(window.delAnalyze_load!=null)
						window.delAnalyze_load.hide();
					if(data!=null && data.status==true){
						topic.publish("list.refresh");
						dialog.success('<bean:message key="return.optSuccess" />');
					}else{
						dialog.failure('<bean:message key="return.optFailure" />');
					}
				};
				
				//修改新增按钮
			 	/* topic.subscribe('criteria.spa.changed',function(evt){
			 		for(var i=0;i<evt['criterions'].length;i++){
						 if(LUI('add')&&evt['criterions'][i].key=="type"&&evt['criterions'][i].value.length==1){
							 LUI('toolbar').removeButton(LUI('add'));
							var btn=toolbar.buildButton({text:'${lfn:message("sys-task:sysTaskAnalyze.analyze.create.button")}',id:'add',click:'addAnalyze("'+evt['criterions'][i].value[0]+'")',order:'2'});
							 LUI('toolbar').addButton(btn);
						}
				 	}
				}); */
			 });
	 	</script>	 
		<list:criteria id="sysTaskAnalyzeCriteria">		
			<%-- 搜索条件:名称--%>
			<list:cri-ref key="docSubject" ref="criterion.sys.docSubject" title="${lfn:message('sys-task:sysTaskAnalyze.docSubject') }">
			</list:cri-ref>
			<%-- <list:cri-criterion title="${lfn:message('sys-task:sysTaskAnalyze.fdAnalyzeType')}" key="type" expand="false">
				<list:box-select>
					<list:item-select>
						<ui:source type="Static">
							[{text:'${ lfn:message('sys-task:tree.load') }', value:'1'},{text:'${ lfn:message('sys-task:tree.degree') }',value:'2'},{text:'${ lfn:message('sys-task:tree.type') }', value: '4'},{text:'${ lfn:message('sys-task:tree.trend') }', value: '5'}]
						</ui:source>
					</list:item-select>
				</list:box-select>
			</list:cri-criterion> --%>
		</list:criteria>
		
		<%--操作栏--%>
		<div class="lui_list_operation">
			<!-- 全选 -->
			<div class="lui_list_operation_order_btn">
				<list:selectall></list:selectall>
			</div>
			<!-- 分割线 -->
			<div class="lui_list_operation_line"></div>
			<!-- 排序 -->
			<div class="lui_list_operation_sort_btn">
				<div class="lui_list_operation_order_text">
					${ lfn:message('list.orderType') }：
				</div>
				<div class="lui_list_operation_sort_toolbar">
					<ui:toolbar layout="sys.ui.toolbar.sort" style="float:left" >
						<list:sortgroup>
							<list:sort property="docCreateTime" text="${lfn:message('sys-task:sysTaskAnalyze.docCreateTime') }" group="sort.list" value="down"></list:sort>
							<list:sort property="fdStartDate" text="${lfn:message('sys-task:sysTaskAnalyze.startDate') }" group="sort.list"></list:sort>
							<list:sort property="fdEndDate" text="${lfn:message('sys-task:sysTaskAnalyze.endDate') }" group="sort.list"></list:sort>
						</list:sortgroup>
					</ui:toolbar>
				</div>
			</div>
			<!-- 分页 -->
			<div class="lui_list_operation_page_top">	
				<list:paging layout="sys.ui.paging.top" > 		
				</list:paging>
			</div>
			<div style="float:right">
				<div style="display: inline-block;vertical-align: middle;">
					<ui:toolbar id="toolbar" count="2">
						<%--新建--%>
						<kmss:auth requestURL="/sys/task/sys_task_analyze/sysTaskAnalyze.do?method=add" requestMethod="GET">
							<ui:button id="add" text="${lfn:message('sys-task:sysTaskAnalyze.analyze.create.button')}" onclick="addAnalyze('1')" order="2"></ui:button>	
						</kmss:auth>
						<%--
						<kmss:authShow roles="ROLE_SYSTASK_TRANSPORT_EXPORT">
						<ui:button text="${lfn:message('button.export')}" id="export" onclick="listExport('${LUI_ContextPath}/sys/transport/sys_transport_export/SysTransportExport.do?method=listExport')" order="4" ></ui:button>
						</kmss:authShow>
						 --%>
						<%--删除--%>
						<kmss:auth requestURL="/sys/task/sys_task_analyze/sysTaskAnalyze.do?method=deleteall" requestMethod="GET">						
							<ui:button text="${lfn:message('button.deleteall')}" onclick="delAnalyze()" order="4"></ui:button>
						</kmss:auth>
					</ui:toolbar>
				</div>
			</div>
		</div>		
		<ui:fixed elem=".lui_list_operation"></ui:fixed>
		<%--list视图--%>
		<list:listview id="listview">
			<ui:source type="AjaxJson">
				{url:'/sys/task/sys_task_analyze/sysTaskAnalyze.do?method=list'}
			</ui:source>
			<%--列表形式--%>
			<list:colTable url="${LUI_ContextPath }/sys/profile/listShow/sys_listShow/sysListShow.do?method=getSort&modelName=com.landray.kmss.sys.task.model.SysTaskAnalyze" isDefault="false" layout="sys.ui.listview.columntable" 
				rowHref="/sys/task/sys_task_analyze/sysTaskAnalyze.do?method=view&fdId=!{fdId}&type=!{fdAnalyzeType}"  name="columntable">
				<list:col-checkbox></list:col-checkbox>
				<list:col-serial></list:col-serial>
				<list:col-auto></list:col-auto>
			</list:colTable>   
		</list:listview> 
	 	<list:paging></list:paging>	 
	 	
	</template:replace>
	
</template:include>