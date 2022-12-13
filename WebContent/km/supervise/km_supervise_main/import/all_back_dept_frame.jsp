<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple">
	<template:replace name="body">
		<link type="text/css" rel="stylesheet" href="${LUI_ContextPath}/km/supervise/resource/css/supervise.css?s_cache=${LUI_Cache}"/>
		<script type="text/javascript">
			seajs.use(['theme!listview']);	
		</script>
		<ui:dataview>
			<ui:source type="AjaxJson">
				{url: "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=getDeptTasks&fdMainId=${param.fdMainId}&fdDeptId=${param.fdDeptId}"}
			</ui:source>
			<ui:render type="Template">
				<c:import url="/km/supervise/km_supervise_main/import/criteria_task_all.jsp" charEncoding="UTF-8"></c:import>
			</ui:render>
	    </ui:dataview>
	    
	    <ui:dataview id="unitDataView">
			<ui:source type="AjaxJson">
				{url:'/km/supervise/km_supervise_main/kmSuperviseMain.do?method=getDeptBackDatas&fdMainId=${param.fdMainId}&fdTaskId=${param.fdTaskId}&fdDeptId=${param.fdDeptId}'}
			</ui:source>
			<ui:render type="Template">
				<c:import url="/km/supervise/km_supervise_main/import/all_back_dept2.jsp" charEncoding="UTF-8"></c:import>
			</ui:render>
		</ui:dataview>
		<script>
			function allTaskChange(val,node){
	    		var newSrc = "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=getDeptBackDatas&fdMainId=${param.fdMainId}&fdTaskId="+val+"&fdDeptId=${param.fdDeptId}";
	    		LUI("unitDataView").source.setUrl(newSrc);
				LUI("unitDataView").source.get();
				$(node).addClass('sclpitl_item_active lui_text_primary').siblings().removeClass('sclpitl_item_active lui_text_primary');
	    	}
			
			function viewDoc(href){
				Com_OpenWindow("${LUI_ContextPath}"+href,'_blank');
			}
		</script>
	</template:replace>
</template:include>	


