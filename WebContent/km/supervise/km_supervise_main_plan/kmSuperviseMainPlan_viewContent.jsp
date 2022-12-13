<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<ui:content title="督办计划" expand="true">
	<div class="lui_supervise_plan_table">
		<table id="TABLE_DocList">
			<tr>
	            <th class="th1" style="width:8%"><bean:message bundle="km-supervise" key="kmSuperviseTask.fdOrder"/></th>
	            <th class="th2" style="width:20%"><bean:message bundle="km-supervise" key="kmSuperviseTask.fdTarget"/></th>
	            <th class="th3" style="width:12%"><bean:message bundle="km-supervise" key="kmSuperviseTask.fdPlanStartTime"/></th>
	            <th class="th4" style="width:12%"><bean:message bundle="km-supervise" key="kmSuperviseTask.fdPlanEndTime"/></th>
	            <th class="th5" style="width:15%"><bean:message bundle="km-supervise" key="kmSuperviseTask.fdUnit"/></th>
	            <th class="th6" style="width:8%"><bean:message bundle="km-supervise" key="kmSuperviseTask.fdSponsor"/></th>
	            <th class="th7" style="width:10%"><bean:message bundle="km-supervise" key="kmSuperviseTask.fdOtherUnits"/></th>
	        </tr>
			<!-- 内容行 -->
			<c:forEach items="${kmSuperviseMainPlanForm.fdTaskItems}"  var="item" varStatus="vstatus">
				<tr KMSS_IsContentRow="1">
					<td width=8% align="center">
						<c:out value="${item.docSubject}"></c:out>
					</td>
					<td style="width: 20%" align="center">
						<c:out value="${item.docContent}"></c:out>
					</td>
					<td style="width: 12%" align="center">
						<c:out value="${item.fdPlanStartTime}"></c:out>
					</td>
					<td style="width: 12%" align="center">
						<c:out value="${item.fdPlanEndTime}"></c:out>
					</td>
					<td style="width: 15%" align="center">
						<c:choose>
							<c:when test="${kmSuperviseMainPlanForm.fdSysUnitEnable eq 'true' }">
								<c:out value="${item.fdSysUnitName}"></c:out>
							</c:when>
							<c:otherwise>
								<c:out value="${item.fdUnitName}"></c:out>
							</c:otherwise>
						</c:choose>
					</td>
					<td style="width: 8%" align="center">
						<c:out value="${item.fdSponsorName}"></c:out>
					</td>
					<td style="width: 10%" align="center">
						<c:choose>
							<c:when test="${kmSuperviseMainPlanForm.fdSysUnitEnable eq 'true' }">
								<c:out value="${item.fdOtherUnitNames}"></c:out>
							</c:when>
							<c:otherwise>
								<c:out value="${item.fdOUnitNames}"></c:out>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<div class="lui_supervise_plan_other">
		<table class="tb_simple">
	    	<tr>
	    		<td class="td1">
	           		<bean:message bundle="km-supervise" key="kmSuperviseMain.feedback.time"/>：
	           	</td>
	           	<td class="td2">
	           		<c:choose>
	           			<c:when test="${kmSuperviseMainPlanForm.fdBackType eq '0'}">
	           				<bean:message bundle="km-supervise" key="enums.task.back.default"/>
	           			</c:when>
	           			<c:when test="${kmSuperviseMainPlanForm.fdBackType eq '1'}">
	           				<bean:message bundle="km-supervise" key="enums.task.back.week"/>
		           		</c:when>
		           		<c:when test="${kmSuperviseMainPlanForm.fdBackType eq '2'}">
		           			<bean:message bundle="km-supervise" key="enums.task.back.double.week"/>
		           		</c:when>
		           		<c:when test="${kmSuperviseMainPlanForm.fdBackType eq '3'}">
		           			<bean:message bundle="km-supervise" key="enums.task.back.month"/>
		           		</c:when>
		           		<c:when test="${kmSuperviseMainPlanForm.fdBackType eq '4'}">
		           			<bean:message bundle="km-supervise" key="enums.task.back.three.month"/>
		           		</c:when>
		           		<c:when test="${kmSuperviseMainPlanForm.fdBackType eq '5'}">
		           			<bean:message bundle="km-supervise" key="enums.task.back.year"/>
		           		</c:when>
	           		</c:choose>
	           </td>
	       </tr>
			<tr>
				<td class="td1"><bean:message bundle="km-supervise" key="kmSuperviseMain.attSupervise"/>：</td>
	           	<td class="td2">
	           		<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
				   		<c:param name="fdKey" value="attTask" />
				       	<c:param name="formBeanName" value="kmSuperviseMainPlanForm" />
				       	<c:param name="fdMulti" value="true" />
				   </c:import>
	            </td>
	    	</tr>
		</table>
	</div>
</ui:content>

<c:choose>
	<c:when test="${param.approveModel eq 'right'&&kmSuperviseMainPlanForm.docStatus!='10'}">
		<c:choose>
			<c:when test="${kmSuperviseMainPlanForm.docStatus>='30' || kmSuperviseMainPlanForm.docStatus=='00'}">
				<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmSuperviseMainPlanForm" />
					<c:param name="fdKey" value="kmSuperviseMakePlan" />
					<c:param name="showHistoryOpers" value="true" />
					<c:param name="isExpand" value="true" />
					<c:param name="approveType" value="right" />
					<c:param name="needInitLbpm" value="true" />
				</c:import>
			</c:when>
			<c:otherwise>
				<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmSuperviseMainPlanForm" />
					<c:param name="fdKey" value="kmSuperviseMakePlan" />
					<c:param name="showHistoryOpers" value="true" />
					<c:param name="isExpand" value="true" />
					<c:param name="approveType" value="right" />
				</c:import>
			</c:otherwise>
		</c:choose>
	</c:when>
	<c:otherwise>
		<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmSuperviseMainPlanForm" />
			<c:param name="fdKey" value="kmSuperviseMakePlan" />
			<c:param name="showHistoryOpers" value="true" />
			<c:param name="isExpand" value="true" />
		</c:import>
	</c:otherwise>
</c:choose>