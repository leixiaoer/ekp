<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:replace name="content">
<script>
	Com_IncludeFile("jquery.js");
	function confirmDelete(msg){
	var del = confirm("<bean:message key="page.comfirmDelete"/>");
	return del;
}
</script>

<p class="txttitle">${txttitle}</p>
	<div class="lui_form_content_frame">
	<table class="tb_normal" width=100%>
		<c:if test="${param.approveModel ne 'right' }">
				<tr>
					<%-- 标题 --%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.docSubject"/>
					</td>
					<td colspan="3">
						<xform:text property="docSubject" style="width:85%" />
					</td>
				</tr>
				
				<tr>
					<%--类别--%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdApplyCategory"/>
					</td>
					<td width="35%">
						<c:out value="${kmAssetApplyInForm.fdApplyTemplateName}" />
					</td>
					<%--入库单编号--%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdNo"/>
					</td>
					<td width=35%>
						<c:out value="${kmAssetApplyInForm.fdNo}" />
					</td>
				</tr>
							
				<tr>
					<%--拟单人--%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdCreator"/>
					</td>
					<td width="35%">
						<c:out value="${kmAssetApplyInForm.fdCreatorName}" />
					</td>
					<%--拟单时间--%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdCreateDate"/>
					</td>
					<td width="35%">
						<xform:datetime property="fdCreateDate" dateTimeType="datetime"/>
					</td>
				</tr>
		</c:if>
				
				<%-- 入库明细--%>	
				<%@include file="/km/asset/km_asset_apply_in_list/kmAssetApplyInList_view.jsp"%>
				
				<%-- 分隔符 --%>
				<tr>
					<td colspan="4">
					   <c:if test="${fn:length(myCards) > 0}">
							<c:import url="/km/asset/km_asset_card/kmAssetCard_mycard_import.jsp" charEncoding="UTF-8">
								<c:param name="fdResponsiblePerson" value="${kmAssetApplyInForm.fdCreatorId}"></c:param>
							</c:import>
						</c:if>
					</td>
				</tr>		
				
				<tr>
					<%-- 附件 --%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyStock.attachment"/>
					</td>
					<td colspan="3">
						<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
							<c:param name="fdKey" value="kmAssetApplyIn"/>
							<c:param name="formBeanName" value="kmAssetApplyInForm"/>
						</c:import>
					</td>
				</tr>
				
				<c:if test="${not empty kmAssetApplyInForm.fdExplain }">
				<tr>
					<%--说明 --%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdExplain"/>
					</td>
					<td colspan="3">
					    <kmss:showText value="${kmAssetApplyInForm.fdExplain}"></kmss:showText> 
					</td>
				</tr>		
				</c:if>
						
				
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyIn.fdIsCreateCard"/>
					</td>
					<td colspan="3">
						<xform:radio property="fdIsCreateCard">
							<xform:enumsDataSource enumsType="km_asset_apply_in_fd_is_create_card"/>
						</xform:radio>
					</td>
				</tr>
				
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyIn.fdIsUnpickByNums"/>
					</td>
					<td colspan="3">
						<xform:radio property="fdIsUnpickByNums">
							<xform:enumsDataSource enumsType="km_asset_apply_in_fd_is_unpick_by_nums"/>
						</xform:radio>
					</td>
				</tr>
				
			</table>
	
	</div>
	<c:choose>
		<c:when test="${param.approveModel eq 'right'}">
			<ui:tabpanel suckTop="true" layout="sys.ui.tabpanel.sucktop" var-supportExpand="true" var-extend="true" var-average='false' var-useMaxWidth='true'>
				<c:choose>
					<c:when test="${kmAssetApplyInForm.docStatus>='30' || kmAssetApplyInForm.docStatus=='00'}">
						<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmAssetApplyInForm" />
							<c:param name="fdKey" value="KmAssetApplyInDoc" />
							<c:param name="showHistoryOpers" value="true" />
							<c:param name="isExpand" value="true" />
							<c:param name="approveType" value="right" />
							<c:param name="needInitLbpm" value="true" />
						</c:import>
					</c:when>
					<c:otherwise>
						<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmAssetApplyInForm" />
							<c:param name="fdKey" value="KmAssetApplyInDoc" />
							<c:param name="showHistoryOpers" value="true" />
							<c:param name="isExpand" value="true" />
							<c:param name="approveType" value="right" />
						</c:import>
					</c:otherwise>
				</c:choose>
				<c:import url="/sys/right/import/right_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyInForm" />
					<c:param name="moduleModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyIn" />
				</c:import>
					<%--阅读机制--%>
				<c:import url="/sys/readlog/import/sysReadLog_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyInForm" />
				</c:import>
				
				<%--传阅机制--%>
				<c:if test="${kmAssetApplyInForm.fdCanCircularize eq 'true' }">
					<c:import url="/sys/circulation/import/sysCirculationMain_view.jsp"	charEncoding="UTF-8">
						<c:param name="formName" value="kmAssetApplyInForm" />
						<c:param name="order" value="85" />
					</c:import>
				</c:if>
			</ui:tabpanel>
		</c:when>
		<c:otherwise>
			<ui:tabpage expand="false" var-navwidth="90%">
			   <c:import url="/sys/workflow/import/sysWfProcess_view.jsp"
					charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyInForm" />
					<c:param name="fdKey" value="KmAssetApplyInDoc" />
					<c:param name="showHistoryOpers" value="true" />
				</c:import>
				<c:import url="/sys/right/import/right_view.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmAssetApplyInForm" />
						<c:param name="moduleModelName"
							value="com.landray.kmss.km.asset.model.KmAssetApplyIn" />
				</c:import>
				<c:import url="/sys/readlog/import/sysReadLog_view.jsp"
					charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyInForm" />
				</c:import>
				
				<%--传阅机制--%>
				<c:if test="${kmAssetApplyInForm.fdCanCircularize eq 'true' }">
					<c:import url="/sys/circulation/import/sysCirculationMain_view.jsp"	charEncoding="UTF-8">
						<c:param name="formName" value="kmAssetApplyInForm" />
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
				<c:when test="${kmAssetApplyInForm.docStatus>='30' || kmAssetApplyInForm.docStatus=='00'}">
					<ui:accordionpanel>
						<!-- 基本信息-->
						<c:import url="/km/asset/km_asset_apply_in_ui/kmAssetApplyIn_viewBaseInfoContent.jsp" charEncoding="UTF-8">
						</c:import>
						<!-- 关联配置 -->
						<c:import url="/sys/relation/import/sysRelationMain_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmAssetApplyInForm" />
							<c:param name="approveType" value="right" />
						</c:import>
					</ui:accordionpanel>
				</c:when>
				<c:otherwise>
					<ui:tabpanel layout="sys.ui.tabpanel.vertical.icon" id="barRightPanel" >
						<%-- 流程 --%>
						<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmAssetApplyInForm" />
							<c:param name="fdKey" value="KmAssetApplyInDoc" />
							<c:param name="showHistoryOpers" value="true" />
							<c:param name="isExpand" value="true" />
							<c:param name="approveType" value="right" />
							<c:param name="approvePosition" value="right" />
						</c:import>
						<!-- 审批记录 -->
						<c:import url="/sys/lbpmservice/support/lbpm_audit_note/lbpmAuditNote_list_content.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmAssetApplyInForm" />
							<c:param name="fdModelId" value="${kmAssetApplyInForm.fdId}" />
							<c:param name="fdModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyIn" />
						</c:import>
						<!-- 基本信息-->
						<c:import url="/km/asset/km_asset_apply_in_ui/kmAssetApplyIn_viewBaseInfoContent.jsp" charEncoding="UTF-8">
						</c:import>
						<!-- 关联配置 -->
						<c:import url="/sys/relation/import/sysRelationMain_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmAssetApplyInForm" />
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
				<c:param name="formName" value="kmAssetApplyInForm" />
			</c:import>
		</template:replace>
	</c:otherwise>
</c:choose>