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
						<list:sortgroup>
							<list:sort property="docCreateTime" text="${lfn:message('km-carmng:kmCarmngApplication.docCreateTime') }" group="sort.list" value="down"></list:sort>
							<list:sort property="fdStartTime" text="${lfn:message('km-carmng:kmCarmngUserFeeInfo.fdUseStartTime') }" group="sort.list"></list:sort>
							<list:sort property="docSubject" text="${lfn:message('km-carmng:kmCarmngApplication.docSubject') }" group="sort.list"></list:sort>
							<list:sort property="fdMotorcade.fdName" text="${lfn:message('km-carmng:kmCarmngApplication.fdMotorcadeId') }" group="sort.list"></list:sort>
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
					<ui:toolbar style="float:right" id="Btntoolbar">
						<kmss:auth
							requestURL="/km/carmng/km_carmng_dispatchers_info/kmCarmngDispatchersInfo.do?method=addBatch"
							requestMethod="GET">
							<ui:button text="${lfn:message('km-carmng:kmCarmng.button8')}"
								onclick="dispatcher();">
							</ui:button>
						</kmss:auth>
					</ui:toolbar>
				</div>
			</div>
		</div>
	<ui:fixed elem=".lui_list_operation"></ui:fixed>
	<%@ include file="/km/carmng/km_carmng_listByDispatchers_ui/kmCarmngApplication_listByDispatchers_listtable.jsp" %>

	<script type="text/javascript">
	seajs.use(['lui/jquery','lui/dialog','lui/topic','lui/toolbar'], function($, dialog , topic, toolbar) {
		LUI.ready(function(){
		});

		// 监听新建更新等成功后刷新
		topic.subscribe('successReloadPage', function() {
			topic.publish('list.refresh');
		});
		window.dispatcher = function() {
			//debugger;
			var values = "";
			var selected;
			var listFdId = "";
			var select = document.getElementsByName("List_Selected");
			for ( var i = 0; i < select.length; i++) {
				if (select[i].checked) {
					listFdId += select[i].value + ';';
					selected = true;
				}
			}
			if (selected) {
				values = values.substring(0, values.length - 1);
				var url = '${LUI_ContextPath}/km/carmng/km_carmng_dispatchers_info/kmCarmngDispatchersInfo.do?method=addBatch&listFdId='+listFdId;
				Com_OpenWindow(url);
			} else {
				seajs.use( [ 'lui/dialog' ], function(dialog) {
					dialog.alert("${lfn:message('page.noSelect')}");
				})
			}
		};
	});
	</script>