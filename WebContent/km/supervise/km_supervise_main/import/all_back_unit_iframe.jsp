<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple">
	<template:replace name="body">
		<ui:iframe src="${LUI_ContextPath}/km/supervise/km_supervise_main/import/all_back_unit_frame.jsp?fdMainId=${param.fdMainId}&fdUnitId=${param.fdUnitId}&fdTaskId=${param.fdTaskId}"></ui:iframe>
	</template:replace>
</template:include>


