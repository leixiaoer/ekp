<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.landray.kmss.sys.authentication.user.KMSSUser"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<%@ page import="com.landray.kmss.km.asset.util.KmAssetConfigUtil"%>
<%@ page import="java.util.List"%>
<template:include ref="mobile.list">
	<template:replace name="title">
		<c:if test="${param.moduleName!=null && param.moduleName!=''}">
			<c:out value="${JsParam.moduleName}"></c:out>
		</c:if>
		<c:if test="${param.moduleName==null || param.moduleName==''}">
			<c:out value="${lfn:message('km-asset:module.km.asset')}"></c:out>
		</c:if>
	</template:replace>
	<template:replace name="head">
		<mui:min-file name="index.css"/>
	</template:replace>
		<template:replace name="content">
		   <div data-dojo-type="mui/list/StoreScrollableView">
		        <ul data-dojo-type="mui/list/JsonStoreList"
	                data-dojo-mixins="km/asset/mobile/js/list/AssetCardItemListMixin" class="muiAssetCardList"
					data-dojo-props="url:'${JsParam.qurStr}&fdAssetCategoryId=${JsParam.fdAssetCategoryId}&fdResponsiblePersonId=${JsParam.fdResponsiblePersonId}&docDeptId=${JsParam.docDeptId}&fdAssetStatus=${JsParam.fdAssetStatus}&fdCode=${JsParam.fdCode}&_mobile=1', lazy:false">
				</ul>
			</div>
			<ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom">
			  	<li data-dojo-type="mui/back/BackButton"></li>
			    <li data-dojo-type="mui/tabbar/TabBarButtonGroup" data-dojo-props="icon1:'mui mui-more'">
			    	<div data-dojo-type="mui/back/HomeButton"></div>
			    </li>
			</ul>
	</template:replace>
</template:include>