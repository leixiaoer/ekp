<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include file="/sys/profile/resource/template/list.jsp">
	<template:replace name="content">
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
					<ui:toolbar id="Btntoolbar">
						<kmss:auth requestURL="/km/keydata/base/kmKeydataPluginShow.do?method=importPluginShowData"
							requestMethod="GET">
							<ui:button text="${lfn:message('km-keydata-base:keydata.plugin.import')}" onclick="importModule();"></ui:button>
						</kmss:auth>
						<kmss:auth requestURL="/km/keydata/base/kmKeydataPluginShow.do?method=showall">
							<ui:button text="${lfn:message('km-keydata-base:keydata.plugin.enable')}" onclick="showall();"></ui:button>
						</kmss:auth>
						<kmss:auth requestURL="/km/keydata/base/kmKeydataPluginShow.do?method=disshowall">
							<ui:button text="${lfn:message('km-keydata-base:keydata.plugin.disable')}" onclick="disshowall();"></ui:button>
						</kmss:auth>
					</ui:toolbar>	
				</div>
			</div>
			<!-- 分页 -->
			<div class="lui_list_operation_page_top">
                   <list:paging layout="sys.ui.paging.top" />
               </div>
		</div>
		<ui:fixed elem=".lui_list_operation"></ui:fixed>
		<!-- 内容列表 -->
		<list:listview>
			<ui:source type="AjaxJson">
				{url:'/km/keydata/base/kmKeydataPluginShow.do?method=list'}
			</ui:source>
			<list:colTable isDefault="true" layout="sys.ui.listview.columntable" 
			     rowHref="/km/keydata/base/kmKeydataPluginShow.do?method=edit&fdId=!{fdId}">
				<list:col-checkbox></list:col-checkbox>
				<list:col-serial></list:col-serial>
				<list:col-auto props="fdName,fdActionUrl,fdIsShow,operations"></list:col-auto>
			</list:colTable>
		</list:listview>
		<br>
		<!-- 分页 -->
	 	<list:paging/>
	 	<script type="text/javascript">
		 	seajs.use(['lui/jquery', 'lui/dialog', 'lui/topic'], function($, dialog, topic) {

			 	window.edit = function(id){
				 	if(id){
				 		Com_OpenWindow('<c:url value="/km/keydata/base/kmKeydataPluginShow.do?method=edit&fdId=" />'+id,'_blank');
				 	}
			 	};

			 	window.importModule = function(){
			 		Com_OpenWindow('<c:url value="/km/keydata/base/kmKeydataPluginShow.do?method=importPluginShowData" />');
			 		topic.publish("list.refresh");
			 	};

		 		window.showall = function(id){
		 			var values = [];
		 			if(id){
			 			values.push(id);
			 			$.post('<c:url value="/km/keydata/base/kmKeydataPluginShow.do?method=showall"/>',
								$.param({"List_Selected":values},true),delCallback,'json');
		 			}else{
		 				$("input[name='List_Selected']:checked").each(function(){
							values.push($(this).val());
						});
						if(values.length==0){
							dialog.alert('<bean:message key="page.noSelect"/>');
							return;
						}			
						$.post('<c:url value="/km/keydata/base/kmKeydataPluginShow.do?method=showall"/>',
							$.param({"List_Selected":values},true),delCallback,'json');
		 			}
					

				};

				window.disshowall = function(id){
					var values = [];
		 			if(id){
			 			values.push(id);
			 			$.post('<c:url value="/km/keydata/base/kmKeydataPluginShow.do?method=disshowall"/>',
								$.param({"List_Selected":values},true),delCallback,'json');
		 			}else{
		 				$("input[name='List_Selected']:checked").each(function(){
							values.push($(this).val());
						});
						if(values.length==0){
							dialog.alert('<bean:message key="page.noSelect"/>');
							return;
						}				
						$.post('<c:url value="/km/keydata/base/kmKeydataPluginShow.do?method=disshowall"/>',
							$.param({"List_Selected":values},true),delCallback,'json');
		 			}
				};
				window.delCallback = function(data){
					if(window.del_load!=null){
						window.del_load.hide();
					}
					topic.publish("list.refresh");
					dialog.result(data);
				};

				topic.subscribe('successReloadPage', function() {
					topic.publish('list.refresh');
				});
		 	});
	 	</script>
	</template:replace>
</template:include>
