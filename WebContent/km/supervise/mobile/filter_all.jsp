<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<template:include ref="mobile.list" canHash="true">
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

			<div data-dojo-type="mui/nav/MobileCfgNavBar"
				data-dojo-mixins="km/supervise/mobile/resource/js/header/SuperviseNavStatusMixin">
			</div>
			<div class="muiHeaderItemRight" 
				data-dojo-type="mui/catefilter/FilterItem" 
				data-dojo-mixins="mui/syscategory/SysCategoryMixin" 
				data-dojo-props="modelName: 'com.landray.kmss.km.supervise.model.KmSuperviseTemplet',catekey: 'cateId',prefix: ''"></div>
			</div>
			
		</div>
		<div data-dojo-type="mui/list/NavView">
			<ul data-dojo-type="mui/list/HashJsonStoreList" class="muiList" 
				data-dojo-mixins="km/supervise/mobile/resource/js/list/SuperviseItemListNewMixin">
			</ul>
		</div>
	</template:replace>
</template:include>

