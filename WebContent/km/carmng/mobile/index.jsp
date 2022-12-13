<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.landray.kmss.sys.authentication.user.KMSSUser"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<template:include file="/sys/mportal/module/mobile/jsp/module.jsp">
	<template:replace name="title">
		<c:if test="${param.moduleName!=null && param.moduleName!=''}">
			<c:out value="${param.moduleName}"></c:out>
		</c:if>
		<c:if test="${param.moduleName==null || param.moduleName==''}">
			<c:out value="${lfn:message('km-carmng:module.km.carmng')}"></c:out>
		</c:if>
	</template:replace>
	<template:replace name="head">
        <mui:cache-file name="mui-carmng-index.js" cacheType="md5"/>
	</template:replace>
	<template:replace name="content">
		<div data-dojo-type="sys/mportal/module/mobile/Module"
			data-dojo-mixins="km/carmng/mobile/module/js/ModuleMixin"></div>
	</template:replace>
</template:include>