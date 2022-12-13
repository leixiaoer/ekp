<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<template:include ref="mobile.view" compatibleMode="true">
	<template:replace name="title">
		<c:out value="${lfn:message('sys-task:tag.feedback') }"></c:out>
	</template:replace>
	<template:replace name="head">
		<mui:min-file name="mui-task-edit.css"/>
	</template:replace>
	<template:replace name="content"> 
	<div data-dojo-type="dojox/mobile/View" id="_contentView">
		<div data-dojo-type="mui/panel/AccordionPanel" data-dojo-props="fixed:false">
			<div data-dojo-type="mui/panel/Content" data-dojo-props="title:'<bean:message bundle="sys-task" key="tag.feedback" />',icon:'mui-ul'">
				<div class="muiFormContent">
					<table class="muiSimple" cellpadding="0" cellspacing="0">
						<tr>
							<td class="muiTitle">
								<bean:message  bundle="sys-task" key="sysTaskMain.docSubject"/>
								</td><td>
								 <a class="com_btn_link" href="../sys_task_main/sysTaskMain.do?method=view&fdId=${sysTaskFeedbackForm.sysTaskMainForm.fdId}"  target="_blank"><c:out value="${sysTaskFeedbackForm.sysTaskMainForm.docSubject}"/></a>
							</td>
						</tr>
						<tr>
							<td class="muiTitle">
								<bean:message  bundle="sys-task" key="sysTaskMain.fdAppoint"/>
								</td><td>
								<c:out value="${sysTaskFeedbackForm.sysTaskMainForm.fdAppointName}"/>	
							</td>
						</tr>
						<tr>
							<td class="muiTitle">
								<bean:message  bundle="sys-task" key="sysTaskMainPerform.fdPerformId"/>
								</td><td>
								<c:out value="${sysTaskFeedbackForm.sysTaskMainForm.fdPerformName}"/>	
							</td>
						</tr>
						<tr>
							<td class="muiTitle">
								<bean:message  bundle="sys-task" key="sysTaskMainCc.fdCcId"/>
								</td><td>
								<c:out value="${sysTaskFeedbackForm.sysTaskMainForm.fdCcNames}"/>	
							</td>
						</tr>
						<tr>
							<td class="muiTitle">
								<bean:message  bundle="sys-task" key="sysTaskMain.fdPlanCompleteTime"/>
								</td><td>
								<c:out value="${sysTaskFeedbackForm.sysTaskMainForm.fdPlanCompleteDate}"/>&nbsp;<c:out value="${sysTaskFeedbackForm.sysTaskMainForm.fdPlanCompleteTime}"/>	
							</td>
						</tr>
						<tr>
							<td class="muiTitle">
								<bean:message bundle="sys-task" key="sysTaskMain.pastdue.yesno"/>
								</td><td>
								<sunbor:enumsShow value="${sysTaskFeedbackForm.fdPastDue}" enumsType="sys_task_yesno"></sunbor:enumsShow>
							</td>
						</tr>
						<tr>
							<td class="muiTitle">
								<bean:message  bundle="sys-task" key="sysTaskMain.fdParentId"/>
								</td><td>
								<c:choose> 
									<c:when test="${sysTaskFeedbackForm.sysTaskMainForm.fdParentName != null}">
										<c:out value="${sysTaskFeedbackForm.sysTaskMainForm.fdParentName}" />
									</c:when>
									<c:otherwise>
										<bean:message bundle="sys-task" key="sysTaskMain.no.message"/>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
						<tr>
							<td class="muiTitle">
								<bean:message  bundle="sys-task" key="sysTaskMain.fdSourceSubject"/>
								</td><td>
								<c:choose> 
									<c:when test="${not empty sysTaskFeedbackForm.sysTaskMainForm.fdSourceSubject && not empty sysTaskFeedbackForm.sysTaskMainForm.fdSourceUrl}">
										<a class="com_btn_link" href='<c:url value="${sysTaskFeedbackForm.sysTaskMainForm.fdSourceUrl}"/>' target="_blank" >
											<c:out value="${sysTaskFeedbackForm.sysTaskMainForm.fdSourceSubject}" />
										</a>
									</c:when>
									<c:when test="${not empty sysTaskFeedbackForm.sysTaskMainForm.fdSourceSubject && empty sysTaskFeedbackForm.sysTaskMainForm.fdSourceUrl}">
										<c:out value="${sysTaskFeedbackForm.sysTaskMainForm.fdSourceSubject}" />
									</c:when>
									<c:otherwise>
										<bean:message bundle="sys-task" key="sysTaskMain.no.message"/>
									</c:otherwise>
								</c:choose>	
							</td>
						</tr>
						<tr>
							<td class="muiTitle">
								<bean:message  bundle="sys-task" key="sysTaskMain.docContent"/>
								</td><td>
								<c:out value="${sysTaskFeedbackForm.sysTaskMainForm.docContent}" escapeXml="false"/>
							</td>
						</tr>
						<tr>
							<td class="muiTitle">
								<bean:message  bundle="sys-task" key="sysTaskFeedback.fdProgress"/>
								</td><td>
								<c:out value="${sysTaskFeedbackForm.fdProgress}"/>%
							</td>
						</tr>
						<tr>
							<td class="muiTitle">
								<bean:message  bundle="sys-task" key="sysTaskFeedback.docContent"/>
								</td><td>
								<xform:rtf property="docContent"></xform:rtf>
							</td>
						</tr>
						<tr>
							<td class="muiTitle">
								<bean:message  bundle="sys-task" key="sysTaskFeedback.docCreatorId"/>
								</td><td>
								<c:out value="${sysTaskFeedbackForm.docCreatorName}"/>
							</td>
						</tr>
						<tr>
							<td class="muiTitle">
								<bean:message  bundle="sys-task" key="sysTaskFeedback.docCreateTime"/>
								</td><td>
								<c:out value="${sysTaskFeedbackForm.docCreateTime}"/>
							</td>
						</tr>
						<tr>
							<td class="muiTitle">
								<bean:message  bundle="sys-task" key="sysTaskFeedback.fdNotifyType"/>
								</td><td>
								<c:forEach var="item" items="${sysTaskFeedbackForm.fdNotifyTypeList}">
									<sunbor:enumsShow value="${item}" enumsType="sysTaskFreedback_fdNotifyType"/>
								</c:forEach>
							</td>
						</tr>
						<%-- <tr>
							<td class="muiTitle">
								<bean:message bundle="sys-task" key="sysTaskFeedback.fdNotifyWay" />
								</td><td>
								<kmss:editNotifyType  property="fdNotifyWay"  />
							</td>
						</tr> --%>
					</table>
				</div>
			</div>
		</div>
	</div>
	</template:replace>
</template:include>