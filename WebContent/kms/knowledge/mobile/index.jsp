<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<%@page import="com.landray.kmss.util.StringUtil"%>

<template:include ref="mobile.list" tiny="true" canHash="true">
	<template:replace name="title">
		<c:if test="${param.moduleName!=null && param.moduleName!=''}">
			<c:out value="${param.moduleName}"></c:out>
		</c:if>
		<c:if test="${param.moduleName==null || param.moduleName==''}">
			${lfn:message('kms-knowledge:module.kms.knowledge') }
		</c:if>
	</template:replace>

	<template:replace name="head">
		<mui:cache-file name="mui-simpleCate.js" cacheType="md5" />
		<mui:cache-file name="mui-kms-knowledge.js" cacheType="md5" />
		<style>
			#kms-knowledge-view-container .muiComplexLBox .muiComplexLLeft {
				background-size: contain!important;
			}
		</style>
	</template:replace>
	
	<template:replace name="content">

		<c:import url="/kms/knowledge/mobile/listview.jsp"
			charEncoding="UTF-8">
		</c:import>
		<kmss:auth
			requestURL="/kms/knowledge/kms_knowledge_base_doc/kmsKnowledgeBaseDoc.do?method=add"
			requestMethod="GET">
			<ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom">
				<li data-dojo-type="mui/tabbar/CreateButton"
					data-dojo-mixins="mui/simplecategory/SimpleCategoryMixin"
					data-dojo-props="icon1:'',createUrl:'/kms/multidoc/mobile/add.jsp?fdTemplateId=!{curIds}',
		  		                     modelName:'com.landray.kmss.kms.knowledge.model.KmsKnowledgeCategory',
		  		                     showFavoriteCate: 'true',
		  		                     ___urlParam:'{extProps:\'fdTemplateType:1;fdTemplateType:3\'}'">
					${lfn:message('kms-knowledge:kms.knowledge.4m.create.knowledge') }</li>
			</ul>
		</kmss:auth>

	</template:replace>
</template:include>
