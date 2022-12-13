<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/profile/profile.tld" prefix="profile"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/profile/profile.tld" prefix="profile"%>
<html>
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="renderer" content="webkit" />
	<template:block name="head">
		<%@ include file="/sys/ui/jsp/jshead.jsp"%>
	</template:block>
	<title>
			<template:block name="title"></template:block>
	</title>
	<link type="text/css" rel="stylesheet" href="${KMSS_Parameter_ContextPath}sys/profile/resource/css/homepage.css" />
	<script type="text/javascript">seajs.use(['theme!profile'])</script>
</head>
<body class="lui_profile_listview_body">
	<c:set var="type" scope="page" value="${empty param.type ? 'ekp' : param.type}"/> 
		<profile:listview>
			<ui:source type="Static">
				[{
					"key" : "config",
					"pinYin" : "zujian",
					"icon" : "lui_icon_l_profile_wechat_test",
					"messageKey" : "集成组件配置",
					"description" : "微信集成组件配置",
					"url" : "/third/wechat/wechatMainConfig.do?method=edit"
				},{
					"key" : "test",
					"pinYin" : "daiban",
					"icon" : "lui_icon_l_profile_wechat_config",
					"messageKey" : "待办推送测试",
					"description" : "微信组件待办推送测试",
					"url" : "/third/wechat/wechatNotify.do?method=toNotify"
				}]
			</ui:source>		
			<ui:render type="Javascript" ref="sys.profile.listview.default"></ui:render>
		</profile:listview>
	<template:block name="body"></template:block>
</body>
</html>

