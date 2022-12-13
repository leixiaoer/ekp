<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<c:choose>
	<c:when test="${kmSuperviseBackForm.fdType eq '0'}">
		<c:import url="/km/supervise/mobile/back_edit_new_task.jsp" charEncoding="UTF-8">
	  	</c:import>
	</c:when>
	<c:when test="${kmSuperviseBackForm.fdType eq '1'}">
		<c:import url="/km/supervise/mobile/back_edit_new_stage.jsp" charEncoding="UTF-8">
	  	</c:import>
	</c:when>
</c:choose>
