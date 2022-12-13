<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:replace name="content">
	<script>Com_IncludeFile("doclist.js|calendar.js");</script>
	<script>
		function confirmDelete(msg){
		var del = confirm("<bean:message key="page.comfirmDelete"/>");
		return del;
	}
	</script>
	<p class="txttitle">
		<c:if test="${not empty txttitle}"><c:out value="${txttitle}"/></c:if>
		<c:if test="${empty  txttitle}">
			<bean:message bundle="km-asset" key="table.kmAssetApplyBuy"/>
		</c:if>
	</p>
	
	<div class="lui_form_content_frame">
		<table class="tb_normal" width=100%>
			<c:if test="${param.approveModel ne 'right'}">
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
					<%-- 类别 --%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdApplyCategory"/>
					</td>
					<td width="35%">
						<bean:write name="kmAssetApplyBuyForm"  property="fdApplyTemplateName" />
					</td>
					<%-- 申请单编号 --%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdNo"/>
					</td>
					<td width="35%">
						<c:out value="${kmAssetApplyBuyForm.fdNo}" />
					</td>
				</tr>
				
				<tr>
					<%-- 申请人 --%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdCreator"/>
					</td>
					<td width="35%">
						<c:out value="${kmAssetApplyBuyForm.fdCreatorName}" />
					</td>
					<%-- 申请部门 --%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdDept"/>
					</td>
					<td width="35%">
						<c:out value="${kmAssetApplyBuyForm.fdDeptName}" />
					</td>
				</tr>
				
				<tr>
					<%-- 申请日期 --%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdCreateDate"/>
					</td>
					<td width="35%">
						<xform:datetime property="fdCreateDate" dateTimeType="datetime"/>
					</td>
					<%-- 是否在计划内 --%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBuy.fdIsPlan"/>
					</td>
					<td width="35%">
						<xform:radio property="fdIsPlan" >
							<xform:enumsDataSource enumsType="km_asset_apply_buy_fd_is_plan" />
						</xform:radio>
					</td>
				</tr>
			</c:if>
			
			<tr>
				<%-- 申购明细标题 --%>
				<td colspan="4" class="td_normal_title" align="center">
					<bean:message bundle="km-asset" key="table.kmAssetApplyBuyList"/>
				</td>
			</tr>
			
			<tr>
				<%-- 申请明细--%>
				<td colspan="4">
					<%@include file="/km/asset/km_asset_apply_buy_list/kmAssetApplyBuyList_view.jsp"%>
					<c:if test="${fn:length(myCards) > 0}">
						<c:import url="/km/asset/km_asset_card/kmAssetCard_mycard_import.jsp" charEncoding="UTF-8">
							<c:param name="fdResponsiblePerson" value="${kmAssetApplyBuyForm.fdCreatorId}"></c:param>
						</c:import>
					</c:if>
				</td>
			</tr>
			
			<tr>
				<%-- 合计 --%>
				<td class="td_normal_title" width=15%>
					<bean:message bundle="km-asset" key="kmAssetApplyBuy.fdTotalMoney"/>
				</td>
				<td colspan="3">
					<input type="hidden"  name="fdTotalMoney" value="${kmAssetApplyBuyForm.fdTotalMoney}" />
					<span id="fdTotalMoneySpan" style="width: 10%">
						<kmss:showNumber value="${kmAssetApplyBuyForm.fdTotalMoney}" pattern="###,##0.00"/>
					</span>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<%--中文大写--%>
					<bean:message bundle="km-asset" key="kmAssetApplyBuy.patten.chinaCase"/>
					<span id="chinaValue"></span>
				</td>
			</tr>
			
			<tr>
				<%--申请事由--%>
				<td class="td_normal_title" width=15%>
					<bean:message bundle="km-asset" key="kmAssetApplyBase.fdReason"/>
				</td>
				<td colspan="3">
					<kmss:showText value="${kmAssetApplyBuyForm.fdReason}"></kmss:showText> 
				</td>
			</tr>
			
			<tr>
				<%-- 附件 --%>
				<td class="td_normal_title" width=15%>
					<bean:message bundle="km-asset" key="kmAssetApplyBuy.attachment"/>
				</td>
				<td colspan="3">
					<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
						<c:param name="fdKey" value="kmAssetApplyBuy"/>
						<c:param name="formBeanName" value="kmAssetApplyBuyForm"/>
					</c:import>
				</td>
			</tr>
			
			<c:if test="${not empty kmAssetApplyBuyForm.fdExplain}">
			<tr>
				<%--说明 --%>
				<td class="td_normal_title" width=15%>
					<bean:message bundle="km-asset" key="kmAssetApplyBase.fdExplain"/>
				</td>
				<td colspan="3">
					<kmss:showText value="${kmAssetApplyBuyForm.fdExplain}"></kmss:showText> 
				</td>
			</tr>
			</c:if>
			
			<%-- 分隔符 --%>
			<tr><td colspan="4">&nbsp;</td></tr>
			
			<tr>
				<%-- 调拨方式 --%>
				<td class="td_normal_title" width=15%>
					<bean:message bundle="km-asset" key="kmAssetApplyBuy.fdStyle"/>
				</td>
				<td colspan="3">
					<xform:radio property="fdStyle">
						<xform:enumsDataSource enumsType="km_asset_apply_buy_fd_style"/>
					</xform:radio>
				</td>
			</tr>
			
			<%--询价意见--%>
			<tr>
				<td class="td_normal_title" width=15%>
					<bean:message bundle="km-asset" key="kmAssetApplyBuy.fdMoneyIdea"/>
				</td>
				<td colspan="3">
					<xform:textarea property="fdMoneyIdea" style="width:85%" />
				</td>
			</tr>
							
		</table>
	</div>
	<c:choose>
		<c:when test="${param.approveModel eq 'right'}">
			<ui:tabpanel suckTop="true" layout="sys.ui.tabpanel.sucktop" var-supportExpand="true" var-extend="true" var-average='false' var-useMaxWidth='true'>
				<c:choose>
					<c:when test="${kmAssetApplyBuyForm.docStatus>='30' || kmAssetApplyBuyForm.docStatus=='00'}">
						<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmAssetApplyBuyForm" />
							<c:param name="fdKey" value="KmAssetApplyBuyDoc" />
							<c:param name="showHistoryOpers" value="true" />
							<c:param name="isExpand" value="true" />
							<c:param name="approveType" value="right" />
							<c:param name="needInitLbpm" value="true" />
						</c:import>
					</c:when>
					<c:otherwise>
						<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmAssetApplyBuyForm" />
							<c:param name="fdKey" value="KmAssetApplyBuyDoc" />
							<c:param name="showHistoryOpers" value="true" />
							<c:param name="isExpand" value="true" />
							<c:param name="approveType" value="right" />
						</c:import>
					</c:otherwise>
				</c:choose>
				<c:import url="/sys/right/import/right_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyBuyForm" />
					<c:param name="moduleModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyBuy" />
				</c:import>
					<%--阅读机制--%>
				<c:import url="/sys/readlog/import/sysReadLog_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyBuyForm" />
				</c:import>
				
				<%--传阅机制--%>
				<c:if test="${kmAssetApplyBuyForm.fdCanCircularize eq 'true' }">
					<c:import url="/sys/circulation/import/sysCirculationMain_view.jsp"	charEncoding="UTF-8">
						<c:param name="formName" value="kmAssetApplyBuyForm" />
						<c:param name="order" value="85" />
					</c:import>
				</c:if>
			</ui:tabpanel>
		</c:when>
		<c:otherwise>
			<ui:tabpage expand="false" var-navwidth="90%">
			    <c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyBuyForm" />
					<c:param name="fdKey" value="KmAssetApplyBuyDoc" />
					<c:param name="showHistoryOpers" value="true" />
				</c:import>  
				<c:import url="/sys/right/import/right_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyBuyForm" />
					<c:param name="moduleModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyBuy" />
				</c:import>
					<%--阅读机制--%>
				<c:import url="/sys/readlog/import/sysReadLog_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyBuyForm" />
				</c:import>
				
				<%--传阅机制--%>
				<c:if test="${kmAssetApplyBuyForm.fdCanCircularize eq 'true' }">
					<c:import url="/sys/circulation/import/sysCirculationMain_view.jsp"	charEncoding="UTF-8">
						<c:param name="formName" value="kmAssetApplyBuyForm" />
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
				<c:when test="${kmAssetApplyBuyForm.docStatus>='30' || kmAssetApplyBuyForm.docStatus=='00'}">
					<ui:accordionpanel>
						<!-- 基本信息-->
						<c:import url="/km/asset/km_asset_apply_buy_ui/kmAssetApplyBuy_viewBaseInfoContent.jsp" charEncoding="UTF-8">
						</c:import>
						<!-- 关联配置 -->
						<c:import url="/sys/relation/import/sysRelationMain_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmAssetApplyBuyForm" />
							<c:param name="approveType" value="right" />
						</c:import>
					</ui:accordionpanel>
				</c:when>
				<c:otherwise>
					<ui:tabpanel layout="sys.ui.tabpanel.vertical.icon" id="barRightPanel" >
						<%-- 流程 --%>
						<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmAssetApplyBuyForm" />
							<c:param name="fdKey" value="KmAssetApplyBuyDoc" />
							<c:param name="showHistoryOpers" value="true" />
							<c:param name="isExpand" value="true" />
							<c:param name="approveType" value="right" />
							<c:param name="approvePosition" value="right" />
						</c:import>
						<!-- 审批记录 -->
						<c:import url="/sys/lbpmservice/support/lbpm_audit_note/lbpmAuditNote_list_content.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmAssetApplyBuyForm" />
							<c:param name="fdModelId" value="${kmAssetApplyBuyForm.fdId}" />
							<c:param name="fdModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyBuy" />
						</c:import>
						<!-- 基本信息-->
						<c:import url="/km/asset/km_asset_apply_buy_ui/kmAssetApplyBuy_viewBaseInfoContent.jsp" charEncoding="UTF-8">
						</c:import>
						<!-- 关联配置 -->
						<c:import url="/sys/relation/import/sysRelationMain_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmAssetApplyBuyForm" />
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
				<c:param name="formName" value="kmAssetApplyBuyForm" />
			</c:import>
		</template:replace>
	</c:otherwise>
</c:choose>