<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include file="/sys/xform/maindata/xform_ui_list.jsp">
	<template:replace name="head">
		<link type="text/css" rel="stylesheet" href="${LUI_ContextPath}/sys/profile/resource/css/operations.css?s_cache=${LUI_Cache}"/>
	</template:replace>
	<%-- 右边框内容 --%>
	<template:replace name="content">
		<%-- 筛选器 --%>
		<list:criteria>
			<list:cri-ref key="docSubject" ref="criterion.sys.docSubject">
			</list:cri-ref>
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
						<list:sort property="fdOrder" text="${lfn:message('sys-xform-maindata:sysFormMainDataShow.fdOrder') }" group="sort.list" value="up"></list:sort>
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
					<ui:toolbar>						
						<ui:button text="${lfn:message('button.add')}" onclick="addDocByCate();" order="2"  ></ui:button>					
						<ui:button text="${lfn:message('button.deleteall')}" order="4" onclick="delDoc()"></ui:button>
						<!-- 快速排序 -->
						<c:import url="/sys/profile/common/change_order_num.jsp" charEncoding="UTF-8">
							<c:param name="modelName" value="com.landray.kmss.sys.xform.maindata.model.SysFormMainDataShow"></c:param>              
							<c:param name="property" value="fdOrder"></c:param>
						</c:import>						
					</ui:toolbar>
				</div>
			</div>
		</div>
		<ui:fixed elem=".lui_list_operation"></ui:fixed>
		<list:listview id="listview">
			<ui:source type="AjaxJson">
				{url:'/sys/xform/maindata/main_data_show/sysFormMainDataShow.do?method=list&categoryId=${JsParam.categoryId }'}
			</ui:source>
			<%--列表形式--%>
			<list:colTable isDefault="false" layout="sys.ui.listview.columntable" 
				rowHref="/sys/xform/maindata/main_data_show/sysFormMainDataShow.do?method=edit&fdId=!{fdId}" name="columntable">
				<list:col-checkbox></list:col-checkbox>
				<list:col-auto props=""></list:col-auto>
			</list:colTable>   
		</list:listview> 
		<script type="text/javascript">
		seajs.use(['lui/jquery', 'lui/util/str', 'lui/dialog','lui/topic'], function($, strutil, dialog , topic) {
			var cateId = "${JsParam.categoryId}";
			window.addDocByCate = function(){
				Com_OpenWindow('<c:url value="/sys/xform/maindata/main_data_show/sysFormMainDataShow.do" />?method=add&categoryId='+ cateId);
			};
			//根据筛选器分类异步校验权限
			topic.subscribe('criteria.changed',function(evt){
				//每次都重置分类id的值,因为可能存在直接点叉清除分类筛选项
				try {
					for(var i=0;i<evt['criterions'].length;i++){
					  //获取分类id和类型
	             	  if(evt['criterions'][i].key=="docCategory"){
	             		 
	                 	 cateId= evt['criterions'][i].value[0];
		                // nodeType = evt['criterions'][i].nodeType;
	             	  }
					}
				}catch(e){}
			});
			// 监听新建更新等成功后刷新
			topic.subscribe('successReloadPage', function() {
				topic.publish("list.refresh");
			});
			// 编辑
	 		window.edit = function(id) {
		 		if(id)
	 				Com_OpenWindow('<c:url value="/sys/xform/maindata/main_data_show/sysFormMainDataShow.do" />?method=edit&fdId=' + id);
	 		};
	 		// 编辑
	 		window.listMainDatas = function(id) {
		 		if(id)
	 				Com_OpenWindow('<c:url value="/sys/xform/maindata/main_data_show/sysFormMainDataShow.do" />?method=listMainDatas&fdId=' + id);
	 		};
		 	//删除
	 		window.delDoc = function(id){
	 			var values = [];
	 			if(id) {
	 				values.push(id);
		 		} else {
					$("input[name='List_Selected']:checked").each(function() {
						values.push($(this).val());
					});
		 		}
				if(values.length==0){
					dialog.alert('<bean:message key="page.noSelect"/>');
					return;
				}
				var url  = '<c:url value="/sys/xform/maindata/main_data_show/sysFormMainDataShow.do?method=deleteall"/>';
				dialog.confirm('<bean:message key="page.comfirmDelete"/>', function(value) {
					if(value == true) {
						window.del_load = dialog.loading();
						$.ajax({
							url : url,
							type : 'POST',
							data : $.param({"List_Selected" : values}, true),
							dataType : 'json',
							error : function(data) {
								if(window.del_load != null) {
									window.del_load.hide(); 
								}
								dialog.result(data.responseJSON);
							},
							success: function(data) {
								if(window.del_load != null){
									window.del_load.hide(); 
									topic.publish("list.refresh");
								}
								dialog.result(data);
							}
					   });
					}
				});
			};
	 	});
		</script>
		<br>
	 	<list:paging></list:paging>
	</template:replace>
</template:include>