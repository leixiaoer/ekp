<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include file="/sys/profile/resource/template/list.jsp">
	<template:replace name="content">
		<!-- 筛选器 -->
		<list:criteria id="criteria">
		     <list:cri-ref key="fdName" ref="criterion.sys.docSubject" title="${lfn:message('km-review:kmReviewTemplate.fdName') }">
			</list:cri-ref>
			<%-- 搜索条件:是否有效 --%>
			<list:cri-criterion title="${ lfn:message('km-asset:kmAssetApplyBase.status')}" key="fdIsAvailable" multi="false" >
				<list:box-select>
					<list:item-select cfg-defaultValue="1">
						<ui:source type="Static">
							[{text:'${ lfn:message('km-asset:kmAssetApplyBase.fdIsAvailable.true')}', value:'1'},
							{text:'${ lfn:message('km-asset:kmAssetApplyBase.fdIsAvailable.false')}',value:'0'}]
						</ui:source>
					</list:item-select>
				</list:box-select>
			</list:cri-criterion>
		</list:criteria>
		<!-- 操作栏 -->
		<div class="lui_list_operation">
			<!-- 全选 -->
			<div class="lui_list_operation_order_btn">
				<list:selectall></list:selectall>
			</div>
			<!-- 分割线 -->
			<div class="lui_list_operation_line"></div>
			<!-- 排序 -->
			<div class="lui_list_operation_sort_btn">
				<div class="lui_list_operation_order_text">
					${ lfn:message('list.orderType') }：
				</div>
				<div class="lui_list_operation_sort_toolbar">
					<ui:toolbar layout="sys.ui.toolbar.sort" style="float:left" >
					<list:sortgroup>
					    <list:sort property="fdOrder" text="${lfn:message('km-review:kmReviewTemplate.fdOrder') }" group="sort.list" value="up"></list:sort>
						<list:sort property="docCreateTime" text="${lfn:message('km-review:kmReviewTemplate.docCreateTime') }" group="sort.list"></list:sort>
						<list:sort property="fdName" text="${lfn:message('km-review:kmReviewTemplate.fdName') }" group="sort.list"></list:sort>
					</list:sortgroup>
					</ui:toolbar>
				</div>
			</div>
			<!-- 分页 -->
			<div class="lui_list_operation_page_top">	
				<list:paging layout="sys.ui.paging.top" > 		
				</list:paging>
			</div>
			<!-- 操作按钮 -->
			<div style="float:right">
				<div style="display: inline-block;vertical-align: middle;">
					<ui:toolbar id="Btntoolbar">
					    <kmss:auth requestURL="/km/asset/km_asset_apply_template/kmAssetApplyTemplate.do?method=add" requestMethod="GET">
							<ui:button text="${lfn:message('button.add')}"  onclick="selectTemp();" order="1" ></ui:button>
						</kmss:auth>
						<kmss:auth requestURL="/km/asset/km_asset_apply_template/kmAssetApplyTemplate.do?method=deleteall" requestMethod="GET">
							<ui:button text="${lfn:message('button.deleteall')}" onclick="deleteAll();" order="2" ></ui:button>
						</kmss:auth>
						<c:import url="/sys/right/cchange_tmp_right/cchange_tmp_right_button_new.jsp" charEncoding="UTF-8">
							<c:param name="mainModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyBase" />
							<c:param name="tmpModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyTemplate" />
							<c:param name="templateName" value="fdApplyTemplate" />
							<c:param name="authReaderNoteFlag" value="2" /> 
						</c:import>
						<c:import url="/sys/workflow/import/sysWfTemplate_auditorBtn.jsp" charEncoding="UTF-8">
							<c:param name="fdModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyTemplate"/>
							<c:param name="cateid" value="${param.parentId}"/>
						</c:import>
						<kmss:auth requestURL="/km/asset/km_asset_apply_template/kmAssetApplyTemplate.do?method=deleteall" requestMethod="GET">
							<!-- 快速排序 -->
							<c:import url="/sys/profile/common/change_order_num.jsp" charEncoding="UTF-8">
								<c:param name="modelName" value="com.landray.kmss.km.asset.model.KmAssetApplyTemplate"></c:param>
								<c:param name="property" value="fdOrder"></c:param>
							</c:import>
						</kmss:auth>
					</ui:toolbar>
				</div>
			</div>
		</div>
		<ui:fixed elem=".lui_list_operation"></ui:fixed>
		<!-- 内容列表 -->
		<input type="hidden"" name="fdkey" value=""/>
		<input type="hidden"" name="fdApplyCategoryId" value=""/>
		<input type="hidden"" name="fdApplyCategoryName" value=""/>
		<input type="hidden"" name="fdTempName" value=""/>
		<list:listview>
			<ui:source type="AjaxJson">
				{url:'/km/asset/km_asset_apply_template/kmAssetApplyTemplate.do?method=listChildren&parentId=${param.parentId}'}
			</ui:source>
			<list:colTable isDefault="true" layout="sys.ui.listview.columntable" 
			    rowHref="/km/asset/km_asset_apply_template/kmAssetApplyTemplate.do?method=view&fdId=!{fdId}">
				<list:col-checkbox></list:col-checkbox>
				<list:col-auto props="fdOrder,fdName,fdIsAvailable,docCreator.fdName,docCreateTime,operations"></list:col-auto>
			</list:colTable>
		</list:listview>
		<br>
		<!-- 分页 -->
	 	<list:paging/>
	 	<script>
		Com_IncludeFile("dialog.js|data.js");
		</script>
		<script type="text/javascript">
		function selectTemp(){
			var fdkey = document.getElementsByName("fdkey")[0];
			var fdTempName = document.getElementsByName("fdTempName")[0];
			fdkey.value="";
			fdTempName.value="";
			Dialog_Tree(false,'fdkey','fdTempName',null,  'kmAssetApplyTreeService','<bean:message bundle="km-asset" key="kmAssetApplyTemplate.selectFdType"/>', null, afterTempSelect, null, null, true);
		}
		
		function afterTempSelect(){
			var fdkey = document.getElementsByName("fdkey")[0].value;
			var fdTempName = document.getElementsByName("fdTempName")[0].value;
			if(""!=fdkey||null!=fdkey.value){
		        var createUrl = '${KMSS_Parameter_ContextPath}km/asset/km_asset_apply_template/kmAssetApplyTemplate.do?method=add';
		       window.top.open(createUrl+'&parentId=${param.parentId}&fdkey='+fdkey+'&fdTempName='+encodeURI(fdTempName),'_blank');
			  }
		}
		</script>
	 	<script type="text/javascript">
		 	seajs.use(['lui/jquery', 'lui/dialog', 'lui/topic'], function($, dialog, topic) {
		 	    // 编辑
		 		window.edit = function(id) {
			 		if(id)
		 				Com_OpenWindow('<c:url value="/km/asset/km_asset_apply_template/kmAssetApplyTemplate.do" />?method=edit&fdId=' + id);
		 		};
		 		window.deleteAll = function(id){
					var values = [];
					if(id){
						values.push(id);
					}else{
					    $("input[name='List_Selected']:checked").each(function(){
							values.push($(this).val());
						});
					}
					if(values.length==0){
						dialog.alert('<bean:message key="page.noSelect"/>');
						return;
					}
					var url =Com_Parameter.ContextPath+'km/asset/km_asset_apply_template/kmAssetApplyTemplate.do?method=deleteall';
					var config = {
						url : url, // 删除数据的URL
						data : $.param({"List_Selected":values},true), // 要删除的数据
						modelName : "com.landray.kmss.km.asset.model.KmAssetApplyTemplate" // 主要是判断此文档是否有部署软删除
					};

					Com_Delete(config, delCallback);
					
				};
				window.delCallback= function(data){
					if(window.del_load!=null)
						window.del_load.hide();
					if(typeof (data.responseText) != 'undefined'){
						var obj = eval('(' + data.responseText + ')');
						if(false==obj.status){
							var msg =obj.message;
							dialog.failure(msg[0].msg);
						}else{
							topic.publish("list.refresh");
							dialog.result(data);
						}
					}else{
						topic.publish("list.refresh");
						dialog.result(data);
					}
				}
				// 监听新建更新等成功后刷新
				topic.subscribe('successReloadPage', function() {
					topic.publish('list.refresh');
				});
		 	});
	 	</script>
	</template:replace>
</template:include>
