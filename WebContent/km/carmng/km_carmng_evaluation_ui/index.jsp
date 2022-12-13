<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple">
	<template:replace name="title">
		<c:out value="${ lfn:message('km-carmng:module.km.carmng') }"></c:out>
	</template:replace>
	<%-- <template:replace name="path">
			<ui:menu layout="sys.ui.menu.nav" style="height:40px;line-height:40px;">
				<ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" href="/" target="_self">
				</ui:menu-item>
				<ui:menu-item text="${ lfn:message('km-carmng:module.km.carmng') }" href="/km/carmng/" target="_self">
				</ui:menu-item>
				<ui:menu-item text="${ lfn:message('km-carmng:table.kmCarmngEvaluation') }" href="javascript:void(0);" target="_self">
				</ui:menu-item>
			</ui:menu>
	</template:replace> --%>
	<template:replace name="body">
		<script type="text/javascript">
			seajs.use(['theme!list']);	
		</script>
		<!-- 筛选器 -->
	<ui:tabpanel id="kmCarmngEvaluationPanel" layout="sys.ui.tabpanel.list" >
		<ui:content id="kmCarmngEvaluationContent" title="${ lfn:message('km-carmng:table.kmCarmngEvaluation') }">
		<list:criteria id="criteria1">
			<list:cri-ref key="fdAppName" title="${lfn:message('km-carmng:kmCarmngEvaluation.fdAppNames')}" ref="criterion.sys.docSubject">
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
					    <list:sort property="fdEvaluationTime" text="${lfn:message('km-carmng:kmCarmngEvaluation.fdEvaluationTime') }" group="sort.list" value="down" ></list:sort>
					</ui:toolbar>
				</div>
			</div>
			<!-- 分页 -->
			<div class="lui_list_operation_page_top">	
				<list:paging layout="sys.ui.paging.top" > 		
				</list:paging>
			</div>
		</div>
	<ui:fixed elem=".lui_list_operation"></ui:fixed>
	<list:listview id="listview">
		<ui:source type="AjaxJson">
				{url:'/km/carmng/km_carmng_evaluation/kmCarmngEvaluation.do?method=list'}
		</ui:source>
		  <!-- 列表视图 -->	
		<list:colTable isDefault="true" layout="sys.ui.listview.columntable" 
			rowHref="/km/carmng/km_carmng_evaluation/kmCarmngEvaluation.do?method=view&fdId=!{fdId}"  name="columntable">
			<list:col-checkbox></list:col-checkbox>
			<list:col-serial></list:col-serial> 
			<list:col-auto props=""></list:col-auto>
		</list:colTable>
	</list:listview> 
	<list:paging></list:paging>
	</ui:content>
</ui:tabpanel>
	</template:replace> 
	
</template:include>
