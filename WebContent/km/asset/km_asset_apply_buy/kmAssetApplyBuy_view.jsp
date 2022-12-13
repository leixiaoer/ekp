<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/view_top.jsp"%>
<script>Com_IncludeFile("doclist.js|calendar.js|dialog.js");</script>
<script>
	function confirmDelete(msg){
	var del = confirm("<bean:message key="page.comfirmDelete"/>");
	return del;
}
</script>
<div id="optBarDiv">
	<c:if test="${kmAssetApplyBuyForm.docStatus=='10' || kmAssetApplyBuyForm.docStatus=='11'|| kmAssetApplyBuyForm.docStatus=='20'}">
	<kmss:auth requestURL="/km/asset/km_asset_apply_buy/kmAssetApplyBuy.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.edit"/>"
			onclick="Com_OpenWindow('kmAssetApplyBuy.do?method=edit&fdId=${JsParam.fdId}','_self');">
	</kmss:auth>
	</c:if>
	<kmss:auth requestURL="/km/asset/km_asset_apply_buy/kmAssetApplyBuy.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.delete"/>"
			onclick="if(!confirmDelete())return;Com_OpenWindow('kmAssetApplyBuy.do?method=delete&fdId=${JsParam.fdId}','_self');">
	</kmss:auth>
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>

<p class="txttitle">
	<c:if test="${not empty txttitle}">${txttitle}</c:if>
	<c:if test="${empty  txttitle}">
		<bean:message bundle="km-asset" key="table.kmAssetApplyBuy"/>
	</c:if>
</p>

<center>
<table id="Label_Tabel"  width=95%>
	<%-- 申请单信息 --%>
	<tr LKS_LabelName="<bean:message bundle="km-asset" key="kmAssetApplyBuy.page.tab1" />">
		<td>
			<table class="tb_normal" width=100%>
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
						<xform:datetime property="fdCreateDate"/>
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
				
				<tr>
					<%--说明 --%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdExplain"/>
					</td>
					<td colspan="3">
						<kmss:showText value="${kmAssetApplyBuyForm.fdExplain}"></kmss:showText> 
					</td>
				</tr>
				
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
		</td>
	</tr>
	
	<%--流程--%>
	<c:import url="/sys/workflow/include/sysWfProcess_view.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="kmAssetApplyBuyForm" />
		<c:param name="fdKey" value="KmAssetApplyBuyDoc" />
		<c:param name="showHistoryOpers" value="true" />
	</c:import>
	
	<%-- 权限 --%>
	<tr LKS_LabelName="<bean:message bundle="sys-right" key="right.moduleName" />">
		<td>
			<table class="tb_normal" width=100%>
				<c:import url="/sys/right/right_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyBuyForm" />
					<c:param name="moduleModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyBuy" />
				</c:import>
			</table>
		</td>
	</tr>
	
	<%--关联机制--%>
	<tr	LKS_LabelName="<bean:message bundle="sys-relation" key="sysRelationMain.tab.label" />">
		<c:set var="mainModelForm" value="${kmAssetApplyBuyForm}" scope="request"/>
		<c:set var="currModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyBuy" scope="request"/>
		<td>
			<%@ include	file="/sys/relation/include/sysRelationMain_view.jsp"%>
		</td>
	</tr>
	
	<%--阅读机制--%>
	<c:import url="/sys/readlog/include/sysReadLog_view.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="kmAssetApplyBuyForm" />
	</c:import>
	
	
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>