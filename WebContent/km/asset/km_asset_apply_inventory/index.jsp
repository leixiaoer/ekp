<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include  ref="default.simple"  spa="true">
	<template:replace name="title">
		<c:out value="${ lfn:message('km-asset:module.km.asset') }"></c:out>
	</template:replace>
	<template:replace name="body">
			<script type="text/javascript">
			seajs.use(['theme!list']);	
		</script>
	<script type="text/javascript">
			function addDoc(){
				Com_OpenWindow("${LUI_ContextPath}/km/asset/km_asset_apply_inventory/kmAssetApplyInventory.do?method=add");
			}
			function delDoc(){
				var values = [];
				$("input[name='List_Selected']:checked").each(function(){
						values.push($(this).val());
					});
				if(values.length==0){
					seajs.use(['lui/dialog'],function(dialog){
						  dialog.alert('<bean:message key="page.noSelect"/>');
						});
					return;
				}
				seajs.use(['lui/jquery','lui/dialog','lui/topic'], function($, dialog , topic){
					dialog.confirm('<bean:message key="page.comfirmDelete"/>',function(value){
						if(value==true){
							var del_load = dialog.loading();
							$.post('${LUI_ContextPath}/km/asset/km_asset_apply_inventory/kmAssetApplyInventory.do?method=deleteall&categoryId=${param.categoryId}',$.param({"List_Selected":values},true),function(data){
								if(del_load!=null){
									del_load.hide();
									topic.publish("list.refresh");
								}
								dialog.result(data);
							},'json');
						}
					});
				});
			}
		</script>
		<!-- 查询条件  -->
		<list:criteria id="criteria1">
			<list:cri-ref key="docSubject" ref="criterion.sys.docSubject"/>
			<list:cri-criterion title="${ lfn:message('km-asset:kmAsset.inventory.my') }" key="mydoc" multi="false">
				<list:box-select>
					<list:item-select>
						<ui:source type="Static">
							[{text:'${ lfn:message('list.create') }', value:'create'},{text:'${ lfn:message('list.approval') }',value:'approval'}, {text:'${ lfn:message('list.approved') }', value: 'approved'}]
						</ui:source>
					</list:item-select>
				</list:box-select> 
				</list:cri-criterion>
					<list:tab-criterion title="" key="docStatus"> 
							<list:box-select>
								<list:item-select  type="lui/criteria/select_panel!TabCriterionSelectDatas"  cfg-if=" (param['mydoc']=='create'||param['mydoc']=='approved') && param['status']!='draft'">
									<ui:source type="Static">
										[
										{text:'${ lfn:message('status.draft')}',value:'10'},
										{text:'${ lfn:message('status.examine')}',value:'20'},
										{text:'${ lfn:message('status.refuse')}',value:'11'},
										{text:'${ lfn:message('status.publish')}',value:'30'}]
									</ui:source>
								</list:item-select>
							</list:box-select>
					</list:tab-criterion>
					<list:tab-criterion title="" key="docStatus"> 
				<list:box-select>
					<list:item-select cfg-enable="false" type="lui/criteria/select_panel!TabCriterionSelectDatas" cfg-if="param['mydoc']=='approval'">
						<ui:source type="Static">
							[
							{text:'${ lfn:message('status.examine')}',value:'20'},
							{text:'${ lfn:message('status.refuse')}',value:'11'}
							]
						</ui:source>
					</list:item-select>
				</list:box-select>
			</list:tab-criterion>
			<list:cri-auto modelName="com.landray.kmss.km.asset.model.KmAssetApplyInventory" 
				property="docCreateTime;fdNo;" />
		</list:criteria>
		 
		<!-- 列表工具栏 -->
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
								<list:sort property="fdId" text="${lfn:message('list.sort.fdId') }" group="sort.list" value="down"></list:sort>
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
						<ui:toolbar id="Btntoolbar">
							<ui:togglegroup order="0">
							    <ui:toggle icon="lui_icon_s_zaiyao" title="${ lfn:message('list.rowTable') }" 
									selected="true" group="tg_1" text="${ lfn:message('list.rowTable') }" value="rowtable" onclick="hideExport(this.value);LUI('listview').switchType(this.value);">
								</ui:toggle>
								<ui:toggle icon="lui_icon_s_liebiao" title="${ lfn:message('list.columnTable') }" 
									value="columntable"  group="tg_1" text="${ lfn:message('list.columnTable') }" onclick="hideExport(this.value);LUI('listview').switchType(this.value);">
								</ui:toggle>
							</ui:togglegroup>
							<kmss:auth requestURL="/km/asset/km_asset_apply_inventory/kmAssetApplyInventory.do?method=deleteall">					 								
							<ui:button text="${lfn:message('button.delete')}" onclick="delDoc()" order="4"></ui:button>
							</kmss:auth>
							<kmss:authShow roles="ROLE_KMASSET_TRANSPORT_EXPORT">
							<ui:button text="${lfn:message('button.export')}" id="export"
								onclick="listExport('${LUI_ContextPath}/sys/transport/sys_transport_export/SysTransportExport.do?method=listExport&fdModelName=com.landray.kmss.km.asset.model.KmAssetApplyBase')"
								order="2"></ui:button>
							</kmss:authShow>	
							<%-- 取消推荐 
							<c:import url="/sys/introduce/import/sysIntroduceMain_cancelbtn.jsp" charEncoding="UTF-8">
								<c:param name="fdModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyInventory" />
							</c:import>
							--%>
							<%-- 修改权限 
							<c:import url="/sys/right/import/doc_right_change_button.jsp" charEncoding="UTF-8">
								<c:param name="modelName" value="com.landray.kmss.km.asset.model.KmAssetApplyInventory" />
							</c:import>
							--%>				 
						</ui:toolbar>
					</div>
			</div>
		</div>
		<ui:fixed elem=".lui_list_operation"></ui:fixed>
		 
		 
	 	<list:listview id="listview">
			<ui:source type="AjaxJson">
					{url:'/km/asset/km_asset_apply_inventory/kmAssetApplyInventory.do?method=data&categoryId=${param.categoryId}'}
			</ui:source>
			<!-- 列表视图 -->	
			<list:colTable isDefault="false"
				rowHref="/km/asset/km_asset_apply_inventory/kmAssetApplyInventory.do?method=view&fdId=!{fdId}"  name="columntable">
				<list:col-checkbox></list:col-checkbox>
				<list:col-serial></list:col-serial>
				 
				<list:col-auto props="docSubject;fdDescription;docStatus;docCreateTime;fdNo;docCreator.fdName;fdTask.docSubject;fdApplyTemplate.fdName"></list:col-auto>
			</list:colTable>
			<!-- 摘要视图 -->	
			<list:rowTable isDefault="false"
				rowHref="/km/asset/km_asset_apply_inventory/kmAssetApplyInventory.do?method=view&fdId=!{fdId}" name="rowtable" >
				<list:row-template>
			   	{$
				 <div class="clearfloat lui_listview_rowtable_summary_content_box">
					<dl>
						<dt>
							<input type="checkbox" data-lui-mark="table.content.checkbox" value="{%row.fdId%}" name="List_Selected"/>
							<span class="lui_listview_rowtable_summary_content_serial">{%row.index%}</span>
						</dt>	
					</dl>
					<dl>
						<dt>
							<a class="textEllipsis com_subject" data-href="${LUI_ContextPath}/km/asset/km_asset_apply_inventory/kmAssetApplyInventory.do?method=view&fdId={%row.fdId%}" target="_blank" data-lui-mark-id="{%row.rowId%}" onclick="Com_OpenNewWindow(this)">{%row.docSubject%}</a>
						</dt>
						<dd class="lui_listview_rowtable_summary_content_box_foot_info">
							<span>${lfn:message('km-asset:kmAssetApplyInventory.docStatus')}：{%row['docStatus']%}</span>
							<span>${lfn:message('km-asset:kmAssetApplyInventory.docCreateTime') }：{%row['docCreateTime']%}</span>
							<span>${lfn:message('km-asset:kmAssetApplyInventory.fdNo') }：{%row['fdNo']%}</span>
							<span>${lfn:message('km-asset:kmAssetApplyInventory.docCreator') }：{%row['docCreator.fdName']%}</span>
							<span>${lfn:message('km-asset:kmAssetApplyInventory.fdTask') }：{%row['fdTask.docSubject']%}</span>
							<span>${lfn:message('km-asset:kmAssetApplyInventory.fdApplyTemplate') }：{%row['fdApplyTemplate.fdName']%}</span>
						</dd>
					</dl>
				</div>	
				$}
				</list:row-template>
			</list:rowTable>
		</list:listview> 
		 
	 	<list:paging></list:paging>	 
	</template:replace>
</template:include>
