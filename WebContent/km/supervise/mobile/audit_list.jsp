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
	</template:replace>
	
	<template:replace name="title">
			<bean:message bundle="km-supervise" key="module.km.supervise"/>
	</template:replace>
	<template:replace name="content">
		<!-- 头部选项卡 系统自带 Starts -->
		<div class="muiHeader muiActivityHeader"  style="height: 4rem;">
			<div 
				data-dojo-type="mui/nav/MobileCfgNavBar" 
				data-dojo-props="defaultUrl:'/km/supervise/mobile/audit_nav.jsp',modelName:'com.landray.kmss.km.supervise.model.KmSuperviseMain'" 
				class="muiHeaderItem"> 
			</div>
			<div 
				data-dojo-type="mui/search/SearchButtonBar" 
				data-dojo-props="modelName:'com.landray.kmss.km.supervise.model.KmSuperviseMain'"
				 class="muiSearchButton mui mui-search muiFolder muiHeaderItem" tabindex="0"  style="height: 3.8rem; line-height: 3.8rem;"> 
			</div>
		</div>
		
		<div 
			data-dojo-type="mui/list/NavSwapScrollableView">
		    <ul data-dojo-type="mui/list/JsonStoreList" 
		    	data-dojo-mixins="km/supervise/mobile/resource/js/list/SuperviseItemListMixin">
			</ul>
		</div>
		
	</template:replace>
</template:include>