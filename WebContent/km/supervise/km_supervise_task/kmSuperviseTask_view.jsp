<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<template:include ref="default.view" sidebar="no">
    
    <template:replace name="title">
    	<c:out value="${kmSuperviseTaskForm.docSubject} - " />
        <c:out value="${ lfn:message('km-supervise:module.km.supervise') }" />
    </template:replace>
	
	<%--操作按钮--%>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float">
			<%--关闭--%>
			<ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();">
			</ui:button>
		</ui:toolbar>
	</template:replace>
	
	<template:replace name="content">
		<ui:tabpage expand="false" var-navwidth="90%">
			<div class="lui_form_content_frame" >
	            <table class="tb_normal" width="100%">
	            	<tr>
						<td class="td_normal_title" width="15%">
							<bean:message bundle="km-supervise" key="kmSuperviseTask.fdOrder"/>
						</td>
						<td colspan="3">
							<c:out value="${kmSuperviseTaskForm.docSubject}"/>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width="15%">
							<bean:message bundle="km-supervise" key="kmSuperviseTask.fdTarget"/>
						</td>
						<td colspan="3">
							<c:out value="${kmSuperviseTaskForm.docContent}"/>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width="15%">
							<bean:message bundle="km-supervise" key="kmSuperviseTask.fdPlanStartTime"/>
						</td>
						<td width="35%">
							<c:out value="${kmSuperviseTaskForm.fdPlanStartTime}"/>
						</td>
						<td class="td_normal_title" width="15%">
							<bean:message bundle="km-supervise" key="kmSuperviseTask.fdPlanEndTime"/>
						</td>
						<td width="35%">
							<c:out value="${kmSuperviseTaskForm.fdPlanEndTime}"/>
						</td>
					</tr>
					<tr>
						
						<td class="td_normal_title" width="15%">
							<bean:message bundle="km-supervise" key="kmSuperviseTask.fdUnit"/>
						</td>
						<td width="35%">
							<c:choose>
			                  	<c:when test="${kmSuperviseTaskForm.fdSysUnitEnable eq 'true'}">
									<c:out value="${kmSuperviseTaskForm.fdSysUnitName}"/>
								</c:when>
								<c:otherwise>
									<c:out value="${kmSuperviseTaskForm.fdUnitName}"/>
								</c:otherwise>
							</c:choose>
						</td>
							
						<td class="td_normal_title" width="15%">
							<bean:message bundle="km-supervise" key="kmSuperviseTask.fdSponsor"/>
						</td>
						<td width="35%">
							<c:out value="${kmSuperviseTaskForm.fdSponsorName}"/>
						</td>
					</tr>
					<tr>
						<c:choose>
			            	<c:when test="${kmSuperviseTaskForm.fdSysUnitEnable eq 'true'}">
								<td class="td_normal_title" width="15%">
									<bean:message bundle="km-supervise" key="kmSuperviseMain.fdOtherUnits"/>
								</td>
								<td colspan="3">
									<c:out value="${kmSuperviseTaskForm.fdOtherUnitNames}"/>
								</td>
							</c:when>
							<c:otherwise>
								<td class="td_normal_title" width="15%">
									<bean:message bundle="km-supervise" key="kmSuperviseMain.fdOUnits"/>
								</td>
								<td colspan="3">
									<c:out value="${kmSuperviseTaskForm.fdOUnitNames}"/>
								</td>
							</c:otherwise>
						</c:choose>
					</tr>
				</table>
			</div>
		</ui:tabpage>
	</template:replace>
</template:include>
