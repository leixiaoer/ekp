<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple">
	<template:replace name="title">
		<c:out value="${ lfn:message('geesun-oitems:geesunOitems.tree.modelName') }"></c:out>
	</template:replace>
	<template:replace name="body">  
		<script type="text/javascript">
			seajs.use(['theme!list']);	
		</script>
	<ui:tabpanel id="geesunOitemsMonthReportPanel" layout="sys.ui.tabpanel.list" >
		<ui:content id="geesunOitemsMonthReportContent" title="${ lfn:message('geesun-oitems:geesunOitems.tree.moon.reporting') }"> 
		<list:criteria id="reportCriteria">
		    <list:cri-ref key="docSubject" ref="criterion.sys.docSubject"> 
			</list:cri-ref>
		</list:criteria>
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
						<list:sort property="docCreateTime" text="${lfn:message('geesun-oitems:geesunOitemsMonthReport.docCreateTime') }" group="sort.list" value="down"></list:sort>
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
					<ui:toolbar count="3">
						<kmss:auth requestURL="/geesun/oitems/geesun_oitems_month_report/geesunOitemsMonthReport.do?method=deleteall">
					    	<ui:button text="${lfn:message('button.deleteall')}" onclick="delDoc()" order="2"></ui:button>
						</kmss:auth>
					</ui:toolbar>
				</div>
			</div>
		</div>
		<list:listview id="listview">
			<ui:source type="AjaxJson">
					{url:'/geesun/oitems/geesun_oitems_month_report/geesunOitemsMonthReport.do?method=list'}
			</ui:source>
			<list:colTable isDefault="false" layout="sys.ui.listview.columntable" 
				rowHref="/geesun/oitems/geesun_oitems_month_report/geesunOitemsMonthReport.do?method=view&fdId=!{fdId}"  name="columntable">
				<list:col-checkbox></list:col-checkbox>
				<list:col-serial></list:col-serial>
				<list:col-html  title="${ lfn:message('geesun-oitems:geesunOitemsMonthReport.docSubject') }" style="text-align:left">
				 {$ <span class="com_subject" >{%row['docSubject']%}</span> $}
				</list:col-html>
				<list:col-auto props="docCreateTime"></list:col-auto>
			</list:colTable>
		</list:listview>
	 	<list:paging></list:paging>	
	 	</ui:content>
	 </ui:tabpanel>	 
	 	<script type="text/javascript">
			seajs.use(['lui/jquery','lui/dialog','lui/topic'], function($, dialog , topic) {

				// 监听新建更新等成功后刷新
				topic.subscribe('successReloadPage', function() {
					topic.publish('list.refresh');
				});
				
				//新建
				window.addDoc = function() {
					Com_OpenWindow('<c:url value="/geesun/oitems/geesun_oitems_budger_application/geesunOitemsBudgerApplication.do" />?method=add');
				};
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
							$.post('<c:url value="/geesun/oitems/geesun_oitems_month_report/geesunOitemsMonthReport.do?method=deleteall"/>',
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
	</template:replace>
</template:include>
