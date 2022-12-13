<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple">
	<template:block name="head">
		<link type="text/css" rel="stylesheet" href="${LUI_ContextPath}/km/supervise/resource/css/supervise.css?s_cache=${LUI_Cache}"/>
	</template:block>
	<template:replace name="body">
		<ui:dataview>
			<ui:source type="AjaxJson">
				{url:'/km/supervise/km_supervise_main/kmSuperviseMain.do?method=getAllBackSituations&fdMainId=${param.fdMainId}'}
			</ui:source>
			<ui:render type="Template">
				<c:import url="/km/supervise/km_supervise_main/import/back_situation_view.jsp" charEncoding="UTF-8"></c:import>
			</ui:render>
			<ui:event event="load">
				seajs.use(['lui/jquery','lui/dialog'],function($,dialog){
					if(window.frameElement!=null && window.frameElement.tagName=="IFRAME"){
						window.frameElement.style.height =  ($(document.body).height() + 100 )+ "px";
					}
				});
			</ui:event>
		</ui:dataview>
	</template:replace>
</template:include>	


