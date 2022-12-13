<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:replace name="content">
	<script>
	function confirmDelete(msg){
		var del = confirm("<bean:message key="page.comfirmDelete"/>");
		return del;
	}
	</script>
<p class="txttitle">${txttitle}</p>
	<div class="lui_form_content_frame">
	<table class="tb_normal" width=100%>
		<tr>
			<!--标题-->
			<td class="td_normal_title" width=15%><bean:message
				bundle="km-asset" key="kmAssetApplyBase.docSubject" /></td>
			<td colspan="5"><xform:text property="docSubject"
				style="width:85%" /></td>
		</tr>
		<tr>
			<!--所属模板 -->
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.fdApplyCategory" /></td>
					<td width="19%">
					  <c:out value="${kmAssetApplyChangeForm.fdApplyTemplateName}"/></td>
			<!--申请单编号 -->
			<td class="td_normal_title" width=15%><bean:message
				bundle="km-asset" key="kmAssetApplyBase.fdNo" /></td>
			<td colspan="3"><xform:text property="fdNo" style="width:85%" />
			</td>
		</tr>

		<tr>
			<!--申请人-->
			<td class="td_normal_title" width=15%><bean:message
				bundle="km-asset" key="kmAssetApplyBase.fdCreator" /></td>
			<td width="19%"><c:out
			value="${kmAssetApplyChangeForm.fdCreatorName}" /></td>
			<!--申请部门-->
			<td class="td_normal_title" width=15%><bean:message
				bundle="km-asset" key="kmAssetApplyBase.fdDept" /></td>
			<td width="19%">
			             <c:out value="${kmAssetApplyChangeForm.fdDeptName}" />
			</td>
			<!--申请日期-->
			<td class="td_normal_title" width=15%><bean:message
				bundle="km-asset" key="kmAssetApplyBase.fdCreateDate" /></td>
			<td width="19%"><xform:datetime property="fdCreateDate"  style="width:85%" dateTimeType="datetime"/></td>
		</tr>

                 	<!-- 变更单明细 -->
		<tr>
			<td class="td_normal_title" width="100%" colspan="6" align="center"><bean:message
					bundle="km-asset" key="table.kmAssetApplyChangeList" /></td>
		</tr>
          <tr>
			<td width="100%" colspan="6">
				<c:import
					url="/km/asset/km_asset_apply_change_list/kmAssetApplyChangeList_view.jsp"
					charEncoding="UTF-8">
				</c:import>
				<c:if test="${fn:length(myCards) > 0}">
					<c:import url="/km/asset/km_asset_card/kmAssetCard_mycard_import.jsp" charEncoding="UTF-8">
						<c:param name="fdResponsiblePerson" value="${kmAssetApplyChangeForm.fdCreatorId}"></c:param>
					</c:import>
				</c:if>
			</td>
		</tr>  
      
		<tr>
			<!--事由-->
			<td class="td_normal_title" width=15%><bean:message
				bundle="km-asset" key="kmAssetApplyBase.fdReason" /></td>
			<td colspan="5"><kmss:showText value="${kmAssetApplyChangeForm.fdReason}"/></td>
		</tr>
		
		
	<tr>
			<!--附件机制-->
			<td class="td_normal_title" width=15%><bean:message
				bundle="km-asset" key="kmAssetApplyBase.attachMent" /></td>
			<td colspan="5">
        <c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
			<c:param name="fdKey" value="attachment"/>
			<c:param name="fdModelId" value="${param.fdId }" />
			<c:param name="fdModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyChange" />
        </c:import>
			</td>
		</tr>
     		
		<c:if test="${not empty kmAssetApplyChangeForm.fdExplain}">
		<tr>	
		  <!--说明-->
			<td class="td_normal_title" width=15%><bean:message
				bundle="km-asset" key="kmAssetApplyBase.fdExplain" /></td>
			<td colspan="5">
			   <kmss:showText value="${kmAssetApplyChangeForm.fdExplain}"></kmss:showText> 
			</td>
		</tr>
		</c:if>
