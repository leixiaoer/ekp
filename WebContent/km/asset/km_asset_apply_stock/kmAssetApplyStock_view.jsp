<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/view_top.jsp"%>
<script>
	function confirmDelete(msg){
	var del = confirm("<bean:message key="page.comfirmDelete"/>");
	return del;
}
</script>
<div id="optBarDiv">
	<c:if test="${kmAssetApplyStockForm.docStatus=='10' || kmAssetApplyStockForm.docStatus=='11'|| kmAssetApplyStockForm.docStatus=='20'}">
	<kmss:auth requestURL="/km/asset/km_asset_apply_stock/kmAssetApplyStock.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.edit"/>"
			onclick="Com_OpenWindow('kmAssetApplyStock.do?method=edit&fdId=${param.fdId}','_self');">
	</kmss:auth>
	</c:if>
	<kmss:auth requestURL="/km/asset/km_asset_apply_stock/kmAssetApplyStock.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.delete"/>"
			onclick="if(!confirmDelete())return;Com_OpenWindow('kmAssetApplyStock.do?method=delete&fdId=${param.fdId}','_self');">
	</kmss:auth>
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>

<p class="txttitle">
	<c:if test="${not empty txttitle}">${txttitle}</c:if>
	<c:if test="${empty  txttitle}">
		<bean:message bundle="km-asset" key="table.kmAssetApplyStock"/>
	</c:if>
</p>

<center>

<table id="Label_Tabel"  width=95%>
	<%-- 采购单信息 --%>
	<tr LKS_LabelName="<bean:message bundle="km-asset" key="kmAssetApplyStock.page.tab1" />">
		<td>
			<table class="tb_normal" width=100%%>
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
						<xform:datetime property="fdCreateDate"/>
					</td>
				</tr>
				
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
				
				<tr>
					<%--说明 --%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdExplain"/>
					</td>
					<td colspan="3">
						<xform:textarea property="fdExplain"  style="width:100%" ></xform:textarea>
					</td>
				</tr>
				
			</table>
		</td>
	</tr>
	
	<%--流程--%>
	<c:import url="/sys/workflow/include/sysWfProcess_view.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="kmAssetApplyStockForm" />
		<c:param name="fdKey" value="KmAssetApplyStockDoc" />
		<c:param name="showHistoryOpers" value="true" />
	</c:import>
	
	<%-- 权限 --%>
	<tr LKS_LabelName="<bean:message bundle="sys-right" key="right.moduleName" />">
		<td>
			<table class="tb_normal" width=100%>
				<c:import url="/sys/right/right_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyStockForm" />
					<c:param name="moduleModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyStock" />
				</c:import>
			</table>
		</td>
	</tr>
	
		<%--关联机制--%>
	<tr LKS_LabelName="<bean:message bundle="sys-relation" key="sysRelationMain.tab.label" />">
		<c:set var="mainModelForm" value="${kmAssetApplyStockForm}" scope="request"/>
		<c:set var="currModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyStock" scope="request"/>
		<td>
			<%@ include	file="/sys/relation/include/sysRelationMain_view.jsp"%>
		</td>
	</tr>
	
	<%--阅读机制--%>
	<c:import url="/sys/readlog/include/sysReadLog_view.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="kmAssetApplyStockForm" />
	</c:import>
	
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>