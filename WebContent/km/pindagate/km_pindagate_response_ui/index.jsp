<%--我暂存的答卷index页面--%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.list">
	<%-- 标签页标题 --%>
	<template:replace name="title">
		<c:out value="${ lfn:message('km-pindagate:module.km.pindagate') }"></c:out>
	</template:replace>
	
	<template:replace name="nav">
		<ui:combin ref="menu.nav.create">
			<ui:varParam name="title" value="${ lfn:message('km-pindagate:kmPindagateMain.btn.add.pindagate') }"></ui:varParam>
		</ui:combin>
		
		<div class="lui_list_nav_frame">
			<ui:accordionpanel>
				<c:import url="/km/pindagate/import/nav.jsp">
				   <c:param name="key" value="response"></c:param>
				    <c:param name="criteria" value="responseCriteria"></c:param>
				</c:import>
			</ui:accordionpanel>
		</div>
		
	</template:replace>
	
	<template:replace name="content"> 
		<script type="text/javascript">
			seajs.use(['lui/jquery', 'lui/dialog','lui/topic'], function($, dialog , topic) {
				//删除
		 		window.delDoc = function(){
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
							$.post('<c:url value="/km/pindagate/km_pindagate_response/kmPindagateResponse.do?method=deleteall"/>',
									$.param({"List_Selected":values},true),delCallback,'json');
						}
					});
				};
				window.delCallback = function(data){
					if(window.del_load!=null)
						window.del_load.hide();
					if(data!=null && data.status==true){
						topic.publish("list.refresh");
						dialog.success('<bean:message key="return.optSuccess" />');
					}else{
						dialog.failure('<bean:message key="return.optFailure" />');
					}
				};
			});
		</script>
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
						<list:sort property="fdCreateTime" text="${lfn:message('km-pindagate:kmPindagateResponse.fdCreateTime') }" group="sort.list" value="down"></list:sort>
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
					<ui:toolbar>
						<kmss:auth requestURL="/km/pindagate/km_pindagate_response/kmPindagateResponse.do?method=deleteall">
							<ui:button text="${lfn:message('button.deleteall')}" onclick="delDoc();" order="2" ></ui:button>
						</kmss:auth>
					</ui:toolbar>
				</div>
			</div>
		</div>
		
		<ui:fixed elem=".lui_list_operation"></ui:fixed>
		<%--list页面--%>
		<list:listview id="listview">
			<ui:source type="AjaxJson">
				{url:'/km/pindagate/km_pindagate_response/kmPindagateResponse.do?method=list&nodeType=myReposeDraft'}
			</ui:source>
			<%--列表视图--%>
			<list:colTable isDefault="true" layout="sys.ui.listview.columntable"  
				rowHref="/km/pindagate/km_pindagate_response/kmPindagateResponse.do?method=edit&fdId=!{fdId}"  name="columntable">
				<list:col-checkbox></list:col-checkbox>
				<list:col-serial></list:col-serial>
				<list:col-auto props=""></list:col-auto>
			</list:colTable>
		</list:listview>
		<list:paging></list:paging>	
	</template:replace>
</template:include>