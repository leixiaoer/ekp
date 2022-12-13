<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
            	
<div class="lui_asc_item_title">
	<span>${kmSuperviseTaskForm.docSubject}</span>
	<span class="progress"></span>
</div>
<c:if test="${kmSuperviseTaskForm.fdSuperviseId != null}">
<div class="lui_asc_item_text">
	<span>所属督办： </span>
	<span ><a href="${LUI_ContextPath}/km/supervise/km_supervise_main/kmSuperviseMain.do?method=view&fdId=${kmSuperviseTaskForm.fdSuperviseId}" style="font-size:12px;color:#4285f4;">${kmSuperviseTaskForm.fdSuperviseName}</a></span>
</div>
</c:if>
<div class="lui_asc_item_text">
	<span>计划时间： </span>
    <span>${kmSuperviseTaskForm.fdPlanStartTime} ~ ${kmSuperviseTaskForm.fdPlanEndTime}</span>
</div>
               