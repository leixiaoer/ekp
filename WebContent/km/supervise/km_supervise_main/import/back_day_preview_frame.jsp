<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<template:include ref="default.simple">
	<template:replace name="body">
		<script language="JavaScript">
			Com_IncludeFile("jquery.js");
		</script>
		<link type="text/css" rel="stylesheet" href="${LUI_ContextPath}/km/supervise/resource/css/supervise.css?s_cache=${LUI_Cache}"/>
		<ui:dataview id="preview">
			<ui:source type="AjaxJson">
				{url:''}
			</ui:source>
			<ui:render type="Template">
				<c:import url="/km/supervise/km_supervise_main/import/back_day_preview.jsp" charEncoding="UTF-8"></c:import>
			</ui:render>
		</ui:dataview>
		<script>
		LUI.ready(function(){
				var stages = encodeURI(decodeURI('${param.stages}'));
				var url='/km/supervise/km_supervise_task/kmSuperviseTask.do?method=getBackDay&fdBackType=${param.fdBackType}&stages='+stages;
				LUI("preview").source.setUrl(url);
				LUI("preview").source.get();
			});
		</script>
	</template:replace>
</template:include>	


