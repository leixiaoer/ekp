<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<% response.addHeader("X-UA-Compatible", "IE=edge"); %>	
<!-- <script type="text/javascript">
        document.write('<iframe src="/ad_footer.html?'+ (new Date()).getTime() +'" width="918" scrolling="no" frameborder="0" height="41"></iframe>');
</script> -->
<template:include ref="default.view" sidebar="no">
	<template:replace name="title">
		<c:out value="${kmAssetApplyTaskForm.docSubject} - ${ lfn:message('km-asset:module.km.asset')}"></c:out>
	</template:replace>
	<template:replace name="toolbar">
		<style type="text/css">
 		   .assignUserCtl,.purchaseTimeCtl {
			    display: none;
			}
		</style>
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="3">
			<c:if test="${kmAssetApplyTaskForm.docStatus=='10' || kmAssetApplyTaskForm.docStatus=='11'|| kmAssetApplyTaskForm.docStatus=='20'}">
				<kmss:auth requestURL="/km/asset/km_asset_apply_task/kmAssetApplyTask.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
					<ui:button text="${lfn:message('button.edit')}" 
								onclick="Com_OpenWindow('kmAssetApplyTask.do?method=edit&fdId=${param.fdId}','_self');" order="2">
					</ui:button>
				</kmss:auth>
			</c:if>
			<kmss:auth requestURL="/km/asset/km_asset_apply_task/kmAssetApplyTask.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
				<ui:button text="${lfn:message('button.delete')}" order="4"
							onclick="deleteDoc('kmAssetApplyTask.do?method=delete&fdId=${param.fdId}');">
				</ui:button> 
			</kmss:auth>
			<c:if test="${kmAssetApplyTaskForm.docStatus=='30'}">
				<ui:button text="${lfn:message('km-asset:kmAssetApplyTask.button.export')}" 
							onclick="Com_OpenWindow('kmAssetApplyTask.do?method=exportAssetTask&taskId=${param.fdId}','_self');" order="3">
				</ui:button>
			</c:if>
			<ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();">
			</ui:button>
		</ui:toolbar>
	</template:replace>
	<template:replace name="path">
		<ui:combin ref="menu.path.category">
			<ui:varParams  moduleTitle="${ lfn:message('km-asset:module.km.asset') }" 
			    modulePath="/km/asset/" 
				modelName="com.landray.kmss.km.asset.model.KmAssetApplyTemplate" 
			    autoFetch="false" 
			    href="/km/asset/#j_path=/kmAssetApplyTask_my/create" 
				categoryId="${kmAssetApplyTaskForm.fdApplyTemplateId}" />
		</ui:combin>
	</template:replace>
	<template:replace name="content">
		<script type="text/javascript">
			Com_IncludeFile("document.js", "style/"+Com_Parameter.Style+"/doc/");
			
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
				
				window.deleteDoc = function(delUrl){
					dialog.confirm('<bean:message key="page.comfirmDelete"/>',function(isOk){
						if(isOk){
							Com_OpenWindow(delUrl,'_self');
						}	
					});
				};
				
			});
		</script>
		<p class="txttitle">${txttitle}</p>
		<div class="lui_form_content_frame">
			<table class="tb_normal" width=100%>
				<tr>
					<!--标题-->
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.docSubject" /></td>
					<td colspan="3"><xform:text property="docSubject"
						style="width:85%" /></td>
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
						<bean:message bundle="km-asset" key="kmAssetApplyTask.fdAssetAddress"/>
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
							<xform:datetime property="fdStartDate" dateTimeType="date"/> 
							<span style="position: relative;top:-5px;">—</span>
							<xform:datetime property="fdEndDate" dateTimeType="date"/>
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
							<c:param name="taskStatus" value="${kmAssetApplyTaskForm.fdStatus }" />
							<c:param name="todoNumber" value="${kmAssetApplyTaskForm.todoNumber }" />
							<c:param name="hasdoNumber" value="${kmAssetApplyTaskForm.hasdoNumber }" />
							<c:param name="doNumber" value="${kmAssetApplyTaskForm.doNumber }" />
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
		<ui:tabpage expand="false" var-navwidth="90%">
		    <c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmAssetApplyTaskForm" />
				<c:param name="fdKey" value="KmAssetApplyTaskDoc" />
				<c:param name="showHistoryOpers" value="true" />
			</c:import>  
			<c:import url="/sys/right/import/right_view.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmAssetApplyTaskForm" />
				<c:param name="moduleModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyTask" />
			</c:import>
			<c:import url="/sys/readlog/import/sysReadLog_view.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmAssetApplyTaskForm" />
			</c:import>
		</ui:tabpage>
	</template:replace>
	<template:replace name="nav">
		<c:import url="/sys/relation/import/sysRelationMain_view.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmAssetApplyTaskForm" />
		</c:import>
	</template:replace>
</template:include>