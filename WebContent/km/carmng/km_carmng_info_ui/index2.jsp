<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include file="/sys/profile/resource/template/list.jsp">
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
