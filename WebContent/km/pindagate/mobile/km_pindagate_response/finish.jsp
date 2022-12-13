<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<template:include ref="mobile.view" compatibleMode="true">

	<template:replace name="title">
		<c:out value="${docSubject}"></c:out> 
	</template:replace>
	
	<template:replace name="head">
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/pindagate/mobile/resource/css/finish.css?s_cache=${MUI_Cache}" />
	</template:replace>
	<template:replace name="content">
		<div class="muiDefaultHeading">
			<div class="muiDefaultTitle">${docSubject}</div>
		</div>
		<div class="muiDefaultBody">
			<div class="muiDefaultImgWrap">
				<img src="${LUI_ContextPath}/km/pindagate/mobile/resource/defaultImg.png">
			</div>
			<div class="muiDefaultMsgWrap">
				<p class="muiDefaultMsg">抱歉！你访问的调查已停止收集数据</p>
			</div>
		</div>
	</template:replace>
</template:include>
