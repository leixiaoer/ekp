<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.km.supervise.model.KmSuperviseParamConfig"%>
<% 
   	KmSuperviseParamConfig paramConfig = new KmSuperviseParamConfig();
   	pageContext.setAttribute("paramConfig",paramConfig);
%>
<p class="txttitle">
	<bean:write name="kmSuperviseMainForm" property="docSubject" />
</p>
<ui:content title="${lfn:message('km-supervise:py.DuBanLiXiang')}" expand="true">
    <c:import url="/sys/xform/include/sysForm_view.jsp" charEncoding="UTF-8">
        <c:param name="formName" value="kmSuperviseMainForm" />
        <c:param name="fdKey" value="kmSuperviseMain" />
        <c:param name="useTab" value="false" />
    </c:import>
    <c:choose>
    	<c:when test="${not empty planId }">
    		<div class="lui_supervise_plan_wrap">
				<div class="lui_supervise_plan_title">
			    	<div class="lui_supervise_plan_left">
			        	<span><bean:message bundle="km-supervise" key="py.zhiDingJiHua"/></span>
			        </div>
				</div>
				<center>
					<div><a href="${LUI_ContextPath}/km/supervise/km_supervise_main_plan/kmSuperviseMainPlan.do?method=view&fdId=${planId}" target="blank"><h2><c:out value="${planSubject}"></c:out></h2></a></div>
				</center>
			</div>
    	</c:when>
    	<c:otherwise>
    		<c:choose>
	   			<c:when test="${paramConfig.taskFieldEnable }">
		   			<c:import url="/km/supervise/km_supervise_task/task_view_new.jsp?isEnable=true" charEncoding="UTF-8"></c:import>
		   		</c:when>
		   		<c:otherwise>
		   			<c:import url="/km/supervise/km_supervise_task/task_view_new.jsp?isEnable=false" charEncoding="UTF-8"></c:import>
		   		</c:otherwise>
   			</c:choose>
    	</c:otherwise>
    </c:choose>
</ui:content>

<c:choose>
	<c:when test="${param.approveModel eq 'right'}">
		<c:choose>
			<c:when test="${kmSuperviseMainForm.docStatus>='30' || kmSuperviseMainForm.docStatus=='00' || kmSuperviseMainForm.docStatus=='10'}">
				<%-- 流程 --%>
				<c:choose>
					<c:when test="${kmSuperviseMainForm.docUseXform == 'true' || empty kmSuperviseMainForm.docUseXform}">
						<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmSuperviseMainForm" />
							<c:param name="fdKey" value="kmSuperviseMain" />
							<c:param name="showHistoryOpers" value="true" />
							<c:param name="onClickSubmitButton" value="Com_Submit(document.kmSuperviseMainForm, 'publishDraft');" />
							<c:param name="isExpand" value="true" />
							<c:param name="approveType" value="right" />
							<c:param name="needInitLbpm" value="true" />
						</c:import>
					</c:when>
					<c:otherwise>
						<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmSuperviseMainForm" />
							<c:param name="fdKey" value="kmSuperviseMain" />
							<c:param name="showHistoryOpers" value="true" />
							<c:param name="isExpand" value="true" />
							<c:param name="approveType" value="right" />
						</c:import>
					</c:otherwise>
				</c:choose>
			</c:when>
			<c:otherwise>
				<%-- 流程 --%>
				<c:choose>
					<c:when test="${kmSuperviseMainForm.docUseXform == 'true' || empty kmSuperviseMainForm.docUseXform}">
						<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmSuperviseMainForm" />
							<c:param name="fdKey" value="kmSuperviseMain" />
							<c:param name="showHistoryOpers" value="true" />
							<c:param name="onClickSubmitButton" value="Com_Submit(document.kmSuperviseMainForm, 'publishDraft');" />
							<c:param name="isExpand" value="true" />
							<c:param name="approveType" value="right" />
						</c:import>
					</c:when>
					<c:otherwise>
						<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmSuperviseMainForm" />
							<c:param name="fdKey" value="kmSuperviseMain" />
							<c:param name="showHistoryOpers" value="true" />
							<c:param name="isExpand" value="true" />
							<c:param name="approveType" value="right" />
						</c:import>
					</c:otherwise>
				</c:choose>
			</c:otherwise>
		</c:choose>
	</c:when>
	<c:otherwise>
		<%-- 流程 --%>
		<c:choose>
			<c:when test="${kmSuperviseMainForm.docUseXform == 'true' || empty kmSuperviseMainForm.docUseXform}">
				<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmSuperviseMainForm" />
					<c:param name="fdKey" value="kmSuperviseMain" />
					<c:param name="onClickSubmitButton" value="Com_Submit(document.kmSuperviseMainForm, 'publishDraft');" />
					<c:param name="showHistoryOpers" value="true" />
					<c:param name="isExpand" value="true" />
				</c:import>
			</c:when>
			<c:otherwise>
				<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmSuperviseMainForm" />
					<c:param name="fdKey" value="kmSuperviseMain" />
					<c:param name="showHistoryOpers" value="true" />
					<c:param name="isExpand" value="true" />
				</c:import>
			</c:otherwise>
		</c:choose>
	</c:otherwise>
</c:choose>

<%-- 权限 --%>
<c:import url="/sys/right/import/right_view.jsp" charEncoding="UTF-8">
   	<c:param name="formName" value="kmSuperviseMainForm" />
   	<c:param name="moduleModelName" value="com.landray.kmss.km.supervise.model.KmSuperviseMain" />
</c:import>