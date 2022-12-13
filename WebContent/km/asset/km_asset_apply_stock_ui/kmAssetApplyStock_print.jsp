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
		<c:out value="${kmAssetApplyStockForm.docSubject} - ${ lfn:message('km-asset:module.km.asset')}"></c:out>
	</template:replace>
	<template:replace name="content">
	<%@ include file="/km/asset/resource/assetcommon.jsp"%>
	<%@include file="/km/asset/resource/chinaValue.jsp"%>
<div style="padding-top:50px">	
<p class="txttitle">
	<c:if test="${not empty txttitle}">${txttitle}</c:if>
	<c:if test="${empty  txttitle}">
		<bean:message bundle="km-asset" key="table.kmAssetApplyStock"/>
	</c:if>
</p>
	<div class="lui_form_content_frame">
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
						<xform:datetime property="fdCreateDate" dateTimeType="datetime"/>
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
							<c:param name="formName" value="kmAssetApplyStockForm" />
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
