<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include file="/sys/profile/resource/template/list.jsp">
	<template:replace name="content">
		<!-- 筛选器 -->
		<list:criteria id="criteria">
		     <list:cri-ref key="fdName" ref="criterion.sys.docSubject" title="${lfn:message('km-keydata-customer:kmCustomerMain.fdName') }">
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
						<list:sort property="docCreateTime" text="${lfn:message('km-keydata-customer:kmCustomerMain.docCreateTime') }" group="sort.list" value="down"></list:sort>
					</ui:toolbar>
				</div>
			</div>
			<!-- 分页 -->
			<div class="lui_list_operation_page_top">
            	<list:paging layout="sys.ui.paging.top" />
            </div>
			<!-- 操作按钮 -->
			<div style="float:right">
				<div style="display: inline-block;vertical-align: middle;">
					<ui:toolbar id="Btntoolbar">
						
						<c:if test="${empty param.categoryId}">
							<kmss:auth
							requestURL="/km/keydata/customer/km_customer_main/kmCustomerMain.do?method=add"
							requestMethod="GET">
								<ui:button text="${lfn:message('button.add')}" onclick="addByDialog();"></ui:button>
							</kmss:auth>
						</c:if>	
						<c:if test="${not empty param.categoryId}">
							<kmss:auth
								requestURL="/km/keydata/customer/km_customer_main/kmCustomerMain.do?method=add"
								requestMethod="GET">
								<ui:button text="${lfn:message('button.add')}" onclick="add();"></ui:button>
							</kmss:auth>
						</c:if>
						
						<c:if test="${param.fdIsAvailable=='true'}">
							<kmss:auth requestURL="/km/keydata/customer/km_customer_main/kmCustomerMain.do?method=disableAll">								
								<ui:button text="${lfn:message('km-keydata-base:keydata.setInvalidated')}" onclick="disableAll();"></ui:button>
							</kmss:auth>
						</c:if>
						<c:if test="${param.fdIsAvailable=='false'}">
							<kmss:auth requestURL="/km/keydata/customer/km_customer_main/kmCustomerMain.do?method=enableAll">
								<ui:button text="${lfn:message('km-keydata-base:keydata.setValidated')}" onclick="enableAll();"></ui:button>
							</kmss:auth>
						</c:if>
						
						<c:import url="/sys/simplecategory/import/doc_cate_change_button.jsp"
							charEncoding="UTF-8">
							<c:param name="modelName"
								value="com.landray.kmss.km.keydata.customer.model.KmCustomerMain" />
							<c:param name="docFkName" value="kmCustomerCategory" />
							<c:param name="cateModelName"
								value="com.landray.kmss.km.keydata.customer.model.KmCustomerCategory" />
						</c:import>
						
						 <c:import url="/sys/right/import/cchange_doc_right_button.jsp" charEncoding="UTF-8">
							<c:param name="modelName" value="com.landray.kmss.km.keydata.customer.model.KmCustomerMain" />
							<c:param name="authReaderNoteFlag" value="2" />
						</c:import>	
						
					</ui:toolbar>	
				</div>
			</div>
		</div>
		<ui:fixed elem=".lui_list_operation"></ui:fixed>
		<!-- 内容列表 -->
		<list:listview>
			<ui:source type="AjaxJson">
				{url:'/km/keydata/customer/km_customer_main/kmCustomerMain.do?method=listChildren&fdIsAvailable=${param.fdIsAvailable}&categoryId=${param.categoryId}'}
			</ui:source>
			<list:colTable isDefault="true" layout="sys.ui.listview.columntable" 
			     rowHref="/km/keydata/customer/km_customer_main/kmCustomerMain.do?method=showUsed&fdId=!{fdId}">
				<list:col-checkbox></list:col-checkbox>
				<list:col-serial></list:col-serial>
				<list:col-auto props="fdName,fdCode,fdBrief,fdEnglishName,docCreator.fdName,operations"></list:col-auto>
			</list:colTable>
		</list:listview>
		<br>
		<!-- 分页 -->
	 	<list:paging/>
	 	<script type="text/javascript">
		 	seajs.use(['lui/jquery', 'lui/dialog', 'lui/topic'], function($, dialog, topic) {

		 		window.showKeydataUsed = function(){
		 			var values = [];
					if(id){
						values.push(id);
					}else{
					    $("input[name='List_Selected']:checked").each(function(){
							values.push($(this).val());
						});
					}
		 			if(values.length==0){
		 				dialog.alert("<bean:message bundle="km-keydata-base" key="keydata.not.select.data"/>");
		 				return false;
		 			}else if(values.length>1){
		 				dialog.alert("<bean:message bundle="km-keydata-base" key="keydata.select.onlyOne"/>");
		 				return false;
		 			}

		 			var url = '<c:url value="/km/keydata/customer/km_customer_main/kmCustomerMain.do" />?method=showUsed'+'&keydataId='+id;
		 			
		 			Com_OpenWindow(url);
		 		};
		 		
		 		window.addByDialog = function(){
			 		
			 		var modelName = 'com.landray.kmss.km.keydata.customer.model.KmCustomerCategory';
			 		var urlParam = '/km/keydata/customer/km_customer_main/kmCustomerMain.do?method=add&fdTemplateId=!{id}&fdTemplateName=!{name}';
			 		
		 			function isIE() { //ie?
		 				      if (!!window.ActiveXObject || "ActiveXObject" in window)
		 				        return true;
		 				      else
		 				        return false;
		 			}
			 		
		 			dialog.simpleCategoryForNewFile(modelName, urlParam);
		 		};

		 		window.add = function(){
		 			Com_OpenWindow('<c:url value="/km/keydata/customer/km_customer_main/kmCustomerMain.do" />?method=add&fdTemplateId=${param.categoryId}');
			 	};

			 	window.edit = function(id){
					if(id){
						Com_OpenWindow('<c:url value="/km/keydata/customer/km_customer_main/kmCustomerMain.do?method=edit&fdId=" />'+id,'_blank');
					}
				};
		 		
		 		window.disableAll = function(id){
					var values = [];
					if(id){
						values.push(id);
						$.post('<c:url value="/km/keydata/customer/km_customer_main/kmCustomerMain.do?method=disableAll"/>',
								$.param({"List_Selected":values},true),delCallback,'json');
					}else{
						$("input[name='List_Selected']:checked").each(function(){
							values.push($(this).val());
						});
						if(values.length==0){
							dialog.alert('<bean:message key="page.noSelect"/>');
							return;
						}
						$.post('<c:url value="/km/keydata/customer/km_customer_main/kmCustomerMain.do?method=disableAll"/>',
							$.param({"List_Selected":values},true),delCallback,'json');				
					}
				};

				window.enableAll = function(id){
					var values = [];
					if(id){
						values.push(id);
						$.post('<c:url value="/km/keydata/customer/km_customer_main/kmCustomerMain.do?method=enableAll"/>',
								$.param({"List_Selected":values},true),delCallback,'json');
					}else{
						$("input[name='List_Selected']:checked").each(function(){
							values.push($(this).val());
						});
						if(values.length==0){
							dialog.alert('<bean:message key="page.noSelect"/>');
							return;
						}
						$.post('<c:url value="/km/keydata/customer/km_customer_main/kmCustomerMain.do?method=enableAll"/>',
								$.param({"List_Selected":values},true),delCallback,'json');
					}
				};
				window.delCallback = function(data){
					if(window.del_load!=null){
						window.del_load.hide();
					}
					topic.publish("list.refresh");
					dialog.result(data);
				};
				// 监听新建更新等成功后刷新
				topic.subscribe('successReloadPage', function() {
					topic.publish('list.refresh');
				});
		 	});
	 	</script>
	</template:replace>
</template:include>
