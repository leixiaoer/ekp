<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple">
	<template:replace name="body">
		<ui:iframe src="${LUI_ContextPath}/km/supervise/km_supervise_main/import/plan_and_back_frame_user2.jsp?fdTaskId=${param.fdTaskId}"></ui:iframe>
	</template:replace>
</template:include>