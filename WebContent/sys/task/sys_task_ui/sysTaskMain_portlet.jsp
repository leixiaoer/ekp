<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="sysTaskMain" list="${queryPage.list }" custom="false">
		<%--ID--%>
		<list:data-column property="fdId"></list:data-column>
		<%--任务名称--%>
		<list:data-column col="docSubject" title="${ lfn:message('sys-task:sysTaskMain.docSubject') }" style="text-align:left;" escape="false">
			<p title="${sysTaskMain.docSubject}" style="overflow: hidden;white-space: nowrap;text-overflow: ellipsis;">
			<a href="${LUI_ContextPath}/sys/task/sys_task_main/sysTaskMain.do?method=view&fdId=${sysTaskMain.fdId}" target="_blank">
				<c:choose >
					<c:when test="${fn:length(sysTaskMain.docSubject)>28}">${fn:escapeXml(fn:substring(sysTaskMain.docSubject, 0,26))}...</c:when>
					<c:otherwise>${fn:escapeXml(sysTaskMain.docSubject)}</c:otherwise>
				</c:choose>
			</a>
			</p>
		</list:data-column>
		<%--任务状态--%>
		<list:data-column headerClass="width60"  styleClass="width60"  col="fdPastDue" title="${ lfn:message('sys-task:sysTaskMain.fdStatus') }" escape="false" >
			<kmss:showTaskStatus taskStatus="${sysTaskMain.fdStatus}" />
		</list:data-column>
		<%--任务进度--%>
		<list:data-column headerClass="width120" style="text-align:left;" styleClass="width120" col="fdProgress" title="${ lfn:message('sys-task:sysTaskMain.fdProgress') }" escape="false">
			<style>
				.pro_barline{display:inline-block;width: 63px;height: 7px;background: #e5e4e1;border: 1px solid #d2d1cc;text-align: left;border-radius: 4px;}
				.pro_barline .complete{height: 7px;background: #00a001;border-radius: 3px;}
				.pro_barline .uncomplete{height: 7px;background: #ff8b00;border-radius: 3px;}
				.pro_percent{display:inline-block;margin-left:6px;}
			</style>
			<div class='pro_barline'>
				<c:if test="${sysTaskMain.fdProgress=='100' }">
					<div class='complete' style="width:${sysTaskMain.fdProgress}%"></div>
				</c:if>
				<c:if test="${sysTaskMain.fdProgress!='100' }">
					<div class='uncomplete' style="width:${sysTaskMain.fdProgress}%"></div>
				</c:if>
			</div>
			<span class='pro_percent'><c:out value="${sysTaskMain.fdProgress}" />%</span>
		</list:data-column>
		<%-- 计划完成时间--%>
		<list:data-column headerClass="width120" styleClass="width120" property="fdPlanCompleteDateTime" title="${ lfn:message('sys-task:sysTaskMain.fdPlanCompleteTime') }" style="width:120px" >
		</list:data-column>
	</list:data-columns>
</list:data>