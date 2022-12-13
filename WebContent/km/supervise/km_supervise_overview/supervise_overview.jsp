<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include  ref="default.simple" sidebar="no" spa="true">
	<template:replace name="body">
	<link type="text/css" rel="stylesheet" href="${LUI_ContextPath}/km/supervise/resource/css/overview.css?s_cache=${LUI_Cache}"/>
	<script type="text/javascript">
		seajs.use(['theme!module']);
		
		function loadSummaryCount(){
			$.ajax({     
			     type:"get",    
			     url:"${LUI_ContextPath}/km/supervise/km_supervise_main/kmSuperviseMain.do?method=findByStatusCount",     
			     async:true,
			     dataType : 'json',
			     success:function(data){
			    	 $("#supervise_docStatus20").html(data.docStatus20);
			    	 $("#supervise_docStatus30").html(data.docStatus30);
			    	 $("#supervise_docStatus40").html(data.docStatus40);
			    	 $("#supervise_docStatus50").html(data.docStatus50);
			    	 
			  	 }
		    });
		}
		function clickHref(status){
			window.parent.newPage(status);
		}
		window.onload=function(){
			loadSummaryCount();
		}
	</script>

	  <ui:tabpanel layout="sys.ui.tabpanel.list">
		  <ui:content title="${lfn:message('km-supervise:py.DuBanGaiLan') }">
		  
		  <div class="head_div_wrap">
			<div class="head_div_box" onclick="clickHref('/supervise_docStatus20');">
				<div class="item">
					<span class="head_div_box_number" id="supervise_docStatus20">0</span>
					<span class="head_div_box_text">${lfn:message('km-supervise:enums.doc_status.20')}</span>
				</div>
			</div>
			<div class="head_div_box" onclick="clickHref('/supervise_docStatus30');">
				<div class="item">
					<span class="head_div_box_number" id="supervise_docStatus30">0</span>
					<span class="head_div_box_text">${lfn:message('km-supervise:enums.doc_status.30')}</span>
				</div>
			</div>
			<div class="head_div_box" onclick="clickHref('/supervise_docStatus40');">
				<div class="item">
					<span class="head_div_box_number" id="supervise_docStatus40">0</span>
					<span class="head_div_box_text">${lfn:message('km-supervise:enums.doc_status.40')}</span>
				</div>
			</div>
			<div class="head_div_box" onclick="clickHref('/supervise_docStatus50');">
				<div class="item">
					<span class="head_div_box_number" id="supervise_docStatus50">0</span>
					<span class="head_div_box_text">${lfn:message('km-supervise:enums.doc_status.50')}</span>
				</div>
			</div>
		</div>
			
		<!-- 督办信息一览图 Starts -->
		<table width="100%" class="lui_hr_staff_overview_card_frame">
			<tr>
				<td colspan="4" align="center"> <!-- 督办总览 -->
					<div class="lui_hr_staff_panel_overview_frame">
					<div class="lui_hr_staff_panel_title">
						<span class="panel_title">${ lfn:message('km-supervise:kmSupervise.pandect') }</span>
					</div>
					<div class="lui_hr_staff_panel_content">
						<ui:chart width="100%" height="300px">
		  					<ui:source type="AjaxJson">
								{"url":"/km/supervise/km_supervise_main/kmSuperviseMain.do?method=overviewChart&type=pandect"}
		  					</ui:source>
						</ui:chart>
					</div>
					</div>
				</td>
				<td colspan="4" align="center"> <!-- 督办事项 -->
					<div class="lui_hr_staff_panel_overview_frame">
					<div class="lui_hr_staff_panel_title">
						<span class="panel_title">${ lfn:message('km-supervise:kmSupervise.items') }</span>
					</div>
					<div class="lui_hr_staff_panel_content">
						<ui:chart width="100%" height="300px">
		  					<ui:source type="AjaxJson">
								{"url":"/km/supervise/km_supervise_main/kmSuperviseMain.do?method=overviewChart&type=items"}
		  					</ui:source>
						</ui:chart>
					</div>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="4" align="center"><!-- 任务总览 -->
					<div class="lui_hr_staff_panel_overview_frame">
					<div class="lui_hr_staff_panel_title">
						<span class="panel_title">${ lfn:message('km-supervise:kmSupervise.task.items') }</span>
					</div>
					<kmss:ifModuleExist  path = "/sys/task/">
						<ui:chart width="100%" height="300px">
		  					<ui:source type="AjaxJson">
								{"url":"/sys/task/sys_task_main/sysTaskMain.do?method=buildOverviewChartForTask"}
		  					</ui:source>
						</ui:chart>
					</kmss:ifModuleExist>
					</div>
				</td>
				<td colspan="4" align="center"><!-- 满意度星级 -->
					<div class="lui_hr_staff_panel_overview_frame">
					<div class="lui_hr_staff_panel_title">
						<span class="panel_title">${ lfn:message('km-supervise:kmSupervise.satisfaction.level') }</span>
					</div>
					<ui:chart width="100%" height="300px">
	  					<ui:source type="AjaxJson">
							{"url":"/km/supervise/km_supervise_main/kmSuperviseMain.do?method=overviewChart&type=satisfaction"}
	  					</ui:source>
					</ui:chart>
					</div>
				</td>
			</tr>
		</table>
	</ui:content>
</ui:tabpanel>
	</template:replace>
</template:include>
