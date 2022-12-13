<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<!-- 草稿状态的文档默认选中基本信息页签 -->
<c:if test="${kmSuperviseBackForm.docStatus=='10'}">
	<ui:event event="layoutDone">
		$("i.lui-fm-icon-2").closest(".lui_tabpanel_vertical_icon_navs_item_l").click();
   	</ui:event>
</c:if>
<ui:content title="基本信息" titleicon="lui-fm-icon-2">
	<table class="tb_normal lui-fm-noneBorderTable" width=100%>
		<!-- 主题 -->
		<tr>
			<td width="35%">
				<bean:message bundle="km-supervise" key="kmSuperviseBack.docSubject" />
			</td>
			<td colspan="3">
				<c:out value="${kmSuperviseBackForm.docSubject}"></c:out>
			</td>
		</tr>
		<!-- 反馈单位 -->
		<tr>
			<td width="35%">
				<bean:message bundle="km-supervise" key="kmSuperviseMain.fdSysUnit" />
			</td>
			<td colspan="3">
				<c:choose>
					<c:when test="${kmSuperviseBackForm.fdSysUnitEnable eq 'true'}">
						<c:out value="${kmSuperviseBackForm.fdSysUnitName}"></c:out>
					</c:when>
					<c:otherwise>
						<c:out value="${kmSuperviseBackForm.fdUnitName}"></c:out>
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<!-- 反馈人 -->
		<tr>
			<td width="35%">
				<bean:message bundle="km-supervise" key="kmSuperviseBack.fdPerson" />
			</td>
			<td colspan="3">
				<c:out value="${kmSuperviseBackForm.fdPersonName}"></c:out>
			</td>
		</tr>
		<!-- 反馈时间 -->
		<tr>
			<td width="35%">
				<bean:message bundle="km-supervise" key="kmSuperviseBack.fdFeedbackTime" />
			</td>
			<td colspan="3">
				<c:out value="${kmSuperviseBackForm.fdFeedbackTime}"></c:out>
			</td>
		</tr>
	</table>
</ui:content>