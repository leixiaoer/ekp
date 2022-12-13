<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<tr>
	<%--协办单位--%>
	<td class="td_normal_title" width=15%>
		<bean:message bundle="km-supervise" key="kmSuperviseMain.co-organizer" />
	</td>
	<td width=35% colspan=3>
		<c:out value="${sysTaskMainForm.fdOrganizerName}" />
	</td>
</tr>
<tr>
	<%--反馈周期--%>
	<td class="td_normal_title" width=15%>
		<bean:message bundle="km-supervise" key="kmSuperviseMain.feedback.time" />
	</td>
	<td width=35%>
		<sunbor:enumsShow value="${sysTaskMainForm.fdPeriod}" enumsType="km_supervise_task_period"></sunbor:enumsShow>
	</td>
	<%--计划开始时间--%>
	<td class="td_normal_title" width=15%>
		<bean:message bundle="km-supervise" key="kmSuperviseMain.plan.startTime" />
	</td>
	<td width=35%>
		<c:out value="${sysTaskMainForm.fdPlanStartTime}" />
	</td>
</tr>



