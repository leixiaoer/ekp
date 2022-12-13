<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@page import="com.landray.kmss.km.supervise.model.KmSuperviseTask" %>
<%@page import="com.landray.kmss.km.supervise.model.KmSuperviseMain" %>
<%@page import="com.landray.kmss.util.SpringBeanUtil" %>
<%@page import="com.landray.kmss.km.supervise.service.IKmSuperviseTaskService" %>
<list:data>
    <list:data-columns var="kmSuperviseTask" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column col="index" title="${ lfn:message('page.serial') }">
            ${status+1}
        </list:data-column>
		<%-- 督办事项 --%>
        <list:data-column col="fdSupervise.docSubject" title="${lfn:message('km-supervise:kmSupervise.items')}" escape="false">
        	<span class="com_subject"><c:out value="${kmSuperviseTask.fdSupervise.docSubject}" /></span>
        </list:data-column>
        <%-- 完成时限 --%>
        <list:data-column col="fdPlanEndTime" headerClass="width100" title="${lfn:message('km-supervise:kmSuperviseTask.fdPlanEndTime')}">
            <kmss:showDate value="${kmSuperviseTask.fdPlanEndTime}" type="date"></kmss:showDate>
        </list:data-column>
		<%-- 督办类型 --%>
		<list:data-column col="fdSupervise.docTemplate.name" headerClass="width100" title="${lfn:message('km-supervise:kmSuperviseMain.type')}" escape="false">
            <c:out value="${kmSuperviseTask.fdSupervise.docTemplate.fdName}" />
        </list:data-column>
        <%-- 阶段要求 --%>
		<list:data-column col="docContent" headerClass="width100" title="${lfn:message('km-supervise:kmSuperviseTask.docContent')}" escape="false">
            <c:out value="${kmSuperviseTask.docContent}" />
        </list:data-column>
        <%-- 承办单位 --%>
		<list:data-column col="fdUnit.name" headerClass="width100" title="${lfn:message('km-supervise:kmSuperviseTask.fdUnit')}" escape="false">
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
		<list:data-column col="fdSponsor.name" headerClass="width100" title="${lfn:message('km-supervise:kmSuperviseTask.fdSponsor')}" escape="false">
            <c:out value="${kmSuperviseTask.fdSponsor.fdName}" />
        </list:data-column>
         <%-- 反馈时间 --%>
        <list:data-column col="fdBackTime" headerClass="width100" title="${lfn:message('km-supervise:kmSuperviseTask.fdBackTime')}">
            <kmss:showDate value="${kmSuperviseTask.fdBackTime}" type="date"></kmss:showDate>
        </list:data-column>
        <%-- 进度 --%>
		<list:data-column col="fdTaskProgress" headerClass="width100" title="${lfn:message('km-supervise:kmSuperviseTask.fdTaskProgress')}" escape="false">
            <c:out value="${kmSuperviseTask.fdTaskProgress}" />%
        </list:data-column>
        <%-- 反馈状态 --%>
        <list:data-column col="fdStatus" headerClass="width100" title="${lfn:message('km-supervise:kmSuperviseTask.fdStatus')}" escape="false">
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
        <list:data-column headerClass="width80" col="operations" title="${ lfn:message('list.operation') }" escape="false">
				<div class="conf_show_more_w">
					<div class="conf_btn_edit">
						<kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=urgeSupervise&fdId=${kmSuperviseTask.fdSupervise.fdId}" requestMethod="GET">
							<a class="btn_txt" href="javascript:urgeDoc('${kmSuperviseTask.fdId}')">催办</a>
						</kmss:auth>
					</div>
				</div>
		</list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
        <list:data-paging page="${queryPage}" />
</list:data>
