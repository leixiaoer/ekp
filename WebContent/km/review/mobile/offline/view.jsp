<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<template:include ref="mobile.offline.view" compatibleMode="true" offlineData="/km/review/km_review_main/kmReviewMain.do?method=view">
	<template:replace name="head">
	   <mui:min-file name="mui-review-view.css"/>
	</template:replace>
	<template:replace name="content">
	   <!-- 留空,当前模式下页面内容先由后端提供 -->
	</template:replace>
</template:include>