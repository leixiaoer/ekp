<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include  ref="default.simple">
	<template:replace name="body">
	<script type="text/javascript">
			seajs.use(['theme!list']);	
		</script>
	<div style="width:100%;">
		  <ui:tabpanel layout="sys.ui.tabpanel.list">
		 <ui:content title="${lfn:message('km-asset:kmAsset.task') }">
		 		<script type="text/javascript">
			seajs.use(['theme!list']);	
		</script>
		<script type="text/javascript"> 
			seajs.use(['lui/jquery', 'lui/util/str', 'lui/dialog','lui/topic','lui/toolbar'], function($, strutil, dialog , topic,toolbar) {
				
				// 监听新建更新等成功后刷新
				topic.subscribe('successReloadPage', function() {
					topic.publish('list.refresh');
				});
				
				//新建
			 	window.addDoc = function(){
			 		var tempId = "";
			 			dialog.category('com.landray.kmss.km.asset.model.KmAssetApplyTemplate','fdTemplateId','fdTemplateName',false,function(rtn){
				 			if(rtn != false&&rtn != null){
				 				tempId = document.getElementsByName("fdTemplateId")[0].value;
				 				addByApplyTemplate(tempId);
				 			}
				 	   },null,null,null,null,null,"KmAssetApplyTaskDoc");
			 	};
			 	
			 	window.addByApplyTemplate = function(tempId){
			 		 if(tempId!=null&&tempId!=''){
			 	        	var data = new KMSSData();
			 	    		var url = Com_Parameter.ContextPath+"km/asset/km_asset_apply_base/kmAssetApplyBase.do?method=loadAssetApplyTemplate&tempId="+tempId;
			 	    		var results;
			 	    		data.SendToUrl(url,function(data) {
			 	    			results=data.responseText;
			 	        		
			 	    		},false);
			 	    		document.getElementsByName("fdTemplateId")[0].value = "";
			 	    		document.getElementsByName("fdTemplateName")[0].value = "";
			 	    	 window.open(Com_Parameter.ContextPath+results,'_blank');
			 	      }
				 };
				 
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
							var del_load = dialog.loading();
							$.ajax({
								url: '${LUI_ContextPath}/km/asset/km_asset_apply_task/kmAssetApplyTask.do?method=deleteall&categoryId=${param.categoryId}',
								type: 'POST',
								data:$.param({"List_Selected":values},true),
								dataType: 'json',
								error: function(data){
									if(del_load!=null){
										del_load.hide();
									}
									dialog.result(data.responseJSON);
								},
								success: function(data){
									if(del_load!=null){
										del_load.hide();
										topic.publish("list.refresh");
									}
									dialog.result(data);
								}
							});
						}
					});
				 }
				 
				 window.waitingDialog = function(){
					 dialog.alert("${ lfn:message('km-asset:kmAssetApplyTask.waitingTip') }");
					 return;
				 }
				 
				// 盘点完成
				window.complateInventory = function(taskId){
					$.ajax({
						type:'post',
						async:false,
						url:Com_Parameter.ContextPath+'km/asset/km_asset_apply_task_detail/kmAssetApplyTaskDetail.do?method=countTaskItem',
						data:{'taskId':taskId,'fdStatus':'1'},
						dataType: 'json',
						success:function(result){
							if(result.success){
								if(result.data > 0){
									var msgTemplate = "${ lfn:message('km-asset:kmAssetApplyTask.inventoryCompleteComfirm') }";
									var msg = msgTemplate.replace("{}",result.data);
									dialog.confirm(msg,function(isOk){
										if(isOk){
											doComplateTask(taskId);
										}
									});
								}else{
									doComplateTask(taskId);
								}
							}else{
								dialog.alert('<bean:message key="return.optFailure"/>');
							}
						},
						error:function(){
						}
					});
				}
				
				window.doComplateTask = function(taskId){
					var url = '<c:url value="/km/asset/km_asset_apply_task/kmAssetApplyTask.do?method=completeTask"/>';
					var del_load = dialog.loading();
					$.post(url,$.param({"taskId":taskId},true),function(resp){
						if(del_load!=null){
							del_load.hide();
						}
						if(resp.success){
							topic.publish("list.refresh");
						}else{
							dialog.alert('<bean:message key="return.optFailure"/>');
						}
					},'json');
				}
				 
			});
			
			window.startInventory = function(callbackUrl,fdId){
				seajs.use( [ 'lui/dialog','lui/topic',"lui/util/env"], function(dialog,topic,env) {
					var url = '/km/asset/km_asset_apply_task/kmAssetApplyTask.do?method=toNotify&fdId='+fdId;
					var inventoryUrl = '/km/asset/km_asset_apply_task/kmAssetApplyTask.do?method=inventory&fdId='+fdId;
					dialog.iframe(url,"${lfn:message('km-asset:kmAssetApplyTask.startNotify')}", function(value) {
						var formValue = value;
						if (typeof(formValue) == "undefined" || formValue == null){
							return;
						}else{
							window.loading = dialog.loading();
							$.ajax({
								type:'post',
								async:false,
								url:Com_Parameter.ContextPath+'km/asset/km_asset_apply_task/kmAssetApplyTask.do',
								data:formValue,
								dataType: 'json',
								success:function(result){
									if(result.success){
										if(window.loading != null){
											window.loading.hide();
										}
										topic.publish('list.refresh');
										Com_OpenWindow(env.fn.formatUrl(inventoryUrl), '_blank');
									}
								},
								error:function(){
								}
							});
						}
					}, {
						"width" : 400,
						"height" : 180
					});
				});
			};
		</script>
		<!-- 查询条件  -->
		<list:criteria id="inventorycriteria">
			<list:cri-ref key="docSubject" ref="criterion.sys.docSubject"/>
			<list:cri-criterion title="${ lfn:message('km-asset:kmAssetApply.my') }" key="mydoc" multi="false">
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
					<list:item-select type="lui/criteria/select_panel!TabCriterionSelectDatas"  cfg-if=" (param['mydoc']=='create'||param['mydoc']=='approved') && param['status']!='draft'">
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
			<list:cri-auto modelName="com.landray.kmss.km.asset.model.KmAssetApplyTask" 
				property="fdDescription;docCreateTime;fdAssignUser;fdPurchaseTime;fdStatus" />
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
							<%-- <kmss:authShow roles="ROLE_KMASSETAPPLY_CREATE">	
								<ui:button text="${lfn:message('button.add')}" onclick="addDoc()" order="2"></ui:button>
							</kmss:authShow> --%>
							<kmss:authShow roles="ROLE_KMASSET_TRANSPORT_EXPORT">
							<ui:button text="${lfn:message('button.export')}" id="export" onclick="listExport('${LUI_ContextPath}/sys/transport/sys_transport_export/SysTransportExport.do?method=listExport&fdModelName=com.landray.kmss.km.asset.model.KmAssetApplyBase')" order="2" ></ui:button>
							</kmss:authShow>
							<kmss:auth requestURL="/km/asset/km_asset_apply_task/kmAssetApplyTask.do?method=deleteall">					 								
								<ui:button text="${lfn:message('button.deleteall')}" onclick="delDoc()" order="4"></ui:button>
							</kmss:auth>
							<input type="hidden" name="fdTemplateId" value=""/>
							<input type="hidden" name="fdTemplateName" value=""/>
							<%-- 取消推荐 
							<c:import url="/sys/introduce/import/sysIntroduceMain_cancelbtn.jsp" charEncoding="UTF-8">
								<c:param name="fdModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyTask" />
							</c:import>
							--%>
							<%-- 修改权限 
							<c:import url="/sys/right/import/doc_right_change_button.jsp" charEncoding="UTF-8">
								<c:param name="modelName" value="com.landray.kmss.km.asset.model.KmAssetApplyTask" />
							</c:import>
							--%>
						</ui:toolbar> 					
				</div>
			</div>
		</div>
		
		<ui:fixed elem=".lui_list_operation"></ui:fixed>
		
	 	<list:listview id="listview">
			<ui:source type="AjaxJson">
					{url:'/km/asset/km_asset_apply_task/kmAssetApplyTask.do?method=data&q.j_path=/kmAsset_task&q.except=docStatus:00'}
			</ui:source>
			<!-- 列表视图 -->	
			<list:colTable isDefault="false"
				rowHref="/km/asset/km_asset_apply_task/kmAssetApplyTask.do?method=view&fdId=!{fdId}"  name="columntable">
				<list:col-checkbox></list:col-checkbox>
				<list:col-serial></list:col-serial>
				<list:col-auto props=""></list:col-auto>
			</list:colTable>
			<!-- 摘要视图 -->	
			<list:rowTable isDefault="false" rowHref="/km/asset/km_asset_apply_task/kmAssetApplyTask.do?method=view&fdId=!{fdId}" name="rowtable" >
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
							<a class="textEllipsis com_subject" data-href="${LUI_ContextPath}/km/asset/km_asset_apply_task/kmAssetApplyTask.do?method=view&fdId={%row.fdId%}" target="_blank" data-lui-mark-id="{%row.rowId%}" onclick="Com_OpenNewWindow(this)">{%row.docSubject%}</a>
						</dt>
						<dd class="lui_listview_rowtable_summary_content_box_foot_info">
							<span>${lfn:message('km-asset:kmAssetApplyTask.docCreator')}：{%row['docCreator.fdName']%}</span>
							<span>${lfn:message('km-asset:kmAssetApplyTask.fdDept') }：{%row['fdDept.fdName']%}</span>
							<span>${lfn:message('km-asset:kmAssetApplyTask.docCreateTime') }：{%row['docCreateTime']%}</span>
							<span>${lfn:message('km-asset:kmAssetApplyTask.fdStatus') }：{%row['fdStatus']%}</span>
							<span>${lfn:message('km-asset:kmAssetApplyTask.docStatus') }：{%row['docStatus']%}</span>
							<span>${lfn:message('list.operation') }：{%row['oper']%}</span>
						</dd>
					</dl>
				</div>	
				$}	
				</list:row-template>
			</list:rowTable>
		</list:listview> 
		 
	 	<list:paging></list:paging>	 
		 	 <%--  <ui:iframe id="task" src="${LUI_ContextPath }/km/asset/km_asset_apply_task/kmAssetApplyTask_new.jsp?except=docStatus:10_00&path=/kmAsset_task"></ui:iframe> --%>
		  </ui:content>
		  <kmss:authShow roles="ROLE_KMASSETAPPLY_CREATE">	
		   <ui:content title="${lfn:message('km-asset:kmAsset.task.create') }">
		    <%@ include file="/km/asset/km_asset_apply_task/kmAssetApplyTask_new.jsp"%>
		  <%--  <c:import charEncoding="UTF-8" url="/km/asset/import/kmAssetApplyBase_create.jsp?mainModelName=com.landray.kmss.km.asset.model.KmAssetApplyTask&modelName=com.landray.kmss.km.asset.model.KmAssetApplyTemplate&isSimpleCategory=false&fdTempKey=KmAssetApplyTaskDoc&title=kmAssetApplyTemplate.enum.fdType11"></c:import> --%>
		  </ui:content>
		  </kmss:authShow>
		</ui:tabpanel>
	  </div> 
	</template:replace>
</template:include>