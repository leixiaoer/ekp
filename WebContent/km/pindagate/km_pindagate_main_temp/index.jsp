<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include file="/sys/profile/resource/template/list.jsp">
	<template:replace name="content">
		<!-- 筛选器 -->
		<list:criteria id="criteria">
		     <list:cri-ref key="docSubject" ref="criterion.sys.docSubject" title="${lfn:message('km-pindagate:kmPindagateMainTemp.docSubject') }">
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
					   <list:sort property="fdOrder" text="${lfn:message('km-pindagate:kmPindagateTemplate.fdOrder') }" group="sort.list" value="up"></list:sort>
					   <list:sort property="docSubject" text="${lfn:message('km-pindagate:kmPindagateMainTemp.docSubject') }" group="sort.list"></list:sort>
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
						<kmss:auth requestURL="/km/pindagate/km_pindagate_main_temp/kmPindagateMainTemp.do?method=add">
							<ui:button text="${lfn:message('button.add')}" onclick="add();"></ui:button>
						</kmss:auth>
						<kmss:auth requestURL="/km/pindagate/km_pindagate_main_temp/kmPindagateMainTemp.do?method=deleteall&parentId=${param.parentId}">
							<ui:button text="${lfn:message('button.deleteall')}" onclick="deleteAll();"></ui:button>
						</kmss:auth>
					</ui:toolbar>	
				</div>
			</div>
		</div>
		<ui:fixed elem=".lui_list_operation"></ui:fixed>
		<!-- 内容列表 -->
		<list:listview>
			<ui:source type="AjaxJson">
				{url:'/km/pindagate/km_pindagate_main_temp/kmPindagateMainTemp.do?method=listChildren&parentId=${param.parentId}'}
			</ui:source>
			<list:colTable isDefault="true" layout="sys.ui.listview.columntable" 
			     rowHref="/km/pindagate/km_pindagate_main_temp/kmPindagateMainTemp.do?method=view&fdId=!{fdId}">
				<list:col-checkbox></list:col-checkbox>
				<list:col-serial></list:col-serial>
				<list:col-auto props="docSubject,operations"></list:col-auto>
			</list:colTable>
		</list:listview>
		<br>
		<!-- 分页 -->
	 	<list:paging/>
	 	<script type="text/javascript">
		 	seajs.use(['lui/jquery', 'lui/dialog', 'lui/topic'], function($, dialog, topic) {

		 		topic.subscribe('successReloadPage', function() {
					topic.publish('list.refresh');
				});
		 		
		 		window.add = function() {
		 			Com_OpenWindow('<c:url value="/km/pindagate/km_pindagate_main_temp/kmPindagateMainTemp.do" />?method=add&parentId=${param.parentId}');
		 		};

		 		window.edit = function(id){
					if(id){
						Com_OpenWindow('<c:url value="/km/pindagate/km_pindagate_main_temp/kmPindagateMainTemp.do?method=edit&fdId=" />'+id, '_blank');
					}
			 	};
		 		
		 		window.deleteAll = function(id){
					var values = [];
					if(id){
						values.push(id);
					}else{
					    $("input[name='List_Selected']:checked").each(function(){
							values.push($(this).val());
						});
					    if(values.length==0){
							dialog.alert('<bean:message key="page.noSelect"/>');
							return;
						}
					}
					dialog.confirm('<bean:message key="page.comfirmDelete"/>',function(value){
						if(value==true){
							window.del_load = dialog.loading();
							$.post('<c:url value="/km/pindagate/km_pindagate_main_temp/kmPindagateMainTemp.do?method=deleteall"/>',
									$.param({"List_Selected":values},true),delCallback,'json');
						}
					});
				};
				window.delCallback = function(data){
					if(window.del_load!=null){
						window.del_load.hide();
					}
					topic.publish("list.refresh");
					dialog.result(data);
				};
		 	});
	 	</script>
	</template:replace>
</template:include>
