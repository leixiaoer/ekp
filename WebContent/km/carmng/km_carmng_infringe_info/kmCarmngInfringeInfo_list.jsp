<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include file="/sys/profile/resource/template/list.jsp">
	<template:replace name="content">
		<!-- 筛选器 -->
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
	</template:replace> 
	
</template:include>