</table>
	</div>
	<c:choose>
		<c:when test="${param.approveModel eq 'right'}">
			<ui:tabpanel suckTop="true" layout="sys.ui.tabpanel.sucktop" var-supportExpand="true" var-extend="true" var-average='false' var-useMaxWidth='true'>
				<c:choose>
					<c:when test="${kmAssetApplyChangeForm.docStatus>='30' || kmAssetApplyChangeForm.docStatus=='00'}">
						<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmAssetApplyChangeForm" />
							<c:param name="fdKey" value="KmAssetApplyChangeDoc" />
							<c:param name="showHistoryOpers" value="true" />
							<c:param name="isExpand" value="true" />
							<c:param name="approveType" value="right" />
							<c:param name="needInitLbpm" value="true" />
						</c:import>
					</c:when>
					<c:otherwise>
						<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmAssetApplyChangeForm" />
							<c:param name="fdKey" value="KmAssetApplyChangeDoc" />
							<c:param name="showHistoryOpers" value="true" />
							<c:param name="isExpand" value="true" />
							<c:param name="approveType" value="right" />
						</c:import>
					</c:otherwise>
				</c:choose>
				<c:import url="/sys/right/import/right_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyChangeForm" />
					<c:param name="moduleModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyChange" />
				</c:import>
					<%--阅读机制--%>
				<c:import url="/sys/readlog/import/sysReadLog_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyChangeForm" />
				</c:import>
				
				<%--传阅机制--%>
				<c:if test="${kmAssetApplyChangeForm.fdCanCircularize eq 'true' }">
					<c:import url="/sys/circulation/import/sysCirculationMain_view.jsp"	charEncoding="UTF-8">
						<c:param name="formName" value="kmAssetApplyChangeForm" />
						<c:param name="order" value="85" />
					</c:import>
				</c:if>
			</ui:tabpanel>
		</c:when>
		<c:otherwise>
			<ui:tabpage expand="false" var-navwidth="90%">
			    <c:import url="/sys/workflow/import/sysWfProcess_view.jsp"
					charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyChangeForm" />
					<c:param name="fdKey" value="KmAssetApplyChangeDoc" />
				</c:import>
				<c:import url="/sys/right/import/right_view.jsp" charEncoding="UTF-8">
					 <c:param name="formName" value="kmAssetApplyChangeForm" />
					 <c:param name="moduleModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyChange" />
				</c:import>
					<%--阅读机制--%>
				<c:import url="/sys/readlog/import/sysReadLog_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyChangeForm" />
				</c:import>
				
				<%--传阅机制--%>
				<c:if test="${kmAssetApplyChangeForm.fdCanCircularize eq 'true' }">
					<c:import url="/sys/circulation/import/sysCirculationMain_view.jsp"	charEncoding="UTF-8">
						<c:param name="formName" value="kmAssetApplyChangeForm" />
					</c:import>
				</c:if>
				
			</ui:tabpage>
		</c:otherwise>
	</c:choose>
	</template:replace>
<c:choose>
	<c:when test="${param.approveModel eq 'right'}">
		<template:replace name="barRight">
			<c:choose>
				<c:when test="${kmAssetApplyChangeForm.docStatus>='30' || kmAssetApplyChangeForm.docStatus=='00'}">
					<ui:accordionpanel>
						<!-- 基本信息-->
						<c:import url="/km/asset/km_asset_apply_change_ui/kmAssetApplyChange_viewBaseInfoContent.jsp" charEncoding="UTF-8">
						</c:import>
						<!-- 关联配置 -->
						<c:import url="/sys/relation/import/sysRelationMain_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmAssetApplyChangeForm" />
							<c:param name="approveType" value="right" />
						</c:import>
					</ui:accordionpanel>
				</c:when>
				<c:otherwise>
					<ui:tabpanel layout="sys.ui.tabpanel.vertical.icon" id="barRightPanel" >
						<%-- 流程 --%>
						<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmAssetApplyChangeForm" />
							<c:param name="fdKey" value="KmAssetApplyChangeDoc" />
							<c:param name="showHistoryOpers" value="true" />
							<c:param name="isExpand" value="true" />
							<c:param name="approveType" value="right" />
							<c:param name="approvePosition" value="right" />
						</c:import>
						<!-- 审批记录 -->
						<c:import url="/sys/lbpmservice/support/lbpm_audit_note/lbpmAuditNote_list_content.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmAssetApplyChangeForm" />
							<c:param name="fdModelId" value="${kmAssetApplyChangeForm.fdId}" />
							<c:param name="fdModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyChange" />
						</c:import>
						<!-- 基本信息-->
						<c:import url="/km/asset/km_asset_apply_change_ui/kmAssetApplyChange_viewBaseInfoContent.jsp" charEncoding="UTF-8">
						</c:import>
						<!-- 关联配置 -->
						<c:import url="/sys/relation/import/sysRelationMain_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmAssetApplyChangeForm" />
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
				<c:param name="formName" value="kmAssetApplyChangeForm" />
			</c:import>
		</template:replace>
	</c:otherwise>
</c:choose>