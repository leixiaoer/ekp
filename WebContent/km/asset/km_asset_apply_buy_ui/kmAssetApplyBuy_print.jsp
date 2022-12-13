<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="java.util.List"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<template:include ref="default.view" sidebar="no" showQrcode="false">
	<template:replace name="head">
		<style type="text/css">
			@media print {
				.com_goto{
					display: none;
				}
				#toolBarDiv{
					display: none;
				}
			}
		</style>
	</template:replace>
	<template:replace name="title">
		<c:out value="${kmAssetApplyBuyForm.docSubject} - ${ lfn:message('km-asset:module.km.asset')}"></c:out>
	</template:replace>
	<template:replace name="content">
<div style="padding-top:50px">	
<p class="txttitle">
	<c:if test="${not empty txttitle}"><c:out value="${txttitle}"/></c:if>
	<c:if test="${empty  txttitle}">
		<bean:message bundle="km-asset" key="table.kmAssetApplyBuy"/>
	</c:if>
</p>

<div class="lui_form_content_frame">
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
	<br/>
	<table class="tb_normal" width="100%">
	   <tr>
	   		<td class="td_normal_title" width="100%" align="center">
			    审批记录
			</td>
		</tr>
		<tr>
			<td width="100%">
			    <c:import url="/sys/workflow/include/sysWfProcess_log.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyBuyForm" />
				</c:import>
			</td>
		</tr>
	</table>
	<div id="toolBarDiv" style="padding-top:20px;text-align:right;">
	      <input type="button" class="lui_form_button"  value="<bean:message key='button.print' />"  onclick="window.print();"  style="width:100px;height:60px;font-size:18px"/>
    </div>
</div>
</div>
</template:replace>
</template:include>
