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
				{url: "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=getUnitTasks&fdMainId=${param.fdMainId}&fdUnitId=${param.fdUnitId}"}
			</ui:source>
			<ui:render type="Template">
				<c:import url="/km/supervise/km_supervise_main/import/criteria_task_all.jsp" charEncoding="UTF-8"></c:import>
			</ui:render>
	    </ui:dataview>
	    
	    <ui:dataview id="unitDataView">
			<ui:source type="AjaxJson">
				{url:'/km/supervise/km_supervise_main/kmSuperviseMain.do?method=getUnitBackDatas&fdMainId=${param.fdMainId}&fdTaskId=${param.fdTaskId}&fdUnitId=${param.fdUnitId}'}
			</ui:source>
			<ui:render type="Template">
				<c:import url="/km/supervise/km_supervise_main/import/all_back_unit2.jsp" charEncoding="UTF-8"></c:import>
			</ui:render>
		</ui:dataview>
		<script>
			var allCriteria = {
	    		fdTaskId:''
		    }
			
			function allTaskChange(val,node){
	    		allCriteria["fdTaskId"] = val;
	    		var newSrc = "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=getUnitBackDatas&fdMainId=${param.fdMainId}&fdTaskId="+allCriteria["fdTaskId"]+"&fdUnitId=${param.fdUnitId}";
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


