<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple" spa="true">
	<template:replace name="title">
		<c:out value="${ lfn:message('km-oitems:kmOitems.tree.modelName') }"></c:out>
	</template:replace>
	<template:replace name="body"> 
		<script type="text/javascript">
			seajs.use(['theme!list']);	
		</script>
	<ui:tabpanel id="kmOitemsListingPanel" layout="sys.ui.tabpanel.list" >
		<ui:content id="kmOitemsListingContent" title="${ lfn:message('km-oitems:kmOitems.tree.stock.manage1') }"> 
		<list:criteria id="listingCriteria" multi="false">
		    <list:cri-ref key="keywords" ref="criterion.sys.docSubject" title="${ lfn:message('km-oitems:kmOitemsListing.fdName.placehoder')}" style="width:160px">
			</list:cri-ref>
			<list:cri-ref ref="criterion.sys.simpleCategory" key="fdCategory" multi="false" title="用品分类">
			  <list:varParams modelName="com.landray.kmss.km.oitems.model.KmOitemsManage"/>
			</list:cri-ref>
			<list:cri-criterion title="${ lfn:message('km-oitems:kmOitemsListing.fdIsAbandon') }" key="fdIsAbandon" multi="false">
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
							<list:sort property="kmOitemsListing.fdNo" text="${ lfn:message('km-oitems:kmOitemsListing.fdNo') }" group="sort.list" value="down"></list:sort>
							<list:sort property="kmOitemsListing.fdName" text="${ lfn:message('km-oitems:kmOitemsListing.fdName') }" group="sort.list"></list:sort>
							<list:sort property="kmOitemsListing.fdReferencePrice" text="${ lfn:message('km-oitems:kmOitemsListing.fdReferencePrice') }" group="sort.list"></list:sort>
							<list:sort property="kmOitemsListing.fdAmount" text="${ lfn:message('km-oitems:kmOitemsListing.fdAmount') }" group="sort.list"></list:sort>
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
					<ui:toolbar count="4">
							<kmss:auth requestURL="/km/oitems/km_oitems_listing/kmOitemsListing.do?method=add" requestMethod="GET">
								<ui:button title="${lfn:message('km-oitems:kmOitemsListing.opt.create1')}" text="${lfn:message('button.add')}" onclick="addDoc()" order="2"></ui:button>	
							</kmss:auth>  
							
							<kmss:authShow roles="ROLE_KMOITEMS_TRANSPORT_EXPORT">
								<ui:button text="${lfn:message('button.export')}" id="export" onclick="listExport('${LUI_ContextPath}/sys/transport/sys_transport_export/SysTransportExport.do?method=listExport&fdModelName=com.landray.kmss.km.oitems.model.KmOitemsListing')" order="2" ></ui:button>
						   	</kmss:authShow>
						    
						    <ui:button text="${lfn:message('button.deleteall')}" id="delBtn" onclick="delDoc()" order="4"
						       cfg-auth="/km/oitems/km_oitems_listing/kmOitemsListing.do?method=deleteall">
						    </ui:button>
						   <%-- 修改权限 --%>
							<c:import url="/sys/right/import/doc_right_change_button.jsp" charEncoding="UTF-8">
								<c:param name="modelName" value="com.landray.kmss.km.oitems.model.KmOitemsListing"/>
								<c:param name="spa" value="true" />
							</c:import> 
							
							
					</ui:toolbar> 
				</div>
			</div>
		</div>
		<list:listview id="listview">
		    <ui:source type="AjaxJson">
					{url:'/km/oitems/km_oitems_listing/kmOitemsListing.do?method=list&categoryId=${JsParam.categoryId}'}
		    </ui:source>
			<list:colTable isDefault="false" layout="sys.ui.listview.columntable" 
				rowHref="/km/oitems/km_oitems_listing/kmOitemsListing.do?method=view&fdId=!{fdId}"  name="columntable">
				<list:col-checkbox></list:col-checkbox>
				<list:col-serial></list:col-serial>
				<list:col-auto props="fdNo"></list:col-auto>
				<list:col-html  title="${ lfn:message('km-oitems:kmOitemsListing.fdName') }" style="text-align:left">
				 {$ <span class="com_subject" >{%row['fdName']%}</span> $}
				</list:col-html>
				<list:col-auto props="fdCategory.fdName;fdSpecification;fdBrand;fdUnit;fdReferencePrice;fdAmount"></list:col-auto>
			</list:colTable>
			<ui:event event="load">
				var tempHaveManagerData;
			 	if(this._data){
			 		var tempData = this._data.datas; 
			 		if(tempData){
			 			if(tempData[0]){
				 			$.each(tempData[0], function(i, item){      
							      if(item.col=="tempHaveManager"){
							      	tempHaveManagerData =item.value;
							      	return false;
							      }
							});   
			 			} 
			 		}
			 	} 
				if(tempHaveManagerData=="true"){
					 $("#delBtn").show();
					 $("#changeRightBatch").show();
					 
				} else {
					 $("#delBtn").hide();	
					 $("#changeRightBatch").hide();				 
				}
			</ui:event>
			
		</list:listview>
	 	<list:paging></list:paging>	 
	 	</ui:content>
	 </ui:tabpanel>	
	 	<script type="text/javascript">
	 	
	 	var SYS_SEARCH_MODEL_NAME ="com.landray.kmss.km.oitems.model.KmOitemsListing";
	 	
			seajs.use(['lui/jquery','lui/dialog','lui/topic'], function($, dialog , topic) {
				
				// 监听新建更新等成功后刷新
				topic.subscribe('successReloadPage', function() {
					topic.publish('list.refresh');
				});
				
				//新建
				window.addDoc = function() {
						dialog.simpleCategoryForNewFile(
								'com.landray.kmss.km.oitems.model.KmOitemsManage',
								'/km/oitems/km_oitems_listing/kmOitemsListing.do?method=add&categoryId=!{id}',false,null,null,'${JsParam.categoryId}');
						//Com_OpenWindow('<c:url value="/km/oitems/km_oitems_listing/kmOitemsListing.do" />?method=add');
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
					var url  = '<c:url value="/km/oitems/km_oitems_listing/kmOitemsListing.do?method=deleteall"/>';
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
