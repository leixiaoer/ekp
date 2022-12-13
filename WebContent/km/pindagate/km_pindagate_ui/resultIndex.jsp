<%--调查结果index页面--%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple" spa="true">
	<%-- 标签页标题 --%>
	<template:replace name="title">
		<c:out value="${ lfn:message('km-pindagate:module.km.pindagate') }"></c:out>
	</template:replace>
	<template:replace name="body"> 
		<script type="text/javascript">
		    seajs.use(['theme!list']);
			var SYS_SEARCH_MODEL_NAME ="com.landray.kmss.km.pindagate.model.KmPindagateMain";
			seajs.use(['lui/jquery', 'lui/dialog','lui/topic','lui/toolbar'], function($, dialog , topic,toolbar) {

				// 监听新建更新等成功后刷新
				topic.subscribe('successReloadPage', function() {
					topic.publish('list.refresh');
				});
				
				//新建
		 		window.addDoc = function() {
						dialog.categoryForNewFile(
								'com.landray.kmss.km.pindagate.model.KmPindagateTemplate',
								'/km/pindagate/km_pindagate_main/kmPindagateMain.do?method=add&fdTemplateId=!{id}',false,null,null,'${JsParam.categoryId}',null,null,true);
			 	};
				//删除
		 		window.delDoc = function(){
		 			var values = [];
					$("input[name='List_Selected']:checked").each(function(){
							values.push($(this).val());
						});
					if(values.length==0){
						dialog.alert('<bean:message key="page.noSelect"/>');
						return;
					}
					dialog.confirm('<bean:message key="page.comfirmDelete"/>',function(value){
						if(value==true){
							window._load = dialog.loading();
							$.post('<c:url value="/km/pindagate/km_pindagate_main/kmPindagateMain.do?method=deleteall"/>',
									$.param({"List_Selected":values,"categoryId":"${JsParam.categoryId}"},true),callback,'json');
						}
					});
				};
			 	window.callback = function(data){
					if(window._load!=null)
						window._load.hide();
					if(data!=null && data.status==true){
						topic.publish("list.refresh");
						dialog.success('<bean:message key="return.optSuccess" />');
					}else{
						dialog.failure('<bean:message key="return.optFailure" />');
					}
				};
				
				// 查看二维码
				window.qrcodeShow = function(Id) {
					console.log("qrcodeShow:", Id);
					dialog.iframe("/km/pindagate/qrCode_dialog.jsp?Id=" + Id, '${lfn:message("km-pindagate:kmPindagateMain.operations")}', function(data) {
					}, {
						width:250,
						height:350
					});
				}
			});
			</script>
		<list:criteria id="resultCriteria">
			<list:cri-ref key="docSubject" ref="criterion.sys.docSubject"  title="${ lfn:message('km-pindagate:kmPindagateMain.docSubject') }"></list:cri-ref>
			<list:cri-ref ref="criterion.sys.category" key="categoryId" multi="false" expand="false" title="${ lfn:message('sys-category:menu.sysCategory.index') }">
			  <list:varParams modelName="com.landray.kmss.km.pindagate.model.KmPindagateTemplate"/>
			</list:cri-ref>
			<list:cri-auto modelName="com.landray.kmss.km.pindagate.model.KmPindagateMain" property="docCreator;docStartTime;docFinishedTime"/>
		</list:criteria>
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
					<ui:toolbar layout="sys.ui.toolbar.sort" style="float:left">
						<list:sortgroup>
						    <list:sort property="docCreateTime" text="${lfn:message('km-pindagate:kmPindagateMain.docCreateTime') }" group="sort.list" value="down"></list:sort>
						    <list:sort property="docStatus" text="${lfn:message('km-pindagate:kmPindagateMain.docStatus') }" group="sort.list"></list:sort>
						    <list:sort property="docFinishedTime" text="${lfn:message('km-pindagate:kmPindagateMain.docFinishedTime') }" group="sort.list"></list:sort>
						</list:sortgroup>
					</ui:toolbar>
				</div>
			</div>
			<!-- 分页 -->
			<div class="lui_list_operation_page_top">	
				<list:paging layout="sys.ui.paging.top" > 		
				</list:paging>
			</div>
			
			<div style="float:right">
				<div style="display: inline-block;vertical-align: middle;">
					<ui:toolbar id="toolbar">
						<%--新建--%>
						<kmss:authShow roles="ROLE_KMPINDAGATE_CREATE">
							<ui:button text="${lfn:message('button.add')}" onclick="addDoc()" order="2" ></ui:button>
						</kmss:authShow>
						<kmss:authShow roles="ROLE_KMPINDAGATE_TRANSPORT_EXPORT">
						<ui:button text="${lfn:message('button.export')}" id="export" onclick="listExport('${LUI_ContextPath}/sys/transport/sys_transport_export/SysTransportExport.do?method=listExport&fdModelName=com.landray.kmss.km.pindagate.model.KmPindagateMain')" order="3" ></ui:button>
						</kmss:authShow>
						<%--删除--%>
						<kmss:auth requestURL="/km/pindagate/km_pindagate_main/kmPindagateMain.do?method=deleteall&status=${param.status}&categoryId=${param.categoryId}">
						<ui:button text="${lfn:message('button.deleteall')}" order="4" onclick="delDoc()"></ui:button>
					</kmss:auth>
					</ui:toolbar>
				</div>
			</div>
		</div>
		<ui:fixed elem=".lui_list_operation"></ui:fixed>
		 <%--list页面--%>
		<list:listview id="listview">
			<ui:source type="AjaxJson">
				{url:'/km/pindagate/km_pindagate_main/kmPindagateData.do?method=listChildren&categoryId=${JsParam.categoryId}&treeNode=result'}
			</ui:source>
			<%--列表视图--%>
			<list:colTable isDefault="true" layout="sys.ui.listview.columntable" 
				 rowHref="/km/pindagate/km_pindagate_main/kmPindagateMain.do?method=resultsView&fdId=!{fdId}&flag=!{flag}"  name="columntable">
				<list:col-checkbox></list:col-checkbox>
				<list:col-serial></list:col-serial>
				<list:col-auto props="docSubject;docStatus;fdLastStatNum;kmPindagateTemplate.fdName;docFinishedTime"></list:col-auto>
			</list:colTable>
		</list:listview>
		<list:paging></list:paging>	 
	</template:replace>
	
</template:include>