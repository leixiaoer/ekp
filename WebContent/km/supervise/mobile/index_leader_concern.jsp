<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/sys/mobile/jsp/ajax-accept.jsp" %>
<template:include ref="mobile.list" compatibleMode="true" canHash="true">
	<template:replace name="title">
		<c:if test="${param.moduleName!=null && param.moduleName!=''}">
			<c:out value="${param.moduleName}"></c:out>
		</c:if>
		<c:if test="${param.moduleName==null || param.moduleName==''}">
			<bean:message bundle="km-supervise" key="module.km.supervise"/>
		</c:if>
	</template:replace>
	<template:replace name="head">	   
	   	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/km/supervise/mobile/resource/css/list.css?s_cache=${MUI_Cache}" />
		<link rel="stylesheet" href="${LUI_ContextPath}/km/supervise/mobile/resource/css/allSupervision.css?s_cache=${MUI_Cache}">
  	   	<link rel="stylesheet" href="${LUI_ContextPath}/km/supervise/mobile/resource/css/index.css?s_cache=${MUI_Cache}">
  	   	
	</template:replace>
	<template:replace name="content">

				
		<%-- 导航头部，通常放导航页签、搜索 --%>
		<div data-dojo-type="mui/header/Header" data-dojo-props="height:'4.4rem'" class="muiHeaderNav">
		    <%-- Tab页签（注：当使用MobileCfgNavBar构建页签栏时，如果有模块有配置扩展点，则优先通过modelName从“移动办公--移动应用管理--应用页签配置”）读取数据 ，若无相关配置数据则读取defaultUrl配置的静态数据 --%>
			<div data-dojo-type="mui/nav/MobileCfgNavBar"
				 data-dojo-mixins="km/supervise/mobile/resource/js/header/LeaderConcernNavMixin">
			</div>
			
			<%-- 搜索 --%>
			<div data-dojo-type="mui/search/SearchButtonBar"
				 data-dojo-props="modelName:'com.landray.kmss.km.supervise.model.KmSuperviseDynamic'">
			</div>
		</div>
		
		<div data-dojo-type="mui/header/NavHeader">
		    <%-- 排序（立项时间）  --%>
			<div data-dojo-type="mui/sort/SortItem" 
			    data-dojo-props="name:'fdApprovalTime',subject:'立项时间',value:'down'">
			</div>
		    <%-- 排序（开始时间）  --%>
			<div data-dojo-type="mui/sort/SortItem" 
			    data-dojo-props="name:'fdStartTime',subject:'开始时间',value:''">
			</div>
			
			<%-- 默认筛选器头部模板 --%>
			<div class="muiHeaderItemRight" 
				data-dojo-type="mui/catefilter/FilterItem"
				data-dojo-mixins="mui/syscategory/SysCategoryMixin"
				data-dojo-props="modelName: 'com.landray.kmss.km.supervise.model.KmSuperviseTemplet',catekey: 'categoryId',prefix:''"></div>
		</div>
		
		<%--  页签内容展示区域，可纵向上下滑动   --%>
		<div data-dojo-type="mui/list/NavView">
			<%--  默认列表模板   --%>
			<ul data-dojo-type="mui/list/HashJsonStoreList" class="muiList"
				data-dojo-mixins="km/supervise/mobile/resource/js/list/LeaderConcernItemListMixin">
			</ul>
		</div>
		
		
		<div class="lui_db_footer">
		    <div class="lui_db_footer_item" onclick="navigate2View(0)">
		      <div class="lui_db_footer_item_img index"></div>
		      <p>首页</p>
		    </div>
		    <div class="lui_db_footer_item active" onclick="navigate2View(1)">
		      <div class="lui_db_footer_item_img leader"></div>
		      <p>领导关注</p>
		    </div>
		    <div class="lui_db_footer_item" onclick="navigate2View(2)">
		        <div class="lui_db_footer_item_img all"></div>
		        <p>所有督办</p>
		    </div>
		    <div class="lui_db_footer_item" onclick="navigate2View(3)">
		        <div class="lui_db_footer_item_img mine"></div>
		        <p>我的</p>
		    </div>
		</div>
	</template:replace>
</template:include>
<script>
	require(["dojo/ready","dojo/dom-class","dojo/request","dojo/dom","dojo/query","dojo/on","dojo/dom-attr","dojo/dom-style","dojox/mobile/TransitionEvent", 'dojo/topic'], 
		function(ready,domClass,request,dom,query,on,domAttr,domStyle,TransitionEvent,topic) {
		window.navigate2View = function(view) {
			var url ="${LUI_ContextPath}/km/supervise/mobile/";
			if(0 == view){
				url += "index.jsp"
			}else if(1 == view){
				url += "index_leader_concern.jsp"
			}else if(2 == view){
				url += "index_all.jsp"
			}else if(3 == view){
				url += "index_my.jsp"
			}
			window.open(url, '_self');
		}
	});
</script>
	
