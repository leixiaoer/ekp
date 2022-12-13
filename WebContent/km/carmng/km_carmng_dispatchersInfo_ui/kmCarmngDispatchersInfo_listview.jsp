<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

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
					<ui:toolbar layout="sys.ui.toolbar.sort" style="float:left">
						<list:sort property="kmCarmngDispatchersInfo.docCreateTime" text="${lfn:message('km-carmng:kmCarmngDispatchersInfo.docCreateTime') }" group="sort.list" value="down"></list:sort>
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
				<ui:toolbar style="float:right" id="Btntoolbar">
					<kmss:auth requestURL="/km/carmng/km_carmng_dispatchers_info/kmCarmngDispatchersInfo.do?method=deleteall" requestMethod="GET">
						<ui:button text="${lfn:message('button.deleteall')}" onclick="deleteDispatchersInfo();">
						</ui:button>
					</kmss:auth>
				</ui:toolbar>
				</div>
			</div>
		</div>
	<ui:fixed elem=".lui_list_operation"></ui:fixed>
	<%@ include file="/km/carmng/km_carmng_dispatchersInfo_ui/kmCarmngDispatchersInfo_listtable.jsp" %>

	<script type="text/javascript">
	seajs.use(['lui/jquery','lui/dialog','lui/topic','lui/toolbar'], function($, dialog , topic, toolbar) {
		LUI.ready(function(){
		});

		// 监听新建更新等成功后刷新
		topic.subscribe('successReloadPage', function() {
			topic.publish('list.refresh');
		});
		<!--删除-->
		window.deleteDispatchersInfo = function(){
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
					$.post('${LUI_ContextPath}/km/carmng/km_carmng_dispatchers_info/kmCarmngDispatchersInfo.do?method=deleteall',
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