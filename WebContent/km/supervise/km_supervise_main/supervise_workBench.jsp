<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%
	boolean isLeader = UserUtil.checkRole("ROLE_KMSUPERVISE_LEADER");
	request.setAttribute("isLeader", isLeader);
%>
<c:choose>
	<c:when test="${isLeader eq true }">
		<%@ include file="/km/supervise/km_supervise_main/supervise_index_lead.jsp" %>
	</c:when>
	<c:otherwise>
		<%@ include file="/km/supervise/km_supervise_main/supervise_index_normal.jsp" %>
	</c:otherwise>
</c:choose>