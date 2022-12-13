<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include  ref="default.simple" rwd="true">
	<template:replace name="body">
		<ui:iframe id="recycle_review" src="${LUI_ContextPath }/sys/recycle/import/sysRecycle_index.jsp?modelName=com.landray.kmss.km.supervise.model.KmSuperviseMain"></ui:iframe>
	</template:replace>
</template:include>
