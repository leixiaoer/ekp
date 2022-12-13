<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<template:include file="/sys/mportal/module/mobile/jsp/module.jsp">

    <%-- 浏览器title --%>
	<template:replace name="title">
		<c:if test="${param.moduleName!=null && param.moduleName!=''}">
			<c:out value="${param.moduleName}"></c:out>
		</c:if>
		<c:if test="${param.moduleName==null || param.moduleName==''}">
			<c:out value="${lfn:message('km-asset:module.km.asset')}"></c:out>
		</c:if>
	</template:replace>
	
	<%-- 导入JS、CSS --%>
	<template:replace name="head">   
	    <mui:cache-file name="mui-asset-main.js" cacheType="md5"/>
	</template:replace>
	
	<%-- 页面内容 --%>
	<template:replace name="content">
		<div data-dojo-type="sys/mportal/module/mobile/Module"
			 data-dojo-mixins="km/asset/mobile/module/js/ModuleMixin"></div>
	</template:replace>

</template:include>