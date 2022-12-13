<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple">
	<template:replace name="body">
		<link type="text/css" rel="stylesheet" href="${LUI_ContextPath}/km/supervise/resource/css/supervise.css?s_cache=${LUI_Cache}"/>
		
        <ui:dataview>
			<ui:source type="AjaxJson">
				{url: "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=getBackSituations&fdMainId=${param.fdId}&fdBackPeriod=${param.fdBackPeriod}"}
			</ui:source>
			<ui:render type="Template">
				<c:import url="/km/supervise/km_supervise_main/import/criteria_unit_task.jsp" charEncoding="UTF-8"></c:import>
			</ui:render>
   		</ui:dataview>
		
		<ui:dataview>
			<ui:source type="AjaxJson">
				{url:'/km/supervise/km_supervise_main/kmSuperviseMain.do?method=getTaskAndBackDatas&fdMainId=${param.fdId}&fdBackPeriod=${param.fdBackPeriod}'}
			</ui:source>
			<ui:render type="Template">
				<c:import url="/km/supervise/km_supervise_main/import/task_and_back.jsp" charEncoding="UTF-8"></c:import>
			</ui:render>
			<ui:event event="load">
				seajs.use(['lui/jquery','lui/dialog'],function($,dialog){
					if(window.frameElement!=null && window.frameElement.tagName=="IFRAME"){
						window.frameElement.style.height =  ($(document.body).height() + 100 )+ "px";
					}
					
					window.feedback = function(fdType){
	            		Com_OpenWindow('<c:url value="/km/supervise/km_supervise_back/kmSuperviseBack.do" />?method=add&fdIsNew=true&fdMainId=${param.fdId}&fdType='+fdType);
	            	}
				
					window.urge = function(fdTaskId,fdUnitId){
						window.del_load = dialog.loading();
						$.ajax({
							url: Com_Parameter.ContextPath+'km/supervise/km_supervise_task/kmSuperviseTask.do?method=urgeTask&fdTaskId='+fdTaskId+'&fdUnitId='+fdUnitId,
							type: 'POST',
							dataType: 'json',
							error: function(data){
								if(window.del_load!=null){
									window.del_load.hide(); 
								}
								dialog.failure('<bean:message key="return.optFailure"/>');
							},
							success: topCallback
						});
					}
					window.topCallback = function(data){
						if(window.del_load!=null)
							window.del_load.hide();
						if(data!=null && data.status==true){
							dialog.success('<bean:message key="return.optSuccess"/>');
							window.location.reload();
						}else{
							dialog.failure('<bean:message key="return.optFailure"/>');
							window.location.reload();
						}
					}
					
					window.viewDoc = function(href){
				       Com_OpenWindow("${LUI_ContextPath}"+href,'_blank');
				 	}
				});
			</ui:event>
		</ui:dataview>
	</template:replace>
</template:include>	


