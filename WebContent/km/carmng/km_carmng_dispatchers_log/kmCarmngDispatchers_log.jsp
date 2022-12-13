<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple">
	<template:replace name="body">
		<list:listview>
			<ui:source type="AjaxJson">
				{"url":"/km/carmng/km_carmng_dispatchers_log/kmCarmngDispatchersLog.do?method=getDispatchersLog&fdId=${JsParam.fdId}"}
			</ui:source>
			<list:colTable isDefault="true" layout="sys.ui.listview.listtable" name="columntable">
			    <list:col-serial></list:col-serial>
				<list:col-auto props="content;docCreator.fdName;fdDispatchersTime;"></list:col-auto>
			</list:colTable>
			<ui:event topic="list.loaded">  
				seajs.use(['lui/jquery'],function($){
					if(window.frameElement!=null && window.frameElement.tagName=="IFRAME"){
						window.frameElement.style.height =  $(document.body).height() + "px";
					}
				});
			</ui:event>	
		</list:listview>
		<list:paging layout="sys.ui.paging.simple"></list:paging>
	</template:replace>
</template:include>