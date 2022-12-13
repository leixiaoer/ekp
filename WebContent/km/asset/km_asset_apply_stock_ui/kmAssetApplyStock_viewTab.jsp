<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:replace name="content">
	<%@ include file="/km/asset/resource/assetcommon.jsp"%>
	<%@include file="/km/asset/resource/chinaValue.jsp"%>
<script>
	function confirmDelete(msg){
	var del = confirm("<bean:message key="page.comfirmDelete"/>");
	return del;
}
</script>
<p class="txttitle">
	<c:if test="${not empty txttitle}">${txttitle}</c:if>
	<c:if test="${empty  txttitle}">
		<bean:message bundle="km-asset" key="table.kmAssetApplyStock"/>
	</c:if>
</p>
	<div class="lui_form_content_frame">
	<table class="tb_normal" width=100%%>
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
						<%--类别--%>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-asset" key="kmAssetApplyBase.fdApplyCategory"/>
						</td>
						<td width="35%">
							<c:out value="${kmAssetApplyStockForm.fdApplyTemplateName}" />
						</td>
						<%--采购单编号--%>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-asset" key="kmAssetApplyBase.fdNo"/>
						</td>
						<td width=35%>
							<c:out value="${kmAssetApplyStockForm.fdNo}" />
						</td>
					</tr>
					
					<tr>
						<%--拟单人--%>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-asset" key="kmAssetApplyBase.fdCreator"/>
						</td>
						<td width="35%">
							<c:out value="${kmAssetApplyStockForm.fdCreatorName}" />
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
				
				<tr>
					<%-- 采购明细标题 --%>
					<td colspan="4" class="td_normal_title" align="center">
						<bean:message bundle="km-asset" key="table.kmAssetApplyStockList"/>
					</td>
				</tr>
				
				<tr>
					<%-- 申请明细--%>
					<td colspan="4">
						<%@include file="/km/asset/km_asset_apply_stock_list/kmAssetApplyStockList_view.jsp"%>
						<c:if test="${fn:length(myCards) > 0}">
						<c:import url="/km/asset/km_asset_card/kmAssetCard_mycard_import.jsp" charEncoding="UTF-8">
							<c:param name="fdResponsiblePerson" value="${kmAssetApplyStockForm.fdCreatorId}"></c:param>
						</c:import>
					</c:if>
					</td>
				</tr>
				
				<tr>
					<%-- 合计 --%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyStock.fdTotalMoney"/>
					</td>
					<td colspan="3">
						<input type="hidden"  name="fdTotalMoney" value="${kmAssetApplyStockForm.fdTotalMoney}" />
						<span id="fdTotalMoneySpan" style="width: 10%"><kmss:showNumber value="${kmAssetApplyStockForm.fdTotalMoney}" pattern="###,##0.00"/></span>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<%--中文大写--%>
						<bean:message bundle="km-asset" key="kmAssetApplyBuy.patten.chinaCase"/>
						<span id="chinaValue"></span>
						
						
					</td>
				</tr>
				
				<tr>
					<%--采购事项--%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyStock.fdStockMatter"/>
					</td>
					<td colspan="3">
						<xform:textarea property="fdStockMatter" style="width:100%" />
					</td>
				</tr>
				
				<tr>
					<%-- 附件 --%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyStock.attachment"/>
					</td>
					<td colspan="3">
						<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
							<c:param name="fdKey" value="kmAssetApplyStock"/>
							<c:param name="formBeanName" value="kmAssetApplyStockForm"/>
						</c:import>
					</td>
				</tr>
				
				<c:if test="${not empty kmAssetApplyStockForm.fdExplain }">
				<tr>
					<%--说明 --%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdExplain"/>
					</td>
					<td colspan="3">
						<xform:textarea property="fdExplain"  style="width:100%" ></xform:textarea>
					</td>
				</tr>
				</c:if>
				
			</table>
	</div>
	<c:choose>
		<c:when test="${param.approveModel eq 'right'}">
			<ui:tabpanel suckTop="true" layout="sys.ui.tabpanel.sucktop" var-supportExpand="true" var-extend="true" var-average='false' var-useMaxWidth='true'>
				<c:choose>
					<c:when test="${kmAssetApplyStockForm.docStatus>='30' || kmAssetApplyStockForm.docStatus=='00'}">
						<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmAssetApplyStockForm" />
							<c:param name="fdKey" value="KmAssetApplyStockDoc" />
							<c:param name="showHistoryOpers" value="true" />
							<c:param name="isExpand" value="true" />
							<c:param name="approveType" value="right" />
							<c:param name="needInitLbpm" value="true" />
						</c:import>
					</c:when>
					<c:otherwise>
						<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmAssetApplyStockForm" />
							<c:param name="fdKey" value="KmAssetApplyStockDoc" />
							<c:param name="showHistoryOpers" value="true" />
							<c:param name="isExpand" value="true" />
							<c:param name="approveType" value="right" />
						</c:import>
					</c:otherwise>
				</c:choose>
				<c:import url="/sys/right/import/right_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyStockForm" />
					<c:param name="moduleModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyStock" />
				</c:import>
					<%--阅读机制--%>
				<c:import url="/sys/readlog/import/sysReadLog_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyStockForm" />
				</c:import>
				
				<%--传阅机制--%>
				<c:if test="${kmAssetApplyStockForm.fdCanCircularize eq 'true' }">
					<c:import url="/sys/circulation/import/sysCirculationMain_view.jsp"	charEncoding="UTF-8">
						<c:param name="formName" value="kmAssetApplyStockForm" />
						<c:param name="order" value="85" />
					</c:import>
				</c:if>
			</ui:tabpanel>
		</c:when>
		<c:otherwise>
			<ui:tabpage expand="false" var-navwidth="90%">
			   <c:import url="/sys/workflow/import/sysWfProcess_view.jsp"
					charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyStockForm" />
					<c:param name="fdKey" value="KmAssetApplyStockDoc" />
					<c:param name="showHistoryOpers" value="true" />
				</c:import>
				<c:import url="/sys/right/import/right_view.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmAssetApplyStockForm" />
						<c:param name="moduleModelName"
							value="com.landray.kmss.km.asset.model.KmAssetApplyStock" />
				</c:import>
				<c:import url="/sys/readlog/import/sysReadLog_view.jsp"
					charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyStockForm" />
				</c:import>
				
				<%--传阅机制--%>
				<c:if test="${kmAssetApplyStockForm.fdCanCircularize eq 'true' }">
					<c:import url="/sys/circulation/import/sysCirculationMain_view.jsp"	charEncoding="UTF-8">
						<c:param name="formName" value="kmAssetApplyStockForm" />
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
				<c:when test="${kmAssetApplyStockForm.docStatus>='30' || kmAssetApplyStockForm.docStatus=='00'}">
					<ui:accordionpanel>
						<!-- 基本信息-->
						<c:import url="/km/asset/km_asset_apply_stock_ui/kmAssetApplyStock_viewBaseInfoContent.jsp" charEncoding="UTF-8">
						</c:import>
						<!-- 关联配置 -->
						<c:import url="/sys/relation/import/sysRelationMain_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmAssetApplyStockForm" />
							<c:param name="approveType" value="right" />
						</c:import>
					</ui:accordionpanel>
				</c:when>
				<c:otherwise>
					<ui:tabpanel layout="sys.ui.tabpanel.vertical.icon" id="barRightPanel" >
						<%-- 流程 --%>
						<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmAssetApplyStockForm" />
							<c:param name="fdKey" value="KmAssetApplyStockDoc" />
							<c:param name="showHistoryOpers" value="true" />
							<c:param name="isExpand" value="true" />
							<c:param name="approveType" value="right" />
							<c:param name="approvePosition" value="right" />
						</c:import>
						<!-- 审批记录 -->
						<c:import url="/sys/lbpmservice/support/lbpm_audit_note/lbpmAuditNote_list_content.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmAssetApplyStockForm" />
							<c:param name="fdModelId" value="${kmAssetApplyStockForm.fdId}" />
							<c:param name="fdModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyStock" />
						</c:import>
						<!-- 基本信息-->
						<c:import url="/km/asset/km_asset_apply_stock_ui/kmAssetApplyStock_viewBaseInfoContent.jsp" charEncoding="UTF-8">
						</c:import>
						<!-- 关联配置 -->
						<c:import url="/sys/relation/import/sysRelationMain_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmAssetApplyStockForm" />
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
				<c:param name="formName" value="kmAssetApplyStockForm" />
			</c:import>
		</template:replace>
	</c:otherwise>
</c:choose>