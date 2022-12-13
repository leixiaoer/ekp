<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:replace name="content">
	<%-- 软删除 --%>
	<c:import url="/sys/recycle/import/redirect.jsp">
		<c:param name="formBeanName" value="kmSuperviseMainForm"></c:param>
	</c:import>
	<c:choose>
	    <c:when test="${param.approveModel eq 'right'}">
			<ui:tabpanel suckTop="true" layout="sys.ui.tabpanel.sucktop" var-count="5" var-average='false' var-useMaxWidth='true'>
				<c:import url="/km/supervise/km_supervise_main/kmSuperviseMain_viewContent_publish.jsp" charEncoding="UTF-8">
	 		 		<c:param name="approveModel" value="${param.approveModel}"></c:param>
	 		 		<c:param name="contentType" value="baseInfo"></c:param>
	  			</c:import>
	  			<c:import url="/km/supervise/km_supervise_main/kmSuperviseMain_viewContent_publish.jsp" charEncoding="UTF-8">
	 		 		<c:param name="approveModel" value="${param.approveModel}"></c:param>
	 		 		<c:param name="contentType" value="other"></c:param>
	  			</c:import>
			</ui:tabpanel>
		</c:when>
		<c:otherwise>
			<ui:tabpage collapsed="true" id="reviewTabPage">
					<script>
						LUI.ready(function(){
							setTimeout(function(){
								var reviewTabPage = LUI("reviewTabPage");
								if(reviewTabPage!=null){
									reviewTabPage.element.find(".lui_tabpage_float_collapse").hide();
									reviewTabPage.element.find(".lui_tabpage_float_navs_mark").hide();
								}
							},100)
						})
					</script>
				<c:import url="/km/supervise/km_supervise_main/kmSuperviseMain_viewContent_publish.jsp" charEncoding="UTF-8">
 		 			<c:param name="contentType" value="baseInfo"></c:param>
 		 		</c:import>
			</ui:tabpage>
			<ui:tabpage expand="false" var-navwidth="90%">
				<c:import url="/km/supervise/km_supervise_main/kmSuperviseMain_viewContent_publish.jsp" charEncoding="UTF-8">
 		 			<c:param name="contentType" value="other"></c:param>
 		 		</c:import>
			</ui:tabpage>
		</c:otherwise>
	</c:choose>
	<script type="text/javascript">
		seajs.use(['lui/jquery','lui/dialog','lui/topic','lui/toolbar'], function($, dialog, topic, toolbar){
			//关注or取消关注
			window.updateConcern = function(method){
				 var del_load = dialog.loading();
				 var msg = '';
			     $.ajax({
			        	url:'${LUI_ContextPath}/km/supervise/km_supervise_main/kmSuperviseMain.do'+'?method='+method,
			        	data:{"fdId":'${param.fdId}'},
			        	dataType:'json',
			        	type:'POST',
			        	success:function(data){
			            	del_load.hide();
			        		if(method == 'addConcern'){
			        			msg = '<bean:message bundle="km-supervise" key="kmSuperviseMain.concern.sucess"/>';
			        		}else{
			        			msg = '<bean:message bundle="km-supervise" key="kmSuperviseMain.source.failure"/>';
			        		}
			        		dialog.success(msg);
			        		if(method == 'addConcern'){
			        			LUI('toolbar').removeButton(LUI('attention'));
								LUI('toolbar').addButtons([toolbar.buildButton({text:'<bean:message bundle="km-supervise" key="py.cancelGuanZhu"/>',id:'disAttention',click:'updateConcern("deleteConcern");',order:'1'})]);
			        		}else{
			        			LUI('toolbar').removeButton(LUI('disAttention'));
								LUI('toolbar').addButtons([toolbar.buildButton({text:'<bean:message bundle="km-supervise" key="py.GuanZhu"/>',id:'attention',click:'updateConcern("addConcern");',order:'1'})]);
			        		}
			        	},
			        	error:function(req){
			        		del_load.hide();
			        		if(req.responseJSON){
			        			var data = req.responseJSON;
			        			dialog.failure(data.title);
			        		}else{
			        			dialog.failure('操作失败');
			        		}
			        	}
			
			      });
			};
			
		});
			
	</script>
</template:replace>
<c:choose>
	<c:when test="${param.approveModel eq 'right'}">
		<template:replace name="barRight">
			<ui:accordionpanel>
				<ui:content title="${lfn:message('km-supervise:table.kmSuperviseInstruction')}">
					<ui:iframe src="${LUI_ContextPath}/km/supervise/km_supervise_main/import/instruction_list_frame.jsp?fdMainId=${kmSuperviseMainForm.fdId}"></ui:iframe>
				</ui:content>
				<ui:content title="${lfn:message('km-supervise:table.kmSuperviseInstruction.message')}">
					<ui:iframe src="${LUI_ContextPath}/km/supervise/km_supervise_main/import/instruction_message_list_frame.jsp?fdMainId=${kmSuperviseMainForm.fdId}"></ui:iframe>
				</ui:content>
				<!-- 关联配置 -->
				<c:import url="/sys/relation/import/sysRelationMain_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmSuperviseMainForm" />
					<c:param name="approveType" value="right" />
				</c:import>
			</ui:accordionpanel>
		</template:replace>
	</c:when>
	<c:otherwise>
		<template:replace name="nav">
			<ui:accordionpanel style="min-height:50px;">
				<ui:content title="${lfn:message('km-supervise:table.kmSuperviseInstruction')}">
					<ui:iframe src="${LUI_ContextPath}/km/supervise/km_supervise_main/import/instruction_list_frame.jsp?fdMainId=${kmSuperviseMainForm.fdId}"></ui:iframe>
				</ui:content>
				
				<ui:content title="${lfn:message('km-supervise:table.kmSuperviseInstruction.message')}">
					<ui:iframe src="${LUI_ContextPath}/km/supervise/km_supervise_main/import/instruction_message_list_frame.jsp?fdMainId=${kmSuperviseMainForm.fdId}"></ui:iframe>
				</ui:content>
			</ui:accordionpanel>
			<c:import url="/sys/relation/import/sysRelationMain_view.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmSuperviseMainForm" />
			</c:import>
			
		</template:replace>
	</c:otherwise>
</c:choose>