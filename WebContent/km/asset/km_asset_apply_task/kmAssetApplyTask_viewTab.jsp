<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:replace name="content">
		<script type="text/javascript">
			//Com_IncludeFile("document.js", "style/"+Com_Parameter.Style+"/doc/");
		
			var assignUserValue = '${kmAssetApplyTaskForm.fdAssignUser}';
			var purchaseTimeValue = '${kmAssetApplyTaskForm.fdPurchaseTime}';
		
			seajs.use(['lui/jquery', 'lui/dialog','lui/topic'], function($, dialog , topic) {
				
				$(function(){
					if(assignUserValue == "2" || assignUserValue == "3"){
						 $("div .assignUserCtl").show();
					} 
					if(purchaseTimeValue == "2"){
						$("div .purchaseTimeCtl").show();
					}
				});
				
				topic.subscribe('ChildReloadSuccess', function() {
					window.location.reload();
				});
				
				
				window.deleteDoc = function(delUrl){
					dialog.confirm('<bean:message key="page.comfirmDelete"/>',function(isOk){
						if(isOk){
							Com_OpenWindow(delUrl,'_self');
						}	
					});
				}
				
				// 盘点完成
				window.complateTask = function(taskId){
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
					$.post(url,$.param({"taskId":taskId},true),function(resp){
						if(resp.success){
							window.location.reload();
						}else{
							dialog.alert('<bean:message key="return.optFailure"/>');
						}
					},'json');
				}
				
			});
		</script>
		<p class="txttitle">${txttitle}</p>
		<div class="lui_form_content_frame">
			<table class="tb_normal" width=100%>
				<tr>
					<!--标题-->
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.docSubject" />
					</td>
					<td colspan="3">
						<xform:text property="docSubject" style="width:85%" />
					</td>
				</tr>
				<tr>
					<!--所属模板 -->
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdApplyCategory" />
					</td>
					<td width="35%">
						<c:out value="${kmAssetApplyTaskForm.fdApplyTemplateName}" />
					</td>
					<!--申请单编号 -->
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdNo" />
					</td>
					<td width="35%">
						<c:out value="${kmAssetApplyTaskForm.fdNo}" />
					</td>
				</tr>
				<tr>
					<!--申请人-->
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdCreator" />
					</td>
					<td width="35%">
						<c:out value="${kmAssetApplyTaskForm.fdCreatorName}" />
					</td>
					<!--申请日期-->
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdCreateDate" />
					</td>
					<td width="35%">
						<xform:datetime property="fdCreateDate"/>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyTask.fdAssignUser"/>
					</td>
					<td width="35%">
						<xform:select property="fdAssignUser">
							<xform:enumsDataSource enumsType="km_asset_apply_task_fd_assign_user" />
						</xform:select>
					</td>
					<td class="td_normal_title" width=15%>
						<div class="assignUserCtl">
							<bean:message bundle="km-asset" key="kmAssetApplyTask.kmAssignPersonnel"/>
						</div>
					</td>
					<td width="35%">
						<div class="assignUserCtl">
							<xform:address propertyId="kmAssignPersonnelIds" propertyName="kmAssignPersonnelNames" mulSelect="true" orgType="ORG_TYPE_ALL"  style="width:53%" />
						</div>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyTask.fdAssetCategory"/>
					</td>
					<td width="35%">
						<xform:select property="fdAssetCategoryId">
							<xform:beanDataSource serviceBean="kmAssetCategoryService" selectBlock="fdId,fdName" orderBy="fdOrder" />
						</xform:select>
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetCard.fdAssetAddress"/>
					</td>
					<td>
						<xform:select property="fdAssetAddressId">
							<xform:beanDataSource serviceBean="kmAssetAddressService" selectBlock="fdId,fdAddress" orderBy="fdOrder" />
						</xform:select>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyTask.fdPurchaseTime"/>
					</td>
					<td width="35%">
						<xform:select property="fdPurchaseTime">
							<xform:enumsDataSource enumsType="km_asset_apply_task_fd_purchase_time" />
						</xform:select>
					<td class="td_normal_title" width=15%>
						<div id="purchaseTime" class="purchaseTimeCtl">
							<bean:message bundle="km-asset" key="kmAssetApplyTask.fdPurchaseTime.section"/>
						</div>	
					</td>
					<td width="35%">
						<div id="purchaseTime" class="purchaseTimeCtl">
							<xform:datetime property="fdStartDate" dateTimeType="date"/> - <xform:datetime property="fdEndDate" dateTimeType="date"/>
						</div>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" colspan="4" align="center">
						<bean:message bundle="km-asset" key="kmAssetApplyTask.inventroySituation"/>
					</td>
				</tr>
				<tr>
					<td width="100%" colspan="4">
						<c:import url="/km/asset/km_asset_apply_task/kmAssetApplyTask_inventorydetails.jsp" charEncoding="UTF-8">
							<c:param name="viewType" value="edit" />
							<c:param name="taskStatus" value="${kmAssetApplyTaskForm.fdStatus }" />
							<c:param name="todoNumber" value="${kmAssetApplyTaskForm.todoNumber }" />
							<c:param name="hasdoNumber" value="${kmAssetApplyTaskForm.hasdoNumber }" />
							<c:param name="doNumber" value="${kmAssetApplyTaskForm.doNumber }" />
							<c:param name="fdAssignUser" value="${kmAssetApplyTaskForm.fdAssignUser }" />
							<c:param name="personnelIds" value="${kmAssetApplyTaskForm.kmAssignPersonnelIds }" />
							<c:param name="taskCreator" value="${kmAssetApplyTaskForm.docCreatorId }" />
						</c:import>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title">
						${ lfn:message('sys-doc:sysDocBaseInfo.docAttachments') }
					</td>
					<td colspan="3">
						<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
							<c:param name="formBeanName" value="kmAssetApplyTaskForm" />
							<c:param name="fdKey" value="attachment" />
						</c:import>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyTask.fdDescription"/>
					</td>
					<td width="35%" colspan="3">
						<xform:textarea property="fdDescription" style="width:85%" />
					</td>
				</tr>
			</table> 
		</div>
	<c:choose>
		<c:when test="${param.approveModel eq 'right'}">
			<ui:tabpanel suckTop="true" layout="sys.ui.tabpanel.sucktop" var-supportExpand="true" var-extend="true" var-average='false' var-useMaxWidth='true'>
				<c:choose>
					<c:when test="${kmAssetApplyTaskForm.docStatus>='30' || kmAssetApplyTaskForm.docStatus=='00'}">
						<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmAssetApplyTaskForm" />
							<c:param name="fdKey" value="KmAssetApplyTaskDoc" />
							<c:param name="showHistoryOpers" value="true" />
							<c:param name="isExpand" value="true" />
							<c:param name="approveType" value="right" />
							<c:param name="needInitLbpm" value="true" />
						</c:import>
					</c:when>
					<c:otherwise>
						<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmAssetApplyTaskForm" />
							<c:param name="fdKey" value="KmAssetApplyTaskDoc" />
							<c:param name="showHistoryOpers" value="true" />
							<c:param name="isExpand" value="true" />
							<c:param name="approveType" value="right" />
						</c:import>
					</c:otherwise>
				</c:choose>
				<c:import url="/sys/right/import/right_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyTaskForm" />
					<c:param name="moduleModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyTask" />
				</c:import>
					<%--阅读机制--%>
				<c:import url="/sys/readlog/import/sysReadLog_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyTaskForm" />
				</c:import>
			</ui:tabpanel>
		</c:when>
		<c:otherwise>
			<ui:tabpage expand="false" var-navwidth="90%">
			   <c:import url="/sys/workflow/import/sysWfProcess_view.jsp"
					charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyTaskForm" />
					<c:param name="fdKey" value="KmAssetApplyTaskDoc" />
					<c:param name="showHistoryOpers" value="true" />
				</c:import>
				<c:import url="/sys/right/import/right_view.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmAssetApplyTaskForm" />
						<c:param name="moduleModelName"
							value="com.landray.kmss.km.asset.model.KmAssetApplyTask" />
				</c:import>
				<c:import url="/sys/readlog/import/sysReadLog_view.jsp"
					charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyTaskForm" />
				</c:import>
			</ui:tabpage>
		</c:otherwise>
	</c:choose>
	</template:replace>
