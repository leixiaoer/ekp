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
			<c:if test="${param.approveModel ne 'right'}">
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
							  ${kmAssetApplyRentForm.fdApplyTemplateName}</td>
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
					value="${kmAssetApplyRentForm.fdCreatorName}" /></td>
				   <!--申请部门-->
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.fdDept" /></td>
					<td width="19%">
					     <c:out value="${kmAssetApplyRentForm.fdDeptName}" />
					</td>
					<!--申请日期-->
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.fdCreateDate" /></td>
					<td width="19%"><xform:datetime property="fdCreateDate"  style="width:85%" dateTimeType="datetime"/></td>
				</tr>
			</c:if>
	
		 <!-- 出租单明细 -->
					<tr>
						<td class="td_normal_title" width="100%" colspan="6" align="center"><bean:message
							bundle="km-asset" key="table.kmAssetApplyRentList" /></td>
					</tr>
	                <tr>
						<td width="100%" colspan="6">
						<c:import
							url="/km/asset/km_asset_apply_rent_list/kmAssetApplyRentList_view.jsp"
							charEncoding="UTF-8">
						</c:import>
						<c:if test="${fn:length(myCards) > 0}">
							<c:import url="/km/asset/km_asset_card/kmAssetCard_mycard_import.jsp" charEncoding="UTF-8">
								<c:param name="fdResponsiblePerson" value="${kmAssetApplyRentForm.fdCreatorId}"></c:param>
							</c:import>
						</c:if>
						</td>
					</tr>  
			
			<tr>
				<!--借用期限-->
				<td class="td_normal_title" width=15%><bean:message bundle="km-asset" key="kmAssetApplyRent.deadline"/></td>
				<td colspan="5">
	                <bean:message bundle="km-asset" key="kmAssetApplyRent.from"/>&nbsp;<xform:datetime property="fdStartDate" dateTimeType="date"/>&nbsp;&nbsp;
	                <bean:message bundle="km-asset" key="kmAssetApplyRent.to"/>&nbsp;<xform:datetime property="fdEndDate" dateTimeType="date"/>&nbsp;&nbsp;
	                <bean:message bundle="km-asset" key="kmAssetApplyRent.total"/>&nbsp; <xform:text property="fdDays" />
		            <bean:message bundle="km-asset" key="kmAssetApplyRent.day"/>
				</td>
			</tr>
			
		<tr>
	   	 <!-- 借入单位 -->
			<td class="td_normal_title" width=15%>
				<bean:message bundle="km-asset" key="kmAssetApplyRent.fdForeignBranch"/>
			</td><td width="19%">
				<xform:text property="fdForeignBranch" style="width:85%" />
			</td>
		  <!-- 借入部门 -->
			<td class="td_normal_title" width=15%>
				<bean:message bundle="km-asset" key="kmAssetApplyRent.fdForeignDept"/>
			</td><td colspan="3">
				<xform:text property="fdForeignDept" style="width:85%" />
			</td>
		</tr>		
		<tr>
				<!--借出单位 -->
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-asset" key="kmAssetApplyRent.fdRentBranch" /></td>
				<td width="19%">
				      <c:out value="${kmAssetApplyRentForm.fdRentBranchName}" />
				</td>
				<!--借出部门-->
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-asset" key="kmAssetApplyRent.fdRentDept" /></td>
				<td colspan="3">  
				           <c:out value="${kmAssetApplyRentForm.fdRentDeptName}" />
				</td>
			</tr>
	
	      <tr>	
			  <!--借出事由-->
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-asset" key="kmAssetApplyRent.reason" /></td>
				<td colspan="5"><kmss:showText value="${kmAssetApplyRentForm.fdReason}"/></td>
			</tr>
			
			<tr>
				<!--附件机制-->
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-asset" key="kmAssetApplyBase.attachMent" /></td>
				<td colspan="5">
	        <c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
				<c:param name="fdKey" value="attachment"/>
				<c:param name="fdModelId" value="${param.fdId }" />
				<c:param name="fdModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyRent" />
	        </c:import>
				</td>
			</tr>
				
			<c:if test="${not empty kmAssetApplyRentForm.fdExplain }">
			<tr>	
			  <!--说明-->
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-asset" key="kmAssetApplyBase.fdExplain" /></td>
				<td colspan="5">
				    <kmss:showText value="${kmAssetApplyRentForm.fdExplain}"></kmss:showText> 
				</td>
			</tr>
			</c:if>
	  </table>
	</div>
	<c:choose>
		<c:when test="${param.approveModel eq 'right'}">
			<ui:tabpanel suckTop="true" layout="sys.ui.tabpanel.sucktop" var-supportExpand="true" var-extend="true" var-average='false' var-useMaxWidth='true'>
				<c:choose>
					<c:when test="${kmAssetApplyRentForm.docStatus>='30' || kmAssetApplyRentForm.docStatus=='00'}">
						<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmAssetApplyRentForm" />
							<c:param name="fdKey" value="KmAssetApplyRentDoc" />
							<c:param name="showHistoryOpers" value="true" />
							<c:param name="isExpand" value="true" />
							<c:param name="approveType" value="right" />
							<c:param name="needInitLbpm" value="true" />
						</c:import>
					</c:when>
					<c:otherwise>
						<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmAssetApplyRentForm" />
							<c:param name="fdKey" value="KmAssetApplyRentDoc" />
							<c:param name="showHistoryOpers" value="true" />
							<c:param name="isExpand" value="true" />
							<c:param name="approveType" value="right" />
						</c:import>
					</c:otherwise>
				</c:choose>
				<c:import url="/sys/right/import/right_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyRentForm" />
					<c:param name="moduleModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyRent" />
				</c:import>
					<%--阅读机制--%>
				<c:import url="/sys/readlog/import/sysReadLog_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyRentForm" />
				</c:import>
				
				<%--传阅机制--%>
				<c:if test="${kmAssetApplyRentForm.fdCanCircularize eq 'true' }">
					<c:import url="/sys/circulation/import/sysCirculationMain_view.jsp"	charEncoding="UTF-8">
						<c:param name="formName" value="kmAssetApplyRentForm" />
						<c:param name="order" value="85" />
					</c:import>
				</c:if>
			</ui:tabpanel>
		</c:when>
		<c:otherwise>
			<ui:tabpage expand="false" var-navwidth="90%">
			   <c:import url="/sys/workflow/import/sysWfProcess_view.jsp"
					charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyRentForm" />
					<c:param name="fdKey" value="KmAssetApplyRentDoc" />
					<c:param name="showHistoryOpers" value="true" />
				</c:import>
				<c:import url="/sys/right/import/right_view.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmAssetApplyRentForm" />
						<c:param name="moduleModelName"
							value="com.landray.kmss.km.asset.model.KmAssetApplyRent" />
				</c:import>
				<c:import url="/sys/readlog/import/sysReadLog_view.jsp"
					charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyRentForm" />
				</c:import>
				
				<%--传阅机制--%>
				<c:if test="${kmAssetApplyRentForm.fdCanCircularize eq 'true' }">
					<c:import url="/sys/circulation/import/sysCirculationMain_view.jsp"	charEncoding="UTF-8">
						<c:param name="formName" value="kmAssetApplyRentForm" />
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
				<c:when test="${kmAssetApplyRentForm.docStatus>='30' || kmAssetApplyRentForm.docStatus=='00'}">
					<ui:accordionpanel>
						<!-- 基本信息-->
						<c:import url="/km/asset/km_asset_apply_rent_ui/kmAssetApplyRent_viewBaseInfoContent.jsp" charEncoding="UTF-8">
						</c:import>
						<!-- 关联配置 -->
						<c:import url="/sys/relation/import/sysRelationMain_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmAssetApplyRentForm" />
							<c:param name="approveType" value="right" />
						</c:import>
					</ui:accordionpanel>
				</c:when>
				<c:otherwise>
					<ui:tabpanel layout="sys.ui.tabpanel.vertical.icon" id="barRightPanel" >
						<%-- 流程 --%>
						<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmAssetApplyRentForm" />
							<c:param name="fdKey" value="KmAssetApplyRentDoc" />
							<c:param name="showHistoryOpers" value="true" />
							<c:param name="isExpand" value="true" />
							<c:param name="approveType" value="right" />
							<c:param name="approvePosition" value="right" />
						</c:import>
						<!-- 审批记录 -->
						<c:import url="/sys/lbpmservice/support/lbpm_audit_note/lbpmAuditNote_list_content.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmAssetApplyRentForm" />
							<c:param name="fdModelId" value="${kmAssetApplyRentForm.fdId}" />
							<c:param name="fdModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyRent" />
						</c:import>
						<!-- 基本信息-->
						<c:import url="/km/asset/km_asset_apply_rent_ui/kmAssetApplyRent_viewBaseInfoContent.jsp" charEncoding="UTF-8">
						</c:import>
						<!-- 关联配置 -->
						<c:import url="/sys/relation/import/sysRelationMain_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmAssetApplyRentForm" />
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
				<c:param name="formName" value="kmAssetApplyRentForm" />
			</c:import>
		</template:replace>
	</c:otherwise>
</c:choose>