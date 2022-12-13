<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple">
	<template:replace name="body">
		<link type="text/css" rel="stylesheet" href="${LUI_ContextPath}/km/supervise/resource/css/supervise.css?s_cache=${LUI_Cache}"/>
		<script type="text/javascript">
			seajs.use(['theme!listview']);	
		</script>
		<!-- 筛选项 -->
		<c:if test="${param.fdType == 'unit'}">
			<ui:dataview>
				<ui:source type="AjaxJson">
					{url: "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=getUnits&fdId=${param.fdId}"}
				</ui:source>
				<ui:render type="Template">
					<c:import url="/km/supervise/km_supervise_main/import/criteria_unit_all.jsp" charEncoding="UTF-8"></c:import>
				</ui:render>
		    </ui:dataview>
			<ui:dataview id="unitDataView">
				<ui:source type="AjaxJson">
					{url:'/km/supervise/km_supervise_main/kmSuperviseMain.do?method=getAllBackDatas&fdMainId=${param.fdId}&fdUnitId=${param.fdUnitId}&fdType=${param.fdType}&fdTaskId=${param.fdTaskId }'}
				</ui:source>
				<ui:render type="Template">
					<c:import url="/km/supervise/km_supervise_main/import/all_back_unit.jsp" charEncoding="UTF-8"></c:import>
				</ui:render>
				<ui:event event="load">
					seajs.use(['lui/jquery'],function($){
						if(window.frameElement!=null && window.frameElement.tagName=="IFRAME"){
							window.frameElement.style.height =  ($(document.body).height() + 100 )+ "px";
						}
					});
				</ui:event>
			</ui:dataview>
			<script>
				var allCriteria = {
		    		fdUnitId:''
		    	}
				
				function allUnitChange(val,node){
		    		allCriteria["fdUnitId"] = val;
					var newSrc = "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=getAllBackDatas&fdMainId=${param.fdId}&fdUnitId="+allCriteria["fdUnitId"]+"&fdType=${param.fdType}";
					LUI("unitDataView").source.setUrl(newSrc);
					LUI("unitDataView").source.get();
					$(node).addClass('sclpitl_item_active lui_text_primary').siblings().removeClass('sclpitl_item_active lui_text_primary');
				}
				seajs.use(['sys/ui/js/dialog','lui/topic'], function(dialog) {
	                window.showMoreBack = function(fdUnitId,fdTaskId){
	                	dialog.iframe("/km/supervise/km_supervise_main/import/all_back_unit_iframe.jsp?fdMainId=${param.fdId}&fdUnitId="+fdUnitId+"&fdTaskId="+fdTaskId,
	                   			'反馈详情',null,{width:1010,height:600});
	                }
				});
				function viewDoc(href){
					Com_OpenWindow("${LUI_ContextPath}"+href,'_blank');
				}
			</script>
		</c:if>
		
		<c:if test="${param.fdType == 'dept'}">
			<ui:dataview>
				<ui:source type="AjaxJson">
					{url: "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=getDepts&fdId=${param.fdId}"}
				</ui:source>
				<ui:render type="Template">
					<c:import url="/km/supervise/km_supervise_main/import/criteria_dept_all.jsp" charEncoding="UTF-8"></c:import>
				</ui:render>
		    </ui:dataview>
			<ui:dataview id="unitDataView">
				<ui:source type="AjaxJson">
					{url:'/km/supervise/km_supervise_main/kmSuperviseMain.do?method=getAllBackDatas&fdMainId=${param.fdId}&fdDeptId=${param.fdDeptId}&fdType=${param.fdType}'}
				</ui:source>
				<ui:render type="Template">
					<c:import url="/km/supervise/km_supervise_main/import/all_back_dept.jsp" charEncoding="UTF-8"></c:import>
				</ui:render>
				<ui:event event="load">
					seajs.use(['lui/jquery'],function($){
						if(window.frameElement!=null && window.frameElement.tagName=="IFRAME"){
							window.frameElement.style.height =  ($(document.body).height() + 100 )+ "px";
						}
					});
				</ui:event>
			</ui:dataview>
			<script>
				function allDeptChange(val,node){
					var newSrc = "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=getAllBackDatas&fdMainId=${param.fdId}&fdDeptId="+val+"&fdType=${param.fdType}";
					LUI("unitDataView").source.setUrl(newSrc);
					LUI("unitDataView").source.get();
					$(node).addClass('sclpitl_item_active lui_text_primary').siblings().removeClass('sclpitl_item_active lui_text_primary');
				}
				seajs.use(['sys/ui/js/dialog','lui/topic'], function(dialog) {
	                window.showMoreBack = function(fdDeptId,fdTaskId){
	                	dialog.iframe("/km/supervise/km_supervise_main/import/all_back_dept_iframe.jsp?fdMainId=${param.fdId}&fdDeptId="+fdDeptId+"&fdTaskId="+fdTaskId,
	                   			'反馈详情',null,{width:1010,height:600});
	                }
				});
				function viewDoc(href){
					Com_OpenWindow("${LUI_ContextPath}"+href,'_blank');
				}
			</script>
		</c:if>
		
		<c:if test="${param.fdType == 'stage'}">
			<ui:dataview>
				<ui:source type="AjaxJson">
					{url: "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=getTasks&fdId=${param.fdId}"}
				</ui:source>
				<ui:render type="Template">
					<c:import url="/km/supervise/km_supervise_main/import/criteria_task_all.jsp" charEncoding="UTF-8"></c:import>
				</ui:render>
		    </ui:dataview>
		    
		    <ui:dataview id="stageDataView">
				<ui:source type="AjaxJson">
					{url:'/km/supervise/km_supervise_main/kmSuperviseMain.do?method=getAllBackDatas&fdMainId=${param.fdId}&fdType=${param.fdType}&fdTaskId=${param.fdTaskId }'}
				</ui:source>
				<ui:render type="Template">
					<c:import url="/km/supervise/km_supervise_main/import/all_back_stage.jsp" charEncoding="UTF-8"></c:import>
				</ui:render>
				<ui:event event="load">
					seajs.use(['lui/jquery'],function($){
						if(window.frameElement!=null && window.frameElement.tagName=="IFRAME"){
							window.frameElement.style.height =  ($(document.body).height() + 100 )+ "px";
						}
					});
				</ui:event>
			</ui:dataview>
			<script>
				var allCriteria = {
		    		fdTaskId:''
			    }
				
				function allTaskChange(val,node){
		    		allCriteria["fdTaskId"] = val;
		    		var newSrc = "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=getAllBackDatas&fdMainId=${param.fdId}&fdTaskId="+allCriteria["fdTaskId"]+"&fdType=${param.fdType}";
		    		LUI("stageDataView").source.setUrl(newSrc);
					LUI("stageDataView").source.get();
					$(node).addClass('sclpitl_item_active lui_text_primary').siblings().removeClass('sclpitl_item_active lui_text_primary');
		    	}
				
				function viewDoc(href){
					Com_OpenWindow("${LUI_ContextPath}"+href,'_blank');
				}
			</script>
		</c:if>
	</template:replace>
</template:include>	


