<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include file="/sys/profile/resource/template/list.jsp">
	<template:replace name="content">
		<!-- 筛选器 -->
		<list:criteria id="criteria">
		     <list:cri-ref key="fdName" ref="criterion.sys.docSubject" title="${lfn:message('km-pindagate:kmPindagateTemplate.fdName') }">
			</list:cri-ref>
			<%-- 搜索条件:是否有效 --%>
			<list:cri-criterion title="${ lfn:message('km-pindagate:kmPindagateMain.status')}" key="fdIsAvailable" multi="false" >
				<list:box-select>
					<list:item-select cfg-defaultValue="1">
						<ui:source type="Static">
							[{text:'${ lfn:message('km-pindagate:kmPindagateTemplate.fdIsAvailable.true')}', value:'1'},
							{text:'${ lfn:message('km-pindagate:kmPindagateTemplate.fdIsAvailable.false')}',value:'0'}]
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
						    <list:sort property="fdOrder" text="${lfn:message('km-pindagate:kmPindagateTemplate.fdOrder') }" group="sort.list" value="up"></list:sort>
							<list:sort property="docCreateTime" text="${lfn:message('km-pindagate:kmPindagateTemplate.docCreateTime') }" group="sort.list"></list:sort>
							<list:sort property="fdName" text="${lfn:message('km-pindagate:kmPindagateTemplate.fdName') }" group="sort.list"></list:sort>
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
					<ui:toolbar id="Btntoolbar" count="3">			
						<kmss:auth
							requestURL="/km/pindagate/km_pindagate_template/kmPindagateTemplate.do?method=add"
							requestMethod="GET">
							<ui:button text="${lfn:message('button.add')}" onclick="add();"></ui:button>
						</kmss:auth>
						<kmss:auth
							requestURL="/km/pindagate/km_pindagate_template/kmPindagateTemplate.do?method=deleteall&parentId=${param.parentId}"
							requestMethod="GET">
							<ui:button text="${lfn:message('button.deleteall')}" onclick="deleteAll();"></ui:button>
						</kmss:auth>
						<!-- 快速排序 -->
						<c:import url="/sys/profile/common/change_order_num.jsp" charEncoding="UTF-8">
							<c:param name="modelName" value="com.landray.kmss.km.pindagate.model.KmPindagateTemplate"></c:param>
							<c:param name="property" value="fdOrder"></c:param>
							<c:param name="btnOrder" value="3"></c:param>
						</c:import>
						<c:import url="/sys/right/cchange_tmp_right/cchange_tmp_right_button_new.jsp" charEncoding="UTF-8">
							<c:param name="mainModelName" value="com.landray.kmss.km.pindagate.model.KmPindagateMain" />
							<c:param name="tmpModelName" value="com.landray.kmss.km.pindagate.model.KmPindagateTemplate" />
							<c:param name="templateName" value="fdTemplate" />
							<c:param name="categoryId" value="${param.parentId}" />
							<c:param name="authReaderNoteFlag" value="2" />
						</c:import>
						<c:import url="/sys/workflow/import/sysWfTemplate_auditorBtn.jsp" charEncoding="UTF-8">
							<c:param name="fdModelName" value="com.landray.kmss.km.pindagate.model.KmPindagateTemplate"/>
					    	<c:param name="cateid" value="${param.parentId}"/>
						</c:import>
					</ui:toolbar>	
				</div>
			</div>
		</div>
		<ui:fixed elem=".lui_list_operation"></ui:fixed>
		<!-- 内容列表 -->
		<list:listview>
			<ui:source type="AjaxJson">
				{url:'/km/pindagate/km_pindagate_template/kmPindagateTemplate.do?method=listChildren&parentId=${param.parentId}'}
			</ui:source>
			<list:colTable isDefault="true" layout="sys.ui.listview.columntable" 
			     rowHref="/km/pindagate/km_pindagate_template/kmPindagateTemplate.do?method=view&fdId=!{fdId}">
				<list:col-checkbox></list:col-checkbox>
				<list:col-auto props="fdOrder,fdName,fdIsAvailable,docCreator.fdName,docCreateTime,operations"></list:col-auto>
			</list:colTable>
		</list:listview>
		<br>
		<!-- 分页 -->
	 	<list:paging/>
	 	<script type="text/javascript">
		 	seajs.use(['lui/jquery', 'lui/dialog', 'lui/topic'], function($, dialog, topic) {

		 		topic.subscribe('successReloadPage', function() {
					topic.publish('list.refresh');
				});
		 		
		 		window.add = function() {
		 			Com_OpenWindow('<c:url value="/km/pindagate/km_pindagate_template/kmPindagateTemplate.do" />?method=add&parentId=${param.parentId}');
		 		};
		 		
		 		window.addDoc = function(id) {
		 			Com_OpenWindow('<c:url value="/km/pindagate/km_pindagate_main/kmPindagateMain.do" />?method=add&fdTemplateId='+id);
		 		};

		 		window.edit = function(id){
			 		if(id){
			 			Com_OpenWindow('<c:url value="/km/pindagate/km_pindagate_template/kmPindagateTemplate.do?method=edit&fdId=" />'+id,'_blank');
			 		}
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
							$.post('<c:url value="/km/pindagate/km_pindagate_template/kmPindagateTemplate.do?method=deleteall"/>',
									$.param({"List_Selected":values},true),delCallback,'json');
						}
					});
				};
				window.delCallback = function(data){
					if(window.del_load!=null){
						window.del_load.hide();
					}
					topic.publish("list.refresh");
					dialog.result(data);
				};
		 	});
	 	</script>
	</template:replace>
</template:include>
