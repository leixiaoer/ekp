<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include file="/sys/profile/resource/template/list.jsp">
	<template:replace name="content">  
		<list:criteria id="listingCriteria" multi="false">
		    <list:cri-ref key="keywords" ref="criterion.sys.docSubject" title="${ lfn:message('km-oitems:kmOitemsListing.fdName.placehoder')}" style="width:160px">
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
			<div style='color: #979797;float: left;padding-top:1px;'>
				${ lfn:message('list.orderType') }：
			</div>
			<div style="float:left">
				<div style="display: inline-block;vertical-align: middle;">
					<ui:toolbar layout="sys.ui.toolbar.sort" style="float:left" count="4" >
						<list:sortgroup>
							<list:sort property="fdNo" text="${ lfn:message('km-oitems:kmOitemsListing.fdNo') }" group="sort.list" value="up"></list:sort>
							<list:sort property="fdName" text="${ lfn:message('km-oitems:kmOitemsListing.fdName') }" group="sort.list"></list:sort>
							<list:sort property="fdReferencePrice" text="${ lfn:message('km-oitems:kmOitemsListing.fdReferencePrice') }" group="sort.list"></list:sort>
							<list:sort property="fdAmount" text="${ lfn:message('km-oitems:kmOitemsListing.fdAmount') }" group="sort.list"></list:sort>
						</list:sortgroup>
					</ui:toolbar>
				</div>
			</div>
			<div style="float:left;">	
				<list:paging layout="sys.ui.paging.top" > 		
				</list:paging>
			</div>
			<div style="float:right">
				<div style="display: inline-block;vertical-align: middle;">
					<ui:toolbar count="3">
							<kmss:auth requestURL="/km/oitems/km_oitems_listing/kmOitemsListing.do?method=add" requestMethod="GET">
								<ui:button title="${lfn:message('km-oitems:kmOitemsListing.opt.create1')}" text="${lfn:message('button.add')}" onclick="addDoc()" order="2"></ui:button>	
							</kmss:auth> 
							<kmss:auth requestURL="/km/oitems/km_oitems_listing/kmOitemsListing.do?method=deleteall" requestMethod="GET">
							    <ui:button text="${lfn:message('button.deleteall')}" onclick="delDoc()" order="4"></ui:button>
						   </kmss:auth>
						   <%-- 修改权限 --%>
							<c:import url="/sys/right/import/doc_right_change_button.jsp" charEncoding="UTF-8">
								<c:param name="modelName" value="com.landray.kmss.km.oitems.model.KmOitemsListing"/>
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
		</list:listview>
	 	<list:paging></list:paging>	 
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
