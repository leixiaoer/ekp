<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<ui:content title="${lfn:message('km-asset:kmAsset.config.base') }" titleicon="lui-fm-icon-2">
	<!-- 草稿状态的文档默认选中基本信息页签 -->
	<c:if test="${kmAssetApplyBuyForm.docStatus=='10'}">
		<script>
			LUI.ready(function(){
				setTimeout(function(){
					$("i.lui-fm-icon-2").closest(".lui_tabpanel_vertical_icon_navs_item_l").click();
				},200);
			});
		</script>
	</c:if>
	<table class="tb_normal lui-fm-noneBorderTable" width=100%>
		<tr>
			<%-- 标题 --%>
			<td width=30%>
				<bean:message bundle="km-asset" key="kmAssetApplyBase.docSubject"/>
			</td>
			<td>
				<xform:text property="docSubject" style="width:85%" />
			</td>
		</tr>
		<tr>
			<%-- 类别 --%>
			<td width=30%>
				<bean:message bundle="km-asset" key="kmAssetApplyBase.fdApplyCategory"/>
			</td>
			<td>
				<bean:write name="kmAssetApplyBuyForm"  property="fdApplyTemplateName" />
			</td>
		</tr>
		<tr>
			<%-- 申请单编号 --%>
			<td width=30%>
				<bean:message bundle="km-asset" key="kmAssetApplyBase.fdNo"/>
			</td>
			<td>
				<c:out value="${kmAssetApplyBuyForm.fdNo}" />
			</td>
		</tr>
		<tr>
			<%-- 申请人 --%>
			<td width=30%>
				<bean:message bundle="km-asset" key="kmAssetApplyBase.fdCreator"/>
			</td>
			<td>
				<c:out value="${kmAssetApplyBuyForm.fdCreatorName}" />
			</td>
		</tr>
		<tr>
			<%-- 申请部门 --%>
			<td width=30%>
				<bean:message bundle="km-asset" key="kmAssetApplyBase.fdDept"/>
			</td>
			<td>
				<c:out value="${kmAssetApplyBuyForm.fdDeptName}" />
			</td>
		</tr>
		<tr>
			<%-- 申请日期 --%>
			<td width=30%>
				<bean:message bundle="km-asset" key="kmAssetApplyBase.fdCreateDate"/>
			</td>
			<td>
				<xform:datetime property="fdCreateDate" dateTimeType="datetime"/>
			</td>
		</tr>
		<tr>
			<%-- 是否在计划内 --%>
			<td width=30%>
				<bean:message bundle="km-asset" key="kmAssetApplyBuy.fdIsPlan"/>
			</td>
			<td>
				<xform:radio property="fdIsPlan" >
					<xform:enumsDataSource enumsType="km_asset_apply_buy_fd_is_plan" />
				</xform:radio>
			</td>
		</tr>
	</table>
</ui:content>