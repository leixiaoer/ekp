<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple" spa="true">
	<template:replace name="title">
		<c:out value="${ lfn:message('geesun-oitems:geesunOitems.tree.modelName') }"></c:out>
	</template:replace>
	<template:replace name="body"> 
		<script type="text/javascript">
			seajs.use(['theme!list']);	
		</script>
	<ui:tabpanel id="geesunOitemsListingPanel" layout="sys.ui.tabpanel.list" >
		<ui:content id="geesunOitemsListingContent" title="${ lfn:message('geesun-oitems:geesunOitems.tree.stock.manage1') }"> 
		<list:criteria id="listingCriteria" multi="false">
		    <list:cri-ref key="keywords" ref="criterion.sys.docSubject" title="${ lfn:message('geesun-oitems:geesunOitemsListing.fdName.placehoder')}" style="width:160px">
			</list:cri-ref>
			<list:cri-ref ref="criterion.sys.simpleCategory" key="fdCategory" multi="false" title="用品分类">
			  <list:varParams modelName="com.landray.kmss.geesun.oitems.model.GeesunOitemsManage"/>
			</list:cri-ref>
			<list:cri-criterion title="${ lfn:message('geesun-oitems:geesunOitemsListing.fdIsAbandon') }" key="fdIsAbandon" multi="false">
				<list:box-select>
					<list:item-select cfg-defaultValue="true">
						<ui:source type="Static">
							[{text:'${ lfn:message('message.yes') }', value:'true'}
							,{text:'${ lfn:message('message.no') }', value:'false'}
							]
						</ui:source>
					</list:item-select>
				</list:box-select>
			</list:cri-criterion>
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
					<ui:toolbar layout="sys.ui.toolbar.sort" style="float:left" count="4" >
						<list:sortgroup>
							<list:sort property="fdNo" text="${ lfn:message('geesun-oitems:geesunOitemsListing.fdNo') }" group="sort.list" value="down"></list:sort>
							<list:sort property=" fdName" text="${ lfn:message('geesun-oitems:geesunOitemsListing.fdName') }" group="sort.list"></list:sort>
							<list:sort property="fdReferencePrice" text="${ lfn:message('geesun-oitems:geesunOitemsListing.fdReferencePrice') }" group="sort.list"></list:sort>
							<list:sort property="fdAmount" text="${ lfn:message('geesun-oitems:geesunOitemsListing.fdAmount') }" group="sort.list"></list:sort>
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
					<ui:toolbar count="3">
							<kmss:auth requestURL="/geesun/oitems/geesun_oitems_listing/geesunOitemsListing.do?method=add" requestMethod="GET">
								<ui:button title="${lfn:message('geesun-oitems:geesunOitemsListing.opt.create1')}" text="${lfn:message('button.add')}" onclick="addDoc()" order="2"></ui:button>	
							</kmss:auth> 
							
							<kmss:authShow roles="ROLE_GEESUNOITEMS_TRANSPORT_EXPORT">
							<ui:button text="${lfn:message('button.export')}" id="export" onclick="listExport('${LUI_ContextPath}/sys/transport/sys_transport_export/SysTransportExport.do?method=listExport&fdModelName=com.landray.kmss.geesun.oitems.model.GeesunOitemsListing')" order="2" ></ui:button>
						    </kmss:authShow>
						    
						    <ui:button text="${lfn:message('button.deleteall')}" onclick="delDoc()" order="4"
						       cfg-auth="/geesun/oitems/geesun_oitems_listing/geesunOitemsListing.do?method=deleteall">
						    </ui:button>
						   <%-- 修改权限 --%>
							<c:import url="/sys/right/import/doc_right_change_button.jsp" charEncoding="UTF-8">
								<c:param name="modelName" value="com.landray.kmss.geesun.oitems.model.GeesunOitemsListing"/>
								<c:param name="spa" value="true" />
							</c:import>		
					</ui:toolbar> 
				</div>
			</div>
		</div>
		<list:listview id="listview">
		    <ui:source type="AjaxJson">
					{url:'/geesun/oitems/geesun_oitems_listing/geesunOitemsListing.do?method=list&categoryId=${JsParam.categoryId}'}
		    </ui:source>
			<list:colTable isDefault="false" layout="sys.ui.listview.columntable" 
				rowHref="/geesun/oitems/geesun_oitems_listing/geesunOitemsListing.do?method=view&fdId=!{fdId}"  name="columntable">
				<list:col-checkbox></list:col-checkbox>
				<list:col-serial></list:col-serial>
				<list:col-auto props="fdNo"></list:col-auto>
				<list:col-html  title="${ lfn:message('geesun-oitems:geesunOitemsListing.fdName') }" style="text-align:left">
				 {$ <span class="com_subject" >{%row['fdName']%}</span> $}
				</list:col-html>
				<list:col-auto props="fdCategory.fdName;fdSpecification;fdBrand;fdUnit;fdReferencePrice;fdAmount"></list:col-auto>
			</list:colTable>
		</list:listview>
	 	<list:paging></list:paging>	 
	 	</ui:content>
	 </ui:tabpanel>	
	 	<script type="text/javascript">
	 	
	 	var SYS_SEARCH_MODEL_NAME ="com.landray.kmss.geesun.oitems.model.GeesunOitemsListing";
	 	
			seajs.use(['lui/jquery','lui/dialog','lui/topic'], function($, dialog , topic) {

				// 监听新建更新等成功后刷新
				topic.subscribe('successReloadPage', function() {
					topic.publish('list.refresh');
				});
				
				//新建
				window.addDoc = function() {
						dialog.simpleCategoryForNewFile(
								'com.landray.kmss.geesun.oitems.model.GeesunOitemsManage',
								'/geesun/oitems/geesun_oitems_listing/geesunOitemsListing.do?method=add&categoryId=!{id}',false,null,null,'${JsParam.categoryId}');
						//Com_OpenWindow('<c:url value="/geesun/oitems/geesun_oitems_listing/geesunOitemsListing.do" />?method=add');
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
					var url  = '<c:url value="/geesun/oitems/geesun_oitems_listing/geesunOitemsListing.do?method=deleteall"/>';
					dialog.confirm('<bean:message key="page.comfirmDelete"/>',function(value){
						if(value==true){
							window.del_load = dialog.loading();

							$.ajax({
								url: url,

								type: 'POST',

								data:$.param({"List_Selected":values},true),

								dataType: 'json',

								error: function(data){
									if(window.del_load!=null){
										window.del_load.hide(); 
									}
									dialog.result(data.responseJSON);
								},

								success: delCallback

								});
							
							//$.post('<c:url value="/km/review/km_review_main/kmReviewMain.do?method=deleteall"/>',
							//		$.param({"List_Selected":values},true),delCallback,'json');
						}
					});
				};

				window.delCallback = function(data){
					if(window.del_load!=null)
						window.del_load.hide();
					if(data!=null && data.status==true){
						topic.publish("list.refresh");
						dialog.success('<bean:message key="return.optSuccess" />');
					}else{
						dialog.failure('<bean:message key="return.optFailure" />');
					}
				};
			});
		</script>	 
	</template:replace>
</template:include>