<c:choose>
	<c:when test="${param.approveModel eq 'right'}">
		<template:replace name="barRight">
			<c:choose>
				<c:when test="${kmAssetApplyTaskForm.docStatus>='30' || kmAssetApplyTaskForm.docStatus=='00'}">
					<ui:accordionpanel>
						<!-- 基本信息-->
						<c:import url="/km/asset/km_asset_apply_task/kmAssetApplyTask_viewBaseInfoContent.jsp" charEncoding="UTF-8">
						</c:import>
						<!-- 关联配置 -->
						<c:import url="/sys/relation/import/sysRelationMain_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmAssetApplyTaskForm" />
							<c:param name="approveType" value="right" />
						</c:import>
					</ui:accordionpanel>
				</c:when>
				<c:otherwise>
					<ui:tabpanel layout="sys.ui.tabpanel.vertical.icon" id="barRightPanel" >
						<%-- 流程 --%>
						<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmAssetApplyTaskForm" />
							<c:param name="fdKey" value="KmAssetApplyTaskDoc" />
							<c:param name="showHistoryOpers" value="true" />
							<c:param name="isExpand" value="true" />
							<c:param name="approveType" value="right" />
							<c:param name="approvePosition" value="right" />
						</c:import>
						<!-- 审批记录 -->
						<c:import url="/sys/lbpmservice/support/lbpm_audit_note/lbpmAuditNote_list_content.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmAssetApplyTaskForm" />
							<c:param name="fdModelId" value="${kmAssetApplyTaskForm.fdId}" />
							<c:param name="fdModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyTask" />
						</c:import>
						<!-- 基本信息-->
						<c:import url="/km/asset/km_asset_apply_task/kmAssetApplyTask_viewBaseInfoContent.jsp" charEncoding="UTF-8">
						</c:import>
						<!-- 关联配置 -->
						<c:import url="/sys/relation/import/sysRelationMain_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmAssetApplyTaskForm" />
							<c:param name="approveType" value="right" />
							<c:param name="needTitle" value="true" />
						</c:import>
					</ui:tabpanel>
				</c:otherwise>
			</c:choose>
		</template:replace>
	</c:when>
	<c:otherwise>
		<template:replace name="nav">
			<c:import url="/sys/relation/import/sysRelationMain_view.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmAssetApplyTaskForm" />
			</c:import>
		</template:replace>
	</c:otherwise>
</c:choose>