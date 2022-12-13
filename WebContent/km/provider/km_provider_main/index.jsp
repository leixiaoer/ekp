<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include file="/sys/profile/resource/template/list.jsp">
	<template:replace name="content">
		<!-- 筛选器 -->
		<list:criteria id="criteria" expand="true">
		     <list:cri-ref key="fdName" ref="criterion.sys.docSubject" title="${lfn:message('km-provider:kmProviderMain.fdName') }">
			</list:cri-ref>
			<list:cri-auto modelName="com.landray.kmss.km.provider.model.KmProviderMain" property="fdBiao"/>
			<list:cri-criterion title="${ lfn:message('km-provider:kmProviderMain.fdIsvalidate')}" key="fdIsvalidate" >
				<list:box-select>
					<list:item-select cfg-defaultValue="${empty JsParam.fdIsvalidate ? 'true' : JsParam.fdIsvalidate}">
						<ui:source type="Static">
							[{text:'${ lfn:message('message.yes')}', value:'true'},
							{text:'${ lfn:message('message.no')}',value:'false'}]
						</ui:source>
					</list:item-select>
				</list:box-select>
			</list:cri-criterion>
		</list:criteria>
		<!-- 操作栏 -->
		<div class="lui_list_operation">
			<!-- 排序 -->
			<div style='color: #979797;float: left;padding-top:1px;'>
				${ lfn:message('list.orderType') }：
			</div>
			<div style="float:left">
				<div style="display: inline-block;vertical-align: middle;">
					<ui:toolbar layout="sys.ui.toolbar.sort" style="float:left" >
						<list:sortgroup>
							<list:sort property="docCreateTime" text="${lfn:message('km-provider:kmProviderMain.docCreateTime') }" group="sort.list" value="down"></list:sort>
							<list:sort property="fdName" text="${lfn:message('km-provider:kmProviderMain.fdName') }" group="sort.list"></list:sort>
						</list:sortgroup>
					</ui:toolbar>
				</div>
			</div>
			<!-- 分页 -->
			<div style="float:left;">	
				<list:paging layout="sys.ui.paging.top" > 		
				</list:paging>
			</div>
			<!-- 操作按钮 -->
			<div style="float:right">
				<div style="display: inline-block;vertical-align: middle;">
					<ui:toolbar id="Btntoolbar" count="8" >
					    <kmss:auth requestURL="/km/provider/km_provider_main/kmProviderMain.do?method=add" requestMethod="GET">
					        <ui:button text="${lfn:message('button.add')}" onclick="add()" order="1"></ui:button>	
					        <ui:button text="${lfn:message('button.import')}" onclick="importExcel();" order="3" ></ui:button>
						</kmss:auth>
						<kmss:auth requestURL="/km/provider/km_provider_main/kmProviderMain.do?method=deleteall" requestMethod="GET">
						    <ui:button text="${lfn:message('button.deleteall')}" onclick="deleteAll();" order="2" ></ui:button>
						</kmss:auth>
						<kmss:auth requestURL="/km/provider/km_provider_main/kmProviderMain.do?method=deleteall&categoryId=${param.categoryId}" requestMethod="GET">
						    <ui:button id="invalidate" text="${lfn:message('km-provider:kmProviderMain.btn.invalidate')}" onclick="invalidateAll();" order="4" ></ui:button>
						</kmss:auth>
						<kmss:auth requestURL="/km/provider/km_provider_main/kmProviderMain.do?method=deleteall&categoryId=${param.categoryId}" requestMethod="GET">
						    <ui:button id="validate" text="${lfn:message('km-provider:kmProviderMain.btn.validate')}" onclick="validateAll();" order="5" ></ui:button>
						</kmss:auth>
					</ui:toolbar>
				</div>
			</div>
		</div>
		<ui:fixed elem=".lui_list_operation"></ui:fixed>
		<!-- 内容列表 -->
		<list:listview>
			<ui:source type="AjaxJson">
				{url:'/km/provider/km_provider_main/kmProviderMain.do?method=list&categoryId=${JsParam.categoryId}&authReaderNoteFlag=${JsParam.authReaderNoteFlag}&fdIsvalidate=${JsParam.fdIsvalidate}'}
			</ui:source>
			<list:colTable isDefault="true" layout="sys.ui.listview.columntable" 
			     rowHref="/km/provider/km_provider_main/kmProviderMain.do?method=view&fdId=!{fdId}">
				<list:col-checkbox></list:col-checkbox>
				<list:col-serial></list:col-serial>
				<list:col-auto props="fdName,docCategory.fdName,fdBiao,fdAddress,fdLegal,fdContactPerson,fdPhoneNo,operations"></list:col-auto>
			</list:colTable>
		</list:listview>
		<br>
		<!-- 分页 -->
	 	<list:paging/>
	 	
	 	<script type="text/javascript">
		 	seajs.use(['lui/jquery', 'lui/dialog', 'lui/topic'], function($, dialog, topic) {
			 	// 增加
		 		window.add = function() {
		 			//新建
					dialog.simpleCategoryForNewFile(
							'com.landray.kmss.km.provider.model.KmProviderCategory',
							'/km/provider/km_provider_main/kmProviderMain.do?method=add&categoryId=!{id}',false,null,null,'${param.categoryId}');
		 		};
		 	// 增加
		 		window.importExcel = function() {
		 			Com_OpenWindow('<c:url value="/km/provider/km_provider_main/kmProviderMain_import.jsp" />');
		 		};
		 		
		 	// 编辑
		 		window.edit = function(id) {
			 		if(id)
		 				Com_OpenWindow('<c:url value="/km/provider/km_provider_main/kmProviderMain.do" />?method=edit&fdId=' + id);
		 		};
		 		window.deleteAll = function(id){
					var values = [];
					if(id){
						values.push(id);
			 		}else{
			 			$("input[name='List_Selected']:checked").each(function(){
							values.push($(this).val());
						});
						if(values.length==0){
							dialog.alert('<bean:message key="page.noSelect"/>');
							return;
						}
			 		}
					dialog.confirm('<bean:message key="page.comfirmDelete"/>',function(value){
						if(value==true){
							window.del_load = dialog.loading();
							$.post('<c:url value="/km/provider/km_provider_main/kmProviderMain.do?method=deleteall"/>',
									$.param({"List_Selected":values},true),delCallback,'json').error(function(e){delCallbackError(e);});
						}
					});
				};
				window.invalidateAll = function(id){
					var values = [];
					if(id){
						values.push(id);
					}else{
						$("input[name='List_Selected']:checked").each(function(){
							values.push($(this).val());
						});
						if(values.length==0){
							dialog.alert('<bean:message key="page.noSelect"/>');
							return;
						}
					}
					dialog.confirm('<bean:message bundle="km-provider" key="kmProviderMain.alert.comfirmAbandon"/>',function(value){
						if(value==true){
							window.del_load = dialog.loading();
							$.post('<c:url value="/km/provider/km_provider_main/kmProviderMain.do?method=invalidateAll"/>',
									$.param({"List_Selected":values},true),delCallback,'json').error(function(e){delCallbackError(e);});
						}
					});
				};

				window.validateAll = function(id){
					var values = [];
					if(id){
						values.push(id);
					}else{
						$("input[name='List_Selected']:checked").each(function(){
							values.push($(this).val());
						});
						if(values.length==0){
							dialog.alert('<bean:message key="page.noSelect"/>');
							return;
						}
					}
					dialog.confirm('<bean:message bundle="km-provider" key="kmProviderMain.alert.comfirmUse"/>',function(value){
						if(value==true){
							window.del_load = dialog.loading();
							$.post('<c:url value="/km/provider/km_provider_main/kmProviderMain.do?method=validateAll"/>',
									$.param({"List_Selected":values},true),delCallback,'json').error(function(e){delCallbackError(e);});
						}
					});
				};
				window.delCallback = function(data){ 
					if(window.del_load!=null){
						window.del_load.hide();
						topic.publish("list.refresh");
					}
					dialog.result(data);
				};
				window.delCallbackError = function(e){ 
					//处理
					if(window.del_load!=null){
						window.del_load.hide(); 
					} 
					if(e.responseJSON){
						dialog.result(e.responseJSON);
					}
				}
				
				
				topic.subscribe('successReloadPage', function() {
					topic.publish('list.refresh');
				});
				
				//根据筛选项显示启用或禁用按钮
				topic.subscribe('criteria.changed',function(evt){
					$('#validate').hide();
					$('#invalidate').hide();
					for(var i=0;i<evt['criterions'].length;i++){
	             	  if(evt['criterions'][i].key=="fdIsvalidate"){
		             	  var isValidate = evt['criterions'][i].value[0];
		             	  if(isValidate=='true'){
		             		 $('#invalidate').show();
		             	  }else if(isValidate=='false'){
		             		 $('#validate').show();
		             	  }
	             	  }
					}
					
				});
		 	});
	 	</script>
	</template:replace>
</template:include>
