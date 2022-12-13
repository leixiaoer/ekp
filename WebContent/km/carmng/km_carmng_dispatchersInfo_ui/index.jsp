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
	<ui:tabpanel id="kmCarmngDispatchersInfoPanel" layout="sys.ui.tabpanel.list" >
		<ui:content id="kmCarmngDispatchersInfoContent" title="${ lfn:message('km-carmng:kmCarmng.tree.dispatcher2') }">
		<list:criteria id="criteria1">
			<list:cri-ref key="fdCarInfoNo" title="${lfn:message('km-carmng:kmCarmngInfomation.fdNo')}" ref="criterion.sys.docSubject">
			</list:cri-ref>
			<list:cri-criterion title="${ lfn:message('km-carmng:kmCarmng.tree.car.information6')}" key="fdMotorcade" multi="true" expand="false">
				<list:box-select>
					<list:item-select>
						<ui:source type="AjaxJson">
							{url:'/km/carmng/km_carmng_motorcade_set/kmCarmngMotorcadeSet.do?method=getFdMotorcade'}
						</ui:source>
					</list:item-select>
				</list:box-select>
			</list:cri-criterion>
			<list:cri-ref ref="criterion.sys.simpleCategory" key="fdVehichesType" multi="true" title="${ lfn:message('km-carmng:kmCarmng.tree.car.information1')}">
			  <list:varParams modelName="com.landray.kmss.km.carmng.model.KmCarmngCategory"/>
			</list:cri-ref>
			<list:cri-criterion title="${ lfn:message('km-carmng:kmCarmng.tree.car.information2')}" multi="true" key="fdFlag"> 
				<list:box-select>
					<list:item-select>
						<ui:source type="Static">
							[{text:'${ lfn:message('km-carmng:kmCarmngDispatchersInfo.fdFlag1')}',value:'0'},
							{text:'${ lfn:message('km-carmng:kmCarmngDispatchersInfo.fdFlag2')}',value:'1'},
							{text:'${ lfn:message('km-carmng:mui.kmCarmngDispatchersInfo.fdFlag3')}',value:'2'}]
						</ui:source>
					</list:item-select>
				</list:box-select>
			</list:cri-criterion>
			<list:cri-criterion title="${lfn:message('km-carmng:kmCarmngInfomation.fdDriverId')}" key="fdDriversName">
		      <list:box-select> 
		        <list:item-select type="lui/criteria/criterion_input!TextInput"> 
		        <ui:source type="Static">
		           [{placeholder:'${lfn:message('km-carmng:kmCarmngInfomation.fdDriverId')}'}]
		        </ui:source>
		        </list:item-select>
		      </list:box-select>
		    </list:cri-criterion>
		</list:criteria>
		<%@ include file="/km/carmng/km_carmng_dispatchersInfo_ui/kmCarmngDispatchersInfo_listview.jsp" %>
		</ui:content>
	</ui:tabpanel>	
	</template:replace> 
	
</template:include>
