<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.km.supervise.util.KmSuperviseUtil"%>
<c:set var="__kmSuperviseMainForm" value="${requestScope[param.formName]}" />
<div class="supervise_fdstatus">
	<c:if test="${__kmSuperviseMainForm.fdStatus eq '10'}">
		<c:choose>
			<c:when test="${__kmSuperviseMainForm.isSoonStart}">
				<img src="${KMSS_Parameter_ContextPath}km/supervise/resource/images/icon_status_soon_start.png" height="100" width="100" />
			</c:when>
			<c:otherwise>
				<img src="${KMSS_Parameter_ContextPath}km/supervise/resource/images/icon_status_normal.png" height="100" width="100" />
			</c:otherwise>
		</c:choose>
      	
    </c:if>
    <c:if test="${__kmSuperviseMainForm.fdStatus eq '20'}">
      	<img src="${KMSS_Parameter_ContextPath}km/supervise/resource/images/icon_status_soon_delay.png" height="100" width="100" />
    </c:if>
    <c:if test="${__kmSuperviseMainForm.fdStatus eq '30'}">
      	<img src="${KMSS_Parameter_ContextPath}km/supervise/resource/images/icon_status_delay.png" height="100" width="100" />
    </c:if>
      <c:if test="${__kmSuperviseMainForm.fdStatus eq '40' && __kmSuperviseMainForm.fdIsDelay eq '35'}">
      	<img src="${KMSS_Parameter_ContextPath}km/supervise/resource/images/icon_status_delayFinsh.png" height="100" width="100" />
    </c:if>
    <c:if test="${__kmSuperviseMainForm.fdStatus eq '40' && __kmSuperviseMainForm.fdIsDelay eq '38'}">
      	<img src="${KMSS_Parameter_ContextPath}km/supervise/resource/images/icon_status_normalFinsh.png" height="100" width="100" />
    </c:if>
    <c:if test="${__kmSuperviseMainForm.fdStatus eq '50'}">
      	<img src="${KMSS_Parameter_ContextPath}km/supervise/resource/images/icon_status_stop.png" height="100" width="100" />
    </c:if>
    <c:if test="${__kmSuperviseMainForm.fdStatus eq '60'}">
      	<img src="${KMSS_Parameter_ContextPath}km/supervise/resource/images/icon_status_change.png" height="100" width="100" />
    </c:if>
</div>
<c:if test="${param.approveType eq 'right'}">
 	<script>
 		$(function(){
 			$(".supervise_fdstatus").css("top","60px").css("left","86%");
 		});
 	</script>
</c:if>