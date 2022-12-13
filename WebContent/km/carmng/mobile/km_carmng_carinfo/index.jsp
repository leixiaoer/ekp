<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.landray.kmss.sys.authentication.user.KMSSUser"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<c:set var="tiny" value="true" scope="request" />
<template:include ref="mobile.list" canHash="true">
	<template:replace name="title">
		<c:if test="${param.moduleName!=null && param.moduleName!=''}">
			<c:out value="${param.moduleName}"></c:out>
		</c:if>
		<c:if test="${param.moduleName==null || param.moduleName==''}">
			<c:out value="${lfn:message('km-carmng:kmCarmng.tree.car.information')}"></c:out>
		</c:if>
	</template:replace>
	<template:replace name="head">
		<mui:min-file name="mui-carmng-list.js" />
		<mui:min-file name="mui-carmng-list.css"/>
		<mui:min-file name="mui-carmng-carlist.css"/>
		<mui:min-file name="mui-carmng-dispatcherlist.css"/>
        <mui:cache-file name="mui-carmng-info.js" cacheType="md5"/>
	</template:replace>
	<template:replace name="content">
	
		<c:import url="./listview.jsp" charEncoding="UTF-8"></c:import>
		
		<ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom" id="tabBar" data-dojo-props='fill:"grid"'>
			<kmss:auth requestURL="/km/carmng/km_carmng_application/kmCarmngApplication.do?method=add" requestMethod="GET">
			<li data-dojo-type="mui/tabbar/TabBarButton" data-dojo-props="icon1:'',text:'新建用车申请',href:'/km/carmng/km_carmng_application/kmCarmngApplication.do?method=add' "><bean:message key="kmCarmng.tree.application" bundle="km-carmng"/></li>
			</kmss:auth>
		</ul>
	</template:replace>
</template:include>