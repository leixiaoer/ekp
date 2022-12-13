<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<%
	boolean isLeader = UserUtil.checkRole("ROLE_KMSUPERVISE_LEADER");
	request.setAttribute("isLeader", isLeader);
%>

<c:choose>
	<c:when test="${isLeader eq true }">
		<%@ include file="/km/supervise/mobile/index_home_leader.jsp"%>
	</c:when>
	<c:otherwise>
		<%@ include file="/km/supervise/mobile/index_home.jsp"%>
	</c:otherwise>
</c:choose>

