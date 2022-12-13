<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple">
	<template:replace name="body">
		<list:listview>
			<ui:source type="AjaxJson">
		            {"url":"/km/supervise/km_supervise_back/kmSuperviseBack.do?method=data&fdSuperviseId=${param.fdSuperviseId }"}
		    </ui:source>
			<list:colTable isDefault="true" layout="sys.ui.listview.listtable"
				cfg-norecodeLayout="simple" rowHref="/km/supervise/km_supervise_back/kmSuperviseBack.do?method=view&fdId=!{fdId}">
				<list:col-auto props="index;fdPerson.name;fdFeedbackTime;fdProgress;fdResult;operations"></list:col-auto>
			</list:colTable>
			<ui:event topic="list.loaded">  
				seajs.use(['lui/jquery'],function($){
					if(window.frameElement!=null && window.frameElement.tagName=="IFRAME"){
						window.frameElement.style.height =  $(document.body).height() + "px";
					}
					$(".content").each(function(){
						var value=$(this).html();
						value = value.replace(/<\/?[^>]*>/g,'');
						value = value.replace(/[ | ]*\n/g,'\n');
						$(this).html(value);
					});
				});
			</ui:event>
		</list:listview>
		<div style="height: 15px;"></div>
		<list:paging channel="feedback" layout="sys.ui.paging.simple"></list:paging>
		<script type="text/javascript">
		seajs.use(['lui/dialog','lui/topic'],function(dialog,topic){
			window.feedBackDel = function(event,fdBackId){
				//阻止事件冒泡
				var e=(event)?event:window.event;  
				 if (window.event){  
				 	e.cancelBubble=true;  
				 }else {  
					e.stopPropagation();  
				 }
				dialog.confirm('<bean:message key="page.comfirmDelete"/>', function(isOk) {
	                if(isOk) {
	                	var delUrl = Com_Parameter.ContextPath+'km/supervise/km_supervise_back/kmSuperviseBack.do?method=delete&fdId='+fdBackId;
	                    window._load = dialog.loading();
						$.get(delUrl,function(data){
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
			}
		});
		</script>
	</template:replace>
</template:include>