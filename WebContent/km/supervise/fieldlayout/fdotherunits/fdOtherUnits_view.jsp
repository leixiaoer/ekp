<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/km/supervise/fieldlayout/common/param_parser.jsp"%>
<span class="xform_fieldlayout" style="<%=parse.getStyle()%>">
	<c:choose>
		<c:when test="${kmSuperviseMainForm.fdSysUnitEnable eq 'true' }">
			<c:out value="${kmSuperviseMainForm.fdOtherUnitNames}"/>
		</c:when>
		<c:otherwise>
			<c:out value="${kmSuperviseMainForm.fdOUnitNames}"/>
		</c:otherwise>
	</c:choose>
</span>