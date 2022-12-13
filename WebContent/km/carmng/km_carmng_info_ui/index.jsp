<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.list">
	<template:replace name="title">
		<c:out value="${ lfn:message('km-carmng:module.km.carmng') }"></c:out>
	</template:replace>
	<template:replace name="head">
		<script>
		seajs.use([
		   	   	'lui/jquery', 
		   	   	'lui/util/str', 
		   	   	'lui/dialog',
		   	   	'lui/topic'
		   	   	], function($, strutil, dialog, topic){

			LUI.ready(function(){
				setTimeout('initMenuNav()', 300);
			});

			// 左则样式
			window.initMenuNav = function() {
		 		resetMenuNavStyle($("#km_carmng_info li:eq(0) a"));
		 	}			
		});
		</script>	
	</template:replace>
	<template:replace name="path">
			<ui:menu layout="sys.ui.menu.nav">
				<ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" href="/" target="_self">
				</ui:menu-item>
				<ui:menu-item text="${ lfn:message('km-carmng:module.km.carmng') }" href="/km/carmng/" target="_self">
				</ui:menu-item>
				<ui:menu-item text="${ lfn:message('km-carmng:kmCarmngInfomation.all') }"  target="_self">
				</ui:menu-item>
			</ui:menu>
	</template:replace>
	<template:replace name="nav">
		<ui:combin ref="menu.nav.create">
			<ui:varParam name="title" value="${ lfn:message('km-carmng:module.km.carmng') }" />
			<ui:varParam name="button">
				<%@ include file="/km/carmng/km_carmng_dispatchers_info_list/kmCarmngDispatchersSearch.jsp"%>
			</ui:varParam>
		</ui:combin>
		<div class="lui_list_nav_frame">
			<ui:accordionpanel>
				<c:import url="/km/carmng/import/nav.jsp" charEncoding="UTF-8">
					 <c:param name="key" value="carinfomationArea"></c:param>
				</c:import>
			</ui:accordionpanel>
		</div>
	</template:replace>
	
	<template:replace name="content">
		<!-- 筛选器 -->
		<list:criteria id="criteria1">
			<list:cri-ref key="fdNo" title="${lfn:message('km-carmng:kmCarmngInfomation.fdNo')}" ref="criterion.sys.docSubject">
			</list:cri-ref>
			<list:cri-auto modelName="com.landray.kmss.km.carmng.model.KmCarmngInfomation" 
				property="fdMotorcade;fdVehichesType" />
			<list:cri-criterion title="${ lfn:message('km-carmng:kmCarmng.tree.car.information2')}" key="docStatus"> 
				<list:box-select>
					<list:item-select >
						<ui:source type="Static">
							[{text:'${ lfn:message('km-carmng:kmCarmng.tree.car.information21')}', value:'1'},
							{text:'${ lfn:message('km-carmng:kmCarmng.tree.car.information22')}',value:'2'},
							{text:'${ lfn:message('km-carmng:kmCarmng.tree.car.information23')}',value:'3'}]
						</ui:source>
					</list:item-select>
				</list:box-select>
			</list:cri-criterion>
			<list:cri-auto modelName="com.landray.kmss.km.carmng.model.KmCarmngInfomation" 
				property="fdDriverName" />
		</list:criteria>
		<%@ include file="/km/carmng/km_carmng_info_ui/kmCarmngInfomation_listview.jsp" %>
	</template:replace> 
	
</template:include>
