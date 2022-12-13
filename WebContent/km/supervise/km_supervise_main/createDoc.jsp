<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.sys.config.dict.SysDictModel"%>
<%@page import="com.landray.kmss.sys.config.dict.SysDataDict"%>
<%@page import="com.landray.kmss.util.SpringBeanUtil"%>
<%@page import="com.landray.kmss.km.supervise.service.IKmSuperviseMainService"%>
<template:include ref="default.simple" rwd="true">
	<template:replace name="body">
		<script type="text/javascript">
			seajs.use(['theme!list']);	
		</script>
		<%
		
			String DraftCount = ((IKmSuperviseMainService)SpringBeanUtil.getBean("kmSuperviseMainService")).getCount("draft",true);
			String RraftBox = ResourceUtil.getString("kmSupervise.draftBox", "km-supervise");
			pageContext.setAttribute("draftTitle",RraftBox+"("+DraftCount+")");
			
		%> 
		<div>
			<ui:tabpanel layout="sys.ui.tabpanel.list">
			  <!-- 我立项的 -->
			  <%-- <ui:content title="${lfn:message('km-supervise:py.myLiXiang') }">
			  		<%@ include file="/km/supervise/km_supervise_main/supervise_my_create.jsp"%>	
			  </ui:content> --%>
			  <ui:content title="${lfn:message('km-supervise:py.DuBanLiXiang') }">
			  		<div style="background-color: #fff">
			  			<%@ include file="/sys/category/import/category_search.jsp"%>
			  			<%@ include file="/sys/lbpmperson/import/usualCate.jsp"%>
			  			<%@ include file="/sys/person/sys_person_favorite_category/favorite_category_flat.jsp"%>
			  		</div>
			  </ui:content>
			  <ui:content title="${draftTitle}">
			  		<%@ include file="/km/supervise/km_supervise_main/draftBox.jsp"%>	
			  </ui:content>
		    </ui:tabpanel>
	  </div>
	</template:replace> 
</template:include>