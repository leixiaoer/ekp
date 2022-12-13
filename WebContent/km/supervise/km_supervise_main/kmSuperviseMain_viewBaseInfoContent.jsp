<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<!-- 草稿状态的文档默认选中基本信息页签 -->
<c:if test="${kmSuperviseMainForm.docStatus=='10'}">
	<ui:event event="layoutDone">
		$("i.lui-fm-icon-2").closest(".lui_tabpanel_vertical_icon_navs_item_l").click();
    </ui:event>
</c:if>
<ui:content title="基本信息" titleicon="lui-fm-icon-2">
	<table class="tb_normal lui-fm-noneBorderTable" width=100%>
		<!-- 主题 -->
		<tr>
			<td width="35%">
				<bean:message bundle="km-supervise" key="kmSuperviseMain.docSubject" />
			</td>
			<td colspan="3">
				<c:out value="${ kmSuperviseMainForm.docSubject}"></c:out>
			</td>
		</tr>
		<!-- 创建人 -->
		<tr>
			<td width="35%">
				<bean:message bundle="km-supervise" key="kmSuperviseMain.docCreator" />
			</td>
			<td colspan="3">
				<c:out value="${ kmSuperviseMainForm.docCreatorName}"></c:out>
			</td>
		</tr>
		<!-- 创建时间 -->
		<tr>
			<td width="35%">
				<bean:message bundle="km-supervise" key="kmSuperviseMain.docCreateTime" />
			</td>
			<td colspan="3">
				<c:out value="${ kmSuperviseMainForm.docCreateTime}"></c:out>
			</td>
		</tr>
	</table>
</ui:content>