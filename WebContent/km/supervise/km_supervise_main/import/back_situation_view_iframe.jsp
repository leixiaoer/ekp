<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple">
	<template:replace name="body">
		<ui:iframe src="${LUI_ContextPath}/km/supervise/km_supervise_main/import/back_situation_view_frame.jsp?fdMainId=${param.fdMainId}"></ui:iframe>
	</template:replace>
</template:include>
