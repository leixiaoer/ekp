<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple">
	<template:replace name="body">
		<script type="text/javascript">
			seajs.use(['theme!listview']);	
		</script>
		<link type="text/css" rel="stylesheet" href="${LUI_ContextPath}/km/supervise/resource/css/supervise.css?s_cache=${LUI_Cache}"/>
		<ui:dataview>
			<ui:source type="AjaxJson">
				{url:'/km/supervise/km_supervise_main/kmSuperviseMain.do?method=getStageBackDatas&fdTaskId=${param.fdTaskId}'}
			</ui:source>
			<ui:render type="Template">
				<c:import url="/km/supervise/km_supervise_main/import/plan_and_back_user2.jsp" charEncoding="UTF-8"></c:import>
			</ui:render>
			<ui:event event="load">
				seajs.use(['lui/jquery'],function($){
					if(window.frameElement!=null && window.frameElement.tagName=="IFRAME"){
						window.frameElement.style.height =  ($(document.body).height() + 100 )+ "px";
					}
				});
			</ui:event>
			<script>
				window.viewDoc = function(href){
			       Com_OpenWindow("${LUI_ContextPath}"+href,'_blank');
			 	}
			</script>
		</ui:dataview>
	</template:replace>
</template:include>	


