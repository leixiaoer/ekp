<%@page import="com.landray.kmss.km.supervise.util.CycleDateUtil"%>
<%@page import="com.landray.kmss.km.supervise.service.IKmSuperviseBackService"%>
<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@page import="com.landray.kmss.km.supervise.model.KmSuperviseTask" %>
<%@page import="com.landray.kmss.km.supervise.model.KmSuperviseMain" %>
<%@page import="com.landray.kmss.util.SpringBeanUtil" %>
<%@page import="com.landray.kmss.km.supervise.service.IKmSuperviseTaskService" %>
<%@page import="com.landray.kmss.util.DateUtil"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.landray.kmss.km.supervise.util.KmSuperviseUtil"%>
<%@page import="java.util.Date"%>
<list:data>
    <list:data-columns var="kmSuperviseTask" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column col="index" title="${ lfn:message('page.serial') }">
            ${status+1}
        </list:data-column>
        <%-- 阶段 --%>
        <list:data-column col="docSubject" title="${lfn:message('km-supervise:kmSuperviseTask.docSubject')}" escape="false">
        	<span class="com_subject"><c:out value="${kmSuperviseTask.docSubject}" /></span>
        </list:data-column>
        <%-- 开始时间 --%>
        <list:data-column col="fdPlanStartTime" title="${lfn:message('km-supervise:kmSuperviseTask.fdPlanStartTime')}">
            <kmss:showDate value="${kmSuperviseTask.fdPlanStartTime}" type="date"></kmss:showDate>
        </list:data-column>
        <%-- 完成时限 --%>
        <list:data-column col="fdPlanEndTime" title="${lfn:message('km-supervise:kmSuperviseTask.fdPlanEndTime')}">
            <kmss:showDate value="${kmSuperviseTask.fdPlanEndTime}" type="date"></kmss:showDate>
        </list:data-column>
        <%-- 阶段目标 --%>
		<list:data-column col="docContent" title="${lfn:message('km-supervise:kmSuperviseTask.docContent')}" escape="false">
            <c:out value="${kmSuperviseTask.docContent}" />
        </list:data-column>
        <%-- 承办单位 --%>
        <list:data-column col="fdUnitName" title="${lfn:message('km-supervise:kmSuperviseTask.fdUnit')}" escape="false">
            <c:choose>
            	<c:when test="${kmSuperviseTask.fdSupervise.fdSysUnitEnable == true }">
            		<c:out value="${kmSuperviseTask.fdSysUnit.fdName}" />
            	</c:when>
            	<c:otherwise>
            		<c:out value="${kmSuperviseTask.fdUnit.fdName}" />
            	</c:otherwise>
            </c:choose>
        </list:data-column>
        <%-- 经办人 --%>
        <list:data-column col="fdSponsorName" title="${lfn:message('km-supervise:kmSuperviseTask.fdSponsor')}" escape="false">
            <c:out value="${kmSuperviseTask.fdSponsor.fdName}" />
        </list:data-column>
         <%-- 反馈时间 --%>
        <list:data-column col="fdBackTime" title="${lfn:message('km-supervise:kmSuperviseTask.fdBackTime')}">
            <kmss:showDate value="${kmSuperviseTask.fdBackTime}" type="date"></kmss:showDate>
        </list:data-column>
        <%-- 进度 --%>
		<list:data-column col="fdTaskProgress" title="${lfn:message('km-supervise:kmSuperviseTask.fdTaskProgress')}" escape="false">
            <c:out value="${kmSuperviseTask.fdTaskProgress}" />
        </list:data-column>
        <%-- 反馈状态 --%>
        <list:data-column col="fdStatus" title="${lfn:message('km-supervise:kmSuperviseTask.fdStatus')}" escape="false">
            <%
	            if(pageContext.getAttribute("kmSuperviseTask")!=null){
	            	KmSuperviseTask kmSuperviseTask = (KmSuperviseTask)pageContext.getAttribute("kmSuperviseTask");
	            	IKmSuperviseTaskService kmSuperviseTaskService = (IKmSuperviseTaskService)SpringBeanUtil.getBean("kmSuperviseTaskService");
	            	String fdStatus = kmSuperviseTaskService.getTaskStatus(kmSuperviseTask);
	            	request.setAttribute("fdStatus", fdStatus);
	            }
            %>
            <c:choose>
        		<c:when test="${fdStatus=='10'}">
        			<div class="lui_supervise_data_status"><i class="lui_task_status status_normal"></i><kmss:message bundle="km-supervise" key="task.status.normal" /></div>
        		</c:when>
        		<c:when test="${fdStatus=='20'}">
        			<div class="lui_supervise_data_status"><i class="lui_task_status status_unfeedbacked"></i><kmss:message bundle="km-supervise" key="task.status.not.back" /></div>
        		</c:when>
        		<c:when test="${fdStatus=='30'}">
        			<div class="lui_supervise_data_status"><i class="lui_task_status status_normal"></i><kmss:message bundle="km-supervise" key="task.status.delay" /></div>
        		</c:when>
        	</c:choose>
        </list:data-column>
        <list:data-column col="href" escape="false">
			/km/supervise/km_supervise_task/kmSuperviseTask.do?method=view&fdId=${kmSuperviseTask.fdId}
		</list:data-column>
		<%-- 下一个反馈日 --%>
        <list:data-column col="fdBackDay" title="${lfn:message('km-supervise:kmSuperviseTask.fdBackTime')}">
        	<%
	            if(pageContext.getAttribute("kmSuperviseTask")!=null){
	            	KmSuperviseTask kmSuperviseTask = (KmSuperviseTask)pageContext.getAttribute("kmSuperviseTask");
	            	String backType ;
	            	if (kmSuperviseTask.getFdSupervise() != null) {
	        			backType = kmSuperviseTask.getFdSupervise().getFdBackType();
	        		} else {
	        			backType = kmSuperviseTask.getFdPlan().getFdBackType();
	        		}
	            	Date startTime = kmSuperviseTask.getFdPlanStartTime();
	            	Date endTime = kmSuperviseTask.getFdPlanEndTime();
	            	Calendar backDay = KmSuperviseUtil.getEarlyBackDay(startTime, endTime, backType);
	            	request.setAttribute("fdBackDay", backDay.getTime());
	            	
	            	String fdPeriodId = CycleDateUtil.getPeriodId(backType, backDay);
	            	String fdTaskId = kmSuperviseTask.getFdId();
	            	String fdPersonId = UserUtil.getUser().getFdId();
	            	IKmSuperviseBackService kmSuperviseBackService = (IKmSuperviseBackService)SpringBeanUtil.getBean("kmSuperviseBackService");
	            	boolean isBack = kmSuperviseBackService.isBack(fdPersonId, fdTaskId, fdPeriodId);
	            	request.setAttribute("isBack", isBack);
	            }
            %>
            <kmss:showDate value="${fdBackDay}" type="date"></kmss:showDate>
        </list:data-column>
        <%-- 是否反馈 --%>
        <list:data-column col="fdIsBack" title="${lfn:message('km-supervise:kmSuperviseTask.fdBackTime')}">
            <c:out value="${fdIsBack}" />
        </list:data-column>
        
        <%-- 督办名称 --%>
		<list:data-column col="superviseSubject" title="${lfn:message('km-supervise:kmSuperviseTask.docContent')}" escape="false">
            <c:out value="${kmSuperviseTask.fdSupervise.docSubject}" />
        </list:data-column>
        
        
    </list:data-columns>
    <%-- 分页信息生成 --%>
        <list:data-paging page="${queryPage}" />
</list:data>
