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
				<ui:menu-item text="${ lfn:message('km-carmng:kmCarmng.tree.car.information3') }" href="javascript:void(0);" target="_self">
				</ui:menu-item>
			</ui:menu>
	</template:replace> --%>
	<template:replace name="body">
		<script type="text/javascript">
			seajs.use(['theme!list']);	
		</script>
		<!-- 筛选器 -->
	<ui:tabpanel id="kmCarmngInfringeInfoPanel" layout="sys.ui.tabpanel.list" >
		<ui:content id="kmCarmngInfringeInfoContent" title="${ lfn:message('km-carmng:kmCarmng.tree.car.information3') }"> 
		<list:criteria id="criteria1">
			<list:cri-ref key="fdVehiclesInfo.fdNo" title="${lfn:message('km-carmng:kmCarmngInfomation.fdNo')}" ref="criterion.sys.docSubject">
			</list:cri-ref>
			<list:cri-criterion title="${ lfn:message('km-carmng:kmCarmng.tree.car.information6')}" key="fdMotorcade" multi="false" expand="false">
				<list:box-select>
					<list:item-select>
						<ui:source type="AjaxJson">
							{url:'/km/carmng/km_carmng_motorcade_set/kmCarmngMotorcadeSet.do?method=getFdMotorcade'}
						</ui:source>
					</list:item-select>
				</list:box-select>
			</list:cri-criterion>
			<list:cri-ref ref="criterion.sys.simpleCategory" key="fdVehichesType" multi="false" title="${ lfn:message('km-carmng:kmCarmng.tree.car.information1')}" expand="false">
			  <list:varParams modelName="com.landray.kmss.km.carmng.model.KmCarmngCategory"/>
			</list:cri-ref>
			<list:cri-auto modelName="com.landray.kmss.km.carmng.model.KmCarmngInfringeInfo" 
				property="fdInfringePersonName;fdInfringeTime" />
		</list:criteria>
		<%@ include file="/km/carmng/km_carmng_infringeInfo_ui/kmCarmngInfringeInfo_listview.jsp" %>
		</ui:content>
	</ui:tabpanel>	
	</template:replace> 
	
</template:include>
