<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="mobile.list">
	<template:replace name="head">
		<meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,minimum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
		<meta name="format-detection" content="telephone=no">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/km/supervise/mobile/resource/css/list.css?s_cache=${MUI_Cache}" />
    	<link rel="stylesheet" href="<%=request.getContextPath()%>/km/supervise/mobile/resource/css/supervision_approva.css?s_cache=${MUI_Cache}">
	</template:replace>
	
	<template:replace name="title">
			<bean:message bundle="km-supervise" key="module.km.supervise"/>
	</template:replace>
	<template:replace name="content">
		
		<%-- 导航头部，通常放导航页签、搜索 --%>
		<div data-dojo-type="mui/header/Header" data-dojo-props="height:'4.4rem'" class="muiHeaderNav">
		    <%-- Tab页签（注：当使用MobileCfgNavBar构建页签栏时，如果有模块有配置扩展点，则优先通过modelName从“移动办公--移动应用管理--应用页签配置”）读取数据 ，若无相关配置数据则读取defaultUrl配置的静态数据 --%>
			<div data-dojo-type="mui/nav/MobileCfgNavBar"
				 data-dojo-mixins="km/supervise/mobile/resource/js/header/ListAuditNavMixin">
			</div>
			
			<%-- 搜索 --%>
			<div data-dojo-type="mui/search/SearchButtonBar"
				 data-dojo-props="modelName:'com.landray.kmss.km.supervise.model.KmSuperviseDynamic'">
			</div>
		</div>
		
		<%--  页签内容展示区域，可纵向上下滑动   --%>
		<div data-dojo-type="mui/list/NavView">
			<%--  默认列表模板   --%>
			<ul data-dojo-type="mui/list/HashJsonStoreList" class="muiList"
				data-dojo-mixins="km/supervise/mobile/resource/js/list/ApprovalItemListMixin">
			</ul>
		</div>
		
	</template:replace>
</template:include>