<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple">
	<template:replace name="title">
		<c:out value="${ lfn:message('km-carmng:module.km.carmng') }"></c:out>
	</template:replace>
	
	<%-- <template:replace name="path">
			<ui:menu layout="sys.ui.menu.nav" style="height:40px;line-height:40px;">
				<ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" href="/" target="_self">
				</ui:menu-item>
				<ui:menu-item text="${ lfn:message('km-carmng:module.km.carmng') }" href="/km/carmng/" target="_self">
				</ui:menu-item>
			</ui:menu>
	</template:replace> --%>
	
	<template:replace name="body">
		<script type="text/javascript">
			seajs.use(['theme!list']);	
		</script>
		<!-- 筛选器 -->
	<ui:tabpanel id="kmCarmngListByDispatchersPanel" layout="sys.ui.tabpanel.list" >
		<ui:content id="kmCarmngListByDispatchersContent" title="${ lfn:message('km-carmng:kmCarmng.tree.dispatcher1') }">
		<list:criteria id="criteria1">
			<list:cri-ref key="docSubject" title="${lfn:message('km-carmng:kmCarmngApplication.docSubject')}" ref="criterion.sys.docSubject">
			</list:cri-ref>
			<list:cri-auto modelName="com.landray.kmss.km.carmng.model.KmCarmngApplication" 
				property="fdApplicationPerson;fdApplicationDept;fdStartTime;fdEndTime" />
		</list:criteria>
		<%@ include file="/km/carmng/km_carmng_listByDispatchers_ui/kmCarmngApplication_listByDispatchers_listview.jsp" %>
		</ui:content>
	</ui:tabpanel>	
	</template:replace> 
	
</template:include>
