<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/km/supervise/fieldlayout/common/param_parser.jsp"%>
    <%
		parse.addStyle("width", "control_width", "95%");
	%>
<c:if test="${not empty kmSuperviseMainForm.fdModelId}">
	<a href="<c:url value="${kmSuperviseMainForm.fdSourceUrl}"/>" target="_blank">${kmSuperviseMainForm.fdSourceSubject}</a>
</c:if>