<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple" spa="true">
	<template:replace name="body">
		<link type="text/css" rel="stylesheet" href="${LUI_ContextPath}/km/supervise/resource/css/supervise.css?s_cache=${LUI_Cache}"/>
	   	<ui:iframe id="superviseItem" src="${LUI_ContextPath}/km/supervise/moduleindex.jsp?nav=/km/supervise/km_supervise_main/supervise_item_tree2.jsp"></ui:iframe>
	</template:replace>
</template:include>