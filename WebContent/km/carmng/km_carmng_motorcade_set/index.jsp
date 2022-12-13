<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include file="/sys/profile/resource/template/list.jsp">
<template:replace name="content">
		<!-- 筛选器 -->
		<list:criteria id="criteria">
		     <list:cri-ref key="fdSearchName" ref="criterion.sys.docSubject" title="${lfn:message('km-carmng:kmCarmngMotorcadeSet.fdName') }">
			</list:cri-ref>
		</list:criteria>
		<!-- 操作栏 -->
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
							<list:sort property="fdOrder" text="${lfn:message('km-carmng:kmCarmngMotorcadeSet.fdOrder') }" group="sort.list" value="up"></list:sort>
							<list:sort property="docCreateTime" text="${lfn:message('km-carmng:kmCarmngMotorcadeSet.docCreateTime') }" group="sort.list" ></list:sort>
							<list:sort property="fdName" text="${lfn:message('km-carmng:kmCarmngMotorcadeSet.fdName') }" group="sort.list" ></list:sort>
						</list:sortgroup>
					</ui:toolbar>
				</div>
			</div>
			<!-- 分页 -->
			<div class="lui_list_operation_page_top">	
				<list:paging layout="sys.ui.paging.top" > 		
				</list:paging>
			</div>
			<!-- 操作按钮 -->
			<div style="float:right">
				<div style="display: inline-block;vertical-align: middle;">
					<ui:toolbar id="Btntoolbar">
						<kmss:auth requestURL="/km/carmng/km_carmng_motorcade_set/kmCarmngMotorcadeSet.do?method=add">
						    <ui:button text="${lfn:message('button.add')}" onclick="add();" order="1" ></ui:button>
						</kmss:auth>
						<kmss:auth requestURL="/km/carmng/km_carmng_motorcade_set/kmCarmngMotorcadeSet.do?method=deleteall">
						    <ui:button text="${lfn:message('button.deleteall')}" onclick="deleteAll();" order="2" ></ui:button>
						    <!-- 快速排序 -->
							<c:import url="/sys/profile/common/change_order_num.jsp" charEncoding="UTF-8">
								<c:param name="modelName" value="com.landray.kmss.km.carmng.model.KmCarmngMotorcadeSet"></c:param>
								<c:param name="property" value="fdOrder"></c:param>
							</c:import>
						</kmss:auth>
					</ui:toolbar>
				</div>
			</div>
		</div>
		<ui:fixed elem=".lui_list_operation"></ui:fixed>
		<!-- 内容列表 -->
		<list:listview>
		<ui:source type="AjaxJson">
				{url:'/km/carmng/km_carmng_motorcade_set/kmCarmngMotorcadeSet.do?method=list'}
		</ui:source>
			<list:colTable isDefault="true" 
			rowHref="/km/carmng/km_carmng_motorcade_set/kmCarmngMotorcadeSet.do?method=view&fdId=!{fdId}"
			layout="sys.ui.listview.columntable" >
				<list:col-checkbox></list:col-checkbox>				
				<list:col-auto props="fdOrder,fdName,fdDispatchers.fdName,fdRegister.fdName,docCreator.fdName,docCreateTime,operations"></list:col-auto>			
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
		 			Com_OpenWindow('<c:url value="/km/carmng/km_carmng_motorcade_set/kmCarmngMotorcadeSet.do" />?method=add');
		 		};
		 		
		 	// 增加
		 		window.addDriver = function(id) {
		 			if(id)
		 				Com_OpenWindow('<c:url value="/km/carmng/km_carmng_drivers_info/kmCarmngDriversInfo.do" />?method=add&motorcadeId='+id);
		 		};
		 	// 增加
		 		window.addCar = function(id) {
		 			if(id)
		 				Com_OpenWindow('<c:url value="/km/carmng/km_carmng_infomation/kmCarmngInfomation.do" />?method=add&motorcadeId='+id);
		 		};
		 		
		 		
		 		//编辑
		 		window.edit = function(id) {
			 		if(id)
		 				Com_OpenWindow('<c:url value="/km/carmng/km_carmng_motorcade_set/kmCarmngMotorcadeSet.do" />?method=edit&fdId=' + id);
		 		};
		 		// 删除
		 		window.deleteAll = function(id){
					var values = [];
					if(id){
						values.push(id);
						}else{
							$("input[name='List_Selected']:checked").each(function(){
							values.push($(this).val());
							});
						}
					if(values.length==0){
						dialog.alert('<bean:message key="page.noSelect"/>');
						return;
					}
					dialog.confirm('<bean:message key="page.comfirmDelete"/>',function(value){
						if(value==true){
							window.del_load = dialog.loading();
							$.ajax({
								type: "POST",
								dataType : 'json',
								data: $.param({"List_Selected":values},true),
								url: '<c:url value="/km/carmng/km_carmng_motorcade_set/kmCarmngMotorcadeSet.do?method=deleteall"/>',
								success:function(result){
									if (delCallback){
										delCallback(result);
									}
								},
								error:function(result){
									dialog.failure("${lfn:message('return.optFailure')}");
								}
							});
						}
					});
				};
				window.delCallback = function(data){
					if(window.del_load!=null){
						window.del_load.hide();
						topic.publish("list.refresh");
					}
					if(data.result == 'failure'){
						dialog.failure(data.msg);
					}else{
						dialog.success(data.msg);
					}
				};
		 	});
	 	</script>
	</template:replace>
</template:include>