<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<%@page import="com.landray.kmss.util.SpringBeanUtil"%>
<%@page import="com.landray.kmss.common.service.IBaseService"%>
<%@page import="com.landray.kmss.sys.category.model.SysCategoryMain"%>
<%@page import="com.landray.kmss.km.supervise.model.KmSuperviseTemplet"%>
<%@page import="com.landray.kmss.sys.authentication.user.KMSSUser"%>
<template:include ref="mobile.list">
	<template:replace name="title">
		<c:if test="${param.moduleName!=null && param.moduleName!=''}">
			<c:out value="${param.moduleName}"></c:out>
		</c:if>
		<c:if test="${param.moduleName==null || param.moduleName==''}">
			<c:out value="${lfn:message('km-supervise:module.km.supervise')}"></c:out>
		</c:if>
	</template:replace>
	<template:replace name="head">
	    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/km/supervise/mobile/resource/css/list.css?s_cache=${MUI_Cache}" />
		<link rel="stylesheet" href="${LUI_ContextPath}/km/supervise/mobile/resource/css/allSupervision.css?s_cache=${MUI_Cache}">
  	   	<link rel="stylesheet" href="${LUI_ContextPath}/km/supervise/mobile/resource/css/index.css?s_cache=${MUI_Cache}">
	</template:replace>
	<template:replace name="content">
		<div data-dojo-type="mui/header/Header" data-dojo-props="height:'4rem'">
			<div
				data-dojo-type="mui/nav/MobileCfgNavBar" 
				data-dojo-mixins="mui/nav/NavBarMoreMixin" 
				data-dojo-props="defaultUrl:'/km/supervise/mobile/nav_leader_concern.jsp?categoryId=${JsParam.cateId}', modelName:'com.landray.kmss.km.supervise.model.KmSuperviseMain'">
			</div>
			<div data-dojo-type="mui/nav/HeaderMoreItem"></div>
			
			<div data-dojo-type="mui/header/HeaderItem" 
				data-dojo-mixins="mui/folder/_Folder,mui/syscategory/SysCategoryDialogMixin" 
				data-dojo-props="icon:'mui mui-search',
					getTemplate:1,
					selType: 0|1,
					key:10,
					modelName:'com.landray.kmss.km.supervise.model.KmSuperviseTemplet',
					redirectURL:'/km/supervise/mobile/filter_leader_concern.jsp?moduleName=!{curNames}&cateId=!{curIds}',
					filterURL:''">
			</div>
		</div>
	
		<div 
			data-dojo-type="mui/list/NavSwapScrollableView">
		    <div class="lui_asc_list" data-dojo-type="mui/list/JsonStoreList" 
		    	data-dojo-mixins="km/supervise/mobile/resource/js/list/LeaderConcernItemListMixin">
			</div>
		</div>
	</template:replace>
</template:include>

