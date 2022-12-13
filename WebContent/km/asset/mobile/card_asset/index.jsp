<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<%@page import="com.landray.kmss.sys.authentication.user.KMSSUser"%>
<c:set var="tiny" value="true" scope="request" />
<template:include ref="mobile.list" canHash="true">
	<template:replace name="title">
		<c:if test="${param.moduleName!=null && param.moduleName!=''}">
			<c:out value="${param.moduleName}"></c:out>
		</c:if>
		<c:if test="${param.moduleName==null || param.moduleName==''}">
			<c:out value="${lfn:message('km-asset:kmAsset.mobile.nav.card.asset')}"></c:out>
		</c:if>
	</template:replace>
	<template:replace name="head">
	    <mui:cache-file name="mui-nav.js" cacheType="md5"/>
		<mui:cache-file name="mui-simpleCate.js" cacheType="md5" />
		<mui:cache-file name="mui-asset-main.js" cacheType="md5"/>
		<style type="text/css">       
		    .muiHeaderItemLable {
			    padding: 0 0.8rem;
			    overflow: hidden;
			    white-space: nowrap;
			    text-overflow: ellipsis;
		    }
		</style>
		<link href="../resource/css/cardlist.css" rel="stylesheet" type="text/css" />
	</template:replace>
	<template:replace name="content">

		 <c:import url="/km/asset/mobile/card_asset/listview.jsp" charEncoding="UTF-8"></c:import>
		 
	</template:replace>
</template:include>