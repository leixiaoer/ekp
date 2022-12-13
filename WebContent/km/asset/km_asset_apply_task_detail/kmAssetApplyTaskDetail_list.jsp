<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@page import="com.landray.kmss.km.asset.util.AssetTaskUtil"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<% response.addHeader("X-UA-Compatible", "IE=edge"); %>	
<template:include ref="config.list">
	<template:replace name="toolbar">
	</template:replace>
	<template:replace name="content">
	<script type="text/javascript">
		Com_IncludeFile("common.js|data.js");
		seajs.use(['lui/jquery','lui/dialog','lui/topic',"lui/util/env"], function($,dialog ,topic,env) {
			
			// 监听新建更新等成功后刷新
			topic.subscribe('successReloadPage', function() {
				if (window.parent.LUI) {
					window.parent.LUI.fire({ type: "topic", name: "ChildReloadSuccess" });
				}
			});
			
			// 创建资产卡片
		 	window.openCreateCard = function(fdTaskId,fdAssetCategoryId,fdAssetAddressId) {
				dialog.simpleCategoryForNewFile('com.landray.kmss.km.asset.model.KmAssetCategory',null,false,function(rtn) {
					if(rtn != false&&rtn != null){
		 				var tempId = rtn.id;
		 				var tempName = rtn.name;
		 				if(tempId !=null && tempId != ''){
							Com_OpenWindow(env.fn.formatUrl('/km/asset/km_asset_card/kmAssetCard.do?method=add&fdTaskId='+fdTaskId+'&fdTemplateId='+tempId+'&fdAssetAddressId='+fdAssetAddressId), '_blank');
		 				}
		 			}
				},null,null,null,true)};
			
			//批量盘点和批量盘亏
			window.createInventoryBatch = function(type){
				var values = [];
				$("input[name='List_Selected']:checked").each(function(){
						values.push($(this).val());
					});
				if(values.length==0){
					dialog.alert('<bean:message key="page.noSelect"/>');
					return;
				}
				if(values.length>50){
					dialog.alert('<bean:message bundle="km-asset" key="kmAssetApplyTaskDetail.createInventoryBatch.tip"/>');
					return;
				}
				dialog.category('com.landray.kmss.km.asset.model.KmAssetApplyTemplate','fdTemplateId','fdTemplateName',false,function(rtn){
					if(rtn != false&&rtn != null){
						var tempId = rtn.id;
						var tempName = rtn.name;
						if(tempId !=null && tempId != ''){
							var data = new KMSSData();
							var url = Com_Parameter.ContextPath+"km/asset/km_asset_apply_base/kmAssetApplyBase.do?method=loadAssetApplyTemplate&tempId="+tempId;
							var templateUrl;
							data.SendToUrl(url,function(data) {
		 	 	    			templateUrl=data.responseText;
		 	 	    		},false);
							var fdTaskId = '${JsParam.fdTaskId}';
							values = values.join(";");
							Com_OpenWindow(Com_Parameter.ContextPath+templateUrl+"&fdTaskId="+fdTaskId+"&fdDetailId="+values, '_blank');
						}
					}
				},null,null,null,null,null,type);
			};
				
			// 盘点和盘亏
			window.createInventory = function(type,fdTaskId,fdDetailId,fdCardId){
	 			dialog.category('com.landray.kmss.km.asset.model.KmAssetApplyTemplate','fdTemplateId','fdTemplateName',false,function(rtn){
		 			if(rtn != false&&rtn != null){
		 				var tempId = rtn.id;
		 				var tempName = rtn.name;
		 				if(tempId !=null && tempId != ''){
		 					var data = new KMSSData();
		 	 	    		var url = Com_Parameter.ContextPath+"km/asset/km_asset_apply_base/kmAssetApplyBase.do?method=loadAssetApplyTemplate&tempId="+tempId;
		 	 	    		var templateUrl;
		 	 	    		data.SendToUrl(url,function(data) {
		 	 	    			templateUrl=data.responseText;
		 	 	    		},false);
							Com_OpenWindow(Com_Parameter.ContextPath+templateUrl+"&fdTaskId="+fdTaskId+"&fdCardId="+fdCardId+"&fdDetailId="+fdDetailId, '_blank');
		 				}
		 			}
		 	   },null,null,null,null,null,type);
		 	};
			
			window.viewInventory = function(fdTaskId,fdDetailId,fdCardId,fdOprUrl){
				if (fdOprUrl !== "") {
					Com_OpenWindow(Com_Parameter.ContextPath+fdOprUrl, '_blank');
				}
			};
			
			window.deleteInventory = function(fdTaskId,fdDetailId,fdCardId){
				seajs.use(['lui/jquery','lui/dialog','lui/topic'], function($, dialog , topic){
					dialog.confirm('<bean:message key="page.comfirmDelete"/>',function(value){
						if(value==true){
							var del_load = dialog.loading();
							$.ajax({
								type:'get',
								async:false,
								url:Com_Parameter.ContextPath+'km/asset/km_asset_apply_task_detail/kmAssetApplyTaskDetail.do',
								data:{method:'delete',fdId:fdDetailId},
								dataType: 'json',
								success:function(result){
									if(del_load!=null){
										del_load.hide();
										// topic.publish("list.refresh");
										if (window.parent.LUI) {
											window.parent.LUI.fire({ type: "topic", name: "ChildReloadSuccess" });
										}
									}
									dialog.result(data);
								},
								error:function(){
								}
							});
						}
					});
				});								
			}
		});
	</script>
	<div style="min-height: 30px;display: block;">
		<div style="display: inline-block;vertical-align: middle;float: right;">
				<%-- 批量盘点和批量盘亏按钮 --%>
				<c:if test="${param.inventoryType eq 'todoInventory' and param.criteriaType eq 'my' and kmAssetApplyTask.fdStatus eq '2' and '30' eq  kmAssetApplyTask.docStatus}">
					<ui:button text="${lfn:message('km-asset:kmAssetApplyTask.inventory.batch')}" onclick="createInventoryBatch('KmAssetApplyInventoryDoc');"></ui:button>
					<ui:button text="${lfn:message('km-asset:kmAssetApplyTask.noInventory.batch')}" onclick="createInventoryBatch('KmAssetApplyDealDoc');"></ui:button>
				</c:if>
				<%-- 盘盈按钮 --%>
				<c:if test="${param.inventoryType eq 'Overage' and kmAssetApplyTask.fdStatus eq '2' and '30' eq  kmAssetApplyTask.docStatus}">
					<%
						if(AssetTaskUtil.checkPermission("py",pageContext.getRequest().getAttribute("kmAssetApplyTask"),null)){
					%>
					<ui:button text="${ lfn:message('km-asset:kmAssetApplyTask.button.addInventory') }" onclick="openCreateCard('${kmAssetApplyTask.fdId}','${kmAssetApplyTask.fdAssetCategory.fdId}','${kmAssetApplyTask.fdAssetAddress.fdId}');">
					</ui:button>
					<%	
						}
					%>
				</c:if>
		</div>
	</div>
	<ui:fixed elem=".lui_list_operation"></ui:fixed>
	<list:listview id="listview" cfg-needMinHeight="false">
		<ui:source type="AjaxJson">
				{url:'/km/asset/km_asset_apply_task_detail/kmAssetApplyTaskDetail.do?method=manageList&fdTaskId=${JsParam.fdTaskId}&inventoryType=${JsParam.inventoryType}&criteriaType=${JsParam.criteriaType}&fdAssignUser=${JsParam.fdAssignUser}&personnelIds=${JsParam.personnelIds}&taskCreator=${JsParam.taskCreator}'}
		</ui:source>
		<list:colTable isDefault="false" layout="sys.ui.listview.columntable" name="columntable"> 
			<list:col-checkbox></list:col-checkbox>
			<list:col-serial></list:col-serial>
			<c:choose>
				<%-- 发布状态、进行中的任务才有操作列 --%>
				<c:when test="${kmAssetApplyTask.fdStatus eq '2' and '30' eq  kmAssetApplyTask.docStatus}">
					<list:col-auto props="fdStatus,fdAssetCard.fdAssetStatus,fdAssetCard.fdCode,fdName,fdAssetCard.fdAssetCategory,fdAssetCard.fdStandard,operation"></list:col-auto>
				</c:when>
				<c:otherwise>
					<list:col-auto props="fdStatus,fdAssetCard.fdAssetStatus,fdAssetCard.fdCode,fdName,fdAssetCard.fdAssetCategory,fdAssetCard.fdStandard"></list:col-auto>
				</c:otherwise>
			</c:choose>
		</list:colTable>
	</list:listview> 
 	<list:paging></list:paging>
  </template:replace>
</template:include>