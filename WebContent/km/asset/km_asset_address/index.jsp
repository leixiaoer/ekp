<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include file="/sys/profile/resource/template/list.jsp">
	<template:replace name="content">
		<!-- 筛选器 -->
		<list:criteria id="criteria">
		     <list:cri-ref key="fdAddress" ref="criterion.sys.docSubject" title="${lfn:message('km-asset:kmAssetAddress.fdAddress') }">
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
						<list:sort property="docCreateTime" text="${lfn:message('km-asset:kmAssetAddress.docCreateTime') }" group="sort.list" value="down"></list:sort>
						<list:sort property="fdAddress" text="${lfn:message('km-asset:kmAssetAddress.fdAddress') }" group="sort.list"></list:sort>
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
					    <kmss:auth requestURL="/km/asset/km_asset_address/kmAssetAddress.do?method=add" requestMethod="GET">
					        <ui:button text="${lfn:message('button.add')}" onclick="add();" order="1" ></ui:button>
					        <ui:button text="${lfn:message('button.import')}" onclick="importExcel();" order="3" ></ui:button>
						</kmss:auth>
						<kmss:auth requestURL="/km/asset/km_asset_address/kmAssetAddress.do?method=deleteall" requestMethod="GET">
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
				{url:'/km/asset/km_asset_address/kmAssetAddress.do?method=listChildren&categoryId=${param.categoryId}'}
			</ui:source>
			<list:colTable isDefault="true" layout="sys.ui.listview.columntable" 
			     rowHref="/km/asset/km_asset_address/kmAssetAddress.do?method=view&fdId=!{fdId}">
				<list:col-checkbox></list:col-checkbox>
				<list:col-serial></list:col-serial>
				<list:col-auto props="fdAddress,fdAssetAddressCate.fdName,fdIsvalidate,operations"></list:col-auto>
			</list:colTable>
		</list:listview>
		<br>
		<!-- 分页 -->
	 	<list:paging/>
	 	
	 	<script type="text/javascript">
		 	seajs.use(['lui/jquery', 'lui/dialog', 'lui/topic'], function($, dialog, topic) {
			 	// 增加
		 		window.add = function() {
		 			dialog.simpleCategoryForNewFile(
							'com.landray.kmss.km.asset.model.KmAssetAddressCate',
							'/km/asset/km_asset_address/kmAssetAddress.do?method=add&categoryId=!{id}',false,null,null,'${param.categoryId}');
		 		};
		 	// 增加
		 		window.importExcel = function() {
		 			Com_OpenWindow('<c:url value="/km/asset/km_asset_address/kmAssetAddress.do" />?method=importExcel');
		 		};
		 		
		 	// 编辑
		 		window.edit = function(id) {
			 		if(id)
		 				Com_OpenWindow('<c:url value="/km/asset/km_asset_address/kmAssetAddress.do" />?method=edit&fdId=' + id);
		 		};
		 		
		 		window.deleteAll = function(id){
					var values = [];
					if(id) {
		 				values.push(id);
			 		} else {
						$("input[name='List_Selected']:checked").each(function() {
							values.push($(this).val());
						});
			 		}
					if(values.length==0){
						dialog.alert('<bean:message key="page.noSelect"/>');
						return;
					}
					if(id && values.length==1)
						ajaxDelete('<c:url value="/km/asset/km_asset_address/kmAssetAddress.do?method=delete"/>','GET',$.param({"fdId":id},true));
					else
						ajaxDelete('<c:url value="/km/asset/km_asset_address/kmAssetAddress.do?method=deleteall"/>','POST',$.param({"List_Selected":values},true));
				};
				window.ajaxDelete = function(url,type,data){
					dialog.confirm('<bean:message key="page.comfirmDelete"/>',function(value){
						if(value==true){
							window.del_load = dialog.loading();
							$.ajax({
								url: url,
								type: type,
								data: data,
								dataType: 'json',
								error: function(data){
									if(window.del_load!=null){
										window.del_load.hide(); 
									}
									dialog.result(data.responseJSON);
								},
								success: delCallback
						   });
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
				// 监听新建更新等成功后刷新
				topic.subscribe('successReloadPage', function() {
					topic.publish('list.refresh');
				});
		 	});
	 	</script>
	</template:replace>
</template:include>
