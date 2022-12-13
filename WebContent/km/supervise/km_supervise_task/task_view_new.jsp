<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.sys.organization.model.SysOrgPerson"%>
<%@ page import="java.util.*"%>
<div class="lui_supervise_plan_wrap">
	<div class="lui_supervise_plan_title">
    	<div class="lui_supervise_plan_left">
        	<span><bean:message bundle="km-supervise" key="py.zhiDingJiHua"/></span>
        </div>
	</div>
    <div class="lui_supervise_plan_table">
    	<table id="TABLE_DocList">
    		<tr>
                <th class="th1"><bean:message bundle="km-supervise" key="kmSuperviseTask.fdOrder"/></th>
                <th class="th2"><bean:message bundle="km-supervise" key="kmSuperviseTask.fdTarget"/></th>
                <th class="th3"><bean:message bundle="km-supervise" key="kmSuperviseTask.fdPlanStartTime"/></th>
                <th class="th4"><bean:message bundle="km-supervise" key="kmSuperviseTask.fdPlanEndTime"/></th>
                <c:if test="${param.isEnable eq 'true'}">
                <th class="th5"><bean:message bundle="km-supervise" key="kmSuperviseTask.fdUnit"/></th>
                <th class="th6"><bean:message bundle="km-supervise" key="kmSuperviseTask.fdSponsor"/></th>
                <th class="th7"><bean:message bundle="km-supervise" key="kmSuperviseTask.fdOtherUnits"/></th>
                </c:if>
            </tr>
            <!-- 内容行 -->
			<c:forEach items="${kmSuperviseMainForm.fdItems}"  var="item" varStatus="vstatus">
				<tr KMSS_IsContentRow="1" align="center">
					<td style="width:8%">
						<input type="hidden" name="fdItems[${vstatus.index}].fdId" value="${item.fdId}" />
						<c:out value="${item.docSubject}"></c:out>
					</td>
					<td style="width: 20%" align="left">
						<c:out value="${item.docContent}"></c:out>
					</td>
					<td style="width: 12%">
						<c:out value="${item.fdPlanStartTime}"></c:out>
					</td>
					<td style="width: 12%">
						<c:out value="${item.fdPlanEndTime}"></c:out>
					</td>
					<c:if test="${param.isEnable eq 'true'}">
					<td style="width: 15%">
						<c:choose>
							<c:when test="${kmSuperviseMainForm.fdSysUnitEnable eq 'true' }">
								<c:out value="${item.fdSysUnitName}"></c:out>
							</c:when>
							<c:otherwise>
								<c:out value="${item.fdUnitName}"></c:out>
							</c:otherwise>
						</c:choose>
						
					</td>
					<td style="width: 8%">
						<c:out value="${item.fdSponsorName}"></c:out>
					</td>
					<td style="width: 10%">
						<c:choose>
							<c:when test="${kmSuperviseMainForm.fdSysUnitEnable eq 'true' }">
								<c:out value="${item.fdOtherUnitNames}"></c:out>
							</c:when>
							<c:otherwise>
								<c:out value="${item.fdOUnitNames}"></c:out>
							</c:otherwise>
						</c:choose>
					</td>
					</c:if>
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
                   		<c:when test="${kmSuperviseMainForm.fdBackType eq '0'}">
                   			<bean:message bundle="km-supervise" key="enums.task.back.default"/>
                   		</c:when>
                   		<c:when test="${kmSuperviseMainForm.fdBackType eq '1'}">
                   			<bean:message bundle="km-supervise" key="enums.task.back.week"/>
                   		</c:when>
                   		<c:when test="${kmSuperviseMainForm.fdBackType eq '2'}">
                   			<bean:message bundle="km-supervise" key="enums.task.back.double.week"/>
                   		</c:when>
                   		<c:when test="${kmSuperviseMainForm.fdBackType eq '3'}">
                   			<bean:message bundle="km-supervise" key="enums.task.back.month"/>
                   		</c:when>
                   		<c:when test="${kmSuperviseMainForm.fdBackType eq '4'}">
                   			<bean:message bundle="km-supervise" key="enums.task.back.three.month"/>
                   		</c:when>
                   		<c:when test="${kmSuperviseMainForm.fdBackType eq '5'}">
                   			<bean:message bundle="km-supervise" key="enums.task.back.year"/>
                   		</c:when>
                	</c:choose>
	          	</td>
			</tr>
			<tr>
				<td class="td1"><bean:message bundle="km-supervise" key="py.FuJianShangChuan"/>：</td>
	        	<td class="td2">
	          		<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
		            	<c:param name="fdKey" value="attTask" />
		                <c:param name="formBeanName" value="kmSuperviseMainForm" />
		                <c:param name="fdMulti" value="true" />
	            	</c:import>
	            </td>
	        </tr>
	    </table>
	</div>
</div>