<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<!-- 草稿状态的文档默认选中基本信息页签 -->
<c:if test="${kmSuperviseMainFinishForm.docStatus=='10'}">
	<ui:event event="layoutDone">
		$("i.lui-fm-icon-2").closest(".lui_tabpanel_vertical_icon_navs_item_l").click();
   	</ui:event>
</c:if>
<ui:content title="基本信息" titleicon="lui-fm-icon-2">
	<table class="tb_normal lui-fm-noneBorderTable" width=100%>
		<!-- 主题 -->
		<tr>
			<td width="35%">
				<bean:message bundle="km-supervise" key="kmSuperviseMainFinish.docSubject" />
			</td>
			<td colspan="3">
				<c:out value="${ kmSuperviseMainFinishForm.docSubject}"></c:out>
			</td>
		</tr>
		<!-- 办结人 -->
		<tr>
			<td width="35%">
				<bean:message bundle="km-supervise" key="kmSuperviseMainFinish.fdOperator" />
			</td>
			<td colspan="3">
				<c:out value="${ kmSuperviseMainFinishForm.fdOperatorName}"></c:out>
			</td>
		</tr>
		<!-- 办结时间 -->
		<tr>
			<td width="35%">
				<bean:message bundle="km-supervise" key="kmSuperviseMainFinish.fdRealFinishTime" />
			</td>
			<td colspan="3">
				<c:out value="${ kmSuperviseMainFinishForm.fdRealFinishTime}"></c:out>
			</td>
		</tr>
	</table>
</ui:content>