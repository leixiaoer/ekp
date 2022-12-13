<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple">
	<template:replace name="body">
		<div style="padding: 8px 8px 30px;">
			<list:criteria id="setCriteria">
			   <list:tab-criterion title="" key="docStatus">
				   	<list:box-select>
				   		 	<list:item-select type="lui/criteria/select_panel!TabCriterionSelectDatas">
								<ui:source type="Static">
									[
							          {text:'${ lfn:message('km-pindagate:kmPindagate.tree.status.publish') }', value:'30'},
							          {text:'${ lfn:message('km-pindagate:kmPindagate.tree.status.indagating') }', value:'31'},
							          {text:'${ lfn:message('km-pindagate:kmPindagate.tree.status.complete') }', value:'32'}]
							   </ui:source>
						</list:item-select>
				    </list:box-select>
				 </list:tab-criterion>
				<list:cri-ref key="docSubject" ref="criterion.sys.docSubject" title="${ lfn:message('km-pindagate:kmPindagateMain.docSubject') }">
				</list:cri-ref>
				<list:cri-ref ref="criterion.sys.category" key="categoryId" multi="false" expand="false" title="${ lfn:message('sys-category:menu.sysCategory.index') }">
				  <list:varParams modelName="com.landray.kmss.km.pindagate.model.KmPindagateTemplate"/>
				</list:cri-ref>
				<list:cri-auto modelName="com.landray.kmss.km.pindagate.model.KmPindagateMain"
							   property="docCreator"/>
			</list:criteria>
			<div class="lui_list_operation">
				<div style='color: #979797;float: left;padding-top:1px;'>
					${ lfn:message('list.orderType') }：
				</div>
				<div style="float:left">
					<div style="display: inline-block;vertical-align: middle;">
						<ui:toolbar layout="sys.ui.toolbar.sort" style="float:left">
							<list:sortgroup>
							    <list:sort property="docCreateTime" text="${lfn:message('km-pindagate:kmPindagateMain.docCreateTime') }" group="sort.list" value="down"></list:sort>
							    <list:sort property="docFinishedTime" text="${lfn:message('km-pindagate:kmPindagateMain.docFinishedTime') }" group="sort.list"></list:sort>
							</list:sortgroup>
						</ui:toolbar>
					</div>
				</div>
				<div class="lui_list_operation_page_top">	
					<list:paging layout="sys.ui.paging.top" > 		
					</list:paging>
				</div>
			</div>
			<ui:fixed elem=".lui_list_operation"></ui:fixed>
			 <%--list页面--%>
			<list:listview id="listview">
				<ui:source type="AjaxJson">
					{url:'/km/pindagate/km_pindagate_main/kmPindagateData.do?method=listChildren&categoryId=${JsParam.categoryId}&forward=relaBridgeData&treeNode=set'}
				</ui:source>
				<%--列表视图--%>
				<list:colTable 
					isDefault="false" layout="sys.ui.listview.columntable"  
					onRowClick="select('!{fdId}')"
					name="columntable">
					<list:col-radio/>
					<list:col-serial/>
					<list:col-auto props="docSubject;docStatus;kmPindagateTemplate.fdName;docFinishedTime"/>
				</list:colTable>
			</list:listview>
			<list:paging></list:paging>	 
			<div data-lui-mark="dialog.content.buttons" 
				 style="position: fixed;bottom: 0px;width: 100%;background-color: #fff;padding: 8px 0;" class="lui_dialog_common_buttons clearfloat">
				<ui:button style="float: right;margin-right: 20px;"  
					onclick="onSubmit();" text="${lfn:message('button.ok') }" />
			</div>
	 	</div>
	 	
	 	<script>
	 			seajs.use(["lui/jquery", "lui/dialog"], function($, dialog) {
	 				
	 				window.onSubmit =  function() {
	 					var value = $("input[name='List_Selected']:checked").val();
	 					if(value) {
	 						$dialog.hide(value);
	 					} else {
	 						dialog.alert("${lfn:message('dialog.requiredSelect')}")
	 					} 
	 				}
	 				
	 				window.select = function(v) {
	 					
	 					var obj = $("input[value='" + v + "']:radio");
	 					
	 					if (obj.is(":checked")) {
	 						obj.prop("checked", false);
	 	                } else {
	 	                	obj.prop("checked", true);
	 	                }
	 				}
	 			});
	 	</script>
	</template:replace>
</template:include>
