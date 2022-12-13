<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple">
	<template:replace name="body">
		<div style="height:35px;">
		<c:if test="${param.feedbackcount > 0 }">
			<ui:button text="${lfn:message('sys-task:button.exportExcel')}"  style="margin-bottom:10px;float:right;"
				onclick="Com_OpenWindow('${LUI_ContextPath}/sys/task/sys_task_feedback/sysTaskFeedback.do?method=export&fdTaskId=${JsParam.fdTaskId}','_blank');">
			</ui:button>
		</c:if>
		</div>
		<list:listview >
			<ui:source type="AjaxJson">
				{"url":"/sys/task/sys_task_feedback/sysTaskFeedback.do?method=list&fdTaskId=${JsParam.fdTaskId}&rowsize=10"}
			</ui:source>
			<%--列表形式--%>
			<list:colTable isDefault="true" layout="sys.ui.listview.columntable" cfg-norecodeLayout="simple"
				rowHref="/sys/task/sys_task_feedback/sysTaskFeedback.do?method=view&fdId=!{fdId}"  name="columntable">
				<list:col-serial></list:col-serial>
				<list:col-auto props="docCreator.fdName;docCreateTime;sysTaskMain.docSubject;fdProgress;docContent"></list:col-auto>
				<list:col-auto props="operate"></list:col-auto>
			</list:colTable>   
			<ui:event topic="list.loaded">  
				seajs.use(['lui/jquery'],function($){
					if(window.frameElement!=null && window.frameElement.tagName=="IFRAME"){
						setTimeout(function(){
							window.frameElement.style.height = Math.max(document.documentElement.scrollHeight, document.body.scrollHeight) + "px";
						}, 1000);
					}
					$(".content").each(function(){
						var value=$(this).html();
						value = value.replace(/<\/?[^>]*>/g,'');
						value = value.replace(/[ | ]*\n/g,'\n');
						$(this).html(value);
					});
					$("#aclick a").on("click",function(){
					Com_OpenWindow($(this).attr("href"))
				    return false;
		 		       });		
				});
			</ui:event>	
		</list:listview>
		<div style="height: 15px;"></div>
		<list:paging layout="sys.ui.paging.simple"></list:paging>
	 	<script type="text/javascript">
			seajs.use(['lui/jquery','lui/dialog','lui/topic'], function($, dialog , topic) {
				//删除
				window.del=function(event,url){
					//阻止事件冒泡
					var e=(event)?event:window.event;  
					 if (window.event){  
					 	e.cancelBubble=true;  
					 }else {  
						e.stopPropagation();  
					 }
					dialog.confirm('<bean:message key="page.comfirmDelete"/>',function(value){
						if(value==true){
							window._load = dialog.loading();
							$.get(url,function(data){
								if(window._load!=null)
									window._load.hide();
								if(data!=null && data.status==true){
									topic.publish("list.refresh");
									dialog.success('<bean:message key="return.optSuccess" />');
								}else{
									dialog.failure('<bean:message key="return.optFailure" />');
								}
							},'json');
						}
					});
				};
				//引用
				window.quoteAdd=function(event,url){
					//阻止事件冒泡
					var e=(event)?event:window.event;  
					 if (window.event){  
					 	e.cancelBubble=true;  
					 }else {  
						e.stopPropagation();  
					 }
					 window.open(url);
				};
			});
	 	</script>
	</template:replace>
</template:include>