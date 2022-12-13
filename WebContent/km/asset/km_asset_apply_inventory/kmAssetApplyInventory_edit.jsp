<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.edit">
	<template:replace name="title">
		<c:choose>
			<c:when test="${kmAssetApplyInventoryForm.method_GET == 'add' }">
				<c:out value="${lfn:message('km-asset:table.kmAssetApplyInventory.create') } - ${ lfn:message('km-asset:module.km.asset') }"></c:out>
			</c:when>
			<c:otherwise>
					<c:out value="${kmAssetApplyInventoryForm.docSubject} - "/>
					<c:out value="${ lfn:message('km-asset:module.km.asset') }"></c:out>
			</c:otherwise>
		</c:choose>
	</template:replace>
	<template:replace name="toolbar">
		<script language="javascript">
			// 提交表单
			function commitMethod(method, saveDraft){
				var docStatus = document.getElementsByName("docStatus")[0];
				if (saveDraft != null && saveDraft == 'true'){
					docStatus.value = "10";
				} else {
					docStatus.value = "20";
				}
			   Com_Submit(document.kmAssetApplyInventoryForm, method);
			}
			
			function viewTask(fdTaskId){
				window.open('<c:url value="/km/asset/km_asset_apply_task/kmAssetApplyTask.do" />?method=view&fdId='+fdTaskId,"_blank");
			}
		</script>
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="3"> 
			<c:choose>
				<c:when test="${ kmAssetApplyInventoryForm.method_GET == 'edit' }">
					<%-- 提交 --%>
					<c:if test="${kmAssetApplyInventoryForm.docStatus=='10'}">
						<ui:button text="${ lfn:message('button.savedraft') }" order="2"
							onclick="commitMethod('update', 'true');">
						</ui:button>
					</c:if>
					<c:if test="${kmAssetApplyInventoryForm.docStatus<'20'}">
						<ui:button text="${ lfn:message('button.submit') }" order="2"
							onclick="commitMethod('update', 'false');">
						</ui:button>
					</c:if>
					<c:if test="${kmAssetApplyInventoryForm.docStatus=='20'}">
						<ui:button text="${ lfn:message('button.submit') }" order="2"
							onclick="commitMethod('update', 'false');">
						</ui:button>
					</c:if>
					<c:if test="${kmAssetApplyInventoryForm.docStatus>='30'}">
						<ui:button text="${ lfn:message('button.submit') }" order="2"
							onclick="commitMethod('update', 'false');">
						</ui:button>
					</c:if>
				</c:when>
				<c:when test="${ kmAssetApplyInventoryForm.method_GET == 'add' }">
					<%-- 暂存 --%>
					<ui:button text="${ lfn:message('button.savedraft') }" order="2"
						onclick="commitMethod ('save', 'true');">
					</ui:button>
					<%-- 提交 --%>
					<ui:button text="${ lfn:message('button.update') }" order="2"
						onclick="commitMethod ('save');">
					</ui:button>
				</c:when>
			</c:choose>
			<ui:button text="${ lfn:message('button.close') }" onclick="Com_CloseWindow();"></ui:button>	
		</ui:toolbar>
	</template:replace>
	<template:replace name="path">			
		<ui:menu layout="sys.ui.menu.nav"> 
			<ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home">
			</ui:menu-item>	
			<ui:menu-item text="${ lfn:message('km-asset:module.km.asset') }">
			</ui:menu-item>
		</ui:menu>
	</template:replace>	
	<template:replace name="content">
		<html:form action="/km/asset/km_asset_apply_inventory/kmAssetApplyInventory.do">
			<p class="txttitle">${txttitle}</p>
			<div class="lui_form_content_frame" style="padding-top:20px">
				<table class="tb_normal" width=100%>
					<tr>
						<!--标题-->
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-asset" key="kmAssetApplyBase.docSubject" />
						</td>
						<td colspan="5">
							<c:if test="${kmAssetApplyInventoryForm.titleRegulation==null || kmAssetApplyInventoryForm.titleRegulation=='' }">
								<xform:text property="docSubject" style="width:97%" required="true"/>
							</c:if>
							<c:if test="${kmAssetApplyInventoryForm.titleRegulation!=null && kmAssetApplyInventoryForm.titleRegulation!='' }">
								<xform:text property="docSubject" style="width:97%" showStatus="readOnly" value="${lfn:message('km-asset:kmAssetApplyBase.docSubject.info') }" />
							</c:if>
							<input type="hidden" name="fdTemplateId" value=""/>
							<input type="hidden" name="fdTemplateName" value=""/>
						</td>
					</tr>
					<tr>
						<!--类别 -->
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-asset" key="kmAssetApplyBase.fdApplyCategory" />
						</td>
						<td width="19%">
							<html:hidden property="fdApplyTemplateId" value="${kmAssetApplyInventoryForm.fdApplyTemplateId}"/>
							<html:hidden property="fdApplyTemplateName" />
							<c:out value="${kmAssetApplyInventoryForm.fdApplyTemplateName}"/>
						</td>
						<!--申请单编号 -->
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-asset" key="kmAssetApplyBase.fdNo" />
						</td>						
					    <td colspan="3">
					    <c:choose>
							<c:when test='${kmAssetApplyInventory.fdNo!=null}'>
							    <xform:text property="fdNo" style="width:85%" showStatus="view"/>
							</c:when>
							<c:otherwise>
								<bean:message bundle="km-asset" key="kmAssetApplyBase.autoCreate" />
						    </c:otherwise>
						</c:choose> 
						</td>
					</tr>
					<tr>
						<!--申请人-->
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-asset" key="kmAssetApplyBase.fdCreator" /></td>
						<td width="19%">
							<xform:address propertyId="fdCreatorId" propertyName="fdCreatorName" orgType="ORG_TYPE_PERSON" style="width:85%" showStatus="view" />
						</td>
						<!--申请部门-->
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-asset" key="kmAssetApplyBase.fdDept" />
						</td>
						<td width="19%">
							<xform:address propertyId="fdDeptId" propertyName="fdDeptName" orgType="ORG_TYPE_DEPT" style="width:85%" showStatus="view" />
						</td>
						<!--申请日期-->
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-asset" key="kmAssetApplyBase.fdCreateDate" />
						</td>
						<td width="19%">
							<xform:datetime property="fdCreateDate" dateTimeType="date" style="width:85%" showStatus="view" />
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width="15%">
							<bean:message bundle="km-asset" key="kmAssetApplyInventory.fdTask"/>
						</td>
						<td colspan="5">
							<a style="color: #30abe4;" href="javascript:void(0);" onclick="viewTask('${kmAssetApplyInventoryForm.fdTaskId}')"><c:out value="${kmAssetApplyInventoryForm.fdTaskName}"/></a>
						</td>
					</tr>
					<tr>
						<td width="100%" colspan="6">
							<%@ include file="/km/asset/km_asset_apply_inventory/kmAssetApplyInventory_detail.jsp"%>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title">${ lfn:message('sys-doc:sysDocBaseInfo.docAttachments') }</td>
						<td colspan="5">
							<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
								<c:param name="formBeanName" value="kmAssetApplyInventoryForm" />
								<c:param name="fdKey" value="attachment" />
							</c:import>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title">
							<bean:message bundle="km-asset" key="kmAssetApplyInventory.fdDescription"/>
						</td>
						<td colspan="5">
							<xform:textarea property="fdDescription" style="width:95%" />
						</td>
					</tr>
				</table>
			</div>
			<ui:tabpage expand="false">
				<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyInventoryForm" />
					<c:param name="fdKey" value="KmAssetApplyInventoryDoc" />
					<c:param name="showHistoryOpers" value="true" />
				</c:import>
				<!--权限机制 -->
				<c:import url="/sys/right/import/right_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyInventoryForm" />
					<c:param name="moduleModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyInventory" />
				</c:import>
			</ui:tabpage>
			<html:hidden property="fdId" />
			<html:hidden property="method_GET" />
			<html:hidden property="fdCreatorId" />
			<html:hidden property="fdDeptId" />
			<html:hidden property="docStatus" />
			<html:hidden property="docCreatorId" />
			<html:hidden property="docCreateTime" />
			<html:hidden property="fdTaskId" />
			<html:hidden property="fdTaskDetailRef" />
			<html:hidden property="fdAssetCardId" />
			<html:hidden property="titleRegulation" />
		</html:form>
		<script>
			$KMSSValidation(document.forms['kmAssetApplyInventoryForm']);
		</script>
		
		<%@ include file="/km/asset/km_asset_apply_base/kmAssetApplyBase_common.jsp"%>
	</template:replace>
	<template:replace name="nav">
		<%--关联机制(与原有机制有差异)--%>
		<c:import url="/sys/relation/import/sysRelationMain_edit.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmAssetApplyInventoryForm" />
		</c:import>
	</template:replace>
</template:include>