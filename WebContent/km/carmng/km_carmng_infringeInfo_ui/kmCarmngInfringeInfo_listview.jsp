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
						    <list:sort property="docCreateTime" text="${lfn:message('km-carmng:kmCarmngInfringeInfo.docCreateTime') }" group="sort.list" value="down" ></list:sort>
							<list:sort property="fdVehiclesInfo.fdNo" text="${lfn:message('km-carmng:kmCarmngInfomation.fdNo') }" group="sort.list"></list:sort>
							<list:sort property="fdInfringeTime" text="${lfn:message('km-carmng:kmCarmngInfringeInfo.fdInfringeTime') }" group="sort.list"></list:sort>
							<list:sort property="fdInfringeFee" text="${lfn:message('km-carmng:kmCarmngInfringeInfo.fdInfringeFee') }" group="sort.list"></list:sort>
							<list:sort property="fdInfringePersonName" text="${lfn:message('km-carmng:kmCarmngInfringeInfo.fdInfringePerson') }" group="sort.list"></list:sort>
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
					<ui:toolbar count='3' style="float:right" id="Btntoolbar">
						<kmss:auth requestURL="/km/carmng/km_carmng_infringe_info/kmCarmngInfringeInfo.do?method=add" requestMethod="GET">
							<ui:button text="${lfn:message('button.add')}" onclick="addInfringeInfo();" id="addBtn" order="1">
							</ui:button>
						</kmss:auth>
						
						<kmss:authShow roles="ROLE_KMCARMNG_TRANSPORT_EXPORT">
						<ui:button text="${lfn:message('button.export')}" id="export" onclick="listExport('${LUI_ContextPath}/sys/transport/sys_transport_export/SysTransportExport.do?method=listExport&fdModelName=com.landray.kmss.km.carmng.model.KmCarmngInfringeInfo')" order="2" ></ui:button>
						</kmss:authShow>
						
						<kmss:auth requestURL="/km/carmng/km_carmng_infringe_info/kmCarmngInfringeInfo.do?method=deleteall" requestMethod="GET">								
							<ui:button text="${lfn:message('button.deleteall')}" onclick="delInfringeInfo();" id="delBtn">
							</ui:button>
						</kmss:auth>
					</ui:toolbar>
				</div>
			</div>
		</div>
	<ui:fixed elem=".lui_list_operation"></ui:fixed>
	<%@ include file="/km/carmng/km_carmng_infringeInfo_ui/kmCarmngInfringeInfo_listtable.jsp" %>
	
	<script type="text/javascript">
	seajs.use(['lui/jquery','lui/dialog','lui/topic','lui/toolbar'], function($, dialog , topic, toolbar) {
		LUI.ready(function(){
		});
		
		// 监听新建更新等成功后刷新
		topic.subscribe('successReloadPage', function() {
			topic.publish('list.refresh');
		});
	<!--新建-->
		window.addInfringeInfo = function() {
		   Com_OpenWindow('<c:url value="/km/carmng/km_carmng_infringe_info/kmCarmngInfringeInfo.do" />?method=add');
		};
	<!--删除-->
		window.delInfringeInfo = function(){
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
					$.post('${LUI_ContextPath}/km/carmng/km_carmng_infringe_info/kmCarmngInfringeInfo.do?method=deleteall',
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